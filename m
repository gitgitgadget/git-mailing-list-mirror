Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E042C10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 22:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19DE206E2
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 22:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fv+WbSpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCFWMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:12:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63203 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgCFWMX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 17:12:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F17565C6A4;
        Fri,  6 Mar 2020 17:12:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=REmm3G57ICRlhaBzR1fU1cpMN4c=; b=fv+WbS
        pfF1u7Dnu+z9jSv3prldP/XOkJVwGmCiYTQ8nGuRfvS8LyUi5R400XX/rk5o1rVL
        ZqipsWojWVekkmdOJAUoPc6pzpH88GpvlmzaDVT7hnL2JXChMGQvfV0ADxREoJ72
        ZFANSxydy4zjg6LuDTSaGryTC+U68rB2P20Tk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qAR7RFonZfRKX7XH04ofqVlAzArzJNth
        5PHFHcIoycJ+rMDuzyf5P2Dosf6D6AgmH34knjc87vXgoHZTIESHb7s981wJjgmu
        8XfkmTDhioDTr6I3Na6JudDW37Oi6Ttbh2cfyCEvihmeKvLtiqNDLTejNcgMq+FC
        Jybi3hM2Etg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E93C55C6A3;
        Fri,  6 Mar 2020 17:12:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 594935C6A2;
        Fri,  6 Mar 2020 17:12:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 2/4] real_path: remove unsafe API
References: <pull.575.git.1583521396.gitgitgadget@gmail.com>
        <039d3d368662f3a7e208fa7aa47549ca2654574a.1583521396.git.gitgitgadget@gmail.com>
Date:   Fri, 06 Mar 2020 14:12:18 -0800
In-Reply-To: <039d3d368662f3a7e208fa7aa47549ca2654574a.1583521396.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Fri, 06 Mar 2020
        19:03:14 +0000")
Message-ID: <xmqq4kv12kvx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C4F9884-5FF7-11EA-A25A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> However, two places return the value of `real_path()` to the caller. For
> them, a `static` local `strbuf` was added, effectively pushing the
> problem one level higher:
>     read_gitfile_gently()
>     get_superproject_working_tree()

Yeah, I noticed that while reading the patch.  It is not making it
any worse, and other parts of the patch made tons of sense (except
one small thing).

It was especially pleasing to see that care has been taken to avoid
introducing strbuf leaks.


> diff --git a/builtin/clone.c b/builtin/clone.c
> index 1ad26f4d8c8..e5c2a229a11 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -420,6 +420,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>  	struct dir_iterator *iter;
>  	int iter_status;
>  	unsigned int flags;
> +	struct strbuf realpath = STRBUF_INIT;
>  
>  	mkdir_if_missing(dest->buf, 0777);
>  
> @@ -454,7 +455,9 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>  		if (unlink(dest->buf) && errno != ENOENT)
>  			die_errno(_("failed to unlink '%s'"), dest->buf);
>  		if (!option_no_hardlinks) {
> -			if (!link(real_path(src->buf), dest->buf))
> +			strbuf_reset(&realpath);
> +			strbuf_realpath(&realpath, src->buf, 1);

This is inside a loop, so "struct strbuf realpath" here in the
second or subsequent iteration may not be empty; it is true that
strbuf_reset() is necessary _somewhere_ in the loop to discard
the path that was created for the previous iteration.

If my reading of the code is correct, however, the first thing that
is done by strbuf_realpath() is to empty the output buffer by using
strbuf_reset() indirectly via get_root_part().  Calling strbuf_reset()
here should not hurt, but it is unnecessary, I would think.  An even
worse effect such a redundant strbuf_reset() has is that by repeatedly
seeing the "reset then call realpath" pattern, readers who do not read
the implementation of strbuf_realpath() might mistakenly think that

	strbuf_addf(&message, "the path '%s' is really ", path);
	strbuf_realpath(&message, path);

is how realpath() is expected to be used, i.e. keep the current
contents in the buffer and append the resolved path to it.


>  static void clone_local(const char *src_repo, const char *dest_repo)
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 4a70b33fb5f..3d7ec640e01 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -39,14 +39,18 @@ static struct object_directory *find_odb(struct repository *r,
>  {
>  	struct object_directory *odb;
>  	char *obj_dir_real = real_pathdup(obj_dir, 1);
> +	struct strbuf odb_path_real = STRBUF_INIT;
>  
>  	prepare_alt_odb(r);
>  	for (odb = r->objects->odb; odb; odb = odb->next) {
> -		if (!strcmp(obj_dir_real, real_path(odb->path)))
> +		strbuf_reset(&odb_path_real);
> +		strbuf_realpath(&odb_path_real, odb->path, 1);

Likewise.

> @@ -60,8 +61,11 @@ static int abspath_part_inside_repo(char *path)
>  		path++;
>  		if (*path == '/') {
>  			*path = '\0';
> -			if (fspathcmp(real_path(path0), work_tree) == 0) {
> +			strbuf_reset(&realpath);
> +			strbuf_realpath(&realpath, path0, 1);

Likewise.

> @@ -69,11 +73,15 @@ static int abspath_part_inside_repo(char *path)
>  	}
>  
>  	/* check whole path */
> -	if (fspathcmp(real_path(path0), work_tree) == 0) {
> +	strbuf_reset(&realpath);
> +	strbuf_realpath(&realpath, path0, 1);

Likewise.

> diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
> index 409034cf4ee..40548d31dfe 100644
> --- a/t/helper/test-path-utils.c
> +++ b/t/helper/test-path-utils.c
> @@ -290,11 +290,15 @@ int cmd__path_utils(int argc, const char **argv)
>  	}
>  
>  	if (argc >= 2 && !strcmp(argv[1], "real_path")) {
> +		struct strbuf realpath = STRBUF_INIT;
>  		while (argc > 2) {
> -			puts(real_path(argv[2]));
> +			strbuf_reset(&realpath);
> +			strbuf_realpath(&realpath, argv[2], 1);
> +			puts(realpath.buf);

Likewise.


Thanks.

