Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ABAC63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED7024181
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mVy3zEsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKQV3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:29:00 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52575 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKQV27 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:28:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A331BFF031;
        Tue, 17 Nov 2020 16:28:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JUB7ay0hDWKrdYk262/rFTdifvc=; b=mVy3zE
        sEHCLiP9ox/WUnMgbLilAom7NeTY3pvGOcIzmtNiJmBf52YUuL6YHdn1/3PRGfgZ
        EH8nnFxVLa3MUtoizy0LKhcq6YcRn4hCJWZOoLOUCVhDPMvRMcjoFqaq3Mu1P7Qg
        L80feSWuvifFidK/BWp5QfRZT+P9S/Hy8pIqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i07YldfM9WnOr1d4X/HmW8WABVCI6Voy
        Ryy7tTQVOvzM+bPcLBgALDpPp1sbTcezqJntIvcrK+jSrZdKR6f+yd9EaZeSt+9M
        6WXbDd8+MjXvlaz2XrYlSp8LC9HomyLj0Bk1bXR5vzIFo6Zue2DuYSDKagvCmk/H
        Oo3bJberQ3c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B413FF030;
        Tue, 17 Nov 2020 16:28:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DF392FF02F;
        Tue, 17 Nov 2020 16:28:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/3] builtin/repack.c: don't move existing packs out of
 the way
References: <cover.1605552016.git.me@ttaylorr.com>
        <d4e73aad14189a00621da9e000d2c6a5fe776d84.1605552016.git.me@ttaylorr.com>
        <xmqqpn4c7uf2.fsf@gitster.c.googlers.com>
        <X7MYifflg7SaTRXm@nand.local>
        <xmqqd00c7qup.fsf@gitster.c.googlers.com>
        <X7QvVB8GjI866a8z@nand.local>
Date:   Tue, 17 Nov 2020 13:28:53 -0800
In-Reply-To: <X7QvVB8GjI866a8z@nand.local> (Taylor Blau's message of "Tue, 17
        Nov 2020 15:15:16 -0500")
Message-ID: <xmqqzh3f4qqy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E517438E-291B-11EB-9175-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> That is, it is not the case that we pretend as if pack-objects didn't
> write files identical to ones that already exist, but rather that we
> respect what pack-objects wrote as the source of truth. That cuts two
> ways:
>
>   - If pack-objects produced an identical pack to one that already
>     exists with a bitmap, but did not produce a bitmap, we remove the
>     bitmap that already exists. (This behavior is codified in t7700.14).
>
>   - If pack-objects produced an identical pack to one that already
>     exists, we trust the just-written version of the coresponding .idx,
>     .promisor, and other files over the ones that already exist. This
>     ensures that we use the most up-to-date versions of this files,
>     which is safe even in the face of format changes in, say, the .idx
>     file (which would not be reflected in the .idx file's name).

Very clearly written.  I see no room for confusion, unlike the
original one.

Thanks, will replace.

>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/repack.c | 103 +++++++----------------------------------------
>  1 file changed, 14 insertions(+), 89 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index bb839180da..279be11a16 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -306,7 +306,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	struct string_list rollback = STRING_LIST_INIT_NODUP;
>  	struct string_list existing_packs = STRING_LIST_INIT_DUP;
>  	struct strbuf line = STRBUF_INIT;
> -	int i, ext, ret, failed;
> +	int i, ext, ret;
>  	FILE *out;
>
>  	/* variables to be filled by option parsing */
> @@ -463,109 +463,34 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>
>  	/*
>  	 * Ok we have prepared all new packfiles.
> -	 * First see if there are packs of the same name and if so
> -	 * if we can move them out of the way (this can happen if we
> -	 * repacked immediately after packing fully.
>  	 */
> -	failed = 0;
>  	for_each_string_list_item(item, &names) {
>  		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
>  			char *fname, *fname_old;
>
> -			fname = mkpathdup("%s/pack-%s%s", packdir,
> -						item->string, exts[ext].name);
> -			if (!file_exists(fname)) {
> -				free(fname);
> -				continue;
> -			}
> -
> -			fname_old = mkpathdup("%s/old-%s%s", packdir,
> -						item->string, exts[ext].name);
> -			if (file_exists(fname_old))
> -				if (unlink(fname_old))
> -					failed = 1;
> -
> -			if (!failed && rename(fname, fname_old)) {
> -				free(fname);
> -				free(fname_old);
> -				failed = 1;
> -				break;
> -			} else {
> -				string_list_append(&rollback, fname);
> -				free(fname_old);
> -			}
> -		}
> -		if (failed)
> -			break;
> -	}
> -	if (failed) {
> -		struct string_list rollback_failure = STRING_LIST_INIT_DUP;
> -		for_each_string_list_item(item, &rollback) {
> -			char *fname, *fname_old;
> -			fname = mkpathdup("%s/%s", packdir, item->string);
> -			fname_old = mkpathdup("%s/old-%s", packdir, item->string);
> -			if (rename(fname_old, fname))
> -				string_list_append(&rollback_failure, fname);
> -			free(fname);
> -			free(fname_old);
> -		}
> -
> -		if (rollback_failure.nr) {
> -			int i;
> -			fprintf(stderr,
> -				_("WARNING: Some packs in use have been renamed by\n"
> -				  "WARNING: prefixing old- to their name, in order to\n"
> -				  "WARNING: replace them with the new version of the\n"
> -				  "WARNING: file.  But the operation failed, and the\n"
> -				  "WARNING: attempt to rename them back to their\n"
> -				  "WARNING: original names also failed.\n"
> -				  "WARNING: Please rename them in %s manually:\n"), packdir);
> -			for (i = 0; i < rollback_failure.nr; i++)
> -				fprintf(stderr, "WARNING:   old-%s -> %s\n",
> -					rollback_failure.items[i].string,
> -					rollback_failure.items[i].string);
> -		}
> -		exit(1);
> -	}
> -
> -	/* Now the ones with the same name are out of the way... */
> -	for_each_string_list_item(item, &names) {
> -		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
> -			char *fname, *fname_old;
> -			struct stat statbuffer;
> -			int exists = 0;
>  			fname = mkpathdup("%s/pack-%s%s",
>  					packdir, item->string, exts[ext].name);
>  			fname_old = mkpathdup("%s-%s%s",
>  					packtmp, item->string, exts[ext].name);
> -			if (!stat(fname_old, &statbuffer)) {
> -				statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
> -				chmod(fname_old, statbuffer.st_mode);
> -				exists = 1;
> -			}
> -			if (exists || !exts[ext].optional) {
> +
> +			if (((uintptr_t)item->util) & (1 << ext)) {
> +				struct stat statbuffer;
> +				if (!stat(fname_old, &statbuffer)) {
> +					statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
> +					chmod(fname_old, statbuffer.st_mode);
> +				}
> +
>  				if (rename(fname_old, fname))
>  					die_errno(_("renaming '%s' failed"), fname_old);
> -			}
> +			} else if (!exts[ext].optional)
> +				die(_("missing required file: %s"), fname_old);
> +			else if (unlink(fname) < 0 && errno != ENOENT)
> +				die_errno(_("could not unlink: %s"), fname);
> +
>  			free(fname);
>  			free(fname_old);
>  		}
>  	}
> -
> -	/* Remove the "old-" files */
> -	for_each_string_list_item(item, &names) {
> -		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
> -			char *fname;
> -			fname = mkpathdup("%s/old-%s%s",
> -					  packdir,
> -					  item->string,
> -					  exts[ext].name);
> -			if (remove_path(fname))
> -				warning(_("failed to remove '%s'"), fname);
> -			free(fname);
> -		}
> -	}
> -
>  	/* End of pack replacement. */
>
>  	reprepare_packed_git(the_repository);
> --
> 2.29.2.312.gabc4d358d8
