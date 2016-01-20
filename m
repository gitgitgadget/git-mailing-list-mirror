From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] git submodule: Teach add to accept --group
Date: Wed, 20 Jan 2016 13:18:44 -0800
Message-ID: <xmqq1t9c54qz.fsf@gitster.mtv.corp.google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<1453260880-628-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:18:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM09Y-00024p-Ci
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 22:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbcATVSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 16:18:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752698AbcATVSr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 16:18:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 62C453CEF2;
	Wed, 20 Jan 2016 16:18:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ITUIFt1T7MqNiXuu+5lXDnzpNtc=; b=V1/tik
	SoH5s4u+ezQvLaywLqxsNNl4XNwcg47EKH5/5oqHk1T7/OA5/2vMJkY8AXOnSZSu
	3aa+Dy6XL2nbC03srfnsgYLyNtd7T2MswcQGr52Z5YIy0bMZyGWAQpgJpUFP0xhr
	09PQ8wjVKhgJ9uYL6DorJ06MZisuEKuEN7Lz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sGK1pZk16nYwHPcVk3t/jkzS+fO7yZoo
	8HAV4b/y80tGMH00dRAC+0Np6SCSNnQnzX/kb5keahxB3P5xt/NNBe/wZi0RThGv
	lzTMU3nmmdb/MCCig6weOpWvRITCoVD9pEEt6Y+ZkxwYSccLtFSELLjFWT/tWdwg
	ayWJkcsyGcY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 59CDD3CEF0;
	Wed, 20 Jan 2016 16:18:46 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C5D503CEEE;
	Wed, 20 Jan 2016 16:18:45 -0500 (EST)
In-Reply-To: <1453260880-628-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 19 Jan 2016 19:34:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 63C43CFC-BFBB-11E5-85FF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284468>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 6fce0dc..ab0f209 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -130,6 +130,7 @@ cmd_add()
>  {
>  	# parse $args after "submodule ... add".
>  	reference_path=
> +	submodule_groups=

This can just be called $groups in the context of this script.  I do
not foresee we would be planning to deal with other kinds of groups
here.

>  	while test $# -ne 0
>  	do
>  		case "$1" in
> @@ -165,6 +166,10 @@ cmd_add()
>  		--depth=*)
>  			depth=$1
>  			;;
> +		-g|--group)
> +			submodule_groups=${submodule_groups:+${submodule_groups};}"$2"
> +			shift
> +			;;

You would want to accept "--group=<name>" as well, just like
existing --reference and --depth do.  It won't be much more code,
and when you move to C (hence parse_options) you'd get it for free
anyway.

> @@ -292,6 +297,16 @@ Use -f if you really want to add it." >&2
>  
>  	git config -f .gitmodules submodule."$sm_name".path "$sm_path" &&
>  	git config -f .gitmodules submodule."$sm_name".url "$repo" &&
> +	if test -n "$submodule_groups"
> +	then
> +		OIFS=$IFS
> +		IFS=';'

I do not quite understand the choice of ';' here.  If and only if
you _must_ accept multi-word name that has spaces in between as a
group name, the above construct may make sense, but I do not think
we have such requirement.  Why not separate with $IFS letters just
like any other normal list managed in shell scripts do?  Is there
anything special about names of submodule groups?
