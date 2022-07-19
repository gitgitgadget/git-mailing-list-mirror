Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A1DC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 22:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbiGSWnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 18:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiGSWnO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 18:43:14 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E3F509F7
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 15:43:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35303127D16;
        Tue, 19 Jul 2022 18:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DRgZorl2ncrCwvkPRTc5xMyb9jViB5qDUEq/u4
        XcaDA=; b=kpAmg3jzi4+lz9+03qP4nwBf6IrE+ECqHzgdpY8syjU0gHaQGKkoZO
        Hq/gZoaKel4BYWqGK+BD5QqFTv2SD+JYtFQkow57utez7SwLu6pmiXR5ejVVwe7Q
        Uvv1IaVYJCM0jhrZec9nEHAP+o7KHo2IGm5iMDfSFTdvkbyv2pYBk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C123127D15;
        Tue, 19 Jul 2022 18:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 932ED127D14;
        Tue, 19 Jul 2022 18:43:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 3/6] merge: fix save_state() to work when there are
 racy-dirty files
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
        <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <89e5e633241e45a0c4b18289ab2fafdaabc8191e.1655621424.git.gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 15:43:10 -0700
In-Reply-To: <89e5e633241e45a0c4b18289ab2fafdaabc8191e.1655621424.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sun, 19 Jun 2022
        06:50:21 +0000")
Message-ID: <xmqqsfmw7mgx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B0E5B8E-07B4-11ED-BF2C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> When there are racy-dirty files, but no files are modified,
> `git stash create` exits with unsuccessful status.  This causes merge
> to fail.  Refresh the index first to avoid this problem.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/merge.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 00de224a2da..8ce4336dd3f 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -313,8 +313,16 @@ static int save_state(struct object_id *stash)
>  	int len;
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	struct strbuf buffer = STRBUF_INIT;
> +	struct lock_file lock_file = LOCK_INIT;
> +	int fd;
>  	int rc = -1;
>  
> +	fd = repo_hold_locked_index(the_repository, &lock_file, 0);
> +	refresh_cache(REFRESH_QUIET);
> +	if (0 <= fd)
> +		repo_update_index_if_able(the_repository, &lock_file);
> +	rollback_lock_file(&lock_file);

I might have added "else" but rolling back a lock file that was
already committed or rolled back is a safe no-op, so this is OK.
The pattern already appears elsewhere twice, anyway.

Is it sufficient to be opportunistic?  IOW, if we fail to refresh
the index or write the refreshed result to disk, can we be silent
here and rely on "stash create" and things that follow to safely
fail as necessary, or should we also be detecting errors?

>  	strvec_pushl(&cp.args, "stash", "create", NULL);
>  	cp.out = -1;
>  	cp.git_cmd = 1;
