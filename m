Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18F56201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 01:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbdBUBK6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 20:10:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52059 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751140AbdBUBKy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 20:10:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47070696CF;
        Mon, 20 Feb 2017 20:10:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=wS6r
        xLjhQzdmupBh9a9mqIO24Ug=; b=uyklhpLWVAiIzDj6V5xXLyD+fUOwStsA2TtU
        m9KCT8ZybViy6wM5ys7Qa/S6QQyFmdbP3y01+DGqdUjSrL0CZnfVNPX0Ht0007BE
        Q8opE779DE/UXyM5iuvakLPF0ZmRaaxCytVLJMWHHEpDTqTi9z9dStdurHyEJKBf
        PzGL+bQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E947696CE;
        Mon, 20 Feb 2017 20:10:53 -0500 (EST)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83E3B696C8;
        Mon, 20 Feb 2017 20:10:51 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: [PATCH v2 4/4] branch: record creation of renamed branch in HEAD's log
Date:   Mon, 20 Feb 2017 20:10:35 -0500
Message-Id: <20170221011035.847-5-kyle@kyleam.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170221011035.847-1-kyle@kyleam.com>
References: <20170217035800.13214-1-kyle@kyleam.com>
 <20170221011035.847-1-kyle@kyleam.com>
X-Pobox-Relay-ID: 96CDC442-F7D2-11E6-9429-FE3F13518317-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=wS6rxLjhQzdmupBh9a9mqIO24Ug=;
 b=Anq/2aQhm0R0yKXQ+vFXrRkoDjF44QtOtloh/E+F1sBX7F5ETSeRTm5NjjUUDviJhrm0mLoqovguLbphrqfZzAmMk58w2Ylosiiu+AIOAYK2TvGHTOJE5ADGslAsGxGUxehPKkzWLpIOAS0dqbOqBn8PSkVLxTo8oBROb5tHTfw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Renaming the current branch adds an event to the current branch's log
and to HEAD's log.  However, the logged entries differ.  The entry in
the branch's log represents the entire renaming operation (the old and
new hash are identical), whereas the entry in HEAD's log represents
the deletion only (the new sha1 is null).

Extend replace_each_worktree_head_symref(), whose only caller is
branch_rename(), to take a reflog message argument.  This allows the
creation of the new ref to be recorded in HEAD's log.  As a result,
the renaming event is represented by two entries (a deletion and a
creation entry) in HEAD's log.

It's a bit unfortunate that the branch's log and HEAD's log now
represent the renaming event in different ways.  Given that the
renaming operation is not atomic, the two-entry form is a more
accurate representation of the operation and is more useful for
debugging purposes if a failure occurs between the deletion and
creation events.  It would make sense to move the branch's log to the
two-entry form, but this would involve changes to how the rename is
carried out and to how the update flags and reflogs are processed for
deletions, so it may not be worth the effort.

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 branch.c             | 5 +++--
 branch.h             | 3 ++-
 builtin/branch.c     | 5 +++--
 refs.h               | 3 ++-
 refs/files-backend.c | 4 ++--
 t/t3200-branch.sh    | 5 +++--
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/branch.c b/branch.c
index b955d4f31..5c12036b0 100644
--- a/branch.c
+++ b/branch.c
@@ -345,7 +345,8 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree)
 	    branch, wt->path);
 }
 
-int replace_each_worktree_head_symref(const char *oldref, const char *newref)
+int replace_each_worktree_head_symref(const char *oldref, const char *newref,
+				      const char *logmsg)
 {
 	int ret = 0;
 	struct worktree **worktrees = get_worktrees(0);
@@ -358,7 +359,7 @@ int replace_each_worktree_head_symref(const char *oldref, const char *newref)
 			continue;
 
 		if (set_worktree_head_symref(get_worktree_git_dir(worktrees[i]),
-					     newref)) {
+					     newref, logmsg)) {
 			ret = -1;
 			error(_("HEAD of working tree %s is not updated"),
 			      worktrees[i]->path);
diff --git a/branch.h b/branch.h
index 3103eb9ad..b07788558 100644
--- a/branch.h
+++ b/branch.h
@@ -71,6 +71,7 @@ extern void die_if_checked_out(const char *branch, int ignore_current_worktree);
  * This will be used when renaming a branch. Returns 0 if successful, non-zero
  * otherwise.
  */
-extern int replace_each_worktree_head_symref(const char *oldref, const char *newref);
+extern int replace_each_worktree_head_symref(const char *oldref, const char *newref,
+					     const char *logmsg);
 
 #endif
diff --git a/builtin/branch.c b/builtin/branch.c
index 8f8242e07..e1f97dcfc 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -579,14 +579,15 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 
 	if (rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch rename failed"));
-	strbuf_release(&logmsg);
 
 	if (recovery)
 		warning(_("Renamed a misnamed branch '%s' away"), oldref.buf + 11);
 
-	if (replace_each_worktree_head_symref(oldref.buf, newref.buf))
+	if (replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
 
+	strbuf_release(&logmsg);
+
 	strbuf_addf(&oldsection, "branch.%s", oldref.buf + 11);
 	strbuf_release(&oldref);
 	strbuf_addf(&newsection, "branch.%s", newref.buf + 11);
diff --git a/refs.h b/refs.h
index 5880886a7..e529f4c3a 100644
--- a/refs.h
+++ b/refs.h
@@ -334,7 +334,8 @@ int create_symref(const char *refname, const char *target, const char *logmsg);
  * $GIT_DIR points to.
  * Return 0 if successful, non-zero otherwise.
  * */
-int set_worktree_head_symref(const char *gitdir, const char *target);
+int set_worktree_head_symref(const char *gitdir, const char *target,
+			     const char *logmsg);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f6e7c192c..42b137bb1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3055,7 +3055,7 @@ static int files_create_symref(struct ref_store *ref_store,
 	return ret;
 }
 
-int set_worktree_head_symref(const char *gitdir, const char *target)
+int set_worktree_head_symref(const char *gitdir, const char *target, const char *logmsg)
 {
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
@@ -3083,7 +3083,7 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	lock->lk = &head_lock;
 	lock->ref_name = xstrdup(head_rel);
 
-	ret = create_symref_locked(lock, head_rel, target, NULL);
+	ret = create_symref_locked(lock, head_rel, target, logmsg);
 
 	unlock_ref(lock); /* will free lock */
 	strbuf_release(&head_path);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 0dbc54003..d84837d08 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -139,9 +139,10 @@ test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
 	test $(git rev-parse --abbrev-ref HEAD) = bam
 '
 
-test_expect_success 'git branch -M baz bam should add entry to .git/logs/HEAD' '
+test_expect_success 'git branch -M baz bam should add entries to .git/logs/HEAD' '
         msg="Branch: renamed refs/heads/baz to refs/heads/bam" &&
-	grep " 0\{40\}.*$msg$" .git/logs/HEAD
+	grep " 0\{40\}.*$msg$" .git/logs/HEAD &&
+	grep "^0\{40\}.*$msg$" .git/logs/HEAD
 '
 
 test_expect_success 'git branch -M baz bam should succeed when baz is checked out as linked working tree' '
-- 
2.11.1

