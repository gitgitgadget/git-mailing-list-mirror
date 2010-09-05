From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 07/15] cache_tree_update(): Capability to handle tree entries missing from index
Date: Sat,  4 Sep 2010 18:13:59 -0600
Message-ID: <1283645647-1891-8-git-send-email-newren@gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:13:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2rf-0008IQ-Sk
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568Ab0IEANP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 20:13:15 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65512 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab0IEANJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:13:09 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so647396pwi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Pd+LyGsabHdB+rDXuAin232tPiMzbrHr5eMJ8GLUnvs=;
        b=go+ZTRCgH7x5Xw/TYo/NE/JXVGRgFkHgRlwVbfRAR0KJYHIHRM5UkliFI5fNmThFFW
         JUSnju1RKxRn5ulK6zDvbGJApq/IYrpPmaJb/VX8K/PXDQLiHVOnTlLm5LL3lJtrwgj0
         tnQjizu4ZFQY8vWNrnUS6kUC4RDtIrjIEKWw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fQSriR4DcW/q0SsIuU69Vwu7m933RwbU2u1+PTbVcnEszT0COdvesZHWY32rmmD7jR
         1g7vsOTiHo0RP6MyfQU0hccoRgf84hiyTMR7rjunZZgWo/zVHOOvTbVdZDMl514IQKyn
         bK5+qW/r9hcxqU1Hyo11hwSNpOTYDgByjnwn8=
Received: by 10.114.124.18 with SMTP id w18mr896879wac.228.1283645588852;
        Sat, 04 Sep 2010 17:13:08 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.13.06
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:13:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
In-Reply-To: <1283645647-1891-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155393>

cache_tree_update() will write trees using the index.  With sparse clones,
the index will only contain entries matching the sparse limits, meaning
that the index does not provide enough information to write complete tree
objects.  Having cache_tree_update() take a tree (typically HEAD), will
allow new complete trees to be constructed by using entries from the
specified tree outside the sparse limits together with the index.

Of course, in the non-sparse clone case, cache_tree_update() needs no tree
to be provided since the index contains all relevant information.  So
providing NULL as the tree is supported as another way of getting the
traditional behavior.

This patch only provides the new capability without invoking it; subsequent
patches will update callers of cache_tree_update() to provide a relevant
tree.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache-tree.c |   88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 87 insertions(+), 1 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index c60cf91..2ba6a76 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -2,6 +2,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
+#include "diff.h"  /* FIXME: for tree_entry_interesting; maybe it should be in tree-walk.h? */
 
 #ifndef DEBUG
 #define DEBUG 0
@@ -232,15 +233,91 @@ int cache_tree_fully_valid(struct cache_tree *it)
 	return 1;
 }
 
+static void setup_tree_desc(struct tree_desc *desc, struct tree* tree)
+{
+	if (git_sparse_pathspecs && tree)
+		init_tree_desc(desc, tree->buffer, tree->size);
+	else
+		init_tree_desc(desc, NULL, 0);
+}
+
+static struct tree* find_non_sparse_subtree(struct tree_desc *desc,
+					    const char *path,
+					    int pathlen)
+{
+	struct name_entry entry;
+
+	if (!git_sparse_pathspecs)
+		return NULL; /* No tree needed or useful */
+
+	while (tree_entry(desc, &entry))
+		  if (!memcmp(entry.path, path, pathlen) &&
+		      strlen(entry.path) == pathlen) {
+			struct tree *subtree = lookup_tree(entry.sha1);
+			if (parse_tree(subtree) < 0)
+				die("bad tree %s", sha1_to_hex(entry.sha1));
+			return subtree;
+		  }
+	return NULL;
+}
+
+static void add_missing_paths_before(const char *path,
+				     int pathlen,
+				     int baselen,
+				     struct tree_desc *desc,
+				     struct strbuf *buffer)
+{
+	if (!git_sparse_pathspecs)
+		return; /* No paths are missing */
+
+	for (; desc->size; update_tree_entry(desc)) {
+		struct name_entry entry = desc->entry;
+		int entlen = strlen(entry.path);
+
+		/* We only want paths before path */
+		if (path)
+			/*
+			 * FIXME: if entlen < pathlen, do I need to
+			 * use strncmp instead? Does entry.path being
+			 * NUL-terminated ensure memcmp exits
+			 * early?
+			 */
+			if (memcmp(entry.path,
+				   path+baselen,
+				   pathlen-baselen) >= 0)
+				break;
+
+		/* We only want paths "missing" from index due to sparsity */
+		if (path) {
+			int show = tree_entry_interesting(desc,
+							  path,
+							  baselen,
+							  &git_sparse_diffopts);
+			if (show == 2) {
+				desc->size = 0;
+				break;
+			}
+			else if (show > 0)
+				continue;
+		}
+
+		strbuf_grow(buffer, entlen + 100);
+		strbuf_addf(buffer, "%o %.*s%c", entry.mode, entlen, entry.path, '\0');
+		strbuf_add(buffer, entry.sha1, 20);
+	}
+}
+
 static int update_one(struct cache_tree *it,
 		      struct cache_entry **cache,
 		      int entries,
+		      struct tree *non_sparse_tree,
 		      const char *base,
 		      int baselen,
 		      int missing_ok,
 		      int dryrun)
 {
 	struct strbuf buffer;
+	struct tree_desc desc;
 	int i;
 
 	if (0 <= it->entry_count && has_sha1_file(it->sha1))
@@ -257,9 +334,11 @@ static int update_one(struct cache_tree *it,
 	/*
 	 * Find the subtrees and update them.
 	 */
+	setup_tree_desc(&desc, non_sparse_tree);
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
 		struct cache_tree_sub *sub;
+		struct tree *subtree;
 		const char *path, *slash;
 		int pathlen, sublen, subcnt;
 
@@ -280,8 +359,10 @@ static int update_one(struct cache_tree *it,
 		sub = find_subtree(it, path + baselen, sublen, 1);
 		if (!sub->cache_tree)
 			sub->cache_tree = cache_tree();
+		subtree = find_non_sparse_subtree(&desc, path+baselen, sublen);
 		subcnt = update_one(sub->cache_tree,
 				    cache + i, entries - i,
+				    subtree,
 				    path,
 				    baselen + sublen + 1,
 				    missing_ok,
@@ -298,6 +379,7 @@ static int update_one(struct cache_tree *it,
 	 * Then write out the tree object for this level.
 	 */
 	strbuf_init(&buffer, 8192);
+	setup_tree_desc(&desc, non_sparse_tree);
 
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
@@ -309,6 +391,8 @@ static int update_one(struct cache_tree *it,
 
 		path = ce->name;
 		pathlen = ce_namelen(ce);
+		add_missing_paths_before(path, pathlen, baselen,
+					 &desc, &buffer);
 		if (pathlen <= baselen || memcmp(base, path, baselen))
 			break; /* at the end of this level */
 
@@ -346,6 +430,7 @@ static int update_one(struct cache_tree *it,
 			mode, entlen, path + baselen);
 #endif
 	}
+	add_missing_paths_before(NULL, 0, 0, &desc, &buffer);
 
 	if (dryrun)
 		hash_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1);
@@ -374,7 +459,8 @@ int cache_tree_update(struct cache_tree *it,
 	i = verify_cache(cache, entries);
 	if (i)
 		return i;
-	i = update_one(it, cache, entries, "", 0, missing_ok, dryrun);
+
+	i = update_one(it, cache, entries, NULL, "", 0, missing_ok, dryrun);
 	if (i < 0)
 		return i;
 	return 0;
-- 
1.7.2.2.140.gd06af
