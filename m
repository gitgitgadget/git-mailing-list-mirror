Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B90C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 21:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiCQVhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 17:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiCQVhi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 17:37:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713D615468D
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 14:36:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 214D318415D;
        Thu, 17 Mar 2022 17:36:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GeAot5Okr56D7rW4ucgegvFNXHqwXN3NnqLwiF
        5/aak=; b=J9v3mOLQekYaK+K5HklOsZ49lwa+W4NDtNwW0U64LvPC/ZTpfFZg1a
        WKm5pJa9+oNCMahzVjyJIChkwCAl/MgXbQS+AxtlgUai9gmtLMoLhOgi3KE7QGlv
        jGgMd3TuToFCfP/QeFhE1m8bQD79zgVQVniGh5D2rD4aPoCJiXgfE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1973218415C;
        Thu, 17 Mar 2022 17:36:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3925918415A;
        Thu, 17 Mar 2022 17:36:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 3/3] rebase: set REF_HEAD_DETACH in
 checkout_up_to_date()
References: <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
        <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
        <13c5955c317713bbc6a91b9f44081395880abb67.1647546828.git.gitgitgadget@gmail.com>
Date:   Thu, 17 Mar 2022 14:36:16 -0700
In-Reply-To: <13c5955c317713bbc6a91b9f44081395880abb67.1647546828.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Thu, 17 Mar 2022 19:53:48
        +0000")
Message-ID: <xmqq8rt8dzxr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47149A36-A63A-11EC-AA90-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Fixes a bug whereby rebase updates the deferenced reference HEAD points
> to instead of HEAD directly.

Perhaps

    "git rebase A B", where B is not a commit, should behave as if
    the HEAD got detached at B and then the detached HEAD got
    rebased on top of A.  A bug however overwrites the current
    branch to point at B, when B is a descendant of A (i.e. the
    rebase ends up being a fast-forward).

> ... See [1] for
> the original bug report.

OK (URL is wrong; see below).

The explanation of how the bug occurs (elided) in the patch looked
all reasonable.  It read well.

> ...
> Also add a test to ensure the correct behavior.

Yup.  _Add_ a test to ensure that.  Not replace a misleading test
that expected to see a wrong behaviour.

> 1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/

This is not the original bug report.  It was an early hint for
diagnosis.

[1] https://lore.kernel.org/git/YiokTm3GxIZQQUow@newk/

would be a more appropriate pointer.

>  	ropts.oid = &options->orig_head;
>  	ropts.branch = options->head_name;
>  	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
> +	if (!ropts.branch)
> +		ropts.flags |=  RESET_HEAD_DETACH;
>  	ropts.head_msg = buf.buf;

OK.  If head_name is not set, we do not want to touch the branch
the HEAD happens to be pointing at, so we want to detach.

> +test_expect_success 'switch to non-branch detaches HEAD' '
>  	git checkout main &&
>  	old_main=$(git rev-parse HEAD) &&
>  	git rebase First Second^0 &&
> -	test_cmp_rev HEAD main &&
> -	test_cmp_rev main $(git rev-parse Second) &&
> -	git symbolic-ref HEAD
> +	test_cmp_rev HEAD Second &&
> +	test_cmp_rev main $old_main &&
> +	test_must_fail git symbolic-ref HEAD

As we want (1) HEAD (detached) is pointing at Second, (2) 'main'
stayed at $old_main, and (3) HEAD is detched, these three conditions
look sane.

Thanks.

For reference, I discarded [1/3], queued [2/3] and replaced this
[3/3] with the following for now.

---- >8 ---- ---- >8 ---- ---- >8 ---- ---- >8 ---- ---- >8 ----
From: John Cai <johncai86@gmail.com>
Subject: [PATCH] rebase: set REF_HEAD_DETACH in checkout_up_to_date()

"git rebase A B" where B is not a commit should behave as if the
HEAD got detached at B and then the detached HEAD got rebased on top
of A.  A bug however overwrites the current branch to point at B,
when B is a descendant of A (i.e. the rebase ends up being a
fast-forward).  See [1] for the original bug report.

The callstack from checkout_up_to_date() is the following:

cmd_rebase()
-> checkout_up_to_date()
   -> reset_head()
      -> update_refs()
         -> update_ref()

When B is not a valid branch but an oid, rebase sets the head_name
of rebase_options to NULL. This value gets passed down this call
chain through the branch member of reset_head_opts also getting set
to NULL all the way to update_refs().

Then update_refs() checks ropts.branch to decide whether or not to switch
branches. If ropts.branch is NULL, it calls update_ref() to update HEAD.
At this point however, from rebase's point of view, we want a detached
HEAD. But, since checkout_up_to_date() does not set the RESET_HEAD_DETACH
flag, the update_ref() call will deference HEAD and update the branch its
pointing to. We want the HEAD detached at B instead.

Fix this bug by adding the RESET_HEAD_DETACH flag in
checkout_up_to_date if B is not a valid branch, so that once
reset_head() calls update_refs(), it calls update_ref() with
REF_NO_DEREF which updates HEAD directly intead of deferencing it
and updating the branch that HEAD points to.

Also add a test to ensure the correct behavior.

[1] https://lore.kernel.org/git/YiokTm3GxIZQQUow@newk/

Reported-by: Michael McClimon <michael@mcclimon.org>
Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rebase.c  | 2 ++
 t/t3400-rebase.sh | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b29ad2b65e..27fde7bf28 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -829,6 +829,8 @@ static int checkout_up_to_date(struct rebase_options *options)
 	ropts.oid = &options->orig_head;
 	ropts.branch = options->head_name;
 	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	if (!ropts.branch)
+		ropts.flags |=  RESET_HEAD_DETACH;
 	ropts.head_msg = buf.buf;
 	if (reset_head(the_repository, &ropts) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 6dc8df8be7..cf55b017ff 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -389,6 +389,15 @@ test_expect_success 'switch to branch not checked out' '
 	git rebase main other
 '
 
+test_expect_success 'switch to non-branch detaches HEAD' '
+	git checkout main &&
+	old_main=$(git rev-parse HEAD) &&
+	git rebase First Second^0 &&
+	test_cmp_rev HEAD Second &&
+	test_cmp_rev main $old_main &&
+	test_must_fail git symbolic-ref HEAD
+'
+
 test_expect_success 'refuse to switch to branch checked out elsewhere' '
 	git checkout main &&
 	git worktree add wt &&
-- 
2.35.1-757-g4266a5c05c


