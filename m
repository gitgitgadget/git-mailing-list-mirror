From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Support 'diff=pgm' attribute
Date: Sun, 22 Apr 2007 18:02:31 -0700
Message-ID: <7vtzv7kimw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 03:02:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfmxB-0001AE-HI
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 03:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbXDWBCd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 21:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbXDWBCd
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 21:02:33 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38473 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030297AbXDWBCc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 21:02:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423010232.RHWU1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 21:02:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qR2X1W00U1kojtg0000000; Sun, 22 Apr 2007 21:02:32 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45294>

This enhances the attributes mechanism so that external programs
meant for existing GIT_EXTERNAL_DIFF interface can be specifed
per path.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This ought to be almost trivial, but the only complicating
   factor is that we need to disable any custom diff generation
   when commands other than "git diff" calls the textual diff
   generation.  Most notably, invoking kdiff3 when "git
   format-patch" is asked for does not make any sense.

   The existing GIT_EXTERNAL_DIFF already had this problem; the
   patch fixes it by allowing external diff hook (both the new
   attribute mechanism and the old environment based one) only
   when running the toplevel "git-diff" command.

 builtin-diff.c           |    1 +
 combine-diff.c           |    1 +
 diff.c                   |   27 ++++++++++++++++-
 diff.h                   |    1 +
 t/t4020-diff-external.sh |   69 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 2 deletions(-)
 create mode 100755 t/t4020-diff-external.sh

diff --git a/builtin-diff.c b/builtin-diff.c
index 21d13f0..2ae6009 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -225,6 +225,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		if (diff_setup_done(&rev.diffopt) < 0)
 			die("diff_setup_done failed");
 	}
+	rev.diffopt.allow_external = 1;
 
 	/* Do we have --cached and not have a pending object, then
 	 * default to HEAD by hand.  Eek.
diff --git a/combine-diff.c b/combine-diff.c
index 3a9b32f..cff9c5d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -943,6 +943,7 @@ void diff_tree_combined(const unsigned char *sha1,
 	diffopts = *opt;
 	diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diffopts.recursive = 1;
+	diffopts.allow_external = 0;
 
 	show_log_first = !!rev->loginfo && !rev->no_commit_id;
 	needsep = 0;
diff --git a/diff.c b/diff.c
index f516664..bdbfeb6 100644
--- a/diff.c
+++ b/diff.c
@@ -1077,8 +1077,8 @@ static int file_is_binary(struct diff_filespec *one)
 		else if (ATTR_UNSET(value))
 			;
 		else
-			die("unknown value %s given to 'diff' attribute",
-			    value);
+			/* has external diff attribute */
+			return 0;
 	}
 
 	if (!one->data) {
@@ -1752,6 +1752,21 @@ static void run_external_diff(const char *pgm,
 	}
 }
 
+static const char *external_diff_attr(const char *name)
+{
+	struct git_attr_check attr_diff_check;
+
+	setup_diff_attr_check(&attr_diff_check);
+	if (!git_checkattr(name, 1, &attr_diff_check)) {
+		const char *value = attr_diff_check.value;
+		if (!ATTR_TRUE(value) &&
+		    !ATTR_FALSE(value) &&
+		    !ATTR_UNSET(value))
+			return value;
+	}
+	return NULL;
+}
+
 static void run_diff_cmd(const char *pgm,
 			 const char *name,
 			 const char *other,
@@ -1761,6 +1776,14 @@ static void run_diff_cmd(const char *pgm,
 			 struct diff_options *o,
 			 int complete_rewrite)
 {
+	if (!o->allow_external)
+		pgm = NULL;
+	else {
+		const char *cmd = external_diff_attr(name);
+		if (cmd)
+			pgm = cmd;
+	}
+
 	if (pgm) {
 		run_external_diff(pgm, name, other, one, two, xfrm_msg,
 				  complete_rewrite);
diff --git a/diff.h b/diff.h
index a0d2ce1..63738c1 100644
--- a/diff.h
+++ b/diff.h
@@ -59,6 +59,7 @@ struct diff_options {
 		 color_diff_words:1,
 		 has_changes:1,
 		 quiet:1,
+		 allow_external:1,
 		 exit_with_status:1;
 	int context;
 	int break_opt;
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
new file mode 100755
index 0000000..60a93a7
--- /dev/null
+++ b/t/t4020-diff-external.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='external diff interface test'
+
+. ./test-lib.sh
+
+_z40=0000000000000000000000000000000000000000
+
+test_expect_success setup '
+
+	test_tick &&
+	echo initial >file &&
+	git add file &&
+	git commit -m initial &&
+
+	test_tick &&
+	echo second >file &&
+	git add file &&
+	git commit -m second &&
+
+	test_tick &&
+	echo third >file
+'
+
+test_expect_success 'GIT_EXTERNAL_DIFF environment' '
+
+	GIT_EXTERNAL_DIFF=echo git diff | {
+		read path oldfile oldhex oldmode newfile newhex newmode &&
+		test "z$path" = zfile &&
+		test "z$oldmode" = z100644 &&
+		test "z$newhex" = "z$_z40" &&
+		test "z$newmode" = z100644 &&
+		oh=$(git rev-parse --verify HEAD:file) &&
+		test "z$oh" = "z$oldhex"
+	}
+
+'
+
+test_expect_success 'GIT_EXTERNAL_DIFF environment should apply only to diff' '
+
+	GIT_EXTERNAL_DIFF=echo git log -p -1 HEAD |
+	grep "^diff --git a/file b/file"
+
+'
+
+test_expect_success 'diff attribute' '
+
+	echo >.gitattributes "file diff=echo" &&
+
+	git diff | {
+		read path oldfile oldhex oldmode newfile newhex newmode &&
+		test "z$path" = zfile &&
+		test "z$oldmode" = z100644 &&
+		test "z$newhex" = "z$_z40" &&
+		test "z$newmode" = z100644 &&
+		oh=$(git rev-parse --verify HEAD:file) &&
+		test "z$oh" = "z$oldhex"
+	}
+
+'
+
+test_expect_success 'diff attribute should apply only to diff' '
+
+	git log -p -1 HEAD |
+	grep "^diff --git a/file b/file"
+
+'
+
+test_done
-- 
1.5.1.2.928.ge9eadf
