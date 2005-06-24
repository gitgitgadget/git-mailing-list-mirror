From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Fix oversimplified optimization for add_cache_entry().
Date: Fri, 24 Jun 2005 16:40:22 -0700
Message-ID: <7vvf439vdl.fsf@assigned-by-dhcp.cox.net>
References: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 01:36:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlxi2-0005Yw-0U
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 01:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbVFXXlt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 19:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbVFXXlt
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 19:41:49 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:52222 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S263133AbVFXXkY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2005 19:40:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050624234024.BAI8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Jun 2005 19:40:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 23 Jun 2005 16:20:36 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

An earlier change to optimize directory-file conflict check
broke what "read-tree --emu23" expects.  Introduce an explicit
flag to tell add_cache_entry() not to check for conflicts and
use it when reading an existing tree into an empty stage ---
by definition this case can never introduce such conflicts.

Resurrect the unoptimized directory-file conflict check code for
now as well.  The new one did not handle higher stages properly.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cache.h                           |    1 
 read-cache.c                      |  177 +++++++++++++++++++------------------
 t/t1005-read-tree-m-2way-emu23.sh |    6 +
 tree.c                            |    2 
 4 files changed, 95 insertions(+), 91 deletions(-)

cb13405368b0132ec3b3edcda22d32d89e9c1f85
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -130,6 +130,7 @@ extern int write_cache(int newfd, struct
 extern int cache_name_pos(const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
+#define ADD_CACHE_SKIP_DF_CHECK 4	/* Ok to skip directory/file conflict checks */
 extern int add_cache_entry(struct cache_entry *ce, int option);
 extern int remove_cache_entry_at(int pos);
 extern int remove_file_from_cache(char *path);
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -171,83 +171,6 @@ int ce_same_name(struct cache_entry *a, 
 	return ce_namelen(b) == len && !memcmp(a->name, b->name, len);
 }
 
-/*
- * Do we have another file that has the beginning components being a
- * proper superset of the name we're trying to add?
- */
-static int has_file_name(const struct cache_entry *ce, int pos, int ok_to_replace)
-{
-	int retval = 0;
-	int len = ce_namelen(ce);
-	const char *name = ce->name;
-
-	while (pos < active_nr) {
-		struct cache_entry *p = active_cache[pos++];
-
-		if (len >= ce_namelen(p))
-			break;
-		if (memcmp(name, p->name, len))
-			break;
-		if (p->name[len] != '/')
-			continue;
-		retval = -1;
-		if (!ok_to_replace)
-			break;
-		remove_cache_entry_at(--pos);
-	}
-	return retval;
-}
-
-/*
- * Do we have another file with a pathname that is a proper
- * subset of the name we're trying to add?
- */
-static int has_dir_name(const struct cache_entry *ce, int pos, int ok_to_replace)
-{
-	int retval = 0;
-	const char *name = ce->name;
-	const char *slash = name + ce_namelen(ce);
-
-	for (;;) {
-		int len;
-
-		for (;;) {
-			if (*--slash == '/')
-				break;
-			if (slash <= ce->name)
-				return retval;
-		}
-		len = slash - name;
-
-		pos = cache_name_pos(name, len);
-		if (pos >= 0) {
-			retval = -1;
-			if (ok_to_replace)
-				break;
-			remove_cache_entry_at(pos);
-			continue;
-		}
-
-		/*
-		 * Trivial optimization: if we find an entry that
-		 * already matches the sub-directory, then we know
-		 * we're ok, and we can exit
-		 */
-		pos = -pos-1;
-		if (pos < active_nr) {
-			struct cache_entry *p = active_cache[pos];
-			if (ce_namelen(p) <= len)
-				continue;
-			if (p->name[len] != '/')
-				continue;
-			if (memcmp(p->name, name, len))
-				continue;
-			break;
-		}
-	}
-	return retval;
-}
-
 /* We may be in a situation where we already have path/file and path
  * is being added, or we already have path and path/file is being
  * added.  Either one would result in a nonsense tree that has path
@@ -257,19 +180,98 @@ static int has_dir_name(const struct cac
  * from the cache so the caller should recompute the insert position.
  * When this happens, we return non-zero.
  */
-static int check_file_directory_conflict(const struct cache_entry *ce, int pos, int ok_to_replace)
+static int check_file_directory_conflict(const struct cache_entry *ce,
+					 int ok_to_replace)
 {
+	int pos, replaced = 0;
+	const char *path = ce->name;
+	int namelen = strlen(path);
+	int stage = ce_stage(ce);
+	char *pathbuf = xmalloc(namelen + 1);
+	char *cp;
+
+	memcpy(pathbuf, path, namelen + 1);
+
 	/*
-	 * We check if the path is a sub-path of a subsequent pathname
-	 * first, since removing those will not change the position
-	 * in the array
+	 * We are inserting path/file.  Do they have path registered at
+	 * the same stage?  We need to do this for all the levels of our
+	 * subpath.
 	 */
-	int retval = has_file_name(ce, pos, ok_to_replace);
-	/*
-	 * Then check if the path might have a clashing sub-directory
-	 * before it.
+	cp = pathbuf;
+	while (1) {
+		char *ep = strchr(cp, '/');
+		int len;
+		if (!ep)
+			break;
+		*ep = 0;    /* first cut it at slash */
+		len = ep - pathbuf;
+		pos = cache_name_pos(pathbuf,
+				     ntohs(create_ce_flags(len, stage)));
+		if (0 <= pos) {
+			/* Our leading path component is registered as a file,
+			 * and we are trying to make it a directory.  This is
+			 * bad.
+			 */
+			if (!ok_to_replace) {
+				free(pathbuf);
+				return -1;
+			}
+			fprintf(stderr, "removing file '%s' to replace it with a directory to create '%s'.\n", pathbuf, path);
+			remove_cache_entry_at(pos);
+			replaced = 1;
+		}
+		*ep = '/';  /* then restore it and go downwards */
+		cp = ep + 1;
+	}
+	free(pathbuf);
+
+	/* Do we have an entry in the cache that makes our path a prefix
+	 * of it?  That is, are we creating a file where they already expect
+	 * a directory there?
+	 */
+	pos = cache_name_pos(path,
+			     ntohs(create_ce_flags(namelen, stage)));
+
+	/* (0 <= pos) cannot happen because add_cache_entry()
+	 * should have taken care of that case.
+	 */
+	pos = -pos-1;
+
+	/* pos would point at an existing entry that would come immediately
+	 * after our path.  It could be the same as our path in higher stage,
+	 * or different path but in a lower stage.
+	 *
+	 * E.g. when we are inserting path at stage 2,
+	 *
+	 *        1 path
+	 * pos->  3 path
+	 *        2 path/file1
+	 *        3 path/file1
+	 *        2 path/file2
+	 *        2 patho
+	 *
+	 * We need to examine pos, ignore it because it is at different
+	 * stage, examine next to find the path/file at stage 2, and
+	 * complain.  We need to do this until we are not the leading
+	 * path of an existing entry anymore.
 	 */
-	return retval + has_dir_name(ce, pos, ok_to_replace);
+
+	while (pos < active_nr) {
+		struct cache_entry *other = active_cache[pos];
+		if (strncmp(other->name, path, namelen))
+			break; /* it is not our "subdirectory" anymore */
+		if ((ce_stage(other) == stage) &&
+		    other->name[namelen] == '/') {
+			if (!ok_to_replace)
+				return -1;
+			fprintf(stderr, "removing file '%s' under '%s' to be replaced with a file\n", other->name, path);
+			remove_cache_entry_at(pos);
+			replaced = 1;
+			continue; /* cycle without updating pos */
+		}
+		pos++;
+	}
+	return replaced;
 }
 
 int add_cache_entry(struct cache_entry *ce, int option)
@@ -277,6 +279,7 @@ int add_cache_entry(struct cache_entry *
 	int pos;
 	int ok_to_add = option & ADD_CACHE_OK_TO_ADD;
 	int ok_to_replace = option & ADD_CACHE_OK_TO_REPLACE;
+	int skip_df_check = option & ADD_CACHE_SKIP_DF_CHECK;
 	pos = cache_name_pos(ce->name, ntohs(ce->ce_flags));
 
 	/* existing match? Just replace it */
@@ -302,7 +305,7 @@ int add_cache_entry(struct cache_entry *
 	if (!ok_to_add)
 		return -1;
 
-	if (!ce_stage(ce) && check_file_directory_conflict(ce, pos, ok_to_replace)) {
+	if (!skip_df_check && check_file_directory_conflict(ce, ok_to_replace)) {
 		if (!ok_to_replace)
 			return -1;
 		pos = cache_name_pos(ce->name, ntohs(ce->ce_flags));
diff --git a/t/t1005-read-tree-m-2way-emu23.sh b/t/t1005-read-tree-m-2way-emu23.sh
--- a/t/t1005-read-tree-m-2way-emu23.sh
+++ b/t/t1005-read-tree-m-2way-emu23.sh
@@ -389,7 +389,7 @@ test_expect_success \
      :'
 
 # Emu23 can grok I having more than H.  Make sure we did not
-# botch the conflict tests (Linus code botches this test).
+# botch the conflict tests (fixed).
 test_expect_success \
     'DF vs DF/DF case test (#2).' \
     'rm -f .git/index &&
@@ -400,8 +400,8 @@ test_expect_success \
      # This should fail because I and H have a conflict
      # at DF.
      if git-read-tree --emu23 $treeDF $treeDFDF
-     then true  ;# should be false
-     else false ;# should be true
+     then false
+     else true
      fi'
 
 test_done
diff --git a/tree.c b/tree.c
--- a/tree.c
+++ b/tree.c
@@ -18,7 +18,7 @@ static int read_one_entry(unsigned char 
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
 	memcpy(ce->sha1, sha1, 20);
-	return add_cache_entry(ce, ADD_CACHE_OK_TO_ADD);
+	return add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DF_CHECK);
 }
 
 static int read_tree_recursive(void *buffer, unsigned long size,
------------

