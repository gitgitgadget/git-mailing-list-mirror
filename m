From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 4/4] t4059: rewrite to be adaptive to hunk filtering
Date: Fri,  3 Apr 2015 18:58:36 +0300
Message-ID: <1428076716-4449-5-git-send-email-max@max630.net>
References: <1428006853-21212-1-git-send-email-max@max630.net>
 <1428076716-4449-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 03 17:59:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye407-0007wc-8u
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 17:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbbDCP65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 11:58:57 -0400
Received: from p3plsmtpa12-03.prod.phx3.secureserver.net ([68.178.252.232]:46628
	"EHLO p3plsmtpa12-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752347AbbDCP6h (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2015 11:58:37 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-03.prod.phx3.secureserver.net with 
	id BTyS1q0045B68XE01Tyc3U; Fri, 03 Apr 2015 08:58:37 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1428076716-4449-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266709>

Looks like there is no exact specification what `diff -c` and
`diff --cc` should output. Considering this it is not reasonable to
hardcode any specific output in test. Rather, it should verify that file
selection behaves the same as hunk selection.

Rewrite test so that it makes sure that a "short" file is shown if and
only if the corresponding "long" file's contains the changed hunk.

Signed-off-by: Max Kirillov <max@max630.net>
---
 t/t4059-diff-cc-not-affected-by-path-filtering.sh | 84 ++++++++++++++++-------
 1 file changed, 59 insertions(+), 25 deletions(-)

diff --git a/t/t4059-diff-cc-not-affected-by-path-filtering.sh b/t/t4059-diff-cc-not-affected-by-path-filtering.sh
index ab3dbd2..f4232b0 100755
--- a/t/t4059-diff-cc-not-affected-by-path-filtering.sh
+++ b/t/t4059-diff-cc-not-affected-by-path-filtering.sh
@@ -6,11 +6,20 @@ test_description='combined diff filtering is not affected by preliminary path fi
 # spot changes which were discarded during conflict resolution.
 
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
-	for fn in win1 win2 merge delete base only1 only2
+	for fn in win1 win2 merge delete base only1 only2 only1discard only2discard
 	do
 		test_seq 3 >short/$fn &&
 		git add short/$fn &&
@@ -29,9 +38,12 @@ test_expect_success setup '
 			git add $dir/$fn || return $?
 		done || return $?
 	done &&
-	sed -e "s/^7/7change1/" long/only2 >sed.new &&
-	mv sed.new long/only2 &&
-	git add long/only2 &&
+	for fn in only2 only2discard
+	do
+	    sed -e "s/^7/7change1/" long/$fn >sed.new &&
+	    mv sed.new long/$fn &&
+	    git add long/$fn || return $?
+	done &&
 	git commit -m branch1 &&
 	git branch branch1 &&
 
@@ -45,9 +57,12 @@ test_expect_success setup '
 			git add $dir/$fn || return $?
 		done || return $?
 	done &&
-	sed -e "s/^11/11change2/" long/only1 >sed.new &&
-	mv sed.new long/only1 &&
-	git add long/only1 &&
+	for fn in only1 only1discard
+	do
+	    sed -e "s/^11/11change2/" long/$fn >sed.new &&
+	    mv sed.new long/$fn &&
+	    git add long/$fn || return $?
+	done &&
 	git commit -m branch2 &&
 	git branch branch2 &&
 
@@ -55,6 +70,10 @@ test_expect_success setup '
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
@@ -69,6 +88,10 @@ test_expect_success setup '
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
@@ -85,24 +108,35 @@ test_expect_success setup '
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
