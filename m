From: Chris Mason <mason@suse.com>
Subject: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 12:50:09 -0400
Message-ID: <200504191250.10286.mason@suse.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CbTZC/hYlyEWvb+"
X-From: git-owner@vger.kernel.org Tue Apr 19 18:48:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNvs6-0006F7-I4
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 18:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVDSQuu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 12:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVDSQuu
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 12:50:50 -0400
Received: from ns1.suse.de ([195.135.220.2]:46767 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261623AbVDSQuQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 12:50:16 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 5B65D160949F;
	Tue, 19 Apr 2005 18:50:15 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
User-Agent: KMail/1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_CbTZC/hYlyEWvb+
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everyone,

I did a quick experiment with applying/commit 100 patches from the suse kernel 
into a kernel git tree, which quilt can do in 2 seconds.  git needs 1m5s.

The primary performance problem during each commit is write-tree recalculating 
the hash of each directory, even though the contents of most directories are 
not changing.  I've attached a very quick and dirty mod of write-tree.c, it 
takes an optional tree id (sha1) and list of directories.  The hash of any 
directories not in the list are read in from existing files instead of being 
recalculated.

You have to pass each sub dir with a modified file.  So, if you change 
fs/super.c and fs/ext3/super.c, you would call "write-tree sha1 fs fs/ext3"
With this patch, the time to apply 100 commits goes down to 22 seconds.  It 
could be faster (and easier to use) if the index stored the hash of trees 
instead of just blobs, but that would be a larger change.

I was able to get the commit time down to 13 seconds by changing read-tree.c, 
update-cache.c and read-cache.c to store/read the index in tmpfs instead of 
on the local filesystem.  I haven't attached the patch for that, but it seems 
easiest to move .git/index into .git/index_dir/index, and let the user decide 
where to put index_dir.

Quick speed summary, apply/commit 100 patches
quilt push -a     :                    2s
git (unmodified):               1m5s
git (tree hash reduction)      22s
git (tree hash, tmpfs index) 13s

This patch is against pasky's tree from this morning, but also applies to 
linus' tree.  It's nasty stuff, but will hopefully get some discussion 
started on speeding things up.

-chris

--Boundary-00=_CbTZC/hYlyEWvb+
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fast-dirs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fast-dirs.diff"

--- a/write-tree.c
+++ b/write-tree.c
@@ -4,6 +4,8 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+static char **dirs;
+static int num_dirs = 0;
 
 static int check_valid_sha1(unsigned char *sha1)
 {
@@ -27,15 +29,47 @@ static int prepend_integer(char *buffer,
 	return i;
 }
 
+static int find_sha(char *buffer, int size, const char *base, int baselen, char *returnsha1)
+{
+	while(size) {
+		int len = strlen(buffer)+1;
+		unsigned char *sha1 = buffer + len;
+		char *path = strchr(buffer, ' ')+1;
+		unsigned int mode;
+
+		if (size < len + 20 || sscanf(buffer, "%o", &mode) != 1)
+			die("corrupt 'tree' file");
+		buffer = sha1 + 20;
+		size -= len + 20;
+		if (strncmp(path, base, baselen) == 0 &&
+		    strlen(path) == baselen) {
+			memcpy(returnsha1, sha1, 20);
+			return 0;
+		}
+	}
+	return -1;
+}
+
 #define ORIG_OFFSET (40)	/* Enough space to add the header of "tree <size>\0" */
 
-static int write_tree(struct cache_entry **cachep, int maxentries, const char *base, int baselen, unsigned char *returnsha1)
+static int write_tree(struct cache_entry **cachep, int maxentries, const char *base, int baselen, unsigned char *returnsha1, char *treesha)
 {
 	unsigned char subdir_sha1[20];
 	unsigned long size, offset;
 	char *buffer;
 	int i, nr;
-
+	char *tree = NULL;
+	unsigned long tree_size;
+	char type[20];
+	if (treesha) {
+		tree = read_sha1_file(treesha, type, &tree_size);
+		if (!tree) {
+			die("unable to read sha1 file");
+		} else {
+		}
+		if (strcmp(type, "tree"))
+			die("expected a tree node");
+	}
 	/* Guess at some random initial size */
 	size = 8192;
 	buffer = malloc(size);
@@ -55,15 +89,60 @@ static int write_tree(struct cache_entry
 
 		sha1 = ce->sha1;
 		mode = ntohl(ce->ce_mode);
-
 		/* Do we have _further_ subdirectories? */
 		filename = pathname + baselen;
 		dirname = strchr(filename, '/');
 		if (dirname) {
 			int subdir_written;
-
-			subdir_written = write_tree(cachep + nr, maxentries - nr, pathname, dirname-pathname+1, subdir_sha1);
-			nr += subdir_written;
+			int dirlen = dirname - pathname;
+			int dirmatch = 1;
+			if (tree && num_dirs > 0) {
+				dirmatch = 0;
+				for(i = 0 ; i < num_dirs; i++) {
+					int len = strlen(dirs[i]);
+					if (len <= baselen)
+						continue;
+					if (memcmp(dirs[i], pathname, dirlen)==0 &&
+					    pathname[dirlen] == '/') {
+						dirmatch = 1;
+						break;
+					}
+				}
+				if (!dirmatch && find_sha(tree, tree_size, 
+							 filename, 
+							 dirname-filename, 
+							 subdir_sha1)) {
+					dirmatch = 1;
+				}
+			}
+			if (!dirmatch) {
+				/* eat all the entries in this dir */
+				while(++nr < maxentries) {
+					char *p;
+					ce = cachep[nr];
+					p = strchr(ce->name + baselen, '/');
+					if (!p)
+						break;
+					if (p - ce->name != dirname-pathname)
+						break;
+					if (memcmp(pathname, ce->name, p-ce->name))
+						break;
+				}
+			} else {
+				unsigned char thisdir_sha1[20];
+				char *p = thisdir_sha1;
+				if (num_dirs && tree) {
+				    if (find_sha(tree, tree_size, filename, 
+				                 dirname-filename, p)) {
+				    	num_dirs = 0;
+					p = NULL;
+				    }
+				} else {
+					p = NULL;
+				}
+				subdir_written = write_tree(cachep + nr, maxentries - nr, pathname, dirname-pathname+1, subdir_sha1, p);
+				nr += subdir_written;
+			}
 
 			/* Now we need to write out the directory entry into this tree.. */
 			mode = S_IFDIR;
@@ -92,9 +172,10 @@ static int write_tree(struct cache_entry
 	i = prepend_integer(buffer, offset - ORIG_OFFSET, ORIG_OFFSET);
 	i -= 5;
 	memcpy(buffer+i, "tree ", 5);
-
 	write_sha1_file(buffer + i, offset - i, returnsha1);
 	free(buffer);
+	if (tree)
+		free(tree);
 	return nr;
 }
 
@@ -103,7 +184,19 @@ int main(int argc, char **argv)
 	int i, unmerged;
 	int entries = read_cache();
 	unsigned char sha1[20];
+	unsigned char treesha1[20];
+	char *p = NULL;
 
+	if (argc > 1) {
+		if (argc < 3)
+			die("usage: write-tree [sha1 dir1 dir2 ...]");
+		num_dirs = argc - 2;
+		dirs = argv + 2;
+		if (get_sha1_hex(argv[1], treesha1) < 0)
+			die("bad sha1 given");
+		p = treesha1;
+
+	}
 	if (entries <= 0)
 		die("write-tree: no cache contents to write");
 
@@ -123,7 +216,7 @@ int main(int argc, char **argv)
 		die("write-tree: not able to write tree");
 
 	/* Ok, write it out */
-	if (write_tree(active_cache, entries, "", 0, sha1) != entries)
+	if (write_tree(active_cache, entries, "", 0, sha1, p) != entries)
 		die("write-tree: internal error");
 	printf("%s\n", sha1_to_hex(sha1));
 	return 0;

--Boundary-00=_CbTZC/hYlyEWvb+--
