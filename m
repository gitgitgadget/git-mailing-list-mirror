Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9BBC433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 17:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242345AbiEPR5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 13:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiEPR5d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 13:57:33 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0165F39BB4
        for <git@vger.kernel.org>; Mon, 16 May 2022 10:57:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61C081266F4;
        Mon, 16 May 2022 13:57:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Iivhn1j9J2dZh1EoJ0wGlOyQ8XW8S4FcR8nyVO
        fkdpU=; b=Bkl09PRjbImyZJWI1XGKFsqny4+8uo8FZn1Qm1QY9J+aMftUY4/to+
        0sedPrO2CcYYRVcN9sTQM5Oe8ehBe4gqQ1cyqcZJ8OUdTEhG2eytq28azk5/JYHD
        u6wgq88s21unh83NmAdhzEyFSzGAAs87jDbWjLtq0HOGsLGmyj7jM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 581491266F3;
        Mon, 16 May 2022 13:57:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB1C91266F2;
        Mon, 16 May 2022 13:57:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH v2] fetch: limit shared symref check only for local
 branches
References: <pull.1266.git.git.1652690275625.gitgitgadget@gmail.com>
        <pull.1266.v2.git.git.1652690501963.gitgitgadget@gmail.com>
        <xmqqv8u54gcm.fsf@gitster.g>
Date:   Mon, 16 May 2022 10:57:27 -0700
In-Reply-To: <xmqqv8u54gcm.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        16 May 2022 09:00:57 -0700")
Message-ID: <xmqqfsl92we0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6B09A54-D541-11EC-A84A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Limit it to protect only refs/heads/* to improve fetch performance.
>
> The point of the check is to prevent the index+working tree in the
> worktrees to go out of sync with HEAD, and HEAD by definition can
> point only into refs/heads/*, this change should be OK.

I am willing to take the above change as-is as a standalone patch,
but independently from that ...

> It is surprising find_shared_symref() is so expensive, though.  If
> you have a dozen worktrees linked to the current repository, there
> are at most a dozen HEAD that point at various refs in refs/heads/
> namespace.  Even if you need to check a thousand ref_map elements,
> it should cost almost nothing if you build a hashmap to find matches
> with these dozen HEADs upfront, no?
>
> Another thing that is surprising is that you say this loop is
> expensive when there are many tags or branches.  Do you mean it is
> expensive when there are many tags and branches that are updated, or
> it is expensive to merely have thousands of dormant tags and
> branches?  If the latter, I wonder if it is sensible to limit the
> check only to the refs that are going to be updated.

... I was wondering if an approach like the attached might be a
better way to proceed in the longer run.  Instead of (or in addition
to) reducing the number of calls to the function, we should see if
we can make the function less expensive.

In short, find_shared_symref(), and is_worktree_being_FUTZed(), is
following a wrong API pattern that encourages a loop to call them
repeatedly by taking 'target' parameter and doing a comparison
itself.  If you want to find if any of your 1000 refs violate what
they are trying to check, you'd need to call them 1000 times.

Instead, you should be able to learn which branch is to be protected
per each worktree and do the asking about your 1000 refs yourself.

If we instead find out what branch, other than the one pointed at by
the HEAD symref, each worktree is working on, just like we find out
what branch is pointed at by the HEAD symref, and store that
findings in the worktree structure, you should be able to walk the
list of worktrees just once to build a hashmap that lets you tell
which branches are not to be messed with before deciding if the
fetch should go through.

The following is not even compile tested, and some details may be
wrong, but I hope it is good enough to illustrate the idea.

 worktree.c | 73 ++++++++++++++++++++++++++++++++++----------------------------
 worktree.h |  5 +++++
 2 files changed, 45 insertions(+), 33 deletions(-)

diff --git c/worktree.c w/worktree.c
index 90fc085f76..2d96bd9dd1 100644
--- c/worktree.c
+++ w/worktree.c
@@ -15,6 +15,7 @@ void free_worktrees(struct worktree **worktrees)
 		free(worktrees[i]->path);
 		free(worktrees[i]->id);
 		free(worktrees[i]->head_ref);
+		free(worktrees[i]->protected_branch);
 		free(worktrees[i]->lock_reason);
 		free(worktrees[i]->prune_reason);
 		free(worktrees[i]);
@@ -22,13 +23,28 @@ void free_worktrees(struct worktree **worktrees)
 	free (worktrees);
 }
 
+int is_worktree_being_rebased(const struct worktree *wt,
+			      const char *target)
+{
+	return ((wt->protected_reason == WT_BRANCH_REBASING) &&
+		(!strcmp(target, wt->protected_branch)));
+}
+
+int is_worktree_being_bisected(const struct worktree *wt,
+			       const char *target)
+{
+	return ((wt->protected_reason == WT_BRANCH_BISECTING) &&
+		(!strcmp(target, wt->protected_branch)));
+}
+
 /**
- * Update head_oid, head_ref and is_detached of the given worktree
+ * Grab HEAD-related information of the given worktree
  */
 static void add_head_info(struct worktree *wt)
 {
 	int flags;
 	const char *target;
+	struct wt_status_state state;
 
 	target = refs_resolve_ref_unsafe(get_worktree_ref_store(wt),
 					 "HEAD",
@@ -41,6 +57,29 @@ static void add_head_info(struct worktree *wt)
 		wt->head_ref = xstrdup(target);
 	else
 		wt->is_detached = 1;
+
+	wt->protected_reason = 0;
+	memset(&state, 0, sizeof(state));
+	if (wt_status_check_rebase(wt, &state) &&
+	    (state.rebase_in_progress ||
+	     state.rebase_interactive_in_progress) &&
+	    state.branch &&
+	    skip_prefix(state.branch, "refs/heads/", &target)) {
+		wt->protected_branch = xstrdup(target);
+		wt->protected_reason = WT_BRANCH_REBASING;
+	}
+	wt_status_state_free_buffers(&state);
+
+	memset(&state, 0, sizeof(state));
+	if (wt_status_check_bisect(wt, &state) && state.branch &&
+	    skip_prefix(state.branch, "refs/heads/", &target)) {
+		if (wt->protected_reason)
+			BUG("branch '%s' being bisected and rebased at the same time?",
+			    wt->protected_branch);
+		wt->protected_branch = xstrdup(target);
+		wt->protected_reason = WT_BRANCH_BISECTING;
+	}
+	wt_status_state_free_buffers(&state);
 }
 
 /**
@@ -365,38 +404,6 @@ void update_worktree_location(struct worktree *wt, const char *path_)
 	strbuf_release(&path);
 }
 
-int is_worktree_being_rebased(const struct worktree *wt,
-			      const char *target)
-{
-	struct wt_status_state state;
-	int found_rebase;
-
-	memset(&state, 0, sizeof(state));
-	found_rebase = wt_status_check_rebase(wt, &state) &&
-		       (state.rebase_in_progress ||
-			state.rebase_interactive_in_progress) &&
-		       state.branch &&
-		       skip_prefix(target, "refs/heads/", &target) &&
-		       !strcmp(state.branch, target);
-	wt_status_state_free_buffers(&state);
-	return found_rebase;
-}
-
-int is_worktree_being_bisected(const struct worktree *wt,
-			       const char *target)
-{
-	struct wt_status_state state;
-	int found_bisect;
-
-	memset(&state, 0, sizeof(state));
-	found_bisect = wt_status_check_bisect(wt, &state) &&
-		       state.branch &&
-		       skip_prefix(target, "refs/heads/", &target) &&
-		       !strcmp(state.branch, target);
-	wt_status_state_free_buffers(&state);
-	return found_bisect;
-}
-
 /*
  * note: this function should be able to detect shared symref even if
  * HEAD is temporarily detached (e.g. in the middle of rebase or
diff --git c/worktree.h w/worktree.h
index e9e839926b..4e9d06c26a 100644
--- c/worktree.h
+++ w/worktree.h
@@ -10,6 +10,11 @@ struct worktree {
 	char *path;
 	char *id;
 	char *head_ref;		/* NULL if HEAD is broken or detached */
+	char *protected_branch; /* being rebased or bisected, othewise NULL */
+	enum {
+		WT_BRANCH_REBASING = 1,
+		WT_BRANCH_BISECTING,
+	} protected_reason;
 	char *lock_reason;	/* private - use worktree_lock_reason */
 	char *prune_reason;     /* private - use worktree_prune_reason */
 	struct object_id head_oid;
