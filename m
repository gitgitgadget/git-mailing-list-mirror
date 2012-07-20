From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC/PATCH] Only call record_resolve_undo() when coming from add/rm
Date: Fri, 20 Jul 2012 23:28:48 +0200
Message-ID: <e0e9ce3599d898c974c56c818d9858638e343f5b.1342819276.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 23:29:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsKku-0000F2-II
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 23:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034Ab2GTV2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 17:28:55 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:17884 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab2GTV2y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 17:28:54 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 20 Jul
 2012 23:28:51 +0200
Received: from thomas.inf.ethz.net (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 20 Jul
 2012 23:28:50 +0200
X-Mailer: git-send-email 1.7.11.2.589.gcf84a3b
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201793>

The REUC extension stores the stage 1/2/3 data of entries which were
marked resolved by the user, to enable 'git checkout -m <name>' to
restore the conflicted state later.

When a file was deleted on one side of the merge and unmodified on the
other, merge-recursive uses remove_file_from_cache() to remove it from
the result index.  This uses remove_index_entry_at(), which calls
record_resolve_undo().

Such REUC entries are in fact even useless: neither 'git checkout -m'
nor 'git update-index --unresolve' can resurrect the file (the former
because there is no corresponding index entry, the latter because the
file is missing one side).

Solve this by taking a more specific approach to record_resolve_undo():

* git-rm and 'git update-index --remove' go through
  remove_file_from_cache(), just like merge-recursive.  Make them use
  a new _extended version that optionally records REUC.

* git-add and 'git update-index conflicted_file' go through the
  add_index_entry() call chain.  git-apply and git-read-tree use
  add_index_entry() too.  However, they insert stage-0 entries, which
  already means resolving.  So even if these cases were not caught
  earlier, saving the unresolved state would be correct.

  So we can unconditionally record REUC deeper in the call chain.

(git-mv calls remove_index_entry_at() through rename_index_entry_at();
however, it refuses to work on unresolved files.  So that's okay too.)

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Thomas and me discovered this while hacking on index-v5.  It would be
a bit tricky to handle there: the index is structured according to the
directory layout of the files it contains, and the REUC data is the
same as the conflict (stages) data plus a flag bit, for (future)
easier toggling between them.  With the behavior before this patch, it
is possible to have directories that do not have any "live" files, yet
contain REUC records.  For example, in git.git,

  $ git checkout 8e17b34c33^1
  $ git merge 8e17b34c33^2
  $ g ls-files -s | grep arpa
  $ g ls-files --resolve-undo | grep arpa
  100644 0d8552a2c6dc3a5fee5360ea2ff468463461e3bf 1       compat/vcbuild/include/arpa/inet.h
  100644 0d8552a2c6dc3a5fee5360ea2ff468463461e3bf 3       compat/vcbuild/include/arpa/inet.h

(and several other files in the same commit).  So this patch would let
us keep the complexity of that handling down, by not running into such
cases.

 builtin/rm.c           |  2 +-
 builtin/update-index.c |  2 +-
 cache.h                |  2 ++
 read-cache.c           | 14 +++++++++++---
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 90c8a50..145d368 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -226,7 +226,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		if (!quiet)
 			printf("rm '%s'\n", path);
 
-		if (remove_file_from_cache(path))
+		if (remove_file_from_cache_extended(path, 1))
 			die(_("git rm: unable to remove %s"), path);
 	}
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5f038d6..2e58979 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -196,7 +196,7 @@ static int process_path(const char *path)
 		 * so updating it does not make sense.
 		 * On the other hand, removing it from index should work
 		 */
-		if (allow_remove && remove_file_from_cache(path))
+		if (allow_remove && remove_file_from_cache_extended(path, 1))
 			return error("%s: cannot remove from the index", path);
 		return 0;
 	}
diff --git a/cache.h b/cache.h
index 14d8fd4..616a355 100644
--- a/cache.h
+++ b/cache.h
@@ -378,6 +378,7 @@ static inline void remove_name_hash(struct cache_entry *ce)
 #define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&the_index, (pos), (new_name))
 #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
+#define remove_file_from_cache_extended(path, flags) remove_file_from_index_extended(&the_index, (path), (flags))
 #define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags))
 #define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
@@ -522,6 +523,7 @@ static inline enum object_type object_type(unsigned int mode)
 extern int remove_index_entry_at(struct index_state *, int pos);
 extern void remove_marked_cache_entries(struct index_state *istate);
 extern int remove_file_from_index(struct index_state *, const char *path);
+extern int remove_file_from_index_extended(struct index_state *, const char *path, int save_reuc);
 #define ADD_CACHE_VERBOSE 1
 #define ADD_CACHE_PRETEND 2
 #define ADD_CACHE_IGNORE_ERRORS	4
diff --git a/read-cache.c b/read-cache.c
index ee4e633..e172143 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -540,7 +540,6 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 {
 	struct cache_entry *ce = istate->cache[pos];
 
-	record_resolve_undo(istate, ce);
 	remove_name_hash(ce);
 	istate->cache_changed = 1;
 	istate->cache_nr--;
@@ -572,17 +571,25 @@ void remove_marked_cache_entries(struct index_state *istate)
 	istate->cache_nr = j;
 }
 
-int remove_file_from_index(struct index_state *istate, const char *path)
+int remove_file_from_index_extended(struct index_state *istate, const char *path, int save_reuc)
 {
 	int pos = index_name_pos(istate, path, strlen(path));
 	if (pos < 0)
 		pos = -pos-1;
 	cache_tree_invalidate_path(istate->cache_tree, path);
-	while (pos < istate->cache_nr && !strcmp(istate->cache[pos]->name, path))
+	while (pos < istate->cache_nr && !strcmp(istate->cache[pos]->name, path)) {
+		if (save_reuc)
+			record_resolve_undo(istate, istate->cache[pos]);
 		remove_index_entry_at(istate, pos);
+	}
 	return 0;
 }
 
+int remove_file_from_index(struct index_state *istate, const char *path)
+{
+	return remove_file_from_index_extended(istate, path, 0);
+}
+
 static int compare_name(struct cache_entry *ce, const char *path, int namelen)
 {
 	return namelen != ce_namelen(ce) || memcmp(path, ce->name, namelen);
@@ -1020,6 +1027,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	if (pos < istate->cache_nr && ce_stage(ce) == 0) {
 		while (ce_same_name(istate->cache[pos], ce)) {
 			ok_to_add = 1;
+			record_resolve_undo(istate, istate->cache[pos]);
 			if (!remove_index_entry_at(istate, pos))
 				break;
 		}
-- 
1.7.11.2.589.gcf84a3b
