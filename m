From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: [PATCH] bisect: improve output when bad commit is found
Date: Mon, 11 May 2015 16:58:59 -0400
Message-ID: <1431377939-13887-1-git-send-email-tbsaunde@tbsaunde.org>
Cc: Trevor Saunders <tbsaunde@tbsaunde.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 22:59:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrunE-0003CQ-7e
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 22:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbbEKU7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 16:59:12 -0400
Received: from tbsaunde.org ([66.228.47.254]:43840 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbbEKU7K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 16:59:10 -0400
Received: from iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id 4A779C07C;
	Mon, 11 May 2015 20:59:09 +0000 (UTC)
X-Mailer: git-send-email 2.4.0.78.g7c6ecbf.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268823>

When the first bad commit has been found git bisect prints something
like this

<40 char sha1> is the first bad commit
Commit <40 char sha1>
...

<raw diff output>

The raw diff output is not really useful, and its kind of silly to print
the sha1 twice.  Instead lets print something like

the first bad commit is
Commit <sha1>
...

This also fixes an odd inconsistancy where if the first bad commit is a
trivial merge git bisect will only print the first line.
---
 bisect.c                    |  9 +++------
 git-bisect.sh               |  2 +-
 t/t6030-bisect-porcelain.sh | 30 +++++++++++++++++++-----------
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/bisect.c b/bisect.c
index 10f5e57..a0ebb7f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -875,17 +875,14 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 	init_revisions(&opt, prefix);
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	opt.abbrev = 0;
-	opt.diff = 1;
+	opt.diff = 0;
+	opt.always_show_header = 1;
 
 	/* This is what "--pretty" does */
 	opt.verbose_header = 1;
 	opt.use_terminator = 0;
 	opt.commit_format = CMIT_FMT_DEFAULT;
 
-	/* diff-tree init */
-	if (!opt.diffopt.output_format)
-		opt.diffopt.output_format = DIFF_FORMAT_RAW;
-
 	log_tree_commit(&opt, commit);
 }
 
@@ -942,7 +939,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	if (!hashcmp(bisect_rev, current_bad_oid->hash)) {
 		exit_if_skipped_commits(tried, current_bad_oid);
-		printf("%s is the first bad commit\n", bisect_rev_hex);
+		puts("the first bad commit is");
 		show_diff_tree(prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
 		exit(10);
diff --git a/git-bisect.sh b/git-bisect.sh
index ae3fec2..cb4bd2f 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -480,7 +480,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 			exit $res
 		fi
 
-		if sane_grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" >/dev/null
+		if sane_grep "the first bad commit is" "$GIT_DIR/BISECT_RUN" >/dev/null
 		then
 			gettextln "bisect run success"
 			exit 0;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 06b4868..bf50d20 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -26,6 +26,14 @@ add_line_into_file()
     git commit --quiet -m "$MSG" $_file
 }
 
+check_bisect_msg()
+{
+	file=$1
+	hash=$2
+	grep "the first bad commit is" $file || return $?
+	grep $hash $file || return $?
+}
+
 HASH1=
 HASH2=
 HASH3=
@@ -189,7 +197,7 @@ test_expect_success 'bisect skip: successful result' '
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
 	git bisect bad > my_bisect_log.txt &&
-	grep "$HASH2 is the first bad commit" my_bisect_log.txt
+	check_bisect_msg my_bisect_log.txt $HASH2
 '
 
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3 and $HASH2
@@ -254,7 +262,7 @@ test_expect_success \
      git bisect good $HASH1 &&
      git bisect bad $HASH4 &&
      git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
+     check_bisect_msg my_bisect_log.txt $HASH3 &&
      git bisect reset'
 
 # We want to automatically find the commit that
@@ -267,7 +275,7 @@ test_expect_success \
      chmod +x test_script.sh &&
      git bisect start $HASH4 $HASH1 &&
      git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH4 is the first bad commit" my_bisect_log.txt &&
+     check_bisect_msg my_bisect_log.txt $HASH4 &&
      git bisect reset'
 
 # $HASH1 is good, $HASH5 is bad, we skip $HASH3
@@ -280,14 +288,14 @@ test_expect_success 'bisect skip: add line and then a new test' '
 	git bisect start $HASH5 $HASH1 &&
 	git bisect skip &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
+	check_bisect_msg my_bisect_log.txt $HASH5 &&
 	git bisect log > log_to_replay.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bisect skip and bisect replay' '
 	git bisect replay log_to_replay.txt > my_bisect_log.txt &&
-	grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
+	check_bisect_msg my_bisect_log.txt $HASH5 &&
 	git bisect reset
 '
 
@@ -328,7 +336,7 @@ test_expect_success 'bisect run & skip: find first bad' '
 	chmod +x test_script.sh &&
 	git bisect start $HASH7 $HASH1 &&
 	git bisect run ./test_script.sh > my_bisect_log.txt &&
-	grep "$HASH6 is the first bad commit" my_bisect_log.txt
+	check_bisect_msg my_bisect_log.txt $HASH6
 '
 
 test_expect_success 'bisect skip only one range' '
@@ -378,7 +386,7 @@ test_expect_success 'bisect does not create a "bisect" branch' '
 	rev_hash6=$(git rev-parse --verify HEAD) &&
 	test "$rev_hash6" = "$HASH6" &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$HASH7 is the first bad commit" my_bisect_log.txt &&
+	check_bisect_msg my_bisect_log.txt $HASH7 &&
 	git bisect reset &&
 	rev_hash6=$(git rev-parse --verify bisect) &&
 	test "$rev_hash6" = "$HASH6" &&
@@ -527,7 +535,7 @@ test_expect_success 'restricting bisection on one dir' '
 	para1=$(git rev-parse --verify HEAD) &&
 	test "$para1" = "$PARA_HASH1" &&
 	git bisect bad > my_bisect_log.txt &&
-	grep "$PARA_HASH1 is the first bad commit" my_bisect_log.txt
+	check_bisect_msg my_bisect_log.txt $PARA_HASH1
 '
 
 test_expect_success 'restricting bisection on one dir and a file' '
@@ -545,7 +553,7 @@ test_expect_success 'restricting bisection on one dir and a file' '
 	para1=$(git rev-parse --verify HEAD) &&
 	test "$para1" = "$PARA_HASH1" &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$PARA_HASH4 is the first bad commit" my_bisect_log.txt
+	check_bisect_msg my_bisect_log.txt $PARA_HASH4
 '
 
 test_expect_success 'skipping away from skipped commit' '
@@ -576,7 +584,7 @@ test_expect_success 'test bisection on bare repo - --no-checkout specified' '
 			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
 			>../nocheckout.log
 	) &&
-	grep "$HASH3 is the first bad commit" nocheckout.log
+	check_bisect_msg  nocheckout.log $HASH3
 '
 
 
@@ -591,7 +599,7 @@ test_expect_success 'test bisection on bare repo - --no-checkout defaulted' '
 			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
 			>../defaulted.log
 	) &&
-	grep "$HASH3 is the first bad commit" defaulted.log
+	check_bisect_msg defaulted.log $HASH3
 '
 
 #
-- 
2.4.0.78.g7c6ecbf.dirty
