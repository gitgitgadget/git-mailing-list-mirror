From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Sun, 10 May 2015 10:47:51 -0700
Message-ID: <xmqq8ucwgw8o.fsf@gitster.dls.corp.google.com>
References: <1431203769-11855-1-git-send-email-dturner@twopensource.com>
	<1431203769-11855-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sun May 10 19:48:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrVKZ-0000ws-UH
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 19:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbbEJRry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2015 13:47:54 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52522 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751514AbbEJRry (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 13:47:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 410F44EBD5;
	Sun, 10 May 2015 13:47:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2mNmWwpHHt1KOL94G/pBF9S6HSQ=; b=kvGcRa
	X+kue0Tt2uqHcm0JtHqVola+C7xBBN9HaUAzDApnTrojpMhzQz8OqfcsZp02aLiC
	1jDXORHKiFuaa6/0RnCsHCCpIrmO7AT6kz0sD/xEMhseVSK6AqfcwXg3De/wKn2d
	v0yc/61tCTuoTU0U3mxPOTB16btsWHFiTu4kM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WDTJPFfUrQDPUonKHqOOF8ZFqLD7LbIt
	vJ5NqvbzsuZ8YeowvNYD963If7tXV6LlH43t2L+cwp3DJvAKYlyfLSE0IJqwozjQ
	+AWaXVD7OxCcdpcwC95hbMxLe9clJnyy4pChemYM4j/LThLFWdSyI7mluiVtXw0O
	dT3ti8XXbgY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 388994EBD3;
	Sun, 10 May 2015 13:47:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ACAB14EBD1;
	Sun, 10 May 2015 13:47:52 -0400 (EDT)
In-Reply-To: <1431203769-11855-2-git-send-email-dturner@twopensource.com>
	(dturner@twopensource.com's message of "Sat, 9 May 2015 16:36:08
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AE97E29E-F73C-11E4-984F-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268734>

dturner@twopensource.com writes:

> -#define GET_SHA1_QUIETLY        01
> -#define GET_SHA1_COMMIT         02
> -#define GET_SHA1_COMMITTISH     04
> -#define GET_SHA1_TREE          010
> -#define GET_SHA1_TREEISH       020
> -#define GET_SHA1_BLOB	       040
> -#define GET_SHA1_ONLY_TO_DIE 04000
> +#define GET_SHA1_QUIETLY           01
> +#define GET_SHA1_COMMIT            02
> +#define GET_SHA1_COMMITTISH        04
> +#define GET_SHA1_TREE             010
> +#define GET_SHA1_TREEISH          020
> +#define GET_SHA1_BLOB             040
> +#define GET_SHA1_FOLLOW_SYMLINKS 0100
> +#define GET_SHA1_ONLY_TO_DIE    04000

There is nothing wrong per-se, but this effort for aligning looks
amusing ;-) Perhaps the next person who wants to mimick this pattern
will order their constants in such a way that gives a shoter code to
a symbol with a longer name?

> diff --git a/sha1_name.c b/sha1_name.c
> index 6d10f05..325f666 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1434,15 +1434,22 @@ static int get_sha1_with_context_1(const char *name,
>  			new_filename = resolve_relative_path(filename);
>  			if (new_filename)
>  				filename = new_filename;
> -			ret = get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
> -			if (ret && only_to_die) {
> -				diagnose_invalid_sha1_path(prefix, filename,
> -							   tree_sha1,
> -							   name, len);
> +			if (flags & GET_SHA1_FOLLOW_SYMLINKS) {
> +				ret = get_tree_entry_follow_symlinks(tree_sha1,
> +					filename, sha1, &oc->symlink_path,
> +					&oc->mode);
> +			} else {
> +				ret = get_tree_entry(tree_sha1, filename,
> +						     sha1, &oc->mode);
> +				if (ret && only_to_die) {
> +					diagnose_invalid_sha1_path(prefix,
> +								   filename,
> +								   tree_sha1,
> +								   name, len);
> +				}
>  			}

> -			hashcpy(oc->tree, tree_sha1);
>  			strlcpy(oc->path, filename, sizeof(oc->path));
> -
> +			hashcpy(oc->tree, tree_sha1);

Did the order and additional blank line matter here?  I think you'd
prefer to keep these two lines as before...

>  			free(new_filename);
>  			return ret;
>  		} else {
> @@ -1469,5 +1476,7 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
>  
>  int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc)
>  {
> +	if (flags & GET_SHA1_FOLLOW_SYMLINKS && flags & GET_SHA1_ONLY_TO_DIE)
> +		die("BUG: incompatible flags for get_sha1_with_context");
>  	return get_sha1_with_context_1(str, flags, NULL, sha1, orc);
>  }

Other than that, the patch looks good.

Thanks.
