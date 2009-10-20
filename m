From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 4/5] git-svn: add test data for SVN 1.5+ merge, with script.
Date: Tue, 20 Oct 2009 15:42:02 +1300
Message-ID: <1256006523-5493-5-git-send-email-sam.vilain@catalyst.net.nz>
References: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz>
 <1256006523-5493-2-git-send-email-sam.vilain@catalyst.net.nz>
 <1256006523-5493-3-git-send-email-sam.vilain@catalyst.net.nz>
 <1256006523-5493-4-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 04:43:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N04hZ-0008AQ-Ta
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 04:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbZJTCnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 22:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756339AbZJTCnj
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 22:43:39 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:42717 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758238AbZJTCne (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 22:43:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 56B783237F;
	Tue, 20 Oct 2009 15:43:38 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j8I2DZx6Eyhb; Tue, 20 Oct 2009 15:43:35 +1300 (NZDT)
Received: from localhost.localdomain (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 736A13236D;
	Tue, 20 Oct 2009 15:43:35 +1300 (NZDT)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1256006523-5493-4-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130753>

Dump generated with SVN 1.5.1 (on lenny amd64).  This test should hopefully
cover all but a few intermediate versions of the svnmerge.py script.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 t/t9151/.gitignore         |    2 +
 t/t9151/make-svnmerge-dump |   73 +++++
 t/t9151/svn-mergeinfo.dump |  736 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 811 insertions(+), 0 deletions(-)
 create mode 100644 t/t9151/.gitignore
 create mode 100644 t/t9151/make-svnmerge-dump
 create mode 100644 t/t9151/svn-mergeinfo.dump

diff --git a/t/t9151/.gitignore b/t/t9151/.gitignore
new file mode 100644
index 0000000..587c37d
--- /dev/null
+++ b/t/t9151/.gitignore
@@ -0,0 +1,2 @@
+foo
+foo.svn
diff --git a/t/t9151/make-svnmerge-dump b/t/t9151/make-svnmerge-dump
new file mode 100644
index 0000000..e35d64d
--- /dev/null
+++ b/t/t9151/make-svnmerge-dump
@@ -0,0 +1,73 @@
+#!/bin/sh
+#
+# this script sets up a Subversion repository for Makefile in the
+# first ever git merge, as if it were done with svnmerge (SVN 1.5+)
+#
+
+rm -rf foo.svn foo
+set -e
+
+mkdir foo.svn
+svnadmin create foo.svn
+svn co file://`pwd`/foo.svn foo
+
+cd foo
+mkdir trunk
+mkdir branches
+svn add trunk branches
+svn commit -m "Setup trunk and branches"
+cd trunk
+
+git cat-file blob 6683463e:Makefile > Makefile
+svn add Makefile 
+
+echo "Committing ANCESTOR"
+svn commit -m "ancestor"
+cd ..
+svn cp trunk branches/left
+
+echo "Committing BRANCH POINT"
+svn commit -m "make left branch"
+cd branches/left/
+
+#$sm init
+#svn commit -m "init svnmerge"
+
+git cat-file blob 5873b67e:Makefile > Makefile
+echo "Committing BRANCH UPDATE 1"
+svn commit -m "left update 1"
+cd ../..
+
+cd trunk
+git cat-file blob 75118b13:Makefile > Makefile
+echo "Committing TRUNK UPDATE"
+svn commit -m "trunk update"
+
+cd ../branches/left
+git cat-file blob ff5ebe39:Makefile > Makefile
+echo "Committing BRANCH UPDATE 2"
+svn commit -m "left update 2"
+
+git cat-file blob b5039db6:Makefile > Makefile
+echo "Committing BRANCH UPDATE 3"
+svn commit -m "left update 3"
+
+# merge to trunk
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
+svn commit -m "Merge trunk"
+
+cd ../..
+
+svnadmin dump foo.svn > svn-mergeinfo.dump
+
+rm -rf foo foo.svn
diff --git a/t/t9151/svn-mergeinfo.dump b/t/t9151/svn-mergeinfo.dump
new file mode 100644
index 0000000..2153187
--- /dev/null
+++ b/t/t9151/svn-mergeinfo.dump
@@ -0,0 +1,736 @@
+SVN-fs-dump-format-version: 2
+
+UUID: 1ce241d1-ba54-4eb9-bded-03057fe48a33
+
+Revision-number: 0
+Prop-content-length: 56
+Content-length: 56
+
+K 8
+svn:date
+V 27
+2009-10-20T01:33:37.692723Z
+PROPS-END
+
+Revision-number: 1
+Prop-content-length: 123
+Content-length: 123
+
+K 7
+svn:log
+V 24
+Setup trunk and branches
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-10-20T01:33:38.159933Z
+PROPS-END
+
+Node-path: branches
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: trunk
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Revision-number: 2
+Prop-content-length: 106
+Content-length: 106
+
+K 7
+svn:log
+V 8
+ancestor
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-10-20T01:33:39.160059Z
+PROPS-END
+
+Node-path: trunk/Makefile
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 2401
+Text-content-md5: bfd8ff778d1492dc6758567373176a89
+Content-length: 2411
+
+PROPS-END
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
+fsck-cache: fsck-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o fsck-cache fsck-cache.o read-cache.o $(LIBS)
+
+checkout-cache: checkout-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o checkout-cache checkout-cache.o read-cache.o $(LIBS)
+
+diff-tree: diff-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o diff-tree diff-tree.o read-cache.o $(LIBS)
+
+rev-tree: rev-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o rev-tree rev-tree.o read-cache.o $(LIBS)
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
+Revision-number: 3
+Prop-content-length: 115
+Content-length: 115
+
+K 7
+svn:log
+V 16
+make left branch
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-10-20T01:33:41.148192Z
+PROPS-END
+
+Node-path: branches/left
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 1
+Node-copyfrom-path: trunk
+Prop-content-length: 34
+Content-length: 34
+
+K 13
+svn:mergeinfo
+V 0
+
+PROPS-END
+
+
+Node-path: branches/left/Makefile
+Node-kind: file
+Node-action: add
+Node-copyfrom-rev: 2
+Node-copyfrom-path: trunk/Makefile
+Text-copy-source-md5: bfd8ff778d1492dc6758567373176a89
+
+
+Revision-number: 4
+Prop-content-length: 112
+Content-length: 112
+
+K 7
+svn:log
+V 13
+left update 1
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-10-20T01:33:42.148773Z
+PROPS-END
+
+Node-path: branches/left/Makefile
+Node-kind: file
+Node-action: change
+Text-content-length: 2465
+Text-content-md5: 16e38d9753b061731650561ce01b1195
+Content-length: 2465
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
+fsck-cache: fsck-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o fsck-cache fsck-cache.o read-cache.o $(LIBS)
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
+Revision-number: 5
+Prop-content-length: 111
+Content-length: 111
+
+K 7
+svn:log
+V 12
+trunk update
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-10-20T01:33:43.159959Z
+PROPS-END
+
+Node-path: trunk/Makefile
+Node-kind: file
+Node-action: change
+Text-content-length: 2521
+Text-content-md5: 0668418a621333f4aa8b6632cd63e2a0
+Content-length: 2521
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
+	check-files ls-tree merge-base merge-cache
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
+fsck-cache: fsck-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o fsck-cache fsck-cache.o read-cache.o $(LIBS)
+
+checkout-cache: checkout-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o checkout-cache checkout-cache.o read-cache.o $(LIBS)
+
+diff-tree: diff-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o diff-tree diff-tree.o read-cache.o $(LIBS)
+
+rev-tree: rev-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o rev-tree rev-tree.o read-cache.o $(LIBS)
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
+merge-cache: merge-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o merge-cache merge-cache.o read-cache.o $(LIBS)
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
+Revision-number: 6
+Prop-content-length: 112
+Content-length: 112
+
+K 7
+svn:log
+V 13
+left update 2
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-10-20T01:33:44.164175Z
+PROPS-END
+
+Node-path: branches/left/Makefile
+Node-kind: file
+Node-action: change
+Text-content-length: 2529
+Text-content-md5: f6b197cc3f2e89a83e545d4bb003de73
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
+Revision-number: 7
+Prop-content-length: 112
+Content-length: 112
+
+K 7
+svn:log
+V 13
+left update 3
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-10-20T01:33:45.144214Z
+PROPS-END
+
+Node-path: branches/left/Makefile
+Node-kind: file
+Node-action: change
+Text-content-length: 2593
+Text-content-md5: 5ccff689fb290e00b85fe18ee50c54ba
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
+Revision-number: 8
+Prop-content-length: 110
+Content-length: 110
+
+K 7
+svn:log
+V 11
+Merge trunk
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-10-20T01:33:48.176135Z
+PROPS-END
+
+Node-path: trunk
+Node-kind: dir
+Node-action: change
+Prop-content-length: 53
+Content-length: 53
+
+K 13
+svn:mergeinfo
+V 18
+/branches/left:2-7
+PROPS-END
+
+
+Node-path: trunk/Makefile
+Node-kind: file
+Node-action: change
+Text-content-length: 2713
+Text-content-md5: 0afbe34f244cd662b1f97d708c687f90
+Content-length: 2713
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
+	check-files ls-tree merge-base merge-cache
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
+merge-cache: merge-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o merge-cache merge-cache.o read-cache.o $(LIBS)
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
-- 
1.6.3.3
