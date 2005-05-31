From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] ls-tree: remove trailing slashes properly.
Date: Tue, 31 May 2005 14:49:07 -0700
Message-ID: <7vvf4zvzfw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 23:52:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdEco-0000bX-Rl
	for gcvg-git@gmane.org; Tue, 31 May 2005 23:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVEaVwI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 17:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVEaVvW
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 17:51:22 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:39891 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261564AbVEaVtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 17:49:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050531214906.JNIX19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 May 2005 17:49:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 31 May 2005 08:32:15 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A typo prevented trailing slashes from being removed properly.

This fixes the problem that "drivers/char" which is a tree was
not shown when "drivers/char/" is given.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 t/t3100-ls-tree-restrict.sh |   32 +++++++++++++++++++++++++++-----
 ls-tree.c                   |    2 +-
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -14,7 +14,7 @@ This test runs git-ls-tree with the foll
     path2/baz/b - a file in a directory in a directory
 
 The new path restriction code should do the right thing for path2 and
-path2/baz
+path2/baz.  Also path0/ should snow nothing.
 '
 . ./test-lib.sh
 
@@ -63,7 +63,7 @@ EOF
      test_output'
 
 test_expect_success \
-    'ls-tree filtered' \
+    'ls-tree filtered with path' \
     'git-ls-tree $tree path >current &&
      cat >expected <<\EOF &&
 EOF
@@ -71,7 +71,7 @@ EOF
 
 
 test_expect_success \
-    'ls-tree filtered' \
+    'ls-tree filtered with path1 path0' \
     'git-ls-tree $tree path1 path0 >current &&
      cat >expected <<\EOF &&
 120000 blob X	path1
@@ -80,7 +80,7 @@ EOF
      test_output'
 
 test_expect_success \
-    'ls-tree filtered' \
+    'ls-tree filtered with path2' \
     'git-ls-tree $tree path2 >current &&
      cat >expected <<\EOF &&
 040000 tree X	path2
@@ -91,7 +91,7 @@ EOF
      test_output'
 
 test_expect_success \
-    'ls-tree filtered' \
+    'ls-tree filtered with path2/baz' \
     'git-ls-tree $tree path2/baz >current &&
      cat >expected <<\EOF &&
 040000 tree X	path2/baz
@@ -99,4 +99,26 @@ test_expect_success \
 EOF
      test_output'
 
+test_expect_success \
+    'ls-tree filtered with path2' \
+    'git-ls-tree $tree path2 >current &&
+     cat >expected <<\EOF &&
+040000 tree X	path2
+040000 tree X	path2/baz
+120000 blob X	path2/bazbo
+100644 blob X	path2/foo
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree filtered with path2/' \
+    'git-ls-tree $tree path2/ >current &&
+     cat >expected <<\EOF &&
+040000 tree X	path2
+040000 tree X	path2/baz
+120000 blob X	path2/bazbo
+100644 blob X	path2/foo
+EOF
+     test_output'
+
 test_done
diff --git a/ls-tree.c b/ls-tree.c
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -201,7 +201,7 @@ static int list(char **path)
 	int err = 0;
 	for (i = 0; path[i]; i++) {
 		int len = strlen(path[i]);
-		while (0 <= len && path[i][len] == '/')
+		while (0 < len && path[i][len-1] == '/')
 			len--;
 		err = err | list_one(path[i], path[i] + len);
 	}
------------

