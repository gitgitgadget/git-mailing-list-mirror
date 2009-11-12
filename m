From: Toby Allsopp <toby.allsopp@navman.co.nz>
Subject: [PATCH 1/2] git-svn: add (failing) test for SVN 1.5+ merge with intervening commit
Date: Fri, 13 Nov 2009 09:48:39 +1300
Message-ID: <874ooz5o8s.fsf@navakl084.mitacad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 00:30:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8j7s-0007er-1p
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 00:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208AbZKLXad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 18:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbZKLXab
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 18:30:31 -0500
Received: from ip-58-28-171-25.wxnz.net ([58.28.171.25]:57855 "EHLO
	AKLEXFE01.mitacad.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755164AbZKLXa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 18:30:28 -0500
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Nov 2009 18:30:27 EST
Received: from AKLEXVS01.mitacad.com ([10.112.5.36]) by AKLEXFE01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Nov 2009 12:15:17 +1300
Received: from navakl084.mitacad.com.navman.co.nz ([10.112.8.86]) by AKLEXVS01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Nov 2009 12:15:17 +1300
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
X-OriginalArrivalTime: 12 Nov 2009 23:15:17.0341 (UTC) FILETIME=[FF32F8D0:01CA63ED]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-6.000.1038-17006.000
X-TM-AS-Result: No--10.073100-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132805>

This test exposes a bug in git-svn's handling of SVN 1.5+ mergeinfo
properties.  The problematic case is when there is some commit on an
unrelated branch after the last commit on the merged-from branch.
When SVN records the mergeinfo property, it records the latest
revision in the whole repository, which, in the problematic case, is
not on the branch it is merging from.

To trigger the git-svn bug, we modify t9151 to include two SVN merges,
the second of which has an intervening commit.  The SVN dump was
generated using SVN 1.6.6 (on Debian squeeze amd64).

Signed-off-by: Toby Allsopp <toby.allsopp@navman.co.nz>
---
 t/t9151-svn-mergeinfo.sh   |    6 +-
 t/t9151/make-svnmerge-dump |   32 ++++-
 t/t9151/svn-mergeinfo.dump |  386 +++++++++++++++++++++++++++++++++++++-------
 3 files changed, 366 insertions(+), 58 deletions(-)

diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 9bee516..0d42c84 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -15,7 +15,11 @@ test_expect_success 'load svn dump' "
 	git svn fetch --all
 	"
 
-test_expect_success 'svn merges were represented coming in' "
+test_expect_success 'represent svn merges without intervening commits' "
+	[ `git cat-file commit HEAD^1 | grep parent | wc -l` -eq 2 ]
+	"
+
+test_expect_failure 'represent svn merges with intervening commits' "
 	[ `git cat-file commit HEAD | grep parent | wc -l` -eq 2 ]
 	"
 
diff --git a/t/t9151/make-svnmerge-dump b/t/t9151/make-svnmerge-dump
index e35d64d..7e3da75 100644
--- a/t/t9151/make-svnmerge-dump
+++ b/t/t9151/make-svnmerge-dump
@@ -28,6 +28,10 @@ svn cp trunk branches/left
 
 echo "Committing BRANCH POINT"
 svn commit -m "make left branch"
+svn cp trunk branches/right
+
+echo "Committing other BRANCH POINT"
+svn commit -m "make right branch"
 cd branches/left/
 
 #$sm init
@@ -64,7 +68,33 @@ git cat-file blob b51ad431:Makefile > Makefile
 
 svn resolved Makefile
 
-svn commit -m "Merge trunk"
+svn commit -m "Merge trunk 1"
+
+# create commits on both branches
+
+cd ../branches/left
+git cat-file blob ff5ebe39:Makefile > Makefile
+echo "Committing BRANCH UPDATE 4"
+svn commit -m "left update 4"
+
+cd ../right
+git cat-file blob b5039db6:Makefile > Makefile
+echo "Committing other BRANCH UPDATE 1"
+svn commit -m "right update 1"
+
+# merge to trun again
+
+cd ../..
+svn update
+cd trunk
+
+svn merge ../branches/left --accept postpone
+
+git cat-file blob b51ad431:Makefile > Makefile
+
+svn resolved Makefile
+
+svn commit -m "Merge trunk 2"
 
 cd ../..
 
diff --git a/t/t9151/svn-mergeinfo.dump b/t/t9151/svn-mergeinfo.dump
index 2153187..11a883f 100644
--- a/t/t9151/svn-mergeinfo.dump
+++ b/t/t9151/svn-mergeinfo.dump
@@ -1,6 +1,6 @@
 SVN-fs-dump-format-version: 2
 
-UUID: 1ce241d1-ba54-4eb9-bded-03057fe48a33
+UUID: 1530d5a2-a1dc-4438-8ad5-d95e96db8945
 
 Revision-number: 0
 Prop-content-length: 56
@@ -9,12 +9,12 @@ Content-length: 56
 K 8
 svn:date
 V 27
-2009-10-20T01:33:37.692723Z
+2009-11-12T20:29:38.812226Z
 PROPS-END
 
 Revision-number: 1
-Prop-content-length: 123
-Content-length: 123
+Prop-content-length: 127
+Content-length: 127
 
 K 7
 svn:log
@@ -22,12 +22,12 @@ V 24
 Setup trunk and branches
 K 10
 svn:author
-V 4
-samv
+V 8
+tallsopp
 K 8
 svn:date
 V 27
-2009-10-20T01:33:38.159933Z
+2009-11-12T20:29:39.045856Z
 PROPS-END
 
 Node-path: branches
@@ -49,8 +49,8 @@ PROPS-END
 
 
 Revision-number: 2
-Prop-content-length: 106
-Content-length: 106
+Prop-content-length: 110
+Content-length: 110
 
 K 7
 svn:log
@@ -58,12 +58,12 @@ V 8
 ancestor
 K 10
 svn:author
-V 4
-samv
+V 8
+tallsopp
 K 8
 svn:date
 V 27
-2009-10-20T01:33:39.160059Z
+2009-11-12T20:29:40.079587Z
 PROPS-END
 
 Node-path: trunk/Makefile
@@ -72,6 +72,7 @@ Node-action: add
 Prop-content-length: 10
 Text-content-length: 2401
 Text-content-md5: bfd8ff778d1492dc6758567373176a89
+Text-content-sha1: 103205ce331f7d64086dba497574734f78439590
 Content-length: 2411
 
 PROPS-END
@@ -155,8 +156,8 @@ backup: clean
 
 
 Revision-number: 3
-Prop-content-length: 115
-Content-length: 115
+Prop-content-length: 119
+Content-length: 119
 
 K 7
 svn:log
@@ -164,12 +165,12 @@ V 16
 make left branch
 K 10
 svn:author
-V 4
-samv
+V 8
+tallsopp
 K 8
 svn:date
 V 27
-2009-10-20T01:33:41.148192Z
+2009-11-12T20:29:42.084439Z
 PROPS-END
 
 Node-path: branches/left
@@ -177,27 +178,54 @@ Node-kind: dir
 Node-action: add
 Node-copyfrom-rev: 1
 Node-copyfrom-path: trunk
-Prop-content-length: 34
-Content-length: 34
 
-K 13
-svn:mergeinfo
-V 0
 
+Node-path: branches/left/Makefile
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 2
+Node-copyfrom-path: trunk/Makefile
+Text-copy-source-md5: bfd8ff778d1492dc6758567373176a89
+Text-copy-source-sha1: 103205ce331f7d64086dba497574734f78439590
+
+
+Revision-number: 4
+Prop-content-length: 120
+Content-length: 120
+
+K 7
+svn:log
+V 17
+make right branch
+K 10
+svn:author
+V 8
+tallsopp
+K 8
+svn:date
+V 27
+2009-11-12T20:29:44.065452Z
 PROPS-END
 
+Node-path: branches/right
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 1
+Node-copyfrom-path: trunk
+
 
-Node-path: branches/left/Makefile
+Node-path: branches/right/Makefile
 Node-kind: file
 Node-action: add
 Node-copyfrom-rev: 2
 Node-copyfrom-path: trunk/Makefile
 Text-copy-source-md5: bfd8ff778d1492dc6758567373176a89
+Text-copy-source-sha1: 103205ce331f7d64086dba497574734f78439590
 
 
-Revision-number: 4
-Prop-content-length: 112
-Content-length: 112
+Revision-number: 5
+Prop-content-length: 116
+Content-length: 116
 
 K 7
 svn:log
@@ -205,12 +233,12 @@ V 13
 left update 1
 K 10
 svn:author
-V 4
-samv
+V 8
+tallsopp
 K 8
 svn:date
 V 27
-2009-10-20T01:33:42.148773Z
+2009-11-12T20:29:45.066262Z
 PROPS-END
 
 Node-path: branches/left/Makefile
@@ -218,6 +246,7 @@ Node-kind: file
 Node-action: change
 Text-content-length: 2465
 Text-content-md5: 16e38d9753b061731650561ce01b1195
+Text-content-sha1: 36da4b84ea9b64218ab48171dfc5c48ae025f38b
 Content-length: 2465
 
 # -DCOLLISION_CHECK if you believe that SHA1's
@@ -299,9 +328,9 @@ backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
 
 
-Revision-number: 5
-Prop-content-length: 111
-Content-length: 111
+Revision-number: 6
+Prop-content-length: 115
+Content-length: 115
 
 K 7
 svn:log
@@ -309,12 +338,12 @@ V 12
 trunk update
 K 10
 svn:author
-V 4
-samv
+V 8
+tallsopp
 K 8
 svn:date
 V 27
-2009-10-20T01:33:43.159959Z
+2009-11-12T20:29:46.278498Z
 PROPS-END
 
 Node-path: trunk/Makefile
@@ -322,6 +351,7 @@ Node-kind: file
 Node-action: change
 Text-content-length: 2521
 Text-content-md5: 0668418a621333f4aa8b6632cd63e2a0
+Text-content-sha1: 4f29afd038e52f45acb5ef8c41acfc70062a741a
 Content-length: 2521
 
 # -DCOLLISION_CHECK if you believe that SHA1's
@@ -406,9 +436,9 @@ backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
 
 
-Revision-number: 6
-Prop-content-length: 112
-Content-length: 112
+Revision-number: 7
+Prop-content-length: 116
+Content-length: 116
 
 K 7
 svn:log
@@ -416,12 +446,12 @@ V 13
 left update 2
 K 10
 svn:author
-V 4
-samv
+V 8
+tallsopp
 K 8
 svn:date
 V 27
-2009-10-20T01:33:44.164175Z
+2009-11-12T20:29:47.069090Z
 PROPS-END
 
 Node-path: branches/left/Makefile
@@ -429,6 +459,7 @@ Node-kind: file
 Node-action: change
 Text-content-length: 2529
 Text-content-md5: f6b197cc3f2e89a83e545d4bb003de73
+Text-content-sha1: 2f656677cfec0bceec85e53036ffb63e25126f8e
 Content-length: 2529
 
 # -DCOLLISION_CHECK if you believe that SHA1's
@@ -510,9 +541,9 @@ backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
 
 
-Revision-number: 7
-Prop-content-length: 112
-Content-length: 112
+Revision-number: 8
+Prop-content-length: 116
+Content-length: 116
 
 K 7
 svn:log
@@ -520,12 +551,12 @@ V 13
 left update 3
 K 10
 svn:author
-V 4
-samv
+V 8
+tallsopp
 K 8
 svn:date
 V 27
-2009-10-20T01:33:45.144214Z
+2009-11-12T20:29:48.053835Z
 PROPS-END
 
 Node-path: branches/left/Makefile
@@ -533,6 +564,7 @@ Node-kind: file
 Node-action: change
 Text-content-length: 2593
 Text-content-md5: 5ccff689fb290e00b85fe18ee50c54ba
+Text-content-sha1: a13de8e23f1483efca3e57b2b64b0ae6f740ce10
 Content-length: 2593
 
 # -DCOLLISION_CHECK if you believe that SHA1's
@@ -614,22 +646,22 @@ backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
 
 
-Revision-number: 8
-Prop-content-length: 110
-Content-length: 110
+Revision-number: 9
+Prop-content-length: 116
+Content-length: 116
 
 K 7
 svn:log
-V 11
-Merge trunk
+V 13
+Merge trunk 1
 K 10
 svn:author
-V 4
-samv
+V 8
+tallsopp
 K 8
 svn:date
 V 27
-2009-10-20T01:33:48.176135Z
+2009-11-12T20:29:51.098306Z
 PROPS-END
 
 Node-path: trunk
@@ -641,7 +673,7 @@ Content-length: 53
 K 13
 svn:mergeinfo
 V 18
-/branches/left:2-7
+/branches/left:2-8
 PROPS-END
 
 
@@ -650,6 +682,7 @@ Node-kind: file
 Node-action: change
 Text-content-length: 2713
 Text-content-md5: 0afbe34f244cd662b1f97d708c687f90
+Text-content-sha1: 46d9377d783e67a9b581da110352e799517c8a14
 Content-length: 2713
 
 # -DCOLLISION_CHECK if you believe that SHA1's
@@ -734,3 +767,244 @@ backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
 
 
+Revision-number: 10
+Prop-content-length: 116
+Content-length: 116
+
+K 7
+svn:log
+V 13
+left update 4
+K 10
+svn:author
+V 8
+tallsopp
+K 8
+svn:date
+V 27
+2009-11-12T20:29:52.081644Z
+PROPS-END
+
+Node-path: branches/left/Makefile
+Node-kind: file
+Node-action: change
+Text-content-length: 2529
+Text-content-md5: f6b197cc3f2e89a83e545d4bb003de73
+Text-content-sha1: 2f656677cfec0bceec85e53036ffb63e25126f8e
+Content-length: 2529
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
+merge-base: merge-base.o read-cache.o
+	$(CC) $(CFLAGS) -o merge-base merge-base.o read-cache.o $(LIBS)
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
+Revision-number: 11
+Prop-content-length: 117
+Content-length: 117
+
+K 7
+svn:log
+V 14
+right update 1
+K 10
+svn:author
+V 8
+tallsopp
+K 8
+svn:date
+V 27
+2009-11-12T20:29:53.059636Z
+PROPS-END
+
+Node-path: branches/right/Makefile
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
+Prop-content-length: 116
+Content-length: 116
+
+K 7
+svn:log
+V 13
+Merge trunk 2
+K 10
+svn:author
+V 8
+tallsopp
+K 8
+svn:date
+V 27
+2009-11-12T20:29:56.083003Z
+PROPS-END
+
+Node-path: trunk
+Node-kind: dir
+Node-action: change
+Prop-content-length: 54
+Content-length: 54
+
+K 13
+svn:mergeinfo
+V 19
+/branches/left:2-11
+PROPS-END
+
+
-- 
1.6.5.2.155.gbb47.dirty
