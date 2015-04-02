From: Max Kirillov <max@max630.net>
Subject: [PATCH 4/4] t4059: rewrite to be adaptive to hunk filtering
Date: Thu,  2 Apr 2015 23:34:13 +0300
Message-ID: <1428006853-21212-5-git-send-email-max@max630.net>
References: <1428006853-21212-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:34:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydlp6-0005Fi-U5
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 22:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbbDBUel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 16:34:41 -0400
Received: from p3plsmtpa09-09.prod.phx3.secureserver.net ([173.201.193.238]:52509
	"EHLO p3plsmtpa09-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751933AbbDBUek (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2015 16:34:40 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-09.prod.phx3.secureserver.net with 
	id B8aH1q00T5B68XE018ae9v; Thu, 02 Apr 2015 13:34:40 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1428006853-21212-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266672>

Looks like there is no exact specification what `diff -c` and
`diff --cc` should output. Considering this it is not reasonable to
hardcode any specific output in test. Rather, it should verify that file
selection behaves the same as hunk selection.

Rewrite test so that it makes sure that a "short" file is shown if and
only if the corresponding "long" file's contains the changed hunk.

Signed-off-by: Max Kirillov <max@max630.net>
---
 t/t4059-diff-merge-with-base.sh | 84 ++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/t/t4059-diff-merge-with-base.sh b/t/t4059-diff-merge-with-base.sh
index 6341f7c..75a3820 100755
--- a/t/t4059-diff-merge-with-base.sh
+++ b/t/t4059-diff-merge-with-base.sh
@@ -1,13 +1,22 @@
 #!/bin/sh
 
-test_description='Diff aware of merge base'
+test_description='combined diff filtering is not affected by preliminary path filtering'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
 
+# history is:
+# (mergebase) --> (branch1) --\
+#  |                          V
+#  \ --> (branch2) ----------(merge)
+# there are files in 2 subdirectories, "long" and "short"
+# each file in "long" subdirecty has exactly same history as same file in "short" one,
+# but it has added lines with changes in both branches which merge without conflict
+# so the long files are always selected at path filtering
 test_expect_success setup '
 	mkdir short &&
 	mkdir long &&
-	for fn in win1 win2 merge delete base only1 only2; do
+	for fn in win1 win2 merge delete base only1 only2 only1discard only2discard; do
 		test_seq 3 >short/$fn
 		git add short/$fn &&
 		test_seq 11 >long/$fn &&
@@ -23,9 +32,11 @@ test_expect_success setup '
 			git add $dir/$fn
 		done
 	done &&
-	sed -e "s/^7/7change1/" long/only2 >sed.new &&
-	mv sed.new long/only2 &&
-	git add long/only2 &&
+	for fn in only2 only2discard; do
+	    sed -e "s/^7/7change1/" long/$fn >sed.new &&
+	    mv sed.new long/$fn &&
+	    git add long/$fn
+	done &&
 	git commit -m branch1 &&
 	git branch branch1 &&
 
@@ -37,9 +48,11 @@ test_expect_success setup '
 			git add $dir/$fn
 		done
 	done &&
-	sed -e "s/^11/11change2/" long/only1 >sed.new &&
-	mv sed.new long/only1 &&
-	git add long/only1 &&
+	for fn in only1 only1discard; do
+	    sed -e "s/^11/11change2/" long/$fn >sed.new &&
+	    mv sed.new long/$fn &&
+	    git add long/$fn
+	done &&
 	git commit -m branch2 &&
 	git branch branch2 &&
 
@@ -47,6 +60,10 @@ test_expect_success setup '
 	git checkout mergebase -- . &&
 	test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" >long/base &&
 	git add long/base &&
+	test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" >long/only1discard &&
+	git add long/only1discard &&
+	test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" >long/only2discard &&
+	git add long/only2discard &&
 	test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e "s/^2/2change1/" >long/win1 &&
 	git add long/win1 &&
 	test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e "s/^2/2change2/" >long/win2 &&
@@ -61,6 +78,10 @@ test_expect_success setup '
 	git add long/only2 &&
 	test_seq 3 >short/base &&
 	git add short/base &&
+	test_seq 3 >short/only1discard &&
+	git add short/only1discard &&
+	test_seq 3 >short/only2discard &&
+	git add short/only2discard &&
 	test_seq 3 | sed -e "s/^2/2change1/" >short/win1 &&
 	git add short/win1 &&
 	test_seq 3 | sed -e "s/^2/2change2/" >short/win2 &&
@@ -77,24 +98,35 @@ test_expect_success setup '
 	git branch merge
 '
 
-test_expect_success 'diff with mergebase shows discarded change from parent 2 in merged file' '
-	git diff --cc merge branch1 branch2 mergebase -- long/win1 >actual &&
-	test -s actual
-'
-
-test_expect_success 'diff with mergebase shows discarded change from parent 1 in merged file' '
-	git diff --cc merge branch1 branch2 mergebase -- long/win2 >actual &&
-	test -s actual
-'
+# the difference in short file must be returned if and only if it is shown in long file
+for fn in win1 win2 merge delete base only1 only2 only1discard only2discard; do
+	if git diff --cc merge branch1 branch2 mergebase -- long/$fn | grep -q '^[ +-]\{3\}2\(change[12]|merge\)\?$'
+	then
+		test_expect_success "diff --cc contains short/$fn" '
+			git diff --cc merge branch1 branch2 mergebase -- short/'"$fn"' >actual &&
+			test -s actual
+		'
+	else
+		test_expect_success "diff --cc does not contain short/$fn" '
+			git diff --cc merge branch1 branch2 mergebase -- short/'"$fn"' >actual &&
+			! test -s actual
+		'
+	fi
+done
 
-test_expect_success 'diff with mergebase shows fully discarded file from parent 2' '
-	git diff --cc merge branch1 branch2 mergebase -- short/win1 >actual &&
-	test -s actual
-'
-
-test_expect_success 'diff with mergebase shows fully discarded file from parent 1' '
-	git diff --cc merge branch1 branch2 mergebase -- short/win2 >actual &&
-	test -s actual
-'
+for fn in win1 win2 merge delete base only1 only2 only1discard only2discard; do
+	if git diff -c merge branch1 branch2 mergebase -- long/$fn | grep -q '^[ +-]\{3\}2\(change[12]|merge\)\?$'
+	then
+		test_expect_success "diff -c contains short/$fn" '
+			git diff -c merge branch1 branch2 mergebase -- short/'"$fn"' >actual &&
+			test -s actual
+		'
+	else
+		test_expect_success "diff -c does not contain short/$fn" '
+			git diff -c merge branch1 branch2 mergebase -- short/'"$fn"' >actual &&
+			! test -s actual
+		'
+	fi
+done
 
 test_done
-- 
2.3.4.2801.g3d0809b
