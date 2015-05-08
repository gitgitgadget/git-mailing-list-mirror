From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Fri,  8 May 2015 19:46:03 -0400
Message-ID: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
Cc: Trevor Saunders <tbsaunde@tbsaunde.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 01:49:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqs1Q-0004Cb-Fk
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 01:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbbEHXtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 19:49:32 -0400
Received: from tbsaunde.org ([66.228.47.254]:41297 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbbEHXtb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 19:49:31 -0400
Received: from iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id 6C58AC072;
	Fri,  8 May 2015 23:49:30 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268687>

When bisect finds the first bad commit it prints the full commit hash
followed by " is the first bad commit".  That's not terribly readable,
and its rather silly especially considering the next line contains the
full hash again.  So change bisect to print the unique abbrev hash and
then "is the first bad commit".


---
 bisect.c                    |  3 ++-
 t/t6030-bisect-porcelain.sh | 28 +++++++++++++++++-----------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/bisect.c b/bisect.c
index 10f5e57..7cdb805 100644
--- a/bisect.c
+++ b/bisect.c
@@ -942,7 +942,8 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	if (!hashcmp(bisect_rev, current_bad_oid->hash)) {
 		exit_if_skipped_commits(tried, current_bad_oid);
-		printf("%s is the first bad commit\n", bisect_rev_hex);
+		printf("%s is the first bad commit\n",
+			find_unique_abbrev(bisect_rev, DEFAULT_ABBREV));
 		show_diff_tree(prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
 		exit(10);
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 06b4868..14232ed 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -26,6 +26,12 @@ add_line_into_file()
     git commit --quiet -m "$MSG" $_file
 }
 
+short()
+{
+	return git rev-parse --short $1
+}
+
+
 HASH1=
 HASH2=
 HASH3=
@@ -189,7 +195,7 @@ test_expect_success 'bisect skip: successful result' '
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
 	git bisect bad > my_bisect_log.txt &&
-	grep "$HASH2 is the first bad commit" my_bisect_log.txt
+	grep "$(short $HASH2) is the first bad commit" my_bisect_log.txt
 '
 
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3 and $HASH2
@@ -254,7 +260,7 @@ test_expect_success \
      git bisect good $HASH1 &&
      git bisect bad $HASH4 &&
      git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
+     grep "$(short $HASH3) is the first bad commit" my_bisect_log.txt &&
      git bisect reset'
 
 # We want to automatically find the commit that
@@ -267,7 +273,7 @@ test_expect_success \
      chmod +x test_script.sh &&
      git bisect start $HASH4 $HASH1 &&
      git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH4 is the first bad commit" my_bisect_log.txt &&
+     grep "$(short $HASH4) is the first bad commit" my_bisect_log.txt &&
      git bisect reset'
 
 # $HASH1 is good, $HASH5 is bad, we skip $HASH3
@@ -280,14 +286,14 @@ test_expect_success 'bisect skip: add line and then a new test' '
 	git bisect start $HASH5 $HASH1 &&
 	git bisect skip &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
+	grep "$(short $HASH5) is the first bad commit" my_bisect_log.txt &&
 	git bisect log > log_to_replay.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bisect skip and bisect replay' '
 	git bisect replay log_to_replay.txt > my_bisect_log.txt &&
-	grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
+		grep "$(short $HASH5) is the first bad commit" my_bisect_log.txt &&
 	git bisect reset
 '
 
@@ -328,7 +334,7 @@ test_expect_success 'bisect run & skip: find first bad' '
 	chmod +x test_script.sh &&
 	git bisect start $HASH7 $HASH1 &&
 	git bisect run ./test_script.sh > my_bisect_log.txt &&
-	grep "$HASH6 is the first bad commit" my_bisect_log.txt
+	grep "$(short $HASH6) is the first bad commit" my_bisect_log.txt
 '
 
 test_expect_success 'bisect skip only one range' '
@@ -378,7 +384,7 @@ test_expect_success 'bisect does not create a "bisect" branch' '
 	rev_hash6=$(git rev-parse --verify HEAD) &&
 	test "$rev_hash6" = "$HASH6" &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$HASH7 is the first bad commit" my_bisect_log.txt &&
+	grep "$(short $HASH7) is the first bad commit" my_bisect_log.txt &&
 	git bisect reset &&
 	rev_hash6=$(git rev-parse --verify bisect) &&
 	test "$rev_hash6" = "$HASH6" &&
@@ -527,7 +533,7 @@ test_expect_success 'restricting bisection on one dir' '
 	para1=$(git rev-parse --verify HEAD) &&
 	test "$para1" = "$PARA_HASH1" &&
 	git bisect bad > my_bisect_log.txt &&
-	grep "$PARA_HASH1 is the first bad commit" my_bisect_log.txt
+	grep "$(short $PARA_HASH1) is the first bad commit" my_bisect_log.txt
 '
 
 test_expect_success 'restricting bisection on one dir and a file' '
@@ -545,7 +551,7 @@ test_expect_success 'restricting bisection on one dir and a file' '
 	para1=$(git rev-parse --verify HEAD) &&
 	test "$para1" = "$PARA_HASH1" &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$PARA_HASH4 is the first bad commit" my_bisect_log.txt
+	grep "$(short $PARA_HASH4) is the first bad commit" my_bisect_log.txt
 '
 
 test_expect_success 'skipping away from skipped commit' '
@@ -576,7 +582,7 @@ test_expect_success 'test bisection on bare repo - --no-checkout specified' '
 			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
 			>../nocheckout.log
 	) &&
-	grep "$HASH3 is the first bad commit" nocheckout.log
+		grep "$(short $HASH3) is the first bad commit" nocheckout.log
 '
 
 
@@ -591,7 +597,7 @@ test_expect_success 'test bisection on bare repo - --no-checkout defaulted' '
 			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
 			>../defaulted.log
 	) &&
-	grep "$HASH3 is the first bad commit" defaulted.log
+		grep "$(short $HASH3) is the first bad commit" defaulted.log
 '
 
 #
-- 
2.4.0
