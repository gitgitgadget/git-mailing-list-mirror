From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] notes: dry-run and verbose options for prune
Date: Fri, 14 May 2010 23:42:07 +0200
Message-ID: <ecbe317d2f12d83185f3c3242c0350051e3b4bfa.1273873273.git.git@drmicha.warpmail.net>
Cc: Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 23:42:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD2e8-0003xo-T2
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 23:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758338Ab0ENVmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 17:42:11 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52873 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757401Ab0ENVmJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 17:42:09 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D8321F7DD9;
	Fri, 14 May 2010 17:42:04 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 14 May 2010 17:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=zYF3ob70FpAwCltFTZHsvtiR1Is=; b=YMIWgJZoa7QcOjQSs2I0Ur4i7qAVW0bltvQPQRB+XnDHLI7DuOmH8zezh3F33vJ9vlHgQvHemU2FvQKzZA84nHq6asq+QC8IqApCT8VZxTAqBZG0vtlH6btAMsQlesgZwbxmI1ZdmkByoDC+wKpb8r+8tmgZZGgfXZ2Dtle6RFU=
X-Sasl-enc: o5BTe8S8wHHeesJXet8WUkEu2OPqYDD2lkI2kgWAhVrY 1273873323
Received: from localhost (p5485982A.dip0.t-ipconnect.de [84.133.152.42])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5959B4D5F42;
	Fri, 14 May 2010 17:42:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.240.geeaa4d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147122>

Introduce -n and -v options for "git notes prune" in complete analogy to
"git prune" so that one can check for dangling notes easily.

The output is a list of names of objects whose notes would be resp.
are removed so that one can check the object ("git show sha1") as well as
the note ("git notes show sha1").

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-notes.txt |    9 +++++++-
 builtin/notes.c             |   13 ++++++++---
 notes.c                     |    7 ++++-
 notes.h                     |    5 +++-
 t/t3306-notes-prune.sh      |   48 +++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 4e5113b..0f32792 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 'git notes' edit [<object>]
 'git notes' show [<object>]
 'git notes' remove [<object>]
-'git notes' prune
+'git notes' prune [-n | -v]
 
 
 DESCRIPTION
@@ -121,6 +121,13 @@ OPTIONS
 	GIT_NOTES_REF and the "core.notesRef" configuration.  The ref
 	is taken to be in `refs/notes/` if it is not qualified.
 
+-n::
+	Do not remove anything; just report the object names whose notes
+	would be removed.
+
+-v::
+	Report all object names whose notes are removed.
+
 
 NOTES
 -----
diff --git a/builtin/notes.c b/builtin/notes.c
index 52b72fc..8c2ac51 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -26,7 +26,7 @@ static const char * const git_notes_usage[] = {
 	"git notes [--ref <notes_ref>] edit [<object>]",
 	"git notes [--ref <notes_ref>] show [<object>]",
 	"git notes [--ref <notes_ref>] remove [<object>]",
-	"git notes [--ref <notes_ref>] prune",
+	"git notes [--ref <notes_ref>] prune [-n | -v]",
 	NULL
 };
 
@@ -67,7 +67,7 @@ static const char * const git_notes_remove_usage[] = {
 };
 
 static const char * const git_notes_prune_usage[] = {
-	"git notes prune",
+	"git notes prune [<options>]",
 	NULL
 };
 
@@ -792,7 +792,10 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
 static int prune(int argc, const char **argv, const char *prefix)
 {
 	struct notes_tree *t;
+	int show_only, verbose;
 	struct option options[] = {
+		OPT_BOOLEAN('n', NULL, &show_only, "do not remove, show only"),
+		OPT_BOOLEAN('v', NULL, &verbose, "report pruned notes"),
 		OPT_END()
 	};
 
@@ -806,8 +809,10 @@ static int prune(int argc, const char **argv, const char *prefix)
 
 	t = init_notes_check("prune");
 
-	prune_notes(t);
-	commit_notes(t, "Notes removed by 'git notes prune'");
+	prune_notes(t, (verbose ? NOTES_PRUNE_VERBOSE : 0) |
+		(show_only ? NOTES_PRUNE_VERBOSE|NOTES_PRUNE_DRYRUN : 0) );
+	if (!show_only)
+		commit_notes(t, "Notes removed by 'git notes prune'");
 	free_notes(t);
 	return 0;
 }
diff --git a/notes.c b/notes.c
index e425e19..6ee04e7 100644
--- a/notes.c
+++ b/notes.c
@@ -1083,7 +1083,7 @@ int write_notes_tree(struct notes_tree *t, unsigned char *result)
 	return ret;
 }
 
-void prune_notes(struct notes_tree *t)
+void prune_notes(struct notes_tree *t, int flags)
 {
 	struct note_delete_list *l = NULL;
 
@@ -1094,7 +1094,10 @@ void prune_notes(struct notes_tree *t)
 	for_each_note(t, 0, prune_notes_helper, &l);
 
 	while (l) {
-		remove_note(t, l->sha1);
+		if (flags & NOTES_PRUNE_VERBOSE)
+			printf("%s\n", sha1_to_hex(l->sha1));
+		if (!(flags & NOTES_PRUNE_DRYRUN))
+			remove_note(t, l->sha1);
 		l = l->next;
 	}
 }
diff --git a/notes.h b/notes.h
index 9f59277..cc2dff2 100644
--- a/notes.h
+++ b/notes.h
@@ -171,6 +171,9 @@ int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
  */
 int write_notes_tree(struct notes_tree *t, unsigned char *result);
 
+/* Flags controlling the operation of prune */
+#define NOTES_PRUNE_VERBOSE 1
+#define NOTES_PRUNE_DRYRUN 2
 /*
  * Remove all notes annotating non-existing objects from the given notes tree
  *
@@ -181,7 +184,7 @@ int write_notes_tree(struct notes_tree *t, unsigned char *result);
  * structure are not persistent until a subsequent call to write_notes_tree()
  * returns zero.
  */
-void prune_notes(struct notes_tree *t);
+void prune_notes(struct notes_tree *t, int flags);
 
 /*
  * Free (and de-initialize) the given notes_tree structure
diff --git a/t/t3306-notes-prune.sh b/t/t3306-notes-prune.sh
index a0ed035..a47e4b5 100755
--- a/t/t3306-notes-prune.sh
+++ b/t/t3306-notes-prune.sh
@@ -60,7 +60,7 @@ test_expect_success 'verify commits and notes' '
 
 test_expect_success 'remove some commits' '
 
-	git reset --hard HEAD~2 &&
+	git reset --hard HEAD~1 &&
 	git reflog expire --expire=now HEAD &&
 	git gc --prune=now
 '
@@ -68,7 +68,7 @@ test_expect_success 'remove some commits' '
 test_expect_success 'verify that commits are gone' '
 
 	! git cat-file -p 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
-	! git cat-file -p 08341ad9e94faa089d60fd3f523affb25c6da189 &&
+	git cat-file -p 08341ad9e94faa089d60fd3f523affb25c6da189 &&
 	git cat-file -p ab5f302035f2e7aaf04265f08b42034c23256e1f
 '
 
@@ -79,6 +79,26 @@ test_expect_success 'verify that notes are still present' '
 	git notes show ab5f302035f2e7aaf04265f08b42034c23256e1f
 '
 
+test_expect_success 'prune -n does not remove notes' '
+
+	git notes list > expect &&
+	git notes prune -n &&
+	git notes list > actual &&
+	test_cmp expect actual
+'
+
+cat > expect <<EOF
+5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29
+EOF
+
+test_expect_success 'prune -n lists prunable notes' '
+
+	
+	git notes prune -n > actual &&
+	test_cmp expect actual
+' 
+
+
 test_expect_success 'prune notes' '
 
 	git notes prune
@@ -87,6 +107,30 @@ test_expect_success 'prune notes' '
 test_expect_success 'verify that notes are gone' '
 
 	! git notes show 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
+	git notes show 08341ad9e94faa089d60fd3f523affb25c6da189 &&
+	git notes show ab5f302035f2e7aaf04265f08b42034c23256e1f
+'
+
+test_expect_success 'remove some commits' '
+
+	git reset --hard HEAD~1 &&
+	git reflog expire --expire=now HEAD &&
+	git gc --prune=now
+'
+
+cat > expect <<EOF
+08341ad9e94faa089d60fd3f523affb25c6da189
+EOF
+
+test_expect_success 'prune -v notes' '
+
+	git notes prune -v > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'verify that notes are gone' '
+
+	! git notes show 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
 	! git notes show 08341ad9e94faa089d60fd3f523affb25c6da189 &&
 	git notes show ab5f302035f2e7aaf04265f08b42034c23256e1f
 '
-- 
1.7.1.240.geeaa4d
