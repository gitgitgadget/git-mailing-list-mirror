From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 5/5] reset: disallow using --keep when there are unmerged
	entries
Date: Tue, 19 Jan 2010 05:26:01 +0100
Message-ID: <20100119042602.4510.53789.chriscool@tuxfamily.org>
References: <20100119042404.4510.48855.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Daniel Convissor <danielc@analysisandsolutions.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 05:24:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX5dl-0006y9-54
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 05:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983Ab0ASEY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 23:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754932Ab0ASEYZ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 23:24:25 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53690 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752321Ab0ASEYW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 23:24:22 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4CC03818070;
	Tue, 19 Jan 2010 05:24:00 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DC2DB818073;
	Tue, 19 Jan 2010 05:23:57 +0100 (CET)
X-git-sha1: bdb60e999839e295954bfb6fc2f7444d363ee2bc 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100119042404.4510.48855.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137419>

The use case for --keep option is to remove previous commits unrelated
to the current changes in the working tree. So in this use case we are
not supposed to have unmerged entries. This is why it seems safer to
just disallow using --keep when there are unmerged entries.

And this patch changes the error message when --keep was disallowed and
there were some unmerged entries from:

    error: Entry 'file1' would be overwritten by merge. Cannot merge.
    fatal: Could not reset index file to revision 'HEAD^'.

to:

    fatal: Cannot do a keep reset in the middle of a merge.

which is nicer.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-reset.txt |    5 +++--
 builtin-reset.c             |   17 +++++++++++++----
 t/t7110-reset-merge.sh      |   23 +++++++++--------------
 t/t7111-reset-table.sh      |    2 +-
 4 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 90239f5..d2f6880 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -155,7 +155,8 @@ If there could be conflicts between the changes in the commit we want
 to remove and the changes in the working tree we want to keep, the
 reset is disallowed. That's why it is disallowed if there are both
 changes between the working tree and HEAD, and between HEAD and the
-target.
+target. To be safe, it is also disallowed when there are unmerged
+entries.
 
 The following tables show what happens when there are unmerged
 entries:
@@ -174,7 +175,7 @@ entries:
 				--mixed  X       A     A
 				--hard   A       A     A
 				--merge  A       A     A
-				--keep   X       A     A
+				--keep  (disallowed)
 
 X means any state and U means an unmerged index.
 
diff --git a/builtin-reset.c b/builtin-reset.c
index 52584af..441ac1b 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -224,6 +224,14 @@ static void prepend_reflog_action(const char *action, char *buf, size_t size)
 		warning("Reflog action message too long: %.*s...", 50, buf);
 }
 
+static void die_if_unmerged_cache(int reset_type)
+{
+	if (is_merge() || read_cache() < 0 || unmerged_cache())
+		die("Cannot do a %s reset in the middle of a merge.",
+		    reset_type_names[reset_type]);
+
+}
+
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
@@ -329,10 +337,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
-	if (reset_type == SOFT) {
-		if (is_merge() || read_cache() < 0 || unmerged_cache())
-			die("Cannot do a soft reset in the middle of a merge.");
-	} else {
+	if (reset_type == SOFT)
+		die_if_unmerged_cache(reset_type);
+	else {
+		if (reset_type == KEEP)
+			die_if_unmerged_cache(reset_type);
 		int err = reset_index_file(sha1, reset_type, quiet);
 		if (reset_type == KEEP)
 			err = err || reset_index_file(sha1, MIXED, quiet);
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 1a9c1c7..70cdd8e 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -237,7 +237,7 @@ test_expect_success '"reset --keep HEAD^" fails with pending merge' '
     git reset --hard third &&
     test_must_fail git merge branch1 &&
     test_must_fail git reset --keep HEAD^ 2>err.log &&
-    grep file1 err.log | grep "overwritten by merge"
+    grep "middle of a merge" err.log
 '
 
 # The next test will test the following:
@@ -258,18 +258,15 @@ test_expect_success '"reset --merge HEAD" is ok with pending merge' '
 #
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
-# file1:     X       U     B    B     --keep  X       B     B
-test_expect_success '"reset --keep HEAD" is ok with pending merge' '
+# file1:     X       U     B    B     --keep   (disallowed)
+test_expect_success '"reset --keep HEAD" fails with pending merge' '
     git reset --hard third &&
     test_must_fail git merge branch1 &&
-    cat file1 >orig_file1 &&
-    git reset --keep HEAD &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse third)" &&
-    test -z "$(git diff --cached)" &&
-    test_cmp file1 orig_file1
+    test_must_fail git reset --keep HEAD 2>err.log &&
+    grep "middle of a merge" err.log
 '
 
-test_expect_success '--merge with added/deleted' '
+test_expect_success '--merge is ok with added/deleted merge' '
     git reset --hard third &&
     rm -f file2 &&
     test_must_fail git merge branch3 &&
@@ -283,7 +280,7 @@ test_expect_success '--merge with added/deleted' '
     git diff --exit-code --cached
 '
 
-test_expect_success '--keep with added/deleted' '
+test_expect_success '--keep fails with added/deleted merge' '
     git reset --hard third &&
     rm -f file2 &&
     test_must_fail git merge branch3 &&
@@ -291,10 +288,8 @@ test_expect_success '--keep with added/deleted' '
     test -f file3 &&
     git diff --exit-code file3 &&
     git diff --exit-code branch3 file3 &&
-    git reset --keep HEAD &&
-    test -f file3 &&
-    ! test -f file2 &&
-    git diff --exit-code --cached
+    test_must_fail git reset --keep HEAD 2>err.log &&
+    grep "middle of a merge" err.log
 '
 
 test_done
diff --git a/t/t7111-reset-table.sh b/t/t7111-reset-table.sh
index 2ebda97..ce421ad 100755
--- a/t/t7111-reset-table.sh
+++ b/t/t7111-reset-table.sh
@@ -115,7 +115,7 @@ X U B B soft   XXXXX
 X U B B mixed  X B B
 X U B B hard   B B B
 X U B B merge  B B B
-X U B B keep   X B B
+X U B B keep   XXXXX
 EOF
 
 test_done
-- 
1.6.6.271.gc8799
