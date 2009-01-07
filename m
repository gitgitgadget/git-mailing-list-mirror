From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v3 2/2] create_directories() inside entry.c: only check
 each directory once!
Date: Wed, 07 Jan 2009 14:24:49 +0100
Message-ID: <1231334689-17135-3-git-send-email-barvik@broadpark.no>
References: <1231334689-17135-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 14:26:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKYQx-0002rM-Lc
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 14:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757993AbZAGNZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 08:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754785AbZAGNZO
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 08:25:14 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:32924 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757896AbZAGNY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 08:24:57 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KD300K2FRXK78F0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 07 Jan 2009 14:24:56 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.60])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KD30044ARXDDW40@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 07 Jan 2009 14:24:56 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.49.g7f705
In-reply-to: <1231334689-17135-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104795>

When we do an 'git checkout' after some time we end up in the
'checkout_entry()' function inside entry.c, and from here we call the
'create_directories()' function to make sure the all the directories
exists for the possible new file or entry.

The 'create_directories()' function happily started to check that all
path component exists.  This resulted in tons and tons of calls to
lstat() or stat() when we checkout files nested deep inside a
directory.

We try to avoid this by remembering the last checked and possible
newly created directory.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
:100644 100644 768ba38... ec1297f... M	cache.h
:100644 100644 aa2ee46... 36d6f98... M	entry.c
:100644 100644 28e2759... 0a03e65... M	unpack-trees.c
 cache.h        |    1 +
 entry.c        |   82 +++++++++++++++++++++++++++++++++++++++++++------------
 unpack-trees.c |    1 +
 3 files changed, 66 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index 768ba3825f3015828381490b0c387177a4f71578..ec1297ff5621cc9eb7fce51cc025f18a030ac9ea 100644
--- a/cache.h
+++ b/cache.h
@@ -718,6 +718,7 @@ struct checkout {
 		 refresh_cache:1;
 };
 
+extern void clear_created_dirs_cache(void);
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
 
 #define LSTAT_DIR       (1u << 0)
diff --git a/entry.c b/entry.c
index aa2ee46a84033585d8e07a585610c5a697af82c2..36d6f98c1f59a86a5e9c117e1181c1169208168f 100644
--- a/entry.c
+++ b/entry.c
@@ -1,33 +1,67 @@
 #include "cache.h"
 #include "blob.h"
 
-static void create_directories(const char *path, const struct checkout *state)
+static char dirs_path[PATH_MAX];
+static int  dirs_len = 0;
+
+static inline int
+greatest_common_created_dirs_prefix(int len, const char *name)
 {
-	int len = strlen(path);
-	char *buf = xmalloc(len + 1);
-	const char *slash = path;
+	int max_len, match_len = 0, i = 0;
 
-	while ((slash = strchr(slash+1, '/')) != NULL) {
-		struct stat st;
-		int stat_status;
+	max_len = len < dirs_len ? len : dirs_len;
+	while (i < max_len && name[i] == dirs_path[i]) {
+		if (name[i] == '/') match_len = i;
+		i++;
+	}
+	if (i == dirs_len && len > dirs_len && name[dirs_len] == '/')
+		match_len = dirs_len;
+	return match_len;
+}
 
-		len = slash - path;
-		memcpy(buf, path, len);
-		buf[len] = 0;
+void clear_created_dirs_cache(void)
+{
+	dirs_path[0] = '\0';
+	dirs_len     = 0;
+}
 
-		if (len <= state->base_dir_len)
+static void
+create_directories(int len, const char *path, const struct checkout *state)
+{
+	int i, max_len, last_slash, stat_status;
+	struct stat st;
+
+	/* Check the cache for previously checked or created
+	 * directories (and components) within this function.  There
+	 * is no need to check or re-create directory components more
+	 * than once!
+	 */
+	max_len = len < PATH_MAX ? len : PATH_MAX;
+	i = last_slash = greatest_common_created_dirs_prefix(max_len, path);
+
+	while (i < max_len) {
+		do {
+			dirs_path[i] = path[i];
+			i++;
+		} while (i < max_len && path[i] != '/');
+		if (i >= max_len)
+			break;
+		last_slash = i;
+		dirs_path[last_slash] = '\0';
+
+		if (last_slash <= state->base_dir_len)
 			/*
 			 * checkout-index --prefix=<dir>; <dir> is
 			 * allowed to be a symlink to an existing
 			 * directory.
 			 */
-			stat_status = stat(buf, &st);
+			stat_status = stat(dirs_path, &st);
 		else
 			/*
 			 * if there currently is a symlink, we would
 			 * want to replace it with a real directory.
 			 */
-			stat_status = lstat(buf, &st);
+			stat_status = lstat(dirs_path, &st);
 
 		if (!stat_status && S_ISDIR(st.st_mode))
 			continue; /* ok, it is already a directory. */
@@ -38,14 +72,20 @@ static void create_directories(const char *path, const struct checkout *state)
 		 * error codepath; we do not care, as we unlink and
 		 * mkdir again in such a case.
 		 */
-		if (mkdir(buf, 0777)) {
+		if (mkdir(dirs_path, 0777)) {
 			if (errno == EEXIST && state->force &&
-			    !unlink(buf) && !mkdir(buf, 0777))
+			    !unlink(dirs_path) && !mkdir(dirs_path, 0777))
 				continue;
-			die("cannot create directory at %s", buf);
+			die("cannot create directory at %s", dirs_path);
 		}
 	}
-	free(buf);
+	/* Update the cache of already created/checked directories */
+	if (last_slash > 0 && last_slash < PATH_MAX) {
+		dirs_path[last_slash] = '\0';
+		dirs_len = last_slash;
+	} else {
+		clear_created_dirs_cache();
+	}
 }
 
 static void remove_subtree(const char *path)
@@ -55,6 +95,11 @@ static void remove_subtree(const char *path)
 	char pathbuf[PATH_MAX];
 	char *name;
 
+	/* To be utterly safe we invalidate the cache of the
+	 * previously created directories.
+	 */
+	clear_created_dirs_cache();
+
 	if (!dir)
 		die("cannot opendir %s (%s)", path, strerror(errno));
 	strcpy(pathbuf, path);
@@ -201,6 +246,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 
 	memcpy(path, state->base_dir, len);
 	strcpy(path + len, ce->name);
+	len += ce_namelen(ce);
 
 	if (!lstat(path, &st)) {
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID);
@@ -229,6 +275,6 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 			return error("unable to unlink old '%s' (%s)", path, strerror(errno));
 	} else if (state->not_new)
 		return 0;
-	create_directories(path, state);
+	create_directories(len, path, state);
 	return write_entry(ce, path, state, 0);
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index 28e275981a21b033459ef9c7e420cce4bf7e5513..0a03e65f9c9d869ab2d8b3c337f032ff2b8e7b2f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -119,6 +119,7 @@ static int check_updates(struct unpack_trees_options *o)
 		}
 	}
 
+	clear_created_dirs_cache();
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
-- 
1.6.1.rc1.49.g7f705
