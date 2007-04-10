From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Mon, 9 Apr 2007 21:20:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 09:08:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb7qQ-0007eB-KN
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 06:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965336AbXDJEUf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 00:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966056AbXDJEUf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 00:20:35 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43101 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965336AbXDJEUe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 00:20:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3A4KUPD025749
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Apr 2007 21:20:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3A4KT26031159;
	Mon, 9 Apr 2007 21:20:30 -0700
In-Reply-To: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.956 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44111>


This teaches the really fundamental core SHA1 object handling routines
about gitlinks.  We can compare trees with gitlinks in them (although we
can not actually generate patches for them yet - just raw git diffs),
and they show up as commits in "git ls-tree".

We also know to compare gitlinks as if they were directories (ie the
normal "sort as trees" rules apply).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Ok, that's it for now.

NOTE NOTE NOTE! I'd like to note once more that this doesn't actually get 
you working subproject support. Not only do I need to connect up a few 
more low-level helper functions (things like "git diff" don't know how to 
generate even rudimentary "subproject X changed" patches, nor can you 
actually yet *add* subprojects), but quite apart from that low-level 
stuff, anything more high-level (like "git fetch" and friends) will need 
to know about subprojects.

In general, think of this like the early git plumbing: it's the early
"content-addressable filesystem" part. The actual SCM parts going on top 
of it are yet to be done.

I'm hoping/expecting that there are more people who have the ability and 
the interest to work on the higher-level interfaces once the core plumbing 
support is there. There's still some plumbing to be done, but after that, 
maybe more people (and maybe the SoC people) can start filling out the 
higher-level details..

Comments on the patches/approach so far?

 builtin-ls-tree.c |   20 +++++++++++++++++++-
 cache-tree.c      |    2 +-
 read-cache.c      |   35 +++++++++++++++++++++++++++++++----
 sha1_file.c       |    3 +++
 4 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 6472610..1cb4dca 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "blob.h"
 #include "tree.h"
+#include "commit.h"
 #include "quote.h"
 #include "builtin.h"
 
@@ -59,7 +60,24 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 	int retval = 0;
 	const char *type = blob_type;
 
-	if (S_ISDIR(mode)) {
+	if (S_ISDIRLNK(mode)) {
+		/*
+		 * Maybe we want to have some recursive version here?
+		 *
+		 * Something like:
+		 *
+		if (show_subprojects(base, baselen, pathname)) {
+			if (fork()) {
+				chdir(base);
+				exec ls-tree;
+			}
+			waitpid();
+		}
+		 *
+		 * ..or similar..
+		 */
+		type = commit_type;
+	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base, baselen, pathname)) {
 			retval = READ_TREE_RECURSIVE;
 			if (!(ls_options & LS_SHOW_TREES))
diff --git a/cache-tree.c b/cache-tree.c
index 9b73c86..6369cc7 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -326,7 +326,7 @@ static int update_one(struct cache_tree *it,
 			mode = ntohl(ce->ce_mode);
 			entlen = pathlen - baselen;
 		}
-		if (!missing_ok && !has_sha1_file(sha1))
+		if (mode != S_IFDIRLNK && !missing_ok && !has_sha1_file(sha1))
 			return error("invalid object %s", sha1_to_hex(sha1));
 
 		if (!ce->ce_mode)
diff --git a/read-cache.c b/read-cache.c
index 54573ce..8fe94cd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "cache-tree.h"
+#include "refs.h"
 
 /* Index extensions.
  *
@@ -91,6 +92,23 @@ static int ce_compare_link(struct cache_entry *ce, size_t expected_size)
 	return match;
 }
 
+static int ce_compare_gitlink(struct cache_entry *ce)
+{
+	unsigned char sha1[20];
+
+	/*
+	 * We don't actually require that the .git directory
+	 * under DIRLNK directory be a valid git directory. It
+	 * might even be missing (in case nobody populated that
+	 * sub-project).
+	 *
+	 * If so, we consider it always to match.
+	 */
+	if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
+		return 0;
+	return hashcmp(sha1, ce->sha1);
+}
+
 static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 {
 	switch (st->st_mode & S_IFMT) {
@@ -102,6 +120,9 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 		if (ce_compare_link(ce, xsize_t(st->st_size)))
 			return DATA_CHANGED;
 		break;
+	case S_IFDIRLNK:
+		/* No need to do anything, we did the exact compare in "match_stat_basic" */
+		break;
 	default:
 		return TYPE_CHANGED;
 	}
@@ -127,6 +148,12 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 		    (has_symlinks || !S_ISREG(st->st_mode)))
 			changed |= TYPE_CHANGED;
 		break;
+	case S_IFDIRLNK:
+		if (!S_ISDIR(st->st_mode))
+			changed |= TYPE_CHANGED;
+		else if (ce_compare_gitlink(ce))
+			changed |= DATA_CHANGED;
+		break;
 	default:
 		die("internal error: ce_mode is %o", ntohl(ce->ce_mode));
 	}
@@ -250,9 +277,9 @@ int base_name_compare(const char *name1, int len1, int mode1,
 		return cmp;
 	c1 = name1[len];
 	c2 = name2[len];
-	if (!c1 && S_ISDIR(mode1))
+	if (!c1 && (S_ISDIR(mode1) || S_ISDIRLNK(mode1)))
 		c1 = '/';
-	if (!c2 && S_ISDIR(mode2))
+	if (!c2 && (S_ISDIR(mode2) || S_ISDIRLNK(mode1)))
 		c2 = '/';
 	return (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
 }
@@ -334,8 +361,8 @@ int add_file_to_cache(const char *path, int verbose)
 	if (lstat(path, &st))
 		die("%s: unable to stat (%s)", path, strerror(errno));
 
-	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode))
-		die("%s: can only add regular files or symbolic links", path);
+	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode) && !S_ISDIR(st.st_mode))
+		die("%s: can only add regular files, symbolic links or git-directories", path);
 
 	namelen = strlen(path);
 	size = cache_entry_size(namelen);
diff --git a/sha1_file.c b/sha1_file.c
index 4304fe9..ab915fa 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -13,6 +13,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "tree.h"
+#include "refs.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -2332,6 +2333,8 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, int write
 				     path);
 		free(target);
 		break;
+	case S_IFDIR:
+		return resolve_gitlink_ref(path, "HEAD", sha1);
 	default:
 		return error("%s: unsupported file type", path);
 	}
-- 
1.5.1.110.g1e4c
