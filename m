From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-tar-tree: add a test case (resent)
Date: Thu, 2 Jun 2005 22:50:17 +0200
Message-ID: <20050602205017.GA5491@lsrfire.ath.cx>
References: <20050602185046.GA3717@lsrfire.ath.cx> <7v64ww34of.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 22:56:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdwhT-0006Cv-OZ
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 22:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVFBUzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 16:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFBUxQ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 16:53:16 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:39304 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261340AbVFBUuS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 16:50:18 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id E35244A9; Thu,  2 Jun 2005 22:50:17 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <7v64ww34of.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 02, 2005 at 01:05:36PM -0700, Junio C Hamano wrote:
> I like the test but suspect it belongs to t5000 series according
> to the numbering scheme Pasky originaly did.

The README says:
  3 - the other basic commands (e.g. ls-files)
  [...]
  5 - the pull and exporting commands

So I guess you're right.  I shouldn't have stopped reading after point
three..

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
new file mode 100755
--- /dev/null
+++ b/t/t5000-tar-tree.sh
@@ -0,0 +1,106 @@
+#!/bin/sh
+#
+# Copyright (C) 2005 Rene Scharfe
+#
+
+test_description='git-tar-tree and git-get-tar-commit-id test
+
+This test covers the topics of long paths, file contents, commit date
+handling and commit id embedding:
+
+  Paths longer than 100 characters require the use of a pax extended
+  header to store them.  The test creates files with pathes both longer
+  and shorter than 100 chars, and also checks symlinks with long and
+  short pathes both as their own name and as target path.
+
+  The contents of the repository is compared to the extracted tar
+  archive.  The repository contains simple text files, symlinks and a
+  binary file (/bin/sh).
+
+  git-tar-tree applies the commit date to every file in the archive it
+  creates.  The test sets the commit date to a specific value and checks
+  if the tar archive contains that value.
+
+  When giving git-tar-tree a commit id (in contrast to a tree id) it
+  embeds this commit id into the tar archive as a comment.  The test
+  checks the ability of git-get-tar-commit-id to figure it out from the
+  tar file.
+
+'
+
+. ./test-lib.sh
+
+test_expect_success \
+    'populate workdir' \
+    'mkdir a b c &&
+     p48=1.......10........20........30........40......48 &&
+     p50=1.......10........20........30........40........50 &&
+     p98=${p48}${p50} &&
+     echo simple textfile >a/a &&
+     echo 100 chars in path >a/${p98} &&
+     echo 101 chars in path >a/${p98}x &&
+     echo 102 chars in path >a/${p98}xx &&
+     echo 103 chars in path >a/${p98}xxx &&
+     mkdir a/bin &&
+     cp /bin/sh a/bin/sh &&
+     ln -s a a/l1 &&
+     ln -s ${p98}xx a/l100 &&
+     ln -s ${p98}xxx a/l101 &&
+     ln -s ${p98}xxx a/l${p98} &&
+     (cd a && find .) | sort >a.lst'
+
+test_expect_success \
+    'add files to repository' \
+    'find a -type f | xargs git-update-cache --add &&
+     find a -type l | xargs git-update-cache --add &&
+     treeid=`git-write-tree` &&
+     echo $treeid >treeid &&
+     TZ= GIT_COMMITTER_DATE="2005-05-27 22:00:00" \
+     git-commit-tree $treeid </dev/null >.git/HEAD'
+
+test_expect_success \
+    'git-tar-tree' \
+    'git-tar-tree HEAD >b.tar'
+
+test_expect_success \
+    'validate file modification time' \
+    'tar tvf b.tar a/a | awk \{print\ \$4,\$5\} >b.mtime &&
+     echo "2005-05-27 22:00:00" >expected.mtime &&
+     diff expected.mtime b.mtime'
+
+test_expect_success \
+    'git-get-tar-commit-id' \
+    'git-get-tar-commit-id <b.tar >b.commitid &&
+     diff .git/HEAD b.commitid'
+
+test_expect_success \
+    'extract tar archive' \
+    '(cd b && tar xf -) <b.tar'
+
+test_expect_success \
+    'validate filenames' \
+    '(cd b/a && find .) | sort >b.lst &&
+     diff a.lst b.lst'
+
+test_expect_success \
+    'validate file contents' \
+    'diff -r a b/a'
+
+test_expect_success \
+    'git-tar-tree with prefix' \
+    'git-tar-tree HEAD prefix >c.tar'
+
+test_expect_success \
+    'extract tar archive with prefix' \
+    '(cd c && tar xf -) <c.tar'
+
+test_expect_success \
+    'validate filenames with prefix' \
+    '(cd c/prefix/a && find .) | sort >c.lst &&
+     diff a.lst c.lst'
+
+test_expect_success \
+    'validate file contents with prefix' \
+    'diff -r a c/prefix/a'
+
+test_done
