From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] diff: consolidate test helper script pieces.
Date: Tue, 31 May 2005 14:47:25 -0700
Message-ID: <7vbr6rxe36.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 23:50:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdEaj-0000JO-Gi
	for gcvg-git@gmane.org; Tue, 31 May 2005 23:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVEaVuJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 17:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVEaVtZ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 17:49:25 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:11706 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261602AbVEaVrh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 17:47:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050531214726.WIRJ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 May 2005 17:47:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 31 May 2005 08:32:15 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

There were duplicate script pieces to help comparing diff
output, which this patch consolidates into the t/diff-lib.sh
library.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** The next one is to fix the pathspec, whose test relies on
*** this cleanup.

 t/diff-lib.sh                 |   35 +++++++++++++++++++++++++++++++++++
 t/t4003-diff-rename-1.sh      |    9 +--------
 t/t4005-diff-rename-2.sh      |   23 +----------------------
 t/t4007-rename-3.sh           |   15 +--------------
 t/t4008-diff-break-rewrite.sh |   15 +--------------
 t/t4009-diff-rename-4.sh      |   29 ++++-------------------------
 6 files changed, 43 insertions(+), 83 deletions(-)

diff --git a/t/diff-lib.sh b/t/diff-lib.sh
new file mode 100644
--- /dev/null
+++ b/t/diff-lib.sh
@@ -0,0 +1,35 @@
+:
+
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+sanitize_diff_raw='/^:/s/ '"$_x40"' '"$_x40"' \([A-Z]\)[0-9]*	/ X X \1#	/'
+compare_diff_raw () {
+    # When heuristics are improved, the score numbers would change.
+    # Ignore them while comparing.
+    # Also we do not check SHA1 hash generation in this test, which
+    # is a job for t0000-basic.sh
+
+    sed -e "$sanitize_diff_raw" <"$1" >.tmp-1
+    sed -e "$sanitize_diff_raw" <"$2" >.tmp-2
+    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+}
+
+sanitize_diff_raw_z='/^:/s/ '"$_x40"' '"$_x40"' \([A-Z]\)[0-9]*$/ X X \1#/'
+compare_diff_raw_z () {
+    # When heuristics are improved, the score numbers would change.
+    # Ignore them while comparing.
+    # Also we do not check SHA1 hash generation in this test, which
+    # is a job for t0000-basic.sh
+
+    tr '\0' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
+    tr '\0' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
+    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+}
+
+compare_diff_patch () {
+    # When heuristics are improved, the score numbers would change.
+    # Ignore them while comparing.
+    sed -e '/^[dis]*imilarity index [0-9]*%$/d' <"$1" >.tmp-1
+    sed -e '/^[dis]*imilarity index [0-9]*%$/d' <"$2" >.tmp-2
+    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+}
diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -7,14 +7,7 @@ test_description='More rename detection
 
 '
 . ./test-lib.sh
-
-compare_diff_patch () {
-    # When heuristics are improved, the score numbers would change.
-    # Ignore them while comparing.
-    sed -e '/^similarity index [0-9]*%$/d' <"$1" >.tmp-1
-    sed -e '/^similarity index [0-9]*%$/d' <"$2" >.tmp-2
-    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
-}
+. ../diff-lib.sh ;# test-lib chdir's into trash
 
 test_expect_success \
     'prepare reference tree' \
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -7,28 +7,7 @@ test_description='Same rename detection 
 
 '
 . ./test-lib.sh
-
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
-sanitize_diff_raw='s/ '"$_x40"' '"$_x40"' \([A-Z]\)[0-9]*	/ X X \1#	/'
-compare_diff_raw () {
-    # When heuristics are improved, the score numbers would change.
-    # Ignore them while comparing.
-    # Also we do not check SHA1 hash generation in this test, which
-    # is a job for t0000-basic.sh
-
-    sed -e "$sanitize_diff_raw" <"$1" >.tmp-1
-    sed -e "$sanitize_diff_raw" <"$2" >.tmp-2
-    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
-}
-
-compare_diff_patch () {
-    # When heuristics are improved, the score numbers would change.
-    # Ignore them while comparing.
-    sed -e '/^similarity index [0-9]*%$/d' <"$1" >.tmp-1
-    sed -e '/^similarity index [0-9]*%$/d' <"$2" >.tmp-2
-    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
-}
+. ../diff-lib.sh ;# test-lib chdir's into trash
 
 test_expect_success \
     'prepare reference tree' \
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
--- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -7,20 +7,7 @@ test_description='Rename interaction wit
 
 '
 . ./test-lib.sh
-
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
-sanitize_diff_raw='s/ '"$_x40"' '"$_x40"' \([A-Z]\)[0-9]*	/ X X \1#	/'
-compare_diff_raw () {
-    # When heuristics are improved, the score numbers would change.
-    # Ignore them while comparing.
-    # Also we do not check SHA1 hash generation in this test, which
-    # is a job for t0000-basic.sh
-
-    sed -e "$sanitize_diff_raw" <"$1" >.tmp-1
-    sed -e "$sanitize_diff_raw" <"$2" >.tmp-2
-    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
-}
+. ../diff-lib.sh ;# test-lib chdir's into trash
 
 test_expect_success \
     'prepare reference tree' \
diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -22,20 +22,7 @@ four changes in total.
 Further, with -B and -M together, these should turn into two renames.
 '
 . ./test-lib.sh
-
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
-sanitize_diff_raw='s/ '"$_x40"' '"$_x40"' \([CDNR]\)[0-9]*	/ X X \1#	/'
-compare_diff_raw () {
-    # When heuristics are improved, the score numbers would change.
-    # Ignore them while comparing.
-    # Also we do not check SHA1 hash generation in this test, which
-    # is a job for t0000-basic.sh
-
-    sed -e "$sanitize_diff_raw" <"$1" >.tmp-1
-    sed -e "$sanitize_diff_raw" <"$2" >.tmp-2
-    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
-}
+. ../diff-lib.sh ;# test-lib chdir's into trash
 
 test_expect_success \
     setup \
diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -7,28 +7,7 @@ test_description='Same rename detection 
 
 '
 . ./test-lib.sh
-
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
-sanitize_diff_raw='/^:/s/ '"$_x40"' '"$_x40"' \([A-Z]\)[0-9]*$/ X X \1#/'
-compare_diff_raw () {
-    # When heuristics are improved, the score numbers would change.
-    # Ignore them while comparing.
-    # Also we do not check SHA1 hash generation in this test, which
-    # is a job for t0000-basic.sh
-
-    tr '\0' '\012' <"$1" | sed -e "$sanitize_diff_raw" >.tmp-1
-    tr '\0' '\012' <"$2" | sed -e "$sanitize_diff_raw" >.tmp-2
-    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
-}
-
-compare_diff_patch () {
-    # When heuristics are improved, the score numbers would change.
-    # Ignore them while comparing.
-    sed -e '/^similarity index [0-9]*%$/d' <"$1" >.tmp-1
-    sed -e '/^similarity index [0-9]*%$/d' <"$2" >.tmp-2
-    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
-}
+. ../diff-lib.sh ;# test-lib chdir's into trash
 
 test_expect_success \
     'prepare reference tree' \
@@ -63,7 +42,7 @@ EOF
 
 test_expect_success \
     'validate output from rename/copy detection (#1)' \
-    'compare_diff_raw current expected'
+    'compare_diff_raw_z current expected'
 
 # make sure diff-helper can grok it.
 mv current diff-raw
@@ -120,7 +99,7 @@ EOF
 
 test_expect_success \
     'validate output from rename/copy detection (#2)' \
-    'compare_diff_raw current expected'
+    'compare_diff_raw_z current expected'
 
 # make sure diff-helper can grok it.
 mv current diff-raw
@@ -173,7 +152,7 @@ EOF
 
 test_expect_success \
     'validate output from rename/copy detection (#3)' \
-    'compare_diff_raw current expected'
+    'compare_diff_raw_z current expected'
 
 # make sure diff-helper can grok it.
 mv current diff-raw
------------

