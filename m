Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC439C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 20:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F275206D7
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 20:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H1suw1dC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfLQUMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:12:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60795 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbfLQUMN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 15:12:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 506D69FA66;
        Tue, 17 Dec 2019 15:12:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iwuPdiu90pKSUytZc5AXM3aoaGM=; b=H1suw1
        dC342TjEOIqkP4pH+hb0tvnFvcpXA6ve+ciFqGjES1YTSpUIg7+MRBT3EgXVNQcb
        vH7FsBlBy6Je3IcxTRGcSteQpgiF41pIsWC8qARUp2+jYuK40kqLsxSsXWLgZM7t
        m7d3yXxwl3UuP59FhsPxi1yXRQ05zu4rToe8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FB1VHk2ZwaiELIBjX2rZ4JX8I0zL3Lb6
        ha6ktBru0LyZ3hlAxPJPZ6K/RimAyYC/dIHyaUIDmwfzURJk51YymcjYthb5je3B
        5o254/kDFEztcjET02K03VA7OT9PehA/sj0BGhN2+B2CRrMEuOc7gghjYL9RjQiq
        vTn/wrgAcTE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 493469FA65;
        Tue, 17 Dec 2019 15:12:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 636379FA64;
        Tue, 17 Dec 2019 15:12:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/7] built-in add -p: implement the "stash" and "reset" patch modes
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
        <846cf16e77f4af39310902129be40fda664ace72.1576579264.git.gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 12:12:06 -0800
In-Reply-To: <846cf16e77f4af39310902129be40fda664ace72.1576579264.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 17 Dec 2019
        10:40:59 +0000")
Message-ID: <xmqqy2vag19l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8099E38C-2109-11EA-B0F8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `git stash` and `git reset` commands support a `--patch` option, and
> both simply hand off to `git add -p` to perform that work. Let's teach
> the built-in version of that command to be able to perform that work, too.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  add-interactive.h |  2 ++
>  add-patch.c       | 85 ++++++++++++++++++++++++++++++++++++++++++++---
>  builtin/add.c     |  4 +++
>  3 files changed, 87 insertions(+), 4 deletions(-)
>
> diff --git a/add-interactive.h b/add-interactive.h
> index 3defa2ff3d..c278f3e26f 100644
> --- a/add-interactive.h
> +++ b/add-interactive.h
> @@ -25,6 +25,8 @@ int run_add_i(struct repository *r, const struct pathspec *ps);
>  
>  enum add_p_mode {
>  	ADD_P_STAGE,
> +	ADD_P_STASH,
> +	ADD_P_RESET,

As I mentioned in my review on the previous step, ADD_P_ADD would be
more descriptive of what is going on when listed together with STASH
and RESET here.

> +static struct patch_mode patch_mode_reset_head = {
> +	.diff = { "diff-index", "--cached", NULL },
> +	.apply = { "-R", "--cached", NULL },
> +	.apply_check = { "-R", "--cached", NULL },
> +	.is_reverse = 1,
> +	.index_only = 1,
> +	.prompt_mode = {
> +		N_("Unstage mode change [y,n,q,a,d%s,?]? "),
> +		N_("Unstage deletion [y,n,q,a,d%s,?]? "),
> +		N_("Unstage this hunk [y,n,q,a,d%s,?]? "),
> +	},
> +	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
> +			     "will immediately be marked for unstaging."),
> +	.help_patch_text =
> +		N_("y - unstage this hunk\n"
> +		   "n - do not unstage this hunk\n"
> +		   "q - quit; do not unstage this hunk or any of the remaining "
> +			"ones\n"
> +		   "a - unstage this hunk and all later hunks in the file\n"
> +		   "d - do not unstage this hunk or any of the later hunks in "
> +			"the file\n"),
> +};
> +
> +static struct patch_mode patch_mode_reset_nothead = {
> +	.diff = { "diff-index", "-R", "--cached", NULL },
> +	.apply = { "--cached", NULL },
> +	.apply_check = { "--cached", NULL },
> +	.is_reverse = 0,
> +	.index_only = 1,
> +	.prompt_mode = {
> +		N_("Apply mode change to index [y,n,q,a,d%s,?]? "),
> +		N_("Apply deletion to index [y,n,q,a,d%s,?]? "),
> +		N_("Apply this hunk to index [y,n,q,a,d%s,?]? "),
> +	},
> +	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
> +			     "will immediately be marked for applying."),
> +	.help_patch_text =
> +		N_("y - apply this hunk to index\n"
> +		   "n - do not apply this hunk to index\n"
> +		   "q - quit; do not apply this hunk or any of the remaining "
> +			"ones\n"
> +		   "a - apply this hunk and all later hunks in the file\n"
> +		   "d - do not apply this hunk or any of the later hunks in "
> +			"the file\n"),
> +};

Interesting that "reset to HEAD" and "reset to non-HEAD" would have
to swap the direction to make it feel more natural to the users.
This is nothing new---just re-discovering that it is/was interesting.
