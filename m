Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59DEC433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 21:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbiEYVLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 17:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiEYVLX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 17:11:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1B935AA3
        for <git@vger.kernel.org>; Wed, 25 May 2022 14:11:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE74D18ABEF;
        Wed, 25 May 2022 17:11:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9e0YFYH+LP+CcQygJy+P7LSmOv/xLkz+mAN9qS
        Q01Cw=; b=iGLi+XA36bGkVmmPg+moOebKdj6ECfN9jjZ2ijmocFDy87tRfmoohA
        9FlIBhjrKEV8PcW9MnuvQIZbKN5RNGNzjeBlr7Ri94ZHla1J9tqz7DfaJGr1Pmmh
        P8WOEalQ9rb+kvBu/ItvL8RJisEBW7JFSNhtgGMqwF40CXaky+D7w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6EDC18ABEC;
        Wed, 25 May 2022 17:11:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9A13C18ABEB;
        Wed, 25 May 2022 17:11:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 1/7] archive: optionally add "virtual" files
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
        <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
        <0005cfae31d52a157d4df5ba3db9f9f5b2167ddc.1653145696.git.gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 14:11:10 -0700
In-Reply-To: <0005cfae31d52a157d4df5ba3db9f9f5b2167ddc.1653145696.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Sat, 21 May 2022
        15:08:10 +0000")
Message-ID: <xmqqfskx5ndd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 342D0F5A-DC6F-11EC-9C74-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -61,6 +61,17 @@ OPTIONS
>  	by concatenating the value for `--prefix` (if any) and the
>  	basename of <file>.
>  
> +--add-virtual-file=<path>:<content>::
> +	Add the specified contents to the archive.  Can be repeated to add
> +	multiple files.  The path of the file in the archive is built
> +	by concatenating the value for `--prefix` (if any) and the
> +	basename of <file>.

This sentence was copy-pasted from --add-file without adjusting.
There is no <file>; this new feature gives <path>.

Also, I suspect that the feature is losing end-user supplied
information without a good reason.  --add-file=<file> may have
prepared an input in a randomly named temporary directory and it
would make quite a lot of sense to strip the leading directory
components from <file> and use only the basename part.  But the
<path> given to "--add-virtual-file" does not refer to anything on
the filesystem.  Its ONLY use is to be used as the path in the
archive to store the content.  There is no justification why we
would discard the leading path components from it.  I am not
decided, but I am inclined to say that we should not honor
"--prefix".

   $ git archive --prefix=2.36.0 v2.36.0

would be a way to create a single directory and put everything in
the tree-ish in there, but there probably are cases where the user
of an "extra file" feature wants to add untracked cruft _in_ that
directory, and there are other cases where an extra file wants to go
to the top-level next to the 2.36.0 directory.  A user can use the
same string as --prefix=<base> in front of <path> if the extra file
should go next to the top-level of the tree-ish, or without such
prefixing to place the extra file at the top-level.

Hence

	Add the specified contents to the archive.  Can be repeated
	to add multiple files.  `<path>` is used as the path of the
	file in the archive.
	
would be what I would expect in a version of this feature that is
reasonably designed.

> ++
> +The `<path>` cannot contain any colon, the file mode is limited to
> +a regular file, and the option may be subject to platform-dependent
> +command-line limits. For non-trivial cases, write an untracked file
> +and use `--add-file` instead.

OK.

> diff --git a/archive.c b/archive.c
> index a3bbb091256..d20e16fa819 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -263,6 +263,7 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
>  struct extra_file_info {
>  	char *base;
>  	struct stat stat;
> +	void *content;
>  };
>  
>  int write_archive_entries(struct archiver_args *args,
> @@ -337,7 +338,13 @@ int write_archive_entries(struct archiver_args *args,
>  		strbuf_addstr(&path_in_archive, basename(path));
>  
>  		strbuf_reset(&content);
> -		if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
> +		if (info->content)

We ended up with the problematic "leading <path> components are
discarded" design only because the implementation reuses the logic
path_in_archive computation (the last line is seen in precontext),
which is a bit unfortunate.  I think we could rewrite the inside of
that "for each extra file" loop like so, instead:

	for (i = 0; i < args->extra_files.nr; i++) {
		struct string_list_item *item = args->extra_files.items + i;
		char *path = item->string;
		struct extra_file_info *info = item->util;

		put_be64(fake_oid.hash, i + 1);

		if (!info->content) {
			strbuf_reset(&path_in_archive);
			if (info->base)
				strbuf_addstr(&path_in_archive, info->base);
			strbuf_addstr(&path_in_archive, basename(path));

			strbuf_reset(&content);
			if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
				err = error_errno(_("could not read '%s'"), path);
			else
				err = write_entry(args, &fake_oid, path_in_archive.buf,
						  path_in_archive.len,
						  info->stat.st_mode,
						  content.buf, content.len);
		} else {
			err = write_entry(args, &fake_oid,
					  path, strlen(path),
					  info->stat.st_mode,
					  info->content, info->stat.st_size);
		}

		if (err)
			break;
	}

The first half is the original code for "--add-file", which clears
info->content to NULL.  We mangle the filename to come up with the
name in the archive (i.e. take basename and prefix with info->base).

The "else" side is the new code.  "--add-virtual-file" has the
"<path>" thing in item->string, and info has the contents, so we
just write it out.
