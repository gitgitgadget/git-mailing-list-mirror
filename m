From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 18/23] git notes merge: --commit should fail if underlying
 notes ref has moved
Date: Mon, 25 Oct 2010 02:08:48 +0200
Message-ID: <1287965333-5099-19-git-send-email-johan@herland.net>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 25 02:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAAdn-0000ju-2E
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 02:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab0JYAJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 20:09:30 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59867 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936Ab0JYAJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 20:09:28 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT0051SKFMGG50@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:22 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 9561917990DB_CC4CAB2B	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:22 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 595D61796591_CC4CAB2F	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:21 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT004SRKFAVB20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:17 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1287965333-5099-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159908>

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
index b440378..ca09d45 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -786,7 +786,7 @@ static int merge_abort(struct notes_merge_options *o)
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
index 287fab8..4ec4d11 100755
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
+	git notes merge --abort &&
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
1.7.3.98.g5ad7d9
