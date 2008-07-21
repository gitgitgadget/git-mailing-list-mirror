From: Petr Baudis <pasky@suse.cz>
Subject: [PATCHv2] git-mv: Keep moved index entries inact
Date: Mon, 21 Jul 2008 02:25:56 +0200
Message-ID: <20080721002508.26773.92277.stgit@localhost>
References: <20080721002354.GK10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 21 02:27:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKjF7-0001xh-1A
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 02:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452AbYGUA0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 20:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755443AbYGUA0I
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 20:26:08 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:65284 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755047AbYGUA0G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 20:26:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id DFF2E2ACCA2;
	Mon, 21 Jul 2008 02:25:56 +0200 (CEST)
In-Reply-To: <20080721002354.GK10151@machine.or.cz>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89279>

The rewrite of git-mv from a shell script to a builtin was perhaps
a little too straightforward: the git add and git rm queues were
emulated directly, which resulted in a rather complicated code and
caused an inconsistent behaviour when moving dirty index entries;
git mv would update the entry based on working tree state,
except in case of overwrites, where the new entry would still have
sha1 of the old file.

This patch introduces rename_index_entry_at() into the index toolkit,
which will rename an entry while removing any entries the new entry
might render duplicate. This is then used in git mv instead
of all the file queues, resulting in a major simplification
of the code and an inevitable change in git mv -n output format.

A new test has been added to the testsuite to reflect this change.
Also, based on suggestion by Junio about desired symlink behaviour
of git mv, I have added two tests for that; however, I do not have
need or desire to spend time fixing this, so they are expected
to fail for now until someone gets around to fixing that.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 builtin-mv.c  |   62 ++++++++-------------------------------------------------
 cache.h       |    2 ++
 read-cache.c  |   17 ++++++++++++++++
 t/t7001-mv.sh |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 53 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index 33ad082..28ebc9c 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -36,17 +36,6 @@ static const char **copy_pathspec(const char *prefix, const char **pathspec,
 	return get_pathspec(prefix, result);
 }
 
-static void show_list(const char *label, struct path_list *list)
-{
-	if (list->nr > 0) {
-		int i;
-		printf("%s", label);
-		for (i = 0; i < list->nr; i++)
-			printf("%s%s", i > 0 ? ", " : "", list->items[i].path);
-		putchar('\n');
-	}
-}
-
 static const char *add_slash(const char *path)
 {
 	int len = strlen(path);
@@ -75,11 +64,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	const char **source, **destination, **dest_path;
 	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
 	struct stat st;
-	struct path_list overwritten = {NULL, 0, 0, 0};
 	struct path_list src_for_dst = {NULL, 0, 0, 0};
-	struct path_list added = {NULL, 0, 0, 0};
-	struct path_list deleted = {NULL, 0, 0, 0};
-	struct path_list changed = {NULL, 0, 0, 0};
 
 	git_config(git_default_config, NULL);
 
@@ -189,7 +174,6 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 							" will overwrite!\n",
 							bad);
 					bad = NULL;
-					path_list_insert(dst, &overwritten);
 				} else
 					bad = "Cannot overwrite";
 			}
@@ -218,6 +202,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < argc; i++) {
 		const char *src = source[i], *dst = destination[i];
 		enum update_mode mode = modes[i];
+		int pos;
 		if (show_only || verbose)
 			printf("Renaming %s to %s\n", src, dst);
 		if (!show_only && mode != INDEX &&
@@ -227,45 +212,16 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (mode == WORKING_DIRECTORY)
 			continue;
 
-		assert(cache_name_pos(src, strlen(src)) >= 0);
-
-		path_list_insert(src, &deleted);
-		/* destination can be a directory with 1 file inside */
-		if (path_list_has_path(&overwritten, dst))
-			path_list_insert(dst, &changed);
-		else
-			path_list_insert(dst, &added);
+		pos = cache_name_pos(src, strlen(src));
+		assert(pos >= 0);
+		if (!show_only)
+			rename_cache_entry_at(pos, dst);
 	}
 
-	if (show_only) {
-		show_list("Changed  : ", &changed);
-		show_list("Adding   : ", &added);
-		show_list("Deleting : ", &deleted);
-	} else {
-		for (i = 0; i < changed.nr; i++) {
-			const char *path = changed.items[i].path;
-			int j = cache_name_pos(path, strlen(path));
-			struct cache_entry *ce = active_cache[j];
-
-			if (j < 0)
-				die ("Huh? Cache entry for %s unknown?", path);
-			refresh_cache_entry(ce, 0);
-		}
-
-		for (i = 0; i < added.nr; i++) {
-			const char *path = added.items[i].path;
-			if (add_file_to_cache(path, verbose ? ADD_CACHE_VERBOSE : 0))
-				die("updating index entries failed");
-		}
-
-		for (i = 0; i < deleted.nr; i++)
-			remove_file_from_cache(deleted.items[i].path);
-
-		if (active_cache_changed) {
-			if (write_cache(newfd, active_cache, active_nr) ||
-			    commit_locked_index(&lock_file))
-				die("Unable to write new index file");
-		}
+	if (active_cache_changed) {
+		if (write_cache(newfd, active_cache, active_nr) ||
+		    commit_locked_index(&lock_file))
+			die("Unable to write new index file");
 	}
 
 	return 0;
diff --git a/cache.h b/cache.h
index a779d92..6f1d003 100644
--- a/cache.h
+++ b/cache.h
@@ -260,6 +260,7 @@ static inline void remove_name_hash(struct cache_entry *ce)
 #define unmerged_cache() unmerged_index(&the_index)
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
 #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
+#define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&the_index, (pos), (new_name))
 #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
 #define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags))
@@ -370,6 +371,7 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
 #define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() */
 extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
 extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
+extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
 extern int remove_index_entry_at(struct index_state *, int pos);
 extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_VERBOSE 1
diff --git a/read-cache.c b/read-cache.c
index 1648428..e93ee3c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -38,6 +38,23 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
 	istate->cache_changed = 1;
 }
 
+void rename_index_entry_at(struct index_state *istate, int nr, const char *new_name)
+{
+	struct cache_entry *old = istate->cache[nr], *new;
+	int namelen = strlen(new_name);
+
+	new = xmalloc(cache_entry_size(namelen));
+	copy_cache_entry(new, old);
+	new->ce_flags = (new->ce_flags & ~CE_HASHED) | CE_UNHASHED;
+	new->ce_flags = (new->ce_flags & ~CE_NAMEMASK)
+	                | (namelen >= CE_NAMEMASK ? CE_NAMEMASK : namelen);
+	memcpy(new->name, new_name, namelen);
+
+	cache_tree_invalidate_path(istate->cache_tree, old->name);
+	remove_index_entry_at(istate, nr);
+	add_index_entry(istate, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+}
+
 /*
  * This only updates the "non-critical" parts of the directory
  * cache, ie the parts that aren't tracked by GIT, and only used
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 336cfaa..7e47931 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -156,4 +156,59 @@ test_expect_success 'absolute pathname outside should fail' '(
 
 )'
 
+test_expect_success 'git mv should not change sha1 of moved cache entry' '
+
+	rm -fr .git &&
+	git init &&
+	echo 1 >dirty &&
+	git add dirty &&
+	entry="$(git ls-files --stage dirty | cut -f 1)"
+	git mv dirty dirty2 &&
+	[ "$entry" = "$(git ls-files --stage dirty2 | cut -f 1)" ] &&
+	echo 2 >dirty2 &&
+	git mv dirty2 dirty &&
+	[ "$entry" = "$(git ls-files --stage dirty | cut -f 1)" ]
+
+'
+
+rm -f dirty dirty2
+
+test_expect_failure 'git mv should overwrite symlink to a file' '
+
+	rm -fr .git &&
+	git init &&
+	echo 1 >moved &&
+	ln -s moved symlink &&
+	git add moved symlink &&
+	! git mv moved symlink &&
+	git mv -f moved symlink &&
+	[ ! -e moved ] &&
+	[ -f symlink ] &&
+	[ $(cat symlink) = 1 ] &&
+	git diff-files --quiet
+
+'
+
+rm -f moved symlink
+
+test_expect_failure 'git mv should follow symlink to a directory' '
+
+	rm -fr .git &&
+	git init &&
+	echo 1 >moved &&
+	mkdir -p dir &&
+	touch dir/.keep &&
+	ln -s dir symlink &&
+	git add moved dir/.keep symlink &&
+	git mv moved symlink &&
+	[ ! -e moved ] &&
+	[ -f symlink/moved ] &&
+	[ $(cat symlink/moved) = 1 ] &&
+	[ "$(ls dir)" = "$(ls symlink)" ] &&
+	git diff-files --quiet
+
+'
+
+rm -rf moved symlink dir
+
 test_done
