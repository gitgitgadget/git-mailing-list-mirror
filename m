From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 3/4] submodule: fix sync handling of some relative
 superproject origin URLs
Date: Sun, 03 Jun 2012 15:10:31 -0700
Message-ID: <7v1ulwxd0o.fsf@alter.siamese.dyndns.org>
References: <1338716810-9881-1-git-send-email-jon.seymour@gmail.com>
 <1338716810-9881-4-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, j6t@kdbg.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 00:10:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbJ0Q-0003qR-Bs
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 00:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab2FCWKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 18:10:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44684 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505Ab2FCWKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 18:10:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CBEA8008;
	Sun,  3 Jun 2012 18:10:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Om9CWACYtiEtGmVr70YmaeTwx60=; b=tuyWGI
	9kkxZZXT5d4GdoLJpLIB0MHMML06J6841oRWL5sDfVIuhgzKI2ZJAcPuQaGOkHWi
	MLiI/CZcBULdD/iKm4VjTInpF9AjhP+zTg56m1o/4krf9P23jkaF0wxrbD/qeGmW
	gY3XYRkY9D9F4+7FUWOHnTYT1fmkFgFsNhwCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pN6XKhZFcN26dPc2q082L2iW5b8yzSH5
	xH7aII+ddmb9zTYJbtWDwKjW5+WS0Fz5sWTV4WSsqAvr2WLgwsPX74nnxsD7Utfn
	psLbcqHd8t1i+HgrHm5fu7NqsVOcoPz19Bm3TEFS921OoN6qU0iuxZ89HwZfDtfY
	YGQybAm55sE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 135FB8007;
	Sun,  3 Jun 2012 18:10:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 91E088005; Sun,  3 Jun 2012
 18:10:32 -0400 (EDT)
In-Reply-To: <1338716810-9881-4-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Sun, 3 Jun 2012 19:46:49 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFCFD548-ADC8-11E1-A218-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199108>

Jon Seymour <jon.seymour@gmail.com> writes:

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 64a70d6..314df20 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -30,7 +30,22 @@ nofetch=
>  update=
>  prefix=
>  
> -# Resolve relative url by appending to parent's url
> +# The function takes at most 2 arguments. The first argument is the
> +# relative URL that navigates from the superproject origin repo to the
> +# submodule origin repo. The second up_path argument, if specified, is
> +# the relative path that navigates from the submodule working tree to
> +# the superproject working tree.
> +#
> +# The output of the function is the origin URL of the submodule.
> +#
> +# The output will either be an absolute URL or filesystem path (if the
> +# superproject origin URL is an absolute URL or filesystem path,
> +# respectively) or a relative file system path (if the superproject
> +# origin URL is a relative file system path).
> +#
> +# When the output is a relative file system path, the path is either
> +# relative to the submodule working tree, if up_path is specified, or to
> +# the superproject working tree otherwise.
>  resolve_relative_url ()

OK.

> @@ -39,6 +54,17 @@ resolve_relative_url ()
>  	url="$1"
>  	remoteurl=${remoteurl%/}
>  	sep=/
> +	up_path="$2"
> +
> +	case "$remoteurl" in
> +		*:*|/*)
> +			is_relative=
> +			;;
> +		*)
> +			is_relative=t
> +			;;
> +	esac

Style: please align case/esac and the labels on case arms (see how
two existing nested case statements in this function are written).

> @@ -959,19 +985,32 @@ cmd_sync()
>  	while read mode sha1 stage sm_path
>  	do
>  		name=$(module_name "$sm_path")
> -		url=$(git config -f .gitmodules --get submodule."$name".url)
> +		# path from superproject origin repo to submodule origin repo
> +		module_url=$(git config -f .gitmodules --get submodule."$name".url)
>  
>  		# Possibly a url relative to parent
> -		case "$url" in
> +		case "$module_url" in
>  		./*|../*)
> -			url=$(resolve_relative_url "$url") || exit
> +			# rewrite foo/bar as ../.. to find path from
> +			# submodule work tree to superproject work tree
> +			up_path="$(echo "$sm_path" | sed "s/[^/]*/../g")" &&

Didn't we add some workaround for implementations of sed that do not
match and replace a possibly empty pattern?  Am I seeing the same
breakage as c5bc42b (Avoid bug in Solaris xpg4/sed as used in
submodule, 2012-04-09) addressed with this patch?
