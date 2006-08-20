From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] git-rev-size: calculate sizes of repository
Date: Sun, 20 Aug 2006 18:09:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608201805070.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060820105452.GA19630@nospam.com>
 <Pine.LNX.4.63.0608201519360.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060820152404.GA5679@nospam.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 18:09:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEprp-0005aW-4H
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 18:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWHTQJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 12:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWHTQJh
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 12:09:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:49845 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750834AbWHTQJg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Aug 2006 12:09:36 -0400
Received: (qmail invoked by alias); 20 Aug 2006 16:09:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 20 Aug 2006 18:09:35 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Rutger Nijlunsing <git@wingding.demon.nl>
In-Reply-To: <20060820152404.GA5679@nospam.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25755>

Hi,

On Sun, 20 Aug 2006, Rutger Nijlunsing wrote:

> On Sun, Aug 20, 2006 at 03:20:19PM +0200, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Sun, 20 Aug 2006, Rutger Nijlunsing wrote:
> > 
> > > You can also find it on http://www.wingding.demon.nl/git-rev-size.rb
> > 
> > Ruby is _so_ mainstream. Could I have a Haskell version, pretty please?
> 
> I _knew_ it... Please go bug someone else. The only thing I did was
> help someone, and for that I choose my own tools since I do it for
> fun.

Fair enough.

-- 8< --
[PATCH] Add git-rev-size

This tool spits out the number of trees, the number of blobs, and the total
bytes of the blobs for a given rev range.

Most notably, it adds an object hash map structure to the library.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Makefile           |    4 ++
 builtin-rev-size.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h          |    1 +
 git.c              |    1 +
 hash.c             |   50 ++++++++++++++++++++++++++++
 hash.h             |   12 +++++++
 6 files changed, 159 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index a86f289..06c8dd9 100644
--- a/Makefile
+++ b/Makefile
@@ -264,7 +264,8 @@ LIB_OBJS = \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
-	alloc.o merge-file.o path-list.o unpack-trees.o help.o $(DIFF_OBJS)
+	alloc.o merge-file.o path-list.o unpack-trees.o help.o \
+	hash.o $(DIFF_OBJS)
 
 BUILTIN_OBJS = \
 	builtin-add.o \
@@ -297,6 +298,7 @@ BUILTIN_OBJS = \
 	builtin-repo-config.o \
 	builtin-rev-list.o \
 	builtin-rev-parse.o \
+	builtin-rev-size.o \
 	builtin-rm.o \
 	builtin-show-branch.o \
 	builtin-stripspace.o \
diff --git a/builtin-rev-size.c b/builtin-rev-size.c
new file mode 100644
index 0000000..ad88e48
--- /dev/null
+++ b/builtin-rev-size.c
@@ -0,0 +1,92 @@
+/*
+ * "git rev-size" builtin command
+ *
+ * Copyright (C) 2006 Johannes Schindelin
+ */
+
+#include "cache.h"
+#include "builtin.h"
+#include "object.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+#include "hash.h"
+
+static const char builtin_rev_size_usage[] =
+"git-rev-size <commit-id>...";
+
+struct rev_size {
+	struct object object;
+	size_t trees, blobs, bytes;
+};
+
+struct hash_map rev_size_hash = { 0, 0, NULL };
+
+static struct rev_size *get_rev_size(const char *sha1)
+{
+	struct rev_size *rev_size =
+		(struct rev_size *)hash_get(&rev_size_hash, sha1);
+
+	if (rev_size == NULL) {
+		char type[64];
+		unsigned long size;
+
+		rev_size = xcalloc(1, sizeof(struct rev_size));
+
+		if (sha1_object_info(sha1, type, &size))
+			die("Cannot get info for %s", sha1_to_hex(sha1));
+
+		if (!strcmp(type, "blob")) {
+			rev_size->blobs = 1;
+			rev_size->bytes = size;
+		} else if (!strcmp(type, "tree")) {
+			struct tree *tree = (struct tree *)parse_object(sha1);
+			struct tree_desc desc;
+			struct name_entry entry;
+
+			desc.buf = tree->buffer;
+			desc.size = tree->size;
+
+			while (tree_entry(&desc, &entry)) {
+				struct rev_size *r = get_rev_size(entry.sha1);
+
+				rev_size->trees += r->trees;
+				rev_size->blobs += r->blobs;
+				rev_size->bytes += r->bytes;
+			}
+
+			rev_size->trees++;
+		} else
+			die("Cannot calculate size for type %s", type);
+
+		memcpy(rev_size->object.sha1, sha1, 20);
+		hash_put(&rev_size_hash, &rev_size->object);
+	}
+
+	return rev_size;
+}
+
+int cmd_rev_size(int argc, const char **argv, const char *prefix)
+{
+	struct rev_info revs;
+	struct commit *commit;
+
+	init_revisions(&revs, prefix);
+	revs.abbrev = 0;
+	revs.commit_format = CMIT_FMT_UNSPECIFIED;
+	argc = setup_revisions(argc, argv, &revs, NULL);
+
+	prepare_revision_walk(&revs);
+
+	while ((commit = get_revision(&revs))) {
+		struct rev_size *rev_size =
+			get_rev_size(commit->tree->object.sha1);
+
+		printf("%s %d %d %d\n", sha1_to_hex(commit->object.sha1),
+				rev_size->trees, rev_size->blobs, rev_size->bytes);
+	}
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index ade58c4..9848a5e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -46,6 +46,7 @@ extern int cmd_read_tree(int argc, const
 extern int cmd_repo_config(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
+extern int cmd_rev_size(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index bf0fe0e..4cfa6cf 100644
--- a/git.c
+++ b/git.c
@@ -262,6 +262,7 @@ static void handle_internal_command(int 
 		{ "repo-config", cmd_repo_config },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
+		{ "rev-size", cmd_rev_size, RUN_SETUP },
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
diff --git a/hash.c b/hash.c
new file mode 100644
index 0000000..12d1e65
--- /dev/null
+++ b/hash.c
@@ -0,0 +1,50 @@
+#include "cache.h"
+#include "object.h"
+#include "hash.h"
+
+static unsigned int hash_index(struct hash_map *hash, const char *sha1)
+{
+	unsigned int index = *(unsigned int *)sha1;
+	while (1) {
+		if (index >= hash->alloc)
+			index = index % hash->alloc;
+		if (hash->map[index] == NULL ||
+				!hashcmp(sha1, hash->map[index]->sha1))
+			return index;
+		index++;
+	}
+}
+
+static void grow_hash(struct hash_map *hash)
+{
+	int i;
+	int old_alloc = hash->alloc;
+	struct object **old_map = hash->map;
+
+	hash->alloc = hash->alloc < 32 ? 32 : 2 * hash->alloc;
+	hash->map = xcalloc(hash->alloc, sizeof(struct object *));
+	hash->nr = 0;
+
+	for (i = 0; i < old_alloc; i++) {
+		struct object *obj = old_map[i];
+		if (!obj)
+			continue;
+		hash_put(hash, obj);
+	}
+	free(old_map);
+}
+
+void hash_put(struct hash_map *hash, struct object *obj)
+{
+	if (++hash->nr > hash->alloc / 2)
+		grow_hash(hash);
+
+	hash->map[hash_index(hash, obj->sha1)] = obj;
+}
+
+struct object *hash_get(struct hash_map *hash, const char *sha1)
+{
+	if (hash->alloc == 0)
+		return NULL;
+	return hash->map[hash_index(hash, sha1)];
+}
diff --git a/hash.h b/hash.h
new file mode 100644
index 0000000..0e2b67c
--- /dev/null
+++ b/hash.h
@@ -0,0 +1,12 @@
+#ifndef HASH_H
+#define HASH_H
+
+struct hash_map {
+	unsigned long nr, alloc;
+	struct object **map;
+};
+
+extern struct object *hash_get(struct hash_map *hash, const char *sha1);
+extern void hash_put(struct hash_map *hash, struct object *obj);
+
+#endif
-- 
1.4.2.ga5e8f-dirty
