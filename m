From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/9] Implement "git mv" for submodules
Date: Sat, 10 Apr 2010 18:25:35 -0700
Message-ID: <7v4ojisru8.fsf@alter.siamese.dyndns.org>
References: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
 <1270923830-11830-3-git-send-email-peter@pcc.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Collingbourne <peter@pcc.me.uk>
X-From: git-owner@vger.kernel.org Sun Apr 11 03:25:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0lvv-0001ts-K3
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 03:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab0DKBZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 21:25:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42467 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab0DKBZm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 21:25:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B4EA1A9D8D;
	Sat, 10 Apr 2010 21:25:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=FyBPW3+dBNVU5c8Rw4138w28kwQ=; b=soVQFPWOBGmOymgSlL8Aarq
	kQjTlO+xEcUNfMOnX7oD/u7Tdh5fRfg/Qc3UlHOjtF0uSbNyOxx2Okz6yMdULR6m
	dU8blk2useT7df43cm1RUPGHhHNKQ2Sb+jJNPGMBuTfDF2NNsehMNbbMbMMmXNhV
	DH6OMIalBv3G3HsaAurc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=JWHwFzeLhk5yNofcX10viAXXi7RTU3I0Ut8+xgeJMJ/a9f9Q3
	73FGBa6xIm4ncbvzFEl75RbQvqmy4wqeHeTfqaaNL+jRxkgIOkMVRkUIkzj+C6qW
	iAb1yUsmd2VZmL8R1mSt3TsHLWBRqSSfA5pdTDa4fNbFLs9O0HS3zREWAE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 923A8A9D8C;
	Sat, 10 Apr 2010 21:25:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97EAFA9D81; Sat, 10 Apr
 2010 21:25:36 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2366E8B8-4509-11DF-AFD9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144622>

Peter Collingbourne <peter@pcc.me.uk> writes:

> +		OPT_BOOLEAN('M', NULL, &skip_module_update, "don't upda...

If you are moving them by default, it is confusing to make up a negative
"skip" option like this.

Instead, add a boolean "module_update" that defaults to true, and give
"--[no-]module-update" without a short single-letter option, i.e.

	OPT_BOOLEAN(0 , "module-update", &module_update, "update submodule entries")

Exactly the same comment applies to your "git rm" patch.

> @@ -96,13 +98,14 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  	/* Checking */
>  	for (i = 0; i < argc; i++) {
>  		const char *src = source[i], *dst = destination[i];
> -		int length, src_is_dir;
> +		int length, src_is_dir, pos;
>  		const char *bad = NULL;
>  
>  		if (show_only)
>  			printf("Checking rename of '%s' to '%s'\n", src, dst);
>  
>  		length = strlen(src);
> +		pos = cache_name_pos(src, length);
>  		if (lstat(src, &st) < 0)
>  			bad = "bad source";
>  		else if (!strncmp(src, dst, length) &&
> @@ -111,7 +114,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		} else if ((src_is_dir = S_ISDIR(st.st_mode))
>  				&& lstat(dst, &st) == 0)
>  			bad = "cannot move directory over file";
> -		else if (src_is_dir) {
> +		else if (src_is_dir &&
> +				!(pos >= 0 &&
> +				  S_ISGITLINK(active_cache[pos]->ce_mode))) {

This looks like a funny indentation (perhaps a "diff" artifcat???)...

> diff --git a/git-submodule.sh b/git-submodule.sh
> index de29f3a..f1e4e22 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -859,6 +859,20 @@ cmd_sync()
>  		fi
>  	done
>  }
> +#
> +# Updates the entry in .gitmodules to move a submodule.
> +# This command is called by "git mv" for each submodule it moves.
> +#
> +cmd_mvconfig()
> +{
> +	src="$1"
> +	dst="$2"
> +
> +	name=$(module_name "$src") || exit
> +	git config -f .gitmodules submodule."$name".path "$dst" ||
> +		die "Could not update .gitmodules entry for $name"
> +	git add .gitmodules || die "Could not add .gitmodules to index"
> +}

This does not seem to depend on the first "give random name to submodules"
patch in the series, or does it?
