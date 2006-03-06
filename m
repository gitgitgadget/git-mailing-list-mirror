From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] annotate/blame tests updates.
Date: Sun, 05 Mar 2006 22:12:30 -0800
Message-ID: <7vu0acaypd.fsf@assigned-by-dhcp.cox.net>
References: <20060305111334.GB23448@c165.ib.student.liu.se>
	<440BA4DA.9060101@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Mar 06 07:12:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG8xg-00073N-Tq
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 07:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWCFGMi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 01:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWCFGMi
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 01:12:38 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:22779 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751350AbWCFGMh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 01:12:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060306061041.WUKK20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Mar 2006 01:10:41 -0500
To: Ryan Anderson <ryan@michonline.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17276>

Ryan Anderson <ryan@michonline.com> writes:

>>+test_expect_success \
>>+    'check all lines blamed on A' \
>>+    '[ $(git annotate file | awk "{print \$3}" | grep -c "A") == 2 ]'
>>  
>>
> This should be $PROG as well, I suspect.

True.  Also I am suspecting this awk being a but unsafe.  The
default author is "A U Thor <author@example.com>", and without
FS specified awk would split at whitespaces.

I haven't pushed out the test-case sharing by Fredrik yet, but I
have already taken it.  This patch is on top of it.

-- >8 --
This rewrites the result check code a bit.  The earlier one
using awk was splitting columns at any whitespace, which
confused lines attributed incorrectly to the merge made by the
default author "A U Thor <author@example.com>" with lines
attributed to author "A".

The latest test by Ryan to add the "starting from older commit"
test is also included, with another older commit test.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 t/annotate-tests.sh |   81 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 44 insertions(+), 37 deletions(-)

92a903acfd0904e6dd6d18112428429938783d19
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 54a4dfb..d25a7a1 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -1,6 +1,37 @@
 # This file isn't used as a test script directly, instead it is
 # sourced from t8001-annotate.sh and t8001-blame.sh.
 
+check_count () {
+	head=
+	case "$1" in -h) head="$2"; shift; shift ;; esac
+	$PROG file $head | perl -e '
+		my %expect = (@ARGV);
+		my %count = ();
+		while (<STDIN>) {
+			if (/^[0-9a-f]+\t\(([^\t]+)\t/) {
+				my $author = $1;
+				for ($author) { s/^\s*//; s/\s*$//; }
+				if (exists $expect{$author}) {
+					$count{$author}++;
+				}
+			}
+		}
+		my $bad = 0;
+		while (my ($author, $count) = each %count) {
+			my $ok;
+			if ($expect{$author} != $count) {
+				$bad = 1;
+				$ok = "bad";
+			}
+			else {
+				$ok = "good";
+			}
+			print STDERR "Author $author (expected $expect{$author}, attributed $count) $ok\n";
+		}
+		exit($bad);
+	' "$@"
+}
+
 test_expect_success \
     'prepare reference tree' \
     'echo "1A quick brown fox jumps over the" >file &&
@@ -10,7 +41,7 @@ test_expect_success \
 
 test_expect_success \
     'check all lines blamed on A' \
-    '[ $(git annotate file | awk "{print \$3}" | grep -c "A") == 2 ]'
+    'check_count A 2'
 
 test_expect_success \
     'Setup new lines blamed on B' \
@@ -19,12 +50,8 @@ test_expect_success \
      GIT_AUTHOR_NAME="B" git commit -a -m "Second."'
 
 test_expect_success \
-    'Two lines blamed on A' \
-    '[ $($PROG file | awk "{print \$3}" | grep -c "A") == 2 ]'
-
-test_expect_success \
-    'Two lines blamed on B' \
-    '[ $($PROG file | awk "{print \$3}" | grep -c "B") == 2 ]'
+    'Two lines blamed on A, two on B' \
+    'check_count A 2 B 2'
 
 test_expect_success \
     'merge-setup part 1' \
@@ -34,16 +61,8 @@ test_expect_success \
      GIT_AUTHOR_NAME="B1" git commit -a -m "Branch1-1"'
 
 test_expect_success \
-    'Two lines blamed on A' \
-    '[ $($PROG file | awk "{print \$3}" | grep -c "^A$") == 2 ]'
-
-test_expect_success \
-    'Two lines blamed on B' \
-    '[ $($PROG file | awk "{print \$3}" | grep -c "^B$") == 2 ]'
-
-test_expect_success \
-    'Two lines blamed on B1' \
-    '[ $($PROG file | awk "{print \$3}" | grep -c "^B1$") == 2 ]'
+    'Two lines blamed on A, two on B, two on B1' \
+    'check_count A 2 B 2 B1 2'
 
 test_expect_success \
     'merge-setup part 2' \
@@ -53,34 +72,22 @@ test_expect_success \
      GIT_AUTHOR_NAME="B2" git commit -a -m "Branch2-1"'
 
 test_expect_success \
-    'Two lines blamed on A' \
-    '[ $($PROG file | awk "{print \$3}" | grep -c "^A$") == 2 ]'
-
-test_expect_success \
-    'One line blamed on B' \
-    '[ $($PROG file | awk "{print \$3}" | grep -c "^B$") == 1 ]'
-
-test_expect_success \
-    'One line blamed on B2' \
-    '[ $($PROG file | awk "{print \$3}" | grep -c "^B2$") == 1 ]'
-
+    'Two lines blamed on A, one on B, one on B2' \
+    'check_count A 2 B 1 B2 1'
 
 test_expect_success \
     'merge-setup part 3' \
     'git pull . branch1'
 
 test_expect_success \
-    'Two lines blamed on A' \
-    '[ $($PROG file | awk "{print \$3}" | grep -c "^A$") == 2 ]'
+    'Two lines blamed on A, one on B, two on B1, one on B2' \
+    'check_count A 2 B 1 B1 2 B2 1'
 
 test_expect_success \
-    'One line blamed on B' \
-    '[ $($PROG file | awk "{print \$3}" | grep -c "^B$") == 1 ]'
+    'Annotating an old revision works' \
+    'check_count -h master A 2 B 2'
 
 test_expect_success \
-    'Two lines blamed on B1' \
-    '[ $($PROG file | awk "{print \$3}" | grep -c "^B1$") == 2 ]'
+    'Annotating an old revision works' \
+    'check_count -h master^ A 2'
 
-test_expect_success \
-    'One line blamed on B2' \
-    '[ $($PROG file | awk "{print \$3}" | grep -c "^B2$") == 1 ]'
-- 
1.2.4.g4668
