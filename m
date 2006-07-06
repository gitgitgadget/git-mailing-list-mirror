From: Linus Torvalds <torvalds@osdl.org>
Subject: More fully-fleshed-out builtin "git prune"
Date: Thu, 6 Jul 2006 10:16:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607061009440.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jul 06 19:17:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyXT2-0000OJ-KI
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 19:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWGFRQb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 13:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWGFRQb
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 13:16:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49070 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932420AbWGFRQa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 13:16:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k66HGOnW016752
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 6 Jul 2006 10:16:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k66HGME3002178;
	Thu, 6 Jul 2006 10:16:23 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-5.84 required=5 tests=HTML_MESSAGE,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.84__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23397>


This actually removes the objects to be pruned, unless you specify "-n" 
(at which point it will just tell you which files it would prune).

This doesn't do the pack-file pruning that the shell-script used to do, 
but if somebody really wants to, they could add it easily enough. I wonder 
how useful it is, though, considering that "git repack -a -d" is just a 
lot more efficient and generates a better end result.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

I've tested this somewhat, including the "object only reachable through 
the index" case, and used it to do a few real prunes. It's a lot faster 
(because it only does the trivial reachability part), and it all _seems_ 
fine and the code is fairly obvious and certainly simple enough. 

That said, this is "git prune". Getting things wrong here would be bad. 
People should double- and triple-check this.

 Makefile        |    4 -
 builtin-prune.c |  259 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h       |    2 
 git-prune.sh    |   44 ---------
 git.c           |    3 -
 5 files changed, 265 insertions(+), 47 deletions(-)

diff --git a/Makefile b/Makefile
index 7fa4a27..d355622 100644
--- a/Makefile
+++ b/Makefile
@@ -120,7 +120,7 @@ SCRIPT_SH = \
 	git-fetch.sh \
 	git-ls-remote.sh \
 	git-merge-one-file.sh git-parse-remote.sh \
-	git-prune.sh git-pull.sh git-rebase.sh \
+	git-pull.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
 	git-resolve.sh git-revert.sh git-sh-setup.sh \
 	git-tag.sh git-verify-tag.sh \
@@ -230,7 +230,7 @@ BUILTIN_OBJS = \
 	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
 	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
 	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
-	builtin-update-ref.o builtin-fmt-merge-msg.o
+	builtin-update-ref.o builtin-fmt-merge-msg.o builtin-prune.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-prune.c b/builtin-prune.c
new file mode 100644
index 0000000..fc55b76
--- /dev/null
+++ b/builtin-prune.c
@@ -0,0 +1,259 @@
+#include "cache.h"
+#include "refs.h"
+#include "tag.h"
+#include "commit.h"
+#include "tree.h"
+#include "blob.h"
+#include "tree-walk.h"
+#include "diff.h"
+#include "revision.h"
+#include "builtin.h"
+#include "cache-tree.h"
+
+static const char prune_usage[] = "git prune [-n]";
+static int show_only = 0;
+static struct rev_info revs;
+
+static int prune_object(char *path, const char *filename, const unsigned char *sha1)
+{
+	if (show_only) {
+		printf("would prune %s/%s\n", path, filename);
+		return 0;
+	}
+	unlink(mkpath("%s/%s", path, filename));
+	rmdir(path);
+	return 0;
+}
+
+static int prune_dir(int i, char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *de;
+
+	if (!dir)
+		return 0;
+
+	while ((de = readdir(dir)) != NULL) {
+		char name[100];
+		unsigned char sha1[20];
+		int len = strlen(de->d_name);
+
+		switch (len) {
+		case 2:
+			if (de->d_name[1] != '.')
+				break;
+		case 1:
+			if (de->d_name[0] != '.')
+				break;
+			continue;
+		case 38:
+			sprintf(name, "%02x", i);
+			memcpy(name+2, de->d_name, len+1);
+			if (get_sha1_hex(name, sha1) < 0)
+				break;
+
+			/*
+			 * Do we know about this object?
+			 * It must have been reachable
+			 */
+			if (lookup_object(sha1))
+				continue;
+
+			prune_object(path, de->d_name, sha1);
+			continue;
+		}
+		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
+	}
+	closedir(dir);
+	return 0;
+}
+
+static void prune_object_dir(const char *path)
+{
+	int i;
+	for (i = 0; i < 256; i++) {
+		static char dir[4096];
+		sprintf(dir, "%s/%02x", path, i);
+		prune_dir(i, dir);
+	}
+}
+
+static void process_blob(struct blob *blob,
+			 struct object_array *p,
+			 struct name_path *path,
+			 const char *name)
+{
+	struct object *obj = &blob->object;
+
+	if (obj->flags & SEEN)
+		return;
+	obj->flags |= SEEN;
+	/* Nothing to do, really .. The blob lookup was the important part */
+}
+
+static void process_tree(struct tree *tree,
+			 struct object_array *p,
+			 struct name_path *path,
+			 const char *name)
+{
+	struct object *obj = &tree->object;
+	struct tree_desc desc;
+	struct name_entry entry;
+	struct name_path me;
+
+	if (obj->flags & SEEN)
+		return;
+	obj->flags |= SEEN;
+	if (parse_tree(tree) < 0)
+		die("bad tree object %s", sha1_to_hex(obj->sha1));
+	name = strdup(name);
+	add_object(obj, p, path, name);
+	me.up = path;
+	me.elem = name;
+	me.elem_len = strlen(name);
+
+	desc.buf = tree->buffer;
+	desc.size = tree->size;
+
+	while (tree_entry(&desc, &entry)) {
+		if (S_ISDIR(entry.mode))
+			process_tree(lookup_tree(entry.sha1), p, &me, entry.path);
+		else
+			process_blob(lookup_blob(entry.sha1), p, &me, entry.path);
+	}
+	free(tree->buffer);
+	tree->buffer = NULL;
+}
+
+static void process_tag(struct tag *tag, struct object_array *p, const char *name)
+{
+	struct object *obj = &tag->object;
+	struct name_path me;
+
+	if (obj->flags & SEEN)
+		return;
+	obj->flags |= SEEN;
+
+	me.up = NULL;
+	me.elem = "tag:/";
+	me.elem_len = 5;
+
+	if (parse_tag(tag) < 0)
+		die("bad tag object %s", sha1_to_hex(obj->sha1));
+	add_object(tag->tagged, p, NULL, name);
+}
+
+static void walk_commit_list(struct rev_info *revs)
+{
+	int i;
+	struct commit *commit;
+	struct object_array objects = { 0, 0, NULL };
+
+	/* Walk all commits, process their trees */
+	while ((commit = get_revision(revs)) != NULL)
+		process_tree(commit->tree, &objects, NULL, "");
+
+	/* Then walk all the pending objects, recursively processing them too */
+	for (i = 0; i < revs->pending.nr; i++) {
+		struct object_array_entry *pending = revs->pending.objects + i;
+		struct object *obj = pending->item;
+		const char *name = pending->name;
+		if (obj->type == TYPE_TAG) {
+			process_tag((struct tag *) obj, &objects, name);
+			continue;
+		}
+		if (obj->type == TYPE_TREE) {
+			process_tree((struct tree *)obj, &objects, NULL, name);
+			continue;
+		}
+		if (obj->type == TYPE_BLOB) {
+			process_blob((struct blob *)obj, &objects, NULL, name);
+			continue;
+		}
+		die("unknown pending object %s (%s)", sha1_to_hex(obj->sha1), name);
+	}
+}
+
+static int add_one_ref(const char *path, const unsigned char *sha1)
+{
+	struct object *object = parse_object(sha1);
+	if (!object)
+		die("bad object ref: %s:%s", path, sha1_to_hex(sha1));
+	add_pending_object(&revs, object, "");
+	return 0;        
+}
+
+static void add_one_tree(const unsigned char *sha1)
+{
+	struct tree *tree = lookup_tree(sha1);
+	add_pending_object(&revs, &tree->object, "");
+}
+
+static void add_cache_tree(struct cache_tree *it)
+{
+	int i;
+
+	if (it->entry_count >= 0)
+		add_one_tree(it->sha1);
+	for (i = 0; i < it->subtree_nr; i++)
+		add_cache_tree(it->down[i]->cache_tree);
+}
+
+static void add_cache_refs(void)
+{
+	int i;
+
+ 	read_cache();
+	for (i = 0; i < active_nr; i++) {
+		lookup_blob(active_cache[i]->sha1);
+		/*
+		 * We could add the blobs to the pending list, but quite
+		 * frankly, we don't care. Once we've looked them up, and
+		 * added them as objects, we've really done everything 
+		 * there is to do for a blob
+		 */
+	}
+	if (active_cache_tree)
+		add_cache_tree(active_cache_tree);
+}
+
+int cmd_prune(int argc, const char **argv, char **envp)
+{
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "-n")) {
+			show_only = 1;
+			continue;
+		}
+		usage(prune_usage);
+	}
+
+	/*
+	 * Set up revision parsing, and mark us as being interested
+	 * in all object types, not just commits.
+	 */
+	init_revisions(&revs);
+	revs.tag_objects = 1;
+	revs.blob_objects = 1;
+	revs.tree_objects = 1;
+
+	/* Add all external refs */
+	for_each_ref(add_one_ref);
+
+	/* Add all refs from the index file */
+	add_cache_refs();
+
+	/*
+	 * Set up the revision walk - this will move all commits
+	 * from the pending list to the commit walking list.
+	 */
+	prepare_revision_walk(&revs);
+
+	walk_commit_list(&revs);
+
+	prune_object_dir(get_object_directory());
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index d9e5483..5339d86 100644
--- a/builtin.h
+++ b/builtin.h
@@ -25,6 +25,8 @@ extern int cmd_diff(int argc, const char
 extern int cmd_format_patch(int argc, const char **argv, char **envp);
 extern int cmd_count_objects(int argc, const char **argv, char **envp);
 
+extern int cmd_prune(int argc, const char **argv, char **envp);
+
 extern int cmd_push(int argc, const char **argv, char **envp);
 extern int cmd_grep(int argc, const char **argv, char **envp);
 extern int cmd_rm(int argc, const char **argv, char **envp);
diff --git a/git-prune.sh b/git-prune.sh
deleted file mode 100755
index c5a5d29..0000000
--- a/git-prune.sh
+++ /dev/null
@@ -1,44 +0,0 @@
-#!/bin/sh
-
-USAGE='[-n] [--] [<head>...]'
-. git-sh-setup
-
-dryrun=
-echo=
-while case "$#" in 0) break ;; esac
-do
-    case "$1" in
-    -n) dryrun=-n echo=echo ;;
-    --) break ;;
-    -*) usage ;;
-    *)  break ;;
-    esac
-    shift;
-done
-
-sync
-case "$#" in
-0) git-fsck-objects --full --cache --unreachable ;;
-*) git-fsck-objects --full --cache --unreachable $(git-rev-parse --all) "$@" ;;
-esac |
-
-sed -ne '/unreachable /{
-    s/unreachable [^ ][^ ]* //
-    s|\(..\)|\1/|p
-}' | {
-	cd "$GIT_OBJECT_DIRECTORY" || exit
-	xargs $echo rm -f
-	rmdir 2>/dev/null [0-9a-f][0-9a-f]
-}
-
-git-prune-packed $dryrun
-
-if redundant=$(git-pack-redundant --all 2>/dev/null) && test "" != "$redundant"
-then
-	if test "" = "$dryrun"
-	then
-		echo "$redundant" | xargs rm -f
-	else
-		echo rm -f "$redundant"
-	fi
-fi
diff --git a/git.c b/git.c
index 2567301..16e37e5 100644
--- a/git.c
+++ b/git.c
@@ -188,7 +188,8 @@ static void handle_internal_command(int 
 		{ "stripspace", cmd_stripspace },
 		{ "update-index", cmd_update_index },
 		{ "update-ref", cmd_update_ref },
-		{ "fmt-merge-msg", cmd_fmt_merge_msg }
+		{ "fmt-merge-msg", cmd_fmt_merge_msg },
+		{ "prune", cmd_prune },
 	};
 	int i;
 
