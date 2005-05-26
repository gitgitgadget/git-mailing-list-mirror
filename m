From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] ls-tree matching a prefix
Date: Wed, 25 May 2005 23:47:56 -0400
Message-ID: <20050526034756.GA1488@port.evillabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 26 05:46:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db9KA-0004YJ-RQ
	for gcvg-git@gmane.org; Thu, 26 May 2005 05:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVEZDsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 23:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVEZDsL
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 23:48:11 -0400
Received: from c-67-163-246-116.hsd1.pa.comcast.net ([67.163.246.116]:62697
	"EHLO port.evillabs.net") by vger.kernel.org with ESMTP
	id S261172AbVEZDr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 23:47:57 -0400
Received: by port.evillabs.net (Postfix, from userid 500)
	id 8CDF3405D5; Wed, 25 May 2005 23:47:56 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In the Porcelain I've been working on, I have found it useful
to retrieve a single file's SHA1 out of a tree when I don't 
want to create an index.

For this purpose, I've enhanced git-ls-tree to allow the
specification of an optional 'match path' that restricts
that output of git-ls-tree to just the path requested.

If the patch has a '/' in it, it implies -r.

ie:

$ git-ls-tree HEAD Makefile
100644  blob    92d0e87535ecaa5e52a6503c43dd30dd546ea6b7        Makefile

$ git-ls-tree HEAD t
040000  tree    33ce2f3201c99d5da785bb777639c1e2374c44d2        t

$ git-ls-tree HEAD t/test-lib.sh 
100755  blob    d3f71d1932310197219155b426687d155bf63c5b	t/test-lib.sh

Signed-Off-By: Jason McMullan <jason.mcmullan@timesys.com>

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -27,6 +27,10 @@ OPTIONS
 -z::
 	\0 line termination on output
 
+[path]::
+	Only return items that match the specified path, relative to the
+	root of the tree. If a patch has a '/' in it, implies -r
+
 Output Format
 -------------
         <mode>\t	<type>\t	<object>\t	<file>
diff --git a/ls-tree.c b/ls-tree.c
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -26,10 +26,32 @@ static void print_path_prefix(struct pat
 static void list_recursive(void *buffer,
 			   const char *type,
 			   unsigned long size,
-			   struct path_prefix *prefix)
+			   struct path_prefix *prefix,
+			   const char *match_path)
 {
 	struct path_prefix this_prefix;
 	this_prefix.prev = prefix;
+	char mpref[PATH_MAX];
+	size_t mlen = 0;
+	char *cp = NULL;
+	if (match_path != NULL) {
+		if (*match_path == 0)
+			return;
+		cp = strchr(match_path,'/');
+		if (cp == NULL) {
+			strcpy(mpref,match_path);
+			match_path = NULL;
+		} else {
+			recursive = 1;
+			strncpy(mpref,match_path,cp-match_path);
+			mpref[cp-match_path]=0;
+			cp++;
+			match_path = cp;
+			if (*cp == 0)
+				cp = NULL;
+		}
+		mlen = strlen(mpref);
+	}
 
 	if (strcmp(type, "tree"))
 		die("expected a 'tree' node");
@@ -48,27 +70,35 @@ static void list_recursive(void *buffer,
 		buffer = sha1 + 20;
 		size -= namelen + 20;
 
-		printf("%06o\t%s\t%s\t", mode,
-		       S_ISDIR(mode) ? "tree" : "blob",
-		       sha1_to_hex(sha1));
-		print_path_prefix(prefix);
-		fputs(path, stdout);
-		putchar(line_termination);
+		if (mlen && strcmp(mpref, path) != 0)
+			continue;
+
+		if (cp == NULL) {
+			printf("%06o\t%s\t%s\t", mode,
+			       S_ISDIR(mode) ? "tree" : "blob",
+			       sha1_to_hex(sha1));
+			print_path_prefix(prefix);
+			fputs(path, stdout);
+			putchar(line_termination);
+		}
 
 		if (! recursive || ! S_ISDIR(mode))
 			continue;
 
+		if (mlen && cp == NULL)
+			continue;
+
 		if (! (eltbuf = read_sha1_file(sha1, elttype, &eltsize)) ) {
 			error("cannot read %s", sha1_to_hex(sha1));
 			continue;
 		}
 		this_prefix.name = path;
-		list_recursive(eltbuf, elttype, eltsize, &this_prefix);
+		list_recursive(eltbuf, elttype, eltsize, &this_prefix, match_path);
 		free(eltbuf);
 	}
 }
 
-static int list(unsigned char *sha1)
+static int list(unsigned char *sha1, const char *match_path)
 {
 	void *buffer;
 	unsigned long size;
@@ -76,12 +106,12 @@ static int list(unsigned char *sha1)
 	buffer = read_object_with_reference(sha1, "tree", &size, NULL);
 	if (!buffer)
 		die("unable to read sha1 file");
-	list_recursive(buffer, "tree", size, NULL);
+	list_recursive(buffer, "tree", size, NULL, match_path);
 	free(buffer);
 	return 0;
 }
 
-static const char *ls_tree_usage = "git-ls-tree [-r] [-z] <key>";
+static const char *ls_tree_usage = "git-ls-tree [-r] [-z] <key> [path]";
 
 int main(int argc, char **argv)
 {
@@ -101,11 +131,11 @@ int main(int argc, char **argv)
 		argc--; argv++;
 	}
 
-	if (argc != 2)
+	if (argc != 2 && argc != 3)
 		usage(ls_tree_usage);
 	if (get_sha1(argv[1], sha1) < 0)
 		usage(ls_tree_usage);
-	if (list(sha1) < 0)
+	if (list(sha1, argc==3 ? argv[2] : NULL) < 0)
 		die("list failed");
 	return 0;
 }
