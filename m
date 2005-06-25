From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 7/9] Fix oversimplified optimization for add_cache_entry().
Date: Sat, 25 Jun 2005 02:25:29 -0700
Message-ID: <7vfyv63i0m.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net>
	<7vvf439vdl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506241755280.11175@ppc970.osdl.org>
	<7vaclf6tw7.fsf@assigned-by-dhcp.cox.net>
	<7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 11:21:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm6qb-0002Jv-3E
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 11:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263379AbVFYJ1k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 05:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbVFYJ1k
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 05:27:40 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:48327 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S263379AbVFYJZb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2005 05:25:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050625092530.RIGP7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Jun 2005 05:25:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 25 Jun 2005 02:16:23 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

An earlier change to optimize directory-file conflict check
broke what "read-tree --emu23" expects.  This is fixed by this
commit.

(1) Introduces an explicit flag to tell add_cache_entry() not to
    check for conflicts and use it when reading an existing tree
    into an empty stage --- by definition this case can never
    introduce such conflicts.

(2) Makes read-cache.c:has_file_name() and read-cache.c:has_dir_name()
    aware of the cache stages, and flag conflict only with paths
    in the same stage.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cache.h                           |    1 +
 read-cache.c                      |   32 +++++++++++++++++++++-----------
 t/t1005-read-tree-m-2way-emu23.sh |   25 ++++++++++++++++++++-----
 tree.c                            |    2 +-
 4 files changed, 43 insertions(+), 17 deletions(-)

904dbb145f2f42227ea5b94752146ef8d4c2b153
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -130,6 +130,7 @@ extern int write_cache(int newfd, struct
 extern int cache_name_pos(const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
+#define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
 extern int add_cache_entry(struct cache_entry *ce, int option);
 extern int remove_cache_entry_at(int pos);
 extern int remove_file_from_cache(char *path);
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -179,6 +179,7 @@ static int has_file_name(const struct ca
 {
 	int retval = 0;
 	int len = ce_namelen(ce);
+	int stage = ce_stage(ce);
 	const char *name = ce->name;
 
 	while (pos < active_nr) {
@@ -188,6 +189,8 @@ static int has_file_name(const struct ca
 			break;
 		if (memcmp(name, p->name, len))
 			break;
+		if (ce_stage(p) != stage)
+			continue;
 		if (p->name[len] != '/')
 			continue;
 		retval = -1;
@@ -205,6 +208,7 @@ static int has_file_name(const struct ca
 static int has_dir_name(const struct cache_entry *ce, int pos, int ok_to_replace)
 {
 	int retval = 0;
+	int stage = ce_stage(ce);
 	const char *name = ce->name;
 	const char *slash = name + ce_namelen(ce);
 
@@ -219,7 +223,7 @@ static int has_dir_name(const struct cac
 		}
 		len = slash - name;
 
-		pos = cache_name_pos(name, len);
+		pos = cache_name_pos(name, ntohs(create_ce_flags(len, stage)));
 		if (pos >= 0) {
 			retval = -1;
 			if (ok_to_replace)
@@ -231,18 +235,23 @@ static int has_dir_name(const struct cac
 		/*
 		 * Trivial optimization: if we find an entry that
 		 * already matches the sub-directory, then we know
-		 * we're ok, and we can exit
+		 * we're ok, and we can exit.
 		 */
 		pos = -pos-1;
-		if (pos < active_nr) {
+		while (pos < active_nr) {
 			struct cache_entry *p = active_cache[pos];
-			if (ce_namelen(p) <= len)
-				continue;
-			if (p->name[len] != '/')
-				continue;
-			if (memcmp(p->name, name, len))
-				continue;
-			break;
+			if ((ce_namelen(p) <= len) ||
+			    (p->name[len] != '/') ||
+			    memcmp(p->name, name, len))
+				break; /* not our subdirectory */
+			if (ce_stage(p) == stage)
+				/* p is at the same stage as our entry, and
+				 * is a subdirectory of what we are looking
+				 * at, so we cannot have conflicts at our
+				 * level or anything shorter.
+				 */
+				return retval;
+			pos++;
 		}
 	}
 	return retval;
@@ -277,6 +286,7 @@ int add_cache_entry(struct cache_entry *
 	int pos;
 	int ok_to_add = option & ADD_CACHE_OK_TO_ADD;
 	int ok_to_replace = option & ADD_CACHE_OK_TO_REPLACE;
+	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
 	pos = cache_name_pos(ce->name, ntohs(ce->ce_flags));
 
 	/* existing match? Just replace it */
@@ -302,7 +312,7 @@ int add_cache_entry(struct cache_entry *
 	if (!ok_to_add)
 		return -1;
 
-	if (!ce_stage(ce) && check_file_directory_conflict(ce, pos, ok_to_replace)) {
+	if (!skip_df_check && check_file_directory_conflict(ce, pos, ok_to_replace)) {
 		if (!ok_to_replace)
 			return -1;
 		pos = cache_name_pos(ce->name, ntohs(ce->ce_flags));
diff --git a/t/t1005-read-tree-m-2way-emu23.sh b/t/t1005-read-tree-m-2way-emu23.sh
--- a/t/t1005-read-tree-m-2way-emu23.sh
+++ b/t/t1005-read-tree-m-2way-emu23.sh
@@ -366,6 +366,7 @@ test_expect_success \
      treeDF=`git-write-tree` &&
      echo treeDF $treeDF &&
      git-ls-tree $treeDF &&
+     git-ls-files --stage >DF.out
 
      rm -f DF &&
      mkdir DF &&
@@ -377,7 +378,7 @@ test_expect_success \
      git-ls-files --stage >DFDF.out'
 
 test_expect_success \
-    'DF vs DF/DF case test.' \
+    'DF vs DF/DF case test (#1)' \
     'rm -f .git/index &&
      rm -fr DF &&
      echo DF >DF &&
@@ -388,10 +389,24 @@ test_expect_success \
      check_cache_at DF/DF clean && # different from pure 2-way
      :'
 
+# The other way around
+test_expect_success \
+    'DF vs DF/DF case test (#2)' \
+    'rm -f .git/index &&
+     rm -fr DF &&
+     mkdir DF &&
+     echo DF/DF >DF/DF &&
+     git-update-cache --add DF/DF &&
+     read_tree_twoway $treeDFDF $treeDF &&
+     git-ls-files --stage >DFDFcheck.out &&
+     diff -u DF.out DFDFcheck.out &&
+     check_cache_at DF clean && # different from pure 2-way
+     :'
+
 # Emu23 can grok I having more than H.  Make sure we did not
-# botch the conflict tests (Linus code botches this test).
+# botch the conflict tests (fixed).
 test_expect_success \
-    'DF vs DF/DF case test (#2).' \
+    'DF vs DF/DF case test (#3).' \
     'rm -f .git/index &&
      rm -fr DF &&
      mkdir DF &&
@@ -400,8 +415,8 @@ test_expect_success \
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
+	return add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
 }
 
 static int read_tree_recursive(void *buffer, unsigned long size,
------------

