From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] ls-tree path restriction semantics fixes
Date: Fri, 27 May 2005 08:08:51 -0400
Message-ID: <20050527120851.GA11823@port.evillabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 27 14:08:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbdcK-0007zJ-EG
	for gcvg-git@gmane.org; Fri, 27 May 2005 14:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVE0MJA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 08:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbVE0MJA
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 08:09:00 -0400
Received: from c-67-163-246-116.hsd1.pa.comcast.net ([67.163.246.116]:51145
	"EHLO port.evillabs.net") by vger.kernel.org with ESMTP
	id S262439AbVE0MIw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 08:08:52 -0400
Received: by port.evillabs.net (Postfix, from userid 500)
	id 6317A3048F; Fri, 27 May 2005 08:08:51 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch fixes the git-ls-tree semantics to be less stupid, namely:
	
	* ls of a 'tree' path should just return the SHA1 of the tree
	* ls of a 'tree' path with a trailing '/' should work properly
	* ls of two identical paths should have the same output as ls of
	  a single path. (I consider ls-tree's output to be a hash dictionary)

Also, I added test cases to verify that these issues are fixed.

Old Results:

	$ git-ls-tree t
	040000 tree 4eeb3990955b8badc4c14712b89d8cd9fff02f15    t
	100644 blob 6882e23be568ccf14f3adb0c766139086f2ee952    t/Makefile
	100644 blob 2a94fdb0b83ab5fcbf1a2c6edaf36c2dbe765ec6    t/README
	100644 blob d920c6b3a3bfbb5994244a78d1ad99ce02748122    t/lib-read-tree-m-3way.sh
	...

	$ git-ls-tree t/
	(no output)

	$ git-ls-tree t t
	040000 tree 4eeb3990955b8badc4c14712b89d8cd9fff02f15    t

New Results:

	$ git-ls-tree f
	040000 tree 4eeb3990955b8badc4c14712b89d8cd9fff02f15    t

	$ git-ls-tree t/
	040000 tree 4eeb3990955b8badc4c14712b89d8cd9fff02f15    t

	$ git-ls-tree t t
	040000 tree 4eeb3990955b8badc4c14712b89d8cd9fff02f15    t

Signed-Off-By: Jason McMullan <jason.mcmullan@timesys.com>

diff --git a/ls-tree.c b/ls-tree.c
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -13,8 +13,6 @@ struct path_prefix {
 	const char *name;
 };
 
-#define DEBUG(fmt, ...)	
-
 static int string_path_prefix(char *buff, size_t blen, struct path_prefix *prefix)
 {
 	int len = 0;
@@ -118,6 +116,8 @@ static void list_recursive(void *buffer,
 			mtype = pathcmp(match[mindex],&this_prefix);
 			if (mtype >= 0) {
 				matched = match[mindex];
+				/* Skip over any duplicates */
+				for (; mindex+1 < matches && strcmp(match[mindex+1],matched)==0; mindex++);
 				break;
 			}
 		}
@@ -140,19 +140,22 @@ static void list_recursive(void *buffer,
 		if (matches && ! matched)
 			continue;
 
-		if (! (eltbuf = read_sha1_file(sha1, elttype, &eltsize)) ) {
-			error("cannot read %s", sha1_to_hex(sha1));
-			continue;
-		}
-
 		/* If this is an exact directory match, we may have
 		 * directory files following this path. Match on them.
-		 * Otherwise, we're at a pach subcomponent, and we need
+		 * Otherwise, we're at a path subcomponent, and we need
 		 * to try to match again.
 		 */
 		if (mtype == 0)
 			mindex++;
 
+		if (matched && matches-mindex==0)
+			continue;
+
+		if (! (eltbuf = read_sha1_file(sha1, elttype, &eltsize)) ) {
+			error("cannot read %s", sha1_to_hex(sha1));
+			continue;
+		}
+
 		list_recursive(eltbuf, elttype, eltsize, &this_prefix, &match[mindex], matches-mindex);
 		free(eltbuf);
 	}
@@ -169,9 +172,14 @@ static int list(unsigned char *sha1,char
 	unsigned long size;
 	int npaths;
 
-	for (npaths = 0; path[npaths] != NULL; npaths++)
-		;
+	/* Count the paths, and any trailling '/' */
+	for (npaths = 0; path[npaths] != NULL; npaths++) {
+		char *cp = strrchr(path[npaths],'/');
+		if (cp != NULL && *(cp+1) == 0)
+			*cp=0;
+	}	
 
+	/* Sort the paths */
 	qsort(path,npaths,sizeof(char *),qcmp);
 
 	buffer = read_object_with_reference(sha1, "tree", &size, NULL);
diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -84,10 +84,22 @@ test_expect_success \
     'git-ls-tree $tree path2 >current &&
      cat >expected <<\EOF &&
 040000 tree X	path2
-040000 tree X	path2/baz
-100644 blob X	path2/baz/b
-120000 blob X	path2/bazbo
-100644 blob X	path2/foo
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree filtered' \
+    'git-ls-tree $tree path2/ >current &&
+     cat >expected <<\EOF &&
+040000 tree X	path2
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree filtered' \
+    'git-ls-tree $tree path2 path2 >current &&
+     cat >expected <<\EOF &&
+040000 tree X	path2
 EOF
      test_output'
 
@@ -96,7 +108,16 @@ test_expect_success \
     'git-ls-tree $tree path2/baz >current &&
      cat >expected <<\EOF &&
 040000 tree X	path2/baz
-100644 blob X	path2/baz/b
+EOF
+     test_output'
+
+test_expect_success \
+    'ls-tree filtered' \
+    'git-ls-tree $tree path2 path2/bazbo path2/baz >current &&
+     cat >expected <<\EOF &&
+040000 tree X	path2
+040000 tree X	path2/baz
+120000 blob X	path2/bazbo
 EOF
      test_output'
 
