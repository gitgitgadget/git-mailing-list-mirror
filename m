From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 18/21] git notes merge: --commit should fail if underlying notes ref has moved
Date: Sat,  9 Oct 2010 03:15:53 +0200
Message-ID: <1286586956-3714-19-git-send-email-johan@herland.net>
References: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 03:17:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4O3Y-0004Cm-AH
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760135Ab0JIBQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 21:16:40 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:53180 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab0JIBQh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:16:37 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=localhost.localdomain)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4O39-0001yv-TY; Sat, 09 Oct 2010 03:16:36 +0200
X-Mailer: git-send-email 1.7.3.1.104.g92b87a
In-Reply-To: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158569>

When manually resolving a notes merge, if the merging ref has moved since
the merge started, we should fail to complete the merge, and alert the user
to what's going on.

This situation may arise if you start a 'git notes merge' which results in
conflicts, and you then update the current notes ref (using for example
'git notes add/copy/amend/edit/remove/prune', 'git update-ref', etc.),
before you get around to resolving the notes conflicts and calling
'git notes merge --commit'.

We detect this situation by comparing the first parent of the partial merge
commit (which was created when the merge started) to the current value of the
merging notes ref (pointed to by the .git/NOTES_MERGE_REF symref).

If we don't fail in this situation, the notes merge commit would overwrite
the updated notes ref, thus losing the changes that happened in the meantime.

The patch includes a testcase verifying that we fail correctly in this
situation.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c                       |   11 ++++-
 t/t3310-notes-merge-manual-resolve.sh |   76 +++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 3c373ec..d3754ab 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -786,7 +786,7 @@ static int merge_reset(struct notes_merge_options *o)
 static int merge_commit(struct notes_merge_options *o)
 {
 	struct strbuf msg = STRBUF_INIT;
-	unsigned char sha1[20];
+	unsigned char sha1[20], parent_sha1[20];
 	struct notes_tree *t;
 	struct commit *partial;
 	struct pretty_print_context pretty_ctx;
@@ -803,6 +803,11 @@ static int merge_commit(struct notes_merge_options *o)
 	else if (parse_commit(partial))
 		die("Could not parse commit from NOTES_MERGE_PARTIAL.");
 
+	if (partial->parents)
+		hashcpy(parent_sha1, partial->parents->item->object.sha1);
+	else
+		hashclr(parent_sha1);
+
 	t = xcalloc(1, sizeof(struct notes_tree));
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
 
@@ -818,7 +823,9 @@ static int merge_commit(struct notes_merge_options *o)
 	format_commit_message(partial, "%s", &msg, &pretty_ctx);
 	strbuf_trim(&msg);
 	strbuf_insert(&msg, 0, "notes: ", 7);
-	update_ref(msg.buf, o->local_ref, sha1, NULL, 0, DIE_ON_ERR);
+	update_ref(msg.buf, o->local_ref, sha1,
+		   is_null_sha1(parent_sha1) ? NULL : parent_sha1,
+		   0, DIE_ON_ERR);
 
 	free_notes(t);
 	strbuf_release(&msg);
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 8568307..dfd4954 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -477,4 +477,80 @@ EOF
 	verify_notes z
 '
 
+cp expect_notes_y expect_notes_m
+cp expect_log_y expect_log_m
+
+test_expect_success 'redo merge of z into m (== y) with default ("manual") resolver => Conflicting 3-way merge' '
+	git update-ref refs/notes/m refs/notes/y &&
+	test_must_fail git notes merge z >output &&
+	# Output should point to where to resolve conflicts
+	grep -q "\\.git/NOTES_MERGE_WORKTREE" output &&
+	# Inspect merge conflicts
+	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
+	test_cmp expect_conflicts output_conflicts &&
+	( for f in $(cat expect_conflicts); do
+		test_cmp "expect_conflict_$f" ".git/NOTES_MERGE_WORKTREE/$f" ||
+		exit 1
+	done ) &&
+	# Verify that current notes tree (pre-merge) has not changed (m == y)
+	verify_notes y &&
+	verify_notes m &&
+	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)"
+'
+
+cp expect_notes_w expect_notes_m
+cp expect_log_w expect_log_m
+
+test_expect_success 'reset notes ref m to somewhere else (w)' '
+	git update-ref refs/notes/m refs/notes/w &&
+	verify_notes m &&
+	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)"
+'
+
+test_expect_success 'fail to finalize conflicting merge if underlying ref has moved in the meantime (m != NOTES_MERGE_PARTIAL^1)' '
+	# Resolve conflicts
+	cat >.git/NOTES_MERGE_WORKTREE/$commit_sha1 <<EOF &&
+y and z notes on 1st commit
+EOF
+	cat >.git/NOTES_MERGE_WORKTREE/$commit_sha4 <<EOF &&
+y and z notes on 4th commit
+EOF
+	# Fail to finalize merge
+	test_must_fail git notes merge --commit >output 2>&1 &&
+	# .git/NOTES_MERGE_* must remain
+	test -f .git/NOTES_MERGE_PARTIAL &&
+	test -f .git/NOTES_MERGE_REF &&
+	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha1 &&
+	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha2 &&
+	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
+	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
+	# Refs are unchanged
+	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)"
+	test "$(git rev-parse refs/notes/y)" = "$(git rev-parse NOTES_MERGE_PARTIAL^1)"
+	test "$(git rev-parse refs/notes/m)" != "$(git rev-parse NOTES_MERGE_PARTIAL^1)"
+	# Mention refs/notes/m, and its current and expected value in output
+	grep -q "refs/notes/m" output &&
+	grep -q "$(git rev-parse refs/notes/m)" output &&
+	grep -q "$(git rev-parse NOTES_MERGE_PARTIAL^1)" output &&
+	# Verify that other notes refs has not changed (w, x, y and z)
+	verify_notes w &&
+	verify_notes x &&
+	verify_notes y &&
+	verify_notes z
+'
+
+test_expect_success 'resolve situation by aborting the notes merge' '
+	git notes merge --reset &&
+	# No .git/NOTES_MERGE_* files left
+	test_must_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
+	test_cmp /dev/null output &&
+	# m has not moved (still == w)
+	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)"
+	# Verify that other notes refs has not changed (w, x, y and z)
+	verify_notes w &&
+	verify_notes x &&
+	verify_notes y &&
+	verify_notes z
+'
+
 test_done
-- 
1.7.3.1.104.g92b87a
