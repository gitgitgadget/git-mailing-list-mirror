From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 1/5] git-svn: expand the svn mergeinfo test suite, highlighting some failures
Date: Sun, 20 Dec 2009 05:33:51 +1300
Message-ID: <1261240435-8948-2-git-send-email-sam@vilain.net>
References: <1261240435-8948-1-git-send-email-sam@vilain.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	Andrew Myrick <amyrick@gmail.com>, Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 17:34:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM2GI-000123-0P
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 17:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbZLSQe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 11:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbZLSQeW
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 11:34:22 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:52462 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752807AbZLSQeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 11:34:21 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 9437C21C50A; Sun, 20 Dec 2009 05:34:19 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from denix (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 0543121C366;
	Sun, 20 Dec 2009 05:34:11 +1300 (NZDT)
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by denix with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1NM2Fw-0002Lt-Gy; Sun, 20 Dec 2009 05:34:12 +1300
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1261240435-8948-1-git-send-email-sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135489>

As shown, git-svn has some problems; not all svn merges are correctly
detected, and cherry picks may incorrectly be detected as real merges.
These test cases will be marked as _success once the relevant fixes are in.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 t/t9151-svn-mergeinfo.sh   |   27 ++-
 t/t9151/make-svnmerge-dump |  166 ++++++---
 t/t9151/svn-mergeinfo.dump |  839 ++++++++++++++++++++++++++++++++++++++------
 3 files changed, 860 insertions(+), 172 deletions(-)

diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index f57daf4..dc3478f 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -15,12 +15,27 @@ test_expect_success 'load svn dump' "
 	git svn fetch --all
 	"
 
-test_expect_success 'represent svn merges without intervening commits' "
-	[ `git cat-file commit HEAD^1 | grep parent | wc -l` -eq 2 ]
-	"
+test_expect_failure 'all svn merges became git merge commits' '
+	unmarked=$(git rev-list --parents --all --grep=Merge |
+		grep -v " .* " | cut -f1 -d" ")
+	[ -z "$unmarked" ]
+	'
 
-test_expect_success 'represent svn merges with intervening commits' "
-	[ `git cat-file commit HEAD | grep parent | wc -l` -eq 2 ]
-	"
+test_expect_failure 'cherry picks did not become git merge commits' '
+	bad_cherries=$(git rev-list --parents --all --grep=Cherry |
+		grep " .* " | cut -f1 -d" ")
+	[ -z "$bad_cherries" ]
+	'
+
+test_expect_success 'svn non-merge merge commits did not become git merge commits' '
+	bad_non_merges=$(git rev-list --parents --all --grep=non-merge |
+		grep " .* " | cut -f1 -d" ")
+	[ -z "$bad_non_merges" ]
+	'
+
+test_expect_failure 'everything got merged in the end' '
+	unmerged=$(git rev-list --all --not master)
+	[ -z "$unmerged" ]
+	'
 
 test_done
diff --git a/t/t9151/make-svnmerge-dump b/t/t9151/make-svnmerge-dump
index 7e3da75..d917717 100644
--- a/t/t9151/make-svnmerge-dump
+++ b/t/t9151/make-svnmerge-dump
@@ -11,93 +11,151 @@ mkdir foo.svn
 svnadmin create foo.svn
 svn co file://`pwd`/foo.svn foo
 
+commit() {
+    i=$(( $1 + 1 ))
+    shift;
+    svn commit -m "(r$i) $*" >/dev/null || exit 1
+    echo $i
+}
+
+say() {
+    echo "[1m * $*[0m"
+}
+
+i=0
 cd foo
 mkdir trunk
 mkdir branches
 svn add trunk branches
-svn commit -m "Setup trunk and branches"
-cd trunk
+i=$(commit $i "Setup trunk and branches")
 
-git cat-file blob 6683463e:Makefile > Makefile
-svn add Makefile 
+git cat-file blob 6683463e:Makefile > trunk/Makefile
+svn add trunk/Makefile 
 
-echo "Committing ANCESTOR"
-svn commit -m "ancestor"
-cd ..
+say "Committing ANCESTOR"
+i=$(commit $i "ancestor")
 svn cp trunk branches/left
 
-echo "Committing BRANCH POINT"
-svn commit -m "make left branch"
+say "Committing BRANCH POINT"
+i=$(commit $i "make left branch")
 svn cp trunk branches/right
 
-echo "Committing other BRANCH POINT"
-svn commit -m "make right branch"
-cd branches/left/
+say "Committing other BRANCH POINT"
+i=$(commit $i "make right branch")
 
-#$sm init
-#svn commit -m "init svnmerge"
+say "Committing LEFT UPDATE"
+git cat-file blob 5873b67e:Makefile > branches/left/Makefile
+i=$(commit $i "left update 1")
 
-git cat-file blob 5873b67e:Makefile > Makefile
-echo "Committing BRANCH UPDATE 1"
-svn commit -m "left update 1"
-cd ../..
-
-cd trunk
-git cat-file blob 75118b13:Makefile > Makefile
-echo "Committing TRUNK UPDATE"
-svn commit -m "trunk update"
+git cat-file blob 75118b13:Makefile > branches/right/Makefile
+say "Committing RIGHT UPDATE"
+pre_right_update_1=$i
+i=$(commit $i "right update 1")
 
-cd ../branches/left
-git cat-file blob ff5ebe39:Makefile > Makefile
-echo "Committing BRANCH UPDATE 2"
-svn commit -m "left update 2"
+say "Making more commits on LEFT"
+git cat-file blob ff5ebe39:Makefile > branches/left/Makefile
+i=$(commit $i "left update 2")
+git cat-file blob b5039db6:Makefile > branches/left/Makefile
+i=$(commit $i "left update 3")
 
-git cat-file blob b5039db6:Makefile > Makefile
-echo "Committing BRANCH UPDATE 3"
-svn commit -m "left update 3"
+say "Making a LEFT SUB-BRANCH"
+svn cp branches/left branches/left-sub
+sub_left_make=$i
+i=$(commit $i "make left sub-branch")
 
-# merge to trunk
+say "Making a commit on LEFT SUB-BRANCH"
+echo "crunch" > branches/left-sub/README
+svn add branches/left-sub/README
+i=$(commit $i "left sub-branch update 1")
 
-cd ../..
+say "Merging LEFT to TRUNK"
 svn update
 cd trunk
-
 svn merge ../branches/left --accept postpone
-
-git cat-file blob b51ad431:Makefile > Makefile
-
+git cat-file blob b5039db6:Makefile > Makefile
 svn resolved Makefile
+i=$(commit $i "Merge left to trunk 1")
+cd ..
 
-svn commit -m "Merge trunk 1"
-
-# create commits on both branches
-
-cd ../branches/left
-git cat-file blob ff5ebe39:Makefile > Makefile
-echo "Committing BRANCH UPDATE 4"
-svn commit -m "left update 4"
-
-cd ../right
-git cat-file blob b5039db6:Makefile > Makefile
-echo "Committing other BRANCH UPDATE 1"
-svn commit -m "right update 1"
+say "Making more commits on LEFT and RIGHT"
+echo "touche" > branches/left/zlonk
+svn add branches/left/zlonk
+i=$(commit $i "left update 4")
+echo "thwacke" > branches/right/bang
+svn add branches/right/bang
+i=$(commit $i "right update 2")
 
-# merge to trun again
+say "Squash merge of RIGHT tip 2 commits onto TRUNK"
+svn update
+cd trunk
+svn merge -r$pre_right_update_1:$i ../branches/right
+i=$(commit $i "Cherry-pick right 2 commits to trunk")
+cd ..
 
-cd ../..
+say "Merging RIGHT to TRUNK"
 svn update
 cd trunk
+svn merge ../branches/right --accept postpone
+git cat-file blob b51ad431:Makefile > Makefile
+svn resolved Makefile
+i=$(commit $i "Merge right to trunk 1")
+cd ..
 
-svn merge ../branches/left --accept postpone
+say "Making more commits on RIGHT and TRUNK"
+echo "whamm" > branches/right/urkkk
+svn add branches/right/urkkk
+i=$(commit $i "right update 3")
+echo "pow" > trunk/vronk
+svn add trunk/vronk
+i=$(commit $i "trunk update 1")
 
+say "Merging RIGHT to LEFT SUB-BRANCH"
+svn update
+cd branches/left-sub
+svn merge ../right --accept postpone
 git cat-file blob b51ad431:Makefile > Makefile
-
 svn resolved Makefile
+i=$(commit $i "Merge right to left sub-branch")
+cd ../..
 
-svn commit -m "Merge trunk 2"
+say "Making more commits on LEFT SUB-BRANCH and LEFT"
+echo "zowie" > branches/left-sub/wham_eth
+svn add branches/left-sub/wham_eth
+pre_sub_left_update_2=$i
+i=$(commit $i "left sub-branch update 2")
+sub_left_update_2=$i
+echo "eee_yow" > branches/left/glurpp
+svn add branches/left/glurpp
+i=$(commit $i "left update 5")
+
+say "Cherry pick LEFT SUB-BRANCH commit to LEFT"
+svn update
+cd branches/left
+svn merge -r$pre_sub_left_update_2:$sub_left_update_2 ../left-sub
+i=$(commit $i "Cherry-pick left sub-branch commit to left")
+cd ../..
 
+say "Merging LEFT SUB-BRANCH back to LEFT"
+svn update
+cd branches/left
+# it's only a merge because the previous merge cherry-picked the top commit
+svn merge -r$sub_left_make:$sub_left_update_2 ../left-sub --accept postpone
+i=$(commit $i "Merge left sub-branch to left")
 cd ../..
 
+say "Merging EVERYTHING to TRUNK"
+svn update
+cd trunk
+svn merge ../branches/left --accept postpone
+svn resolved bang
+i=$(commit $i "Merge left to trunk 2")
+# this merge, svn happily updates the mergeinfo, but there is actually
+# nothing to merge.  git-svn will not make a meaningless merge commit.
+svn merge ../branches/right --accept postpone
+i=$(commit $i "non-merge right to trunk 2")
+cd ..
+
+cd ..
 svnadmin dump foo.svn > svn-mergeinfo.dump
 
 rm -rf foo foo.svn
diff --git a/t/t9151/svn-mergeinfo.dump b/t/t9151/svn-mergeinfo.dump
index 11a883f..9543e31 100644
--- a/t/t9151/svn-mergeinfo.dump
+++ b/t/t9151/svn-mergeinfo.dump
@@ -1,6 +1,6 @@
 SVN-fs-dump-format-version: 2
 
-UUID: 1530d5a2-a1dc-4438-8ad5-d95e96db8945
+UUID: 64142547-0943-4db2-836a-d1e1eb2f9924
 
 Revision-number: 0
 Prop-content-length: 56
@@ -9,25 +9,25 @@ Content-length: 56
 K 8
 svn:date
 V 27
-2009-11-12T20:29:38.812226Z
+2009-12-19T16:17:51.232640Z
 PROPS-END
 
 Revision-number: 1
-Prop-content-length: 127
-Content-length: 127
+Prop-content-length: 128
+Content-length: 128
 
 K 7
 svn:log
-V 24
-Setup trunk and branches
+V 29
+(r1) Setup trunk and branches
 K 10
 svn:author
-V 8
-tallsopp
+V 4
+samv
 K 8
 svn:date
 V 27
-2009-11-12T20:29:39.045856Z
+2009-12-19T16:17:51.831965Z
 PROPS-END
 
 Node-path: branches
@@ -49,21 +49,21 @@ PROPS-END
 
 
 Revision-number: 2
-Prop-content-length: 110
-Content-length: 110
+Prop-content-length: 112
+Content-length: 112
 
 K 7
 svn:log
-V 8
-ancestor
+V 13
+(r2) ancestor
 K 10
 svn:author
-V 8
-tallsopp
+V 4
+samv
 K 8
 svn:date
 V 27
-2009-11-12T20:29:40.079587Z
+2009-12-19T16:17:52.300075Z
 PROPS-END
 
 Node-path: trunk/Makefile
@@ -156,21 +156,21 @@ backup: clean
 
 
 Revision-number: 3
-Prop-content-length: 119
-Content-length: 119
+Prop-content-length: 120
+Content-length: 120
 
 K 7
 svn:log
-V 16
-make left branch
+V 21
+(r3) make left branch
 K 10
 svn:author
-V 8
-tallsopp
+V 4
+samv
 K 8
 svn:date
 V 27
-2009-11-12T20:29:42.084439Z
+2009-12-19T16:17:52.768800Z
 PROPS-END
 
 Node-path: branches/left
@@ -190,21 +190,21 @@ Text-copy-source-sha1: 103205ce331f7d64086dba497574734f78439590
 
 
 Revision-number: 4
-Prop-content-length: 120
-Content-length: 120
+Prop-content-length: 121
+Content-length: 121
 
 K 7
 svn:log
-V 17
-make right branch
+V 22
+(r4) make right branch
 K 10
 svn:author
-V 8
-tallsopp
+V 4
+samv
 K 8
 svn:date
 V 27
-2009-11-12T20:29:44.065452Z
+2009-12-19T16:17:53.177879Z
 PROPS-END
 
 Node-path: branches/right
@@ -224,21 +224,21 @@ Text-copy-source-sha1: 103205ce331f7d64086dba497574734f78439590
 
 
 Revision-number: 5
-Prop-content-length: 116
-Content-length: 116
+Prop-content-length: 117
+Content-length: 117
 
 K 7
 svn:log
-V 13
-left update 1
+V 18
+(r5) left update 1
 K 10
 svn:author
-V 8
-tallsopp
+V 4
+samv
 K 8
 svn:date
 V 27
-2009-11-12T20:29:45.066262Z
+2009-12-19T16:17:53.604691Z
 PROPS-END
 
 Node-path: branches/left/Makefile
@@ -329,24 +329,24 @@ backup: clean
 
 
 Revision-number: 6
-Prop-content-length: 115
-Content-length: 115
+Prop-content-length: 118
+Content-length: 118
 
 K 7
 svn:log
-V 12
-trunk update
+V 19
+(r6) right update 1
 K 10
 svn:author
-V 8
-tallsopp
+V 4
+samv
 K 8
 svn:date
 V 27
-2009-11-12T20:29:46.278498Z
+2009-12-19T16:17:54.063555Z
 PROPS-END
 
-Node-path: trunk/Makefile
+Node-path: branches/right/Makefile
 Node-kind: file
 Node-action: change
 Text-content-length: 2521
@@ -437,21 +437,21 @@ backup: clean
 
 
 Revision-number: 7
-Prop-content-length: 116
-Content-length: 116
+Prop-content-length: 117
+Content-length: 117
 
 K 7
 svn:log
-V 13
-left update 2
+V 18
+(r7) left update 2
 K 10
 svn:author
-V 8
-tallsopp
+V 4
+samv
 K 8
 svn:date
 V 27
-2009-11-12T20:29:47.069090Z
+2009-12-19T16:17:54.523904Z
 PROPS-END
 
 Node-path: branches/left/Makefile
@@ -542,21 +542,21 @@ backup: clean
 
 
 Revision-number: 8
-Prop-content-length: 116
-Content-length: 116
+Prop-content-length: 117
+Content-length: 117
 
 K 7
 svn:log
-V 13
-left update 3
+V 18
+(r8) left update 3
 K 10
 svn:author
-V 8
-tallsopp
+V 4
+samv
 K 8
 svn:date
 V 27
-2009-11-12T20:29:48.053835Z
+2009-12-19T16:17:54.975970Z
 PROPS-END
 
 Node-path: branches/left/Makefile
@@ -647,33 +647,285 @@ backup: clean
 
 
 Revision-number: 9
-Prop-content-length: 116
-Content-length: 116
+Prop-content-length: 124
+Content-length: 124
 
 K 7
 svn:log
-V 13
-Merge trunk 1
+V 25
+(r9) make left sub-branch
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-12-19T16:17:55.459904Z
+PROPS-END
+
+Node-path: branches/left-sub
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 3
+Node-copyfrom-path: branches/left
+
+
+Node-path: branches/left-sub/Makefile
+Node-kind: file
+Node-action: delete
+
+Node-path: branches/left-sub/Makefile
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 8
+Node-copyfrom-path: branches/left/Makefile
+Text-copy-source-md5: 5ccff689fb290e00b85fe18ee50c54ba
+Text-copy-source-sha1: a13de8e23f1483efca3e57b2b64b0ae6f740ce10
+
+
+
+
+Revision-number: 10
+Prop-content-length: 129
+Content-length: 129
+
+K 7
+svn:log
+V 30
+(r10) left sub-branch update 1
 K 10
 svn:author
-V 8
-tallsopp
+V 4
+samv
 K 8
 svn:date
 V 27
-2009-11-12T20:29:51.098306Z
+2009-12-19T16:17:55.862113Z
+PROPS-END
+
+Node-path: branches/left-sub/README
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 7
+Text-content-md5: fdbcfb6be9afe1121862143f226b51cf
+Text-content-sha1: 1d1f5ea4ceb584337ffe59b8980d92e3b78dfef4
+Content-length: 17
+
+PROPS-END
+crunch
+
+
+Revision-number: 11
+Prop-content-length: 126
+Content-length: 126
+
+K 7
+svn:log
+V 27
+(r11) Merge left to trunk 1
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-12-19T16:17:56.413416Z
 PROPS-END
 
 Node-path: trunk
 Node-kind: dir
 Node-action: change
-Prop-content-length: 53
-Content-length: 53
+Prop-content-length: 54
+Content-length: 54
 
 K 13
 svn:mergeinfo
-V 18
-/branches/left:2-8
+V 19
+/branches/left:2-10
+PROPS-END
+
+
+Node-path: trunk/Makefile
+Node-kind: file
+Node-action: change
+Text-content-length: 2593
+Text-content-md5: 5ccff689fb290e00b85fe18ee50c54ba
+Text-content-sha1: a13de8e23f1483efca3e57b2b64b0ae6f740ce10
+Content-length: 2593
+
+# -DCOLLISION_CHECK if you believe that SHA1's
+# 1461501637330902918203684832716283019655932542976 hashes do not give you
+# enough guarantees about no collisions between objects ever hapenning.
+#
+# -DNSEC if you want git to care about sub-second file mtimes and ctimes.
+# Note that you need some new glibc (at least >2.2.4) for this, and it will
+# BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely randomly
+# break unless your underlying filesystem supports those sub-second times
+# (my ext3 doesn't).
+CFLAGS=-g -O3 -Wall
+
+CC=gcc
+
+
+PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
+	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
+	check-files ls-tree merge-base
+
+all: $(PROG)
+
+install: $(PROG)
+	install $(PROG) $(HOME)/bin/
+
+LIBS= -lssl -lz
+
+init-db: init-db.o
+
+update-cache: update-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o update-cache update-cache.o read-cache.o $(LIBS)
+
+show-diff: show-diff.o read-cache.o
+	$(CC) $(CFLAGS) -o show-diff show-diff.o read-cache.o $(LIBS)
+
+write-tree: write-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o write-tree write-tree.o read-cache.o $(LIBS)
+
+read-tree: read-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o read-tree read-tree.o read-cache.o $(LIBS)
+
+commit-tree: commit-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o commit-tree commit-tree.o read-cache.o $(LIBS)
+
+cat-file: cat-file.o read-cache.o
+	$(CC) $(CFLAGS) -o cat-file cat-file.o read-cache.o $(LIBS)
+
+fsck-cache: fsck-cache.o read-cache.o object.o commit.o tree.o blob.o
+	$(CC) $(CFLAGS) -o fsck-cache fsck-cache.o read-cache.o object.o commit.o tree.o blob.o $(LIBS)
+
+checkout-cache: checkout-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o checkout-cache checkout-cache.o read-cache.o $(LIBS)
+
+diff-tree: diff-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o diff-tree diff-tree.o read-cache.o $(LIBS)
+
+rev-tree: rev-tree.o read-cache.o object.o commit.o tree.o blob.o
+	$(CC) $(CFLAGS) -o rev-tree rev-tree.o read-cache.o object.o commit.o tree.o blob.o $(LIBS)
+
+show-files: show-files.o read-cache.o
+	$(CC) $(CFLAGS) -o show-files show-files.o read-cache.o $(LIBS)
+
+check-files: check-files.o read-cache.o
+	$(CC) $(CFLAGS) -o check-files check-files.o read-cache.o $(LIBS)
+
+ls-tree: ls-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o ls-tree ls-tree.o read-cache.o $(LIBS)
+
+merge-base: merge-base.o read-cache.o object.o commit.o tree.o blob.o
+	$(CC) $(CFLAGS) -o merge-base merge-base.o read-cache.o object.o commit.o tree.o blob.o $(LIBS)
+
+read-cache.o: cache.h
+show-diff.o: cache.h
+
+clean:
+	rm -f *.o $(PROG)
+
+backup: clean
+	cd .. ; tar czvf dircache.tar.gz dir-cache
+
+
+Revision-number: 12
+Prop-content-length: 118
+Content-length: 118
+
+K 7
+svn:log
+V 19
+(r12) left update 4
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-12-19T16:17:56.831014Z
+PROPS-END
+
+Node-path: branches/left/zlonk
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 7
+Text-content-md5: 8b9d8c7c2aaa6167e7d3407a773bbbba
+Text-content-sha1: 9716527ebd70a75c27625cacbeb2d897c6e86178
+Content-length: 17
+
+PROPS-END
+touche
+
+
+Revision-number: 13
+Prop-content-length: 119
+Content-length: 119
+
+K 7
+svn:log
+V 20
+(r13) right update 2
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-12-19T16:17:57.341143Z
+PROPS-END
+
+Node-path: branches/right/bang
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 8
+Text-content-md5: 34c28f1d2dc6a9adeccc4265bf7516cb
+Text-content-sha1: 0bc5bb345c0e71d28f784f12e0bd2d384c283062
+Content-length: 18
+
+PROPS-END
+thwacke
+
+
+Revision-number: 14
+Prop-content-length: 141
+Content-length: 141
+
+K 7
+svn:log
+V 42
+(r14) Cherry-pick right 2 commits to trunk
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-12-19T16:17:57.841851Z
+PROPS-END
+
+Node-path: trunk
+Node-kind: dir
+Node-action: change
+Prop-content-length: 75
+Content-length: 75
+
+K 13
+svn:mergeinfo
+V 40
+/branches/left:2-10
+/branches/right:6-13
 PROPS-END
 
 
@@ -767,31 +1019,147 @@ backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
 
 
-Revision-number: 10
-Prop-content-length: 116
-Content-length: 116
+Node-path: trunk/bang
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 13
+Node-copyfrom-path: branches/right/bang
+Text-copy-source-md5: 34c28f1d2dc6a9adeccc4265bf7516cb
+Text-copy-source-sha1: 0bc5bb345c0e71d28f784f12e0bd2d384c283062
+
+
+Revision-number: 15
+Prop-content-length: 127
+Content-length: 127
 
 K 7
 svn:log
-V 13
-left update 4
+V 28
+(r15) Merge right to trunk 1
 K 10
 svn:author
-V 8
-tallsopp
+V 4
+samv
 K 8
 svn:date
 V 27
-2009-11-12T20:29:52.081644Z
+2009-12-19T16:17:58.368520Z
 PROPS-END
 
-Node-path: branches/left/Makefile
+Node-path: trunk
+Node-kind: dir
+Node-action: change
+Prop-content-length: 75
+Content-length: 75
+
+K 13
+svn:mergeinfo
+V 40
+/branches/left:2-10
+/branches/right:2-14
+PROPS-END
+
+
+Revision-number: 16
+Prop-content-length: 119
+Content-length: 119
+
+K 7
+svn:log
+V 20
+(r16) right update 3
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-12-19T16:17:58.779056Z
+PROPS-END
+
+Node-path: branches/right/urkkk
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 6
+Text-content-md5: 5889c8392e16251b0c80927607a03036
+Text-content-sha1: 3934264d277a0cf886b6b1c7f2b9e56da2525302
+Content-length: 16
+
+PROPS-END
+whamm
+
+
+Revision-number: 17
+Prop-content-length: 119
+Content-length: 119
+
+K 7
+svn:log
+V 20
+(r17) trunk update 1
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-12-19T16:17:59.221851Z
+PROPS-END
+
+Node-path: trunk/vronk
 Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 4
+Text-content-md5: b2f80fa02a7f1364b9c29d3da44bf9f9
+Text-content-sha1: e994d980c0f2d7a3f76138bf96d57f36f9633828
+Content-length: 14
+
+PROPS-END
+pow
+
+
+Revision-number: 18
+Prop-content-length: 135
+Content-length: 135
+
+K 7
+svn:log
+V 36
+(r18) Merge right to left sub-branch
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-12-19T16:17:59.781666Z
+PROPS-END
+
+Node-path: branches/left-sub
+Node-kind: dir
 Node-action: change
-Text-content-length: 2529
-Text-content-md5: f6b197cc3f2e89a83e545d4bb003de73
-Text-content-sha1: 2f656677cfec0bceec85e53036ffb63e25126f8e
-Content-length: 2529
+Prop-content-length: 55
+Content-length: 55
+
+K 13
+svn:mergeinfo
+V 20
+/branches/right:2-17
+PROPS-END
+
+
+Node-path: branches/left-sub/Makefile
+Node-kind: file
+Node-action: change
+Text-content-length: 2713
+Text-content-md5: 0afbe34f244cd662b1f97d708c687f90
+Text-content-sha1: 46d9377d783e67a9b581da110352e799517c8a14
+Content-length: 2713
 
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
@@ -809,7 +1177,7 @@ CC=gcc
 
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
-	check-files ls-tree merge-base
+	check-files ls-tree merge-base merge-cache
 
 all: $(PROG)
 
@@ -859,8 +1227,11 @@ check-files: check-files.o read-cache.o
 ls-tree: ls-tree.o read-cache.o
 	$(CC) $(CFLAGS) -o ls-tree ls-tree.o read-cache.o $(LIBS)
 
-merge-base: merge-base.o read-cache.o
-	$(CC) $(CFLAGS) -o merge-base merge-base.o read-cache.o $(LIBS)
+merge-base: merge-base.o read-cache.o object.o commit.o tree.o blob.o
+	$(CC) $(CFLAGS) -o merge-base merge-base.o read-cache.o object.o commit.o tree.o blob.o $(LIBS)
+
+merge-cache: merge-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o merge-cache merge-cache.o read-cache.o $(LIBS)
 
 read-cache.o: cache.h
 show-diff.o: cache.h
@@ -872,31 +1243,165 @@ backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
 
 
-Revision-number: 11
-Prop-content-length: 117
-Content-length: 117
+Node-path: branches/left-sub/bang
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 17
+Node-copyfrom-path: branches/right/bang
+Text-copy-source-md5: 34c28f1d2dc6a9adeccc4265bf7516cb
+Text-copy-source-sha1: 0bc5bb345c0e71d28f784f12e0bd2d384c283062
+
+
+Node-path: branches/left-sub/urkkk
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 17
+Node-copyfrom-path: branches/right/urkkk
+Text-copy-source-md5: 5889c8392e16251b0c80927607a03036
+Text-copy-source-sha1: 3934264d277a0cf886b6b1c7f2b9e56da2525302
+
+
+Revision-number: 19
+Prop-content-length: 129
+Content-length: 129
 
 K 7
 svn:log
-V 14
-right update 1
+V 30
+(r19) left sub-branch update 2
 K 10
 svn:author
-V 8
-tallsopp
+V 4
+samv
 K 8
 svn:date
 V 27
-2009-11-12T20:29:53.059636Z
+2009-12-19T16:18:00.200531Z
 PROPS-END
 
-Node-path: branches/right/Makefile
+Node-path: branches/left-sub/wham_eth
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 6
+Text-content-md5: 757bcd5818572ef3f9580052617c1c8b
+Text-content-sha1: b165019b005c199237ba822c4404e771e93b654a
+Content-length: 16
+
+PROPS-END
+zowie
+
+
+Revision-number: 20
+Prop-content-length: 118
+Content-length: 118
+
+K 7
+svn:log
+V 19
+(r20) left update 5
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-12-19T16:18:00.659636Z
+PROPS-END
+
+Node-path: branches/left/glurpp
 Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 8
+Text-content-md5: 14a169f628e0bb59df9c2160649d0a30
+Text-content-sha1: ef7d929e52177767ecfcd28941f6b7f04b4131e3
+Content-length: 18
+
+PROPS-END
+eee_yow
+
+
+Revision-number: 21
+Prop-content-length: 147
+Content-length: 147
+
+K 7
+svn:log
+V 48
+(r21) Cherry-pick left sub-branch commit to left
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-12-19T16:18:01.194402Z
+PROPS-END
+
+Node-path: branches/left
+Node-kind: dir
 Node-action: change
-Text-content-length: 2593
-Text-content-md5: 5ccff689fb290e00b85fe18ee50c54ba
-Text-content-sha1: a13de8e23f1483efca3e57b2b64b0ae6f740ce10
-Content-length: 2593
+Prop-content-length: 56
+Content-length: 56
+
+K 13
+svn:mergeinfo
+V 21
+/branches/left-sub:19
+PROPS-END
+
+
+Node-path: branches/left/wham_eth
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 19
+Node-copyfrom-path: branches/left-sub/wham_eth
+Text-copy-source-md5: 757bcd5818572ef3f9580052617c1c8b
+Text-copy-source-sha1: b165019b005c199237ba822c4404e771e93b654a
+
+
+Revision-number: 22
+Prop-content-length: 134
+Content-length: 134
+
+K 7
+svn:log
+V 35
+(r22) Merge left sub-branch to left
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-12-19T16:18:01.679218Z
+PROPS-END
+
+Node-path: branches/left
+Node-kind: dir
+Node-action: change
+Prop-content-length: 79
+Content-length: 79
+
+K 13
+svn:mergeinfo
+V 44
+/branches/left-sub:4-19
+/branches/right:2-17
+PROPS-END
+
+
+Node-path: branches/left/Makefile
+Node-kind: file
+Node-action: change
+Text-content-length: 2713
+Text-content-md5: 0afbe34f244cd662b1f97d708c687f90
+Text-content-sha1: 46d9377d783e67a9b581da110352e799517c8a14
+Content-length: 2713
 
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
@@ -914,7 +1419,7 @@ CC=gcc
 
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
-	check-files ls-tree merge-base
+	check-files ls-tree merge-base merge-cache
 
 all: $(PROG)
 
@@ -967,6 +1472,9 @@ ls-tree: ls-tree.o read-cache.o
 merge-base: merge-base.o read-cache.o object.o commit.o tree.o blob.o
 	$(CC) $(CFLAGS) -o merge-base merge-base.o read-cache.o object.o commit.o tree.o blob.o $(LIBS)
 
+merge-cache: merge-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o merge-cache merge-cache.o read-cache.o $(LIBS)
+
 read-cache.o: cache.h
 show-diff.o: cache.h
 
@@ -977,34 +1485,141 @@ backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
 
 
-Revision-number: 12
-Prop-content-length: 116
-Content-length: 116
+Node-path: branches/left/README
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 18
+Node-copyfrom-path: branches/left-sub/README
+Text-copy-source-md5: fdbcfb6be9afe1121862143f226b51cf
+Text-copy-source-sha1: 1d1f5ea4ceb584337ffe59b8980d92e3b78dfef4
+
+
+Node-path: branches/left/bang
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 18
+Node-copyfrom-path: branches/left-sub/bang
+Text-copy-source-md5: 34c28f1d2dc6a9adeccc4265bf7516cb
+Text-copy-source-sha1: 0bc5bb345c0e71d28f784f12e0bd2d384c283062
+
+
+Node-path: branches/left/urkkk
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 18
+Node-copyfrom-path: branches/left-sub/urkkk
+Text-copy-source-md5: 5889c8392e16251b0c80927607a03036
+Text-copy-source-sha1: 3934264d277a0cf886b6b1c7f2b9e56da2525302
+
+
+Revision-number: 23
+Prop-content-length: 126
+Content-length: 126
 
 K 7
 svn:log
-V 13
-Merge trunk 2
+V 27
+(r23) Merge left to trunk 2
 K 10
 svn:author
-V 8
-tallsopp
+V 4
+samv
 K 8
 svn:date
 V 27
-2009-11-12T20:29:56.083003Z
+2009-12-19T16:18:02.212349Z
 PROPS-END
 
 Node-path: trunk
 Node-kind: dir
 Node-action: change
-Prop-content-length: 54
-Content-length: 54
+Prop-content-length: 99
+Content-length: 99
 
 K 13
 svn:mergeinfo
-V 19
-/branches/left:2-11
+V 64
+/branches/left:2-22
+/branches/left-sub:4-19
+/branches/right:2-17
+PROPS-END
+
+
+Node-path: trunk/README
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 22
+Node-copyfrom-path: branches/left/README
+Text-copy-source-md5: fdbcfb6be9afe1121862143f226b51cf
+Text-copy-source-sha1: 1d1f5ea4ceb584337ffe59b8980d92e3b78dfef4
+
+
+Node-path: trunk/glurpp
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 22
+Node-copyfrom-path: branches/left/glurpp
+Text-copy-source-md5: 14a169f628e0bb59df9c2160649d0a30
+Text-copy-source-sha1: ef7d929e52177767ecfcd28941f6b7f04b4131e3
+
+
+Node-path: trunk/urkkk
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 22
+Node-copyfrom-path: branches/left/urkkk
+Text-copy-source-md5: 5889c8392e16251b0c80927607a03036
+Text-copy-source-sha1: 3934264d277a0cf886b6b1c7f2b9e56da2525302
+
+
+Node-path: trunk/wham_eth
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 22
+Node-copyfrom-path: branches/left/wham_eth
+Text-copy-source-md5: 757bcd5818572ef3f9580052617c1c8b
+Text-copy-source-sha1: b165019b005c199237ba822c4404e771e93b654a
+
+
+Node-path: trunk/zlonk
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 22
+Node-copyfrom-path: branches/left/zlonk
+Text-copy-source-md5: 8b9d8c7c2aaa6167e7d3407a773bbbba
+Text-copy-source-sha1: 9716527ebd70a75c27625cacbeb2d897c6e86178
+
+
+Revision-number: 24
+Prop-content-length: 131
+Content-length: 131
+
+K 7
+svn:log
+V 32
+(r24) non-merge right to trunk 2
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-12-19T16:18:02.672148Z
+PROPS-END
+
+Node-path: trunk
+Node-kind: dir
+Node-action: change
+Prop-content-length: 99
+Content-length: 99
+
+K 13
+svn:mergeinfo
+V 64
+/branches/left:2-22
+/branches/left-sub:4-19
+/branches/right:2-22
 PROPS-END
 
 
-- 
1.6.3.3
