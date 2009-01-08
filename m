From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v4 2/2] entry.c: create_directories(): only create/check
 each directory once!
Date: Thu, 08 Jan 2009 12:32:36 +0100
Message-ID: <1231414356-6982-3-git-send-email-barvik@broadpark.no>
References: <1231414356-6982-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 12:34:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKt9a-0005wi-Ju
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 12:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbZAHLcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 06:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754339AbZAHLcr
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 06:32:47 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:57588 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbZAHLcp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 06:32:45 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KD500EKAHEI3P30@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 08 Jan 2009 12:32:42 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.24])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KD50047PHECTW80@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 08 Jan 2009 12:32:42 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.49.g7f705
In-reply-to: <1231414356-6982-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104918>

When we do an 'git checkout' after some time we end up in the
'checkout_entry()' function inside entry.c, and from here we call the
'create_directories()' function to make sure that all the directories
exists for the possible new file or entry.

The 'create_directories()' function happily started to check that all
path component exists.  This resulted in tons and tons of calls to
lstat() or stat() when we checkout files nested deep inside a
directory.

We try to avoid this by remembering the last created directory.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
:100644 100644 768ba38... ec1297f... M	cache.h
:100644 100644 aa2ee46... 1d5fc85... M	entry.c
:100644 100644 28e2759... 0a03e65... M	unpack-trees.c
 cache.h        |    1 +
 entry.c        |   57 +++++++++++++++++++++++++++++++++++++++++++++----------
 unpack-trees.c |    1 +
 3 files changed, 48 insertions(+), 11 deletions(-)

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
index aa2ee46a84033585d8e07a585610c5a697af82c2..1d5fc85b5f4b02bcdb862745777f7bc086b70c63 100644
--- a/entry.c
+++ b/entry.c
@@ -1,18 +1,50 @@
 #include "cache.h"
 #include "blob.h"
 
-static void create_directories(const char *path, const struct checkout *state)
+static char buf[PATH_MAX];
+static int  buf_len = 0;
+
+static inline int
+greatest_match_last_created_dir(int len, const char *path)
 {
-	int len = strlen(path);
-	char *buf = xmalloc(len + 1);
-	const char *slash = path;
+	int max_len, match_len = 0, i = 0;
 
-	while ((slash = strchr(slash+1, '/')) != NULL) {
-		struct stat st;
-		int stat_status;
+	max_len = len < buf_len ? len : buf_len;
+	while (i < max_len && path[i] == buf[i]) {
+		if (path[i] == '/') match_len = i;
+		i++;
+	}
+	if (i == buf_len && len > buf_len && path[buf_len] == '/')
+		match_len = buf_len;
+	return match_len;
+}
+
+void clear_created_dirs_cache(void)
+{
+	buf[0]  = 0;
+	buf_len = 0;
+}
+
+static void
+create_directories(int path_len, const char *path, const struct checkout *state)
+{
+	int path_len_max, buf_i, len, stat_status;
+	struct stat st;
 
-		len = slash - path;
-		memcpy(buf, path, len);
+	/* Check the cache for previously created directories (and
+	 * components) within this function.  There is no need to
+	 * re-create directory components more than once!
+	 */
+	path_len_max = path_len < PATH_MAX ? path_len : PATH_MAX;
+	buf_i = len = greatest_match_last_created_dir(path_len_max, path);
+	while (buf_i < path_len_max) {
+		do {
+			buf[buf_i] = path[buf_i];
+			buf_i++;
+		} while (buf_i < path_len_max && path[buf_i] != '/');
+		if (buf_i >= path_len_max)
+			break;
+		len = buf_i;
 		buf[len] = 0;
 
 		if (len <= state->base_dir_len)
@@ -45,7 +77,9 @@ static void create_directories(const char *path, const struct checkout *state)
 			die("cannot create directory at %s", buf);
 		}
 	}
-	free(buf);
+	/* Update the cache of already created directories */
+	buf[len] = 0;
+	buf_len  = len;
 }
 
 static void remove_subtree(const char *path)
@@ -201,6 +235,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 
 	memcpy(path, state->base_dir, len);
 	strcpy(path + len, ce->name);
+	len += ce_namelen(ce);
 
 	if (!lstat(path, &st)) {
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID);
@@ -229,6 +264,6 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
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
