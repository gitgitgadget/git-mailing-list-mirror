From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 3/6] Add case insensitivity support for directories when using git status
Date: Mon, 16 Aug 2010 21:38:11 +0200
Message-ID: <ff426cde57168ff68a4ec9042c2b6fa5b76a55be.1281985411.git.j6t@kdbg.org>
References: <cover.1281985411.git.j6t@kdbg.org>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 16 21:39:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol5Wp-0007Pw-K0
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 21:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198Ab0HPTih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 15:38:37 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:59113 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932179Ab0HPTie (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 15:38:34 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5FDF62C400D;
	Mon, 16 Aug 2010 21:38:33 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1718D19F7CC;
	Mon, 16 Aug 2010 21:38:33 +0200 (CEST)
X-Mailer: git-send-email 1.7.1.402.gf1eeb
In-Reply-To: <cover.1281985411.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153675>

From: Joshua Jensen <jjensen@workspacewhiz.com>

When using a case preserving but case insensitive file system, directory
case can differ but still refer to the same physical directory.  git
status reports the directory with the alternate case as an Untracked
file.  (That is, when mydir/filea.txt is added to the repository and
then the directory on disk is renamed from mydir/ to MyDir/, git status
shows MyDir/ as being untracked.)

Support has been added in name-hash.c for hashing directories with a
terminating slash into the name hash. When index_name_exists() is called
with a directory (a name with a terminating slash), the name is not
found via the normal cache_name_compare() call, but it is found in the
slow_same_name() function.

Additionally, in dir.c, directory_exists_in_index_icase() allows newly
added directories deeper in the directory chain to be identified.

Ultimately, it would be better if the file list was read in case
insensitive alphabetical order from disk, but this change seems to
suffice for now.

The end result is the directory is looked up in a case insensitive
manner and does not show in the Untracked files list.

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 dir.c       |   39 +++++++++++++++++++++++++++++++-
 name-hash.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index be21c20..f80e091 100644
--- a/dir.c
+++ b/dir.c
@@ -485,6 +485,38 @@ enum exist_status {
 };
 
 /*
+ * Do not use the alphabetically stored index to look up
+ * the directory name; instead, use the case insensitive
+ * name hash.
+ */
+static enum exist_status directory_exists_in_index_icase(const char *dirname, int len)
+{
+	struct cache_entry *ce = index_name_exists(&the_index, dirname, len + 1, ignore_case);
+	if (!ce)
+		return index_nonexistent;
+
+	unsigned char endchar = ce->name[len];
+
+	/*
+	 * The cache_entry structure returned will contain this dirname
+	 * and possibly additional path components.
+	 */
+	if (endchar == '/')
+		return index_directory;
+
+	/*
+	 * If there are no additional path components, then this cache_entry
+	 * represents a submodule.  Submodules, despite being directories,
+	 * are stored in the cache without a closing slash.
+	 */
+	if (!endchar && S_ISGITLINK(ce->ce_mode))
+		return index_gitdir;
+
+	/* This should never be hit, but it exists just in case. */
+	return index_nonexistent;
+}
+
+/*
  * The index sorts alphabetically by entry name, which
  * means that a gitlink sorts as '\0' at the end, while
  * a directory (which is defined not as an entry, but as
@@ -493,7 +525,12 @@ enum exist_status {
  */
 static enum exist_status directory_exists_in_index(const char *dirname, int len)
 {
-	int pos = cache_name_pos(dirname, len);
+	int pos;
+
+	if (ignore_case)
+		return directory_exists_in_index_icase(dirname, len);
+
+	pos = cache_name_pos(dirname, len);
 	if (pos < 0)
 		pos = -pos-1;
 	while (pos < active_nr) {
diff --git a/name-hash.c b/name-hash.c
index 0031d78..c6b6a3f 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -32,6 +32,42 @@ static unsigned int hash_name(const char *name, int namelen)
 	return hash;
 }
 
+static void hash_index_entry_directories(struct index_state *istate, struct cache_entry *ce)
+{
+	/*
+	 * Throw each directory component in the hash for quick lookup
+	 * during a git status. Directory components are stored with their
+	 * closing slash.  Despite submodules being a directory, they never
+	 * reach this point, because they are stored without a closing slash
+	 * in the cache.
+	 *
+	 * Note that the cache_entry stored with the directory does not
+	 * represent the directory itself.  It is a pointer to an existing
+	 * filename, and its only purpose is to represent existence of the
+	 * directory in the cache.  It is very possible multiple directory
+	 * hash entries may point to the same cache_entry.
+	 */
+	unsigned int hash;
+	void **pos;
+
+	const char *ptr = ce->name;
+	while (*ptr) {
+		while (*ptr && *ptr != '/')
+			++ptr;
+		if (*ptr == '/') {
+			++ptr;
+			hash = hash_name(ce->name, ptr - ce->name);
+			if (!lookup_hash(hash, &istate->name_hash)) {
+				pos = insert_hash(hash, ce, &istate->name_hash);
+				if (pos) {
+					ce->next = *pos;
+					*pos = ce;
+				}
+			}
+		}
+	}
+}
+
 static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 {
 	void **pos;
@@ -47,6 +83,9 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 		ce->next = *pos;
 		*pos = ce;
 	}
+
+	if (ignore_case)
+		hash_index_entry_directories(istate, ce);
 }
 
 static void lazy_init_name_hash(struct index_state *istate)
@@ -97,7 +136,21 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 	if (len == namelen && !cache_name_compare(name, namelen, ce->name, len))
 		return 1;
 
-	return icase && slow_same_name(name, namelen, ce->name, len);
+	if (!icase)
+		return 0;
+
+	/*
+	 * If the entry we're comparing is a filename (no trailing slash), then compare
+	 * the lengths exactly.
+	 */
+	if (name[namelen - 1] != '/')
+		return slow_same_name(name, namelen, ce->name, len);
+
+	/*
+	 * For a directory, we point to an arbitrary cache_entry filename.  Just
+	 * make sure the directory portion matches.
+	 */
+	return slow_same_name(name, namelen, ce->name, namelen < len ? namelen : len);
 }
 
 struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
@@ -115,5 +168,22 @@ struct cache_entry *index_name_exists(struct index_state *istate, const char *na
 		}
 		ce = ce->next;
 	}
+
+	/*
+	 * Might be a submodule.  Despite submodules being directories,
+	 * they are stored in the name hash without a closing slash.
+	 * When ignore_case is 1, directories are stored in the name hash
+	 * with their closing slash.
+	 *
+	 * The side effect of this storage technique is we have need to
+	 * remove the slash from name and perform the lookup again without
+	 * the slash.  If a match is made, S_ISGITLINK(ce->mode) will be
+	 * true.
+	 */
+	if (icase && name[namelen - 1] == '/') {
+		ce = index_name_exists(istate, name, namelen - 1, icase);
+		if (ce && S_ISGITLINK(ce->ce_mode))
+			return ce;
+	}
 	return NULL;
 }
-- 
1.7.1.402.gf1eeb
