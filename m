Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D441C00528
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 17:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjHARYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 13:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbjHARYF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 13:24:05 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBFD213E
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 10:23:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8D6C1AF021;
        Tue,  1 Aug 2023 13:23:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YtIVQ3uZOLJIM8M8FIX2a67iS5m2vtg+jYxt7L
        BKeA0=; b=uWlesh7P5Mqot6ldOnck3wMuOb9AEDDAcA0cAoFG+esVd1a8CVo6si
        sjmRnNV58xJ8ILA+mW3OkzbO4410GIOr2WGeSWuyhO+ZnQkYw+ttx5rmZwMvixPO
        /rGsWzxeubGd8cpV+mKfHsaeA4usMjMQ7VJpuzyl8jeZMuWgcYAOU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D03251AF020;
        Tue,  1 Aug 2023 13:23:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B9AE1AF01E;
        Tue,  1 Aug 2023 13:23:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 2/7] rebase -i: remove patch file after conflict
 resolution
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
        <e2a758eb4a5df0fab189b3dd235a1651a0c10342.1690903412.git.gitgitgadget@gmail.com>
Date:   Tue, 01 Aug 2023 10:23:16 -0700
In-Reply-To: <e2a758eb4a5df0fab189b3dd235a1651a0c10342.1690903412.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Tue, 01 Aug 2023 15:23:27
        +0000")
Message-ID: <xmqq5y5yd6d7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A7860CA-3090-11EE-955B-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When a rebase stops for the user to resolve conflicts it writes a patch
> for the conflicting commit to .git/rebase-merge/patch. This file has
> been written since the introduction of "git-rebase-interactive.sh" in
> 1b1dce4bae7 (Teach rebase an interactive mode, 2007-06-25). I assume the
> idea was to enable the user inspect the conflicting commit in the same
> way as they could for the patch based rebase. This file should be
> deleted when the rebase continues as if the rebase stops for a failed
> "exec" command or a "break" command it is confusing to the user if there
> is a stale patch lying around from an unrelated command.

Unlike the previous step, this describes the change in end-user
observable behaviour *and* asserts that it is an intended change.

Very good.

> As the path is
> now used in two different places rebase_path_patch() is added and used
> to obtain the path for the patch.

The get_dir() function gives different paths, between "rebase-merge"
(for "rebase -i") and "sequencer" (for everything else), and that is
the parent directory of "/patch" output make_patch() uses.

error_with_patch() is the only caller of make_patch(), and
error_with_patch() is called by

 error_failed_squash() - called from pick_commits()
 pick_commits() - when TODO_EDIT stops the sequence, or
		  a non fix-up insn failed when is_rebase_i(), or
		  a merge insn failed, or
		  a reschedule happened.

Are we sure that it is the right thing to do to hardcode
"rebase-merge/patch"?  Unless "rebase -i" is the only thing that
calls pick_commits() and reaches error_with_patch() to cause
make_patch() to be called, this changes the behaviour for cases the
tests added by this patch do not cover, doesn't it?

I would feel safer if this change is accompanied by something like

diff --git i/sequencer.c w/sequencer.c
index cc9821ece2..a5ec8538fa 100644
--- i/sequencer.c
+++ w/sequencer.c
@@ -3502,6 +3502,9 @@ static int make_patch(struct repository *r,
 	char hex[GIT_MAX_HEXSZ + 1];
 	int res = 0;
 
+	if (!is_rebase_i(opts))
+		BUG("make-patch should only be triggered during rebase -i");
+
 	oid_to_hex_r(hex, &commit->object.oid);
 	if (write_message(hex, strlen(hex), rebase_path_stopped_sha(), 1) < 0)
 		return -1;

to make sure that future changes to "git cherry-pick A..B" that
makes it easier to edit .git/sequencer/todo and tweak "pick" into
"edit" (aka "git cherry-pick -i") would not happen unless the author
of such a change considerts its ramifications first.

Alternatively, we could still introduce a handy path function, but
call it sequencer_path_patch() that does get_dir() + "/patch", i.e.
return different paths honoring is_rebase_i(), to make sure we will
behave the same way as before.  That might be safer.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c                | 13 +++++++++----
>  t/t3418-rebase-continue.sh | 18 ++++++++++++++++++
>  2 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index de66bda9d5b..70b0a7023b0 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4659,6 +4663,7 @@ static int pick_commits(struct repository *r,
>  	unlink(rebase_path_message());
>  	unlink(rebase_path_stopped_sha());
>  	unlink(rebase_path_amend());
> +	unlink(rebase_path_patch());
>  
>  	while (todo_list->current < todo_list->nr) {
>  		struct todo_item *item = todo_list->items + todo_list->current;

Other hunks are about "get_dir() + /patch" -> "rebase_path_patch()",
but this hunk is about the intended behaviour change.  We clear the
leftover patch file from the previous round before we enter the loop
to process new insn from the list, which makes sense.

> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 2d0789e554b..261e7cd754c 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -244,6 +244,24 @@ test_expect_success 'the todo command "break" works' '
>  	test_path_is_file execed
>  '
>  
> +test_expect_success 'patch file is removed before break command' '
> +	test_when_finished "git rebase --abort" &&
> +	cat >todo <<-\EOF &&
> +	pick commit-new-file-F2-on-topic-branch
> +	break
> +	EOF
> +
> +	(
> +		set_replace_editor todo &&
> +		test_must_fail git rebase -i --onto commit-new-file-F2 HEAD
> +	) &&
> +	test_path_is_file .git/rebase-merge/patch &&
> +	echo 22>F2 &&
> +	git add F2 &&
> +	git rebase --continue &&
> +	test_path_is_missing .git/rebase-merge/patch
> +'
> +
>  test_expect_success '--reschedule-failed-exec' '
>  	test_when_finished "git rebase --abort" &&
>  	test_must_fail git rebase -x false --reschedule-failed-exec HEAD^ &&
