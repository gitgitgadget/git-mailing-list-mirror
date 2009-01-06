From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v2 1/4] Optimised, faster,
 more effective symlink/directory detection
Date: Tue, 06 Jan 2009 21:36:29 +0100
Message-ID: <1231274192-30478-2-git-send-email-barvik@broadpark.no>
References: <1231274192-30478-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 21:38:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKIgd-0001D1-Qb
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 21:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbZAFUgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 15:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbZAFUgk
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 15:36:40 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:55282 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbZAFUgh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 15:36:37 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KD200B86H90GN20@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 06 Jan 2009 21:36:36 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.60])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KD200CL4H8WWS00@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 06 Jan 2009 21:36:36 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.49.g7f705
In-reply-to: <1231274192-30478-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104718>

This patch is work based on the following 2 commits:

Linus Torvalds: c40641b77b0274186fd1b327d5dc3246f814aaaf
Junio C Hamano: f859c846e90b385c7ef873df22403529208ade50

Changes includes the following:

- The cache functionality is more effective.  Previously when A/B/C/D
  was in the cache and A/B/C/E/file.c was called for, there was no
  match at all from the cache.  Now we use the fact that the paths
  "A", "A/B" and "A/B/C" is already tested, and we only need to do an
  lstat() call on "A/B/C/E".

- We only cache/store the last path regardless of it's type.  Since the
  cache functionality is always used with alphabetically sorted names
  (at least it seams so for me), there is no need to store both the
  last symlink-leading path and the last real-directory path.  Note
  that if the cache is not called with (mostly) alphabetically sorted
  names, neither the old, nor this new one, would be very effective.

- We also can cache the fact that a directory does not exist.
  Previously we could end up doing lots of lstat() calls for a removed
  directory which previously contained lots of files.  Since we
  already have simplified the cache functionality and only store the
  last path (see above), this new functionality was easy to add.

- Previously, when symlink A/B/C/S was cached/stored in the
  symlink-leading path, and A/B/C/file.c was called for, it was not
  easy to use the fact that we already known that the paths "A", "A/B"
  and "A/B/C" is real directories.  Since we now only store one single
  path (the last one), we also get similar logic for free regarding
  the new "non-exsisting-directory-cache".

- Avoid copying the first path components of the name 2 zillions times
  when we tests new path components.  Since we always cache/store the
  last path, we can copy each component as we test those directly into
  the cache.  Previously we ended up doing a memcpy() for the full
  path/name right before each lstat() call, and when updating the
  cache for each time we have tested an new path component.

- We also use less memory, that is PATH_MAX bytes less memory on the
  stack and PATH_MAX bytes less memory on the heap.

- Introduce a 3rd argument, 'unsigned int track_flags', to the
  cache-test function, check_lstat_cache().  This new argument can be
  used to tell the cache functionality which types of directories
  should be cached.

- Also introduce a 'void clear_lstat_cache(void)' function, which
  should be used to clean the cache before usage.  If for instance,
  you have changed the types of directories which should be cached,
  the cache could contain a path which was not wanted.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
:100644 100644 aabf013... 7449b10... M	Makefile
:100644 100644 231c06d... 9adc4a2... M	cache.h
:000000 100644 0000000... 2f025c8... A	lstat_cache.c
 Makefile      |    1 +
 cache.h       |   15 +++++++++
 lstat_cache.c |   99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 lstat_cache.c

diff --git a/Makefile b/Makefile
index aabf0130b99bee5204c8e668ba8f40caea77dae2..7449b105b03e862d53244d50ed035b4ddabef028 100644
--- a/Makefile
+++ b/Makefile
@@ -446,6 +446,7 @@ LIB_OBJS += list-objects.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
+LIB_OBJS += lstat_cache.o
 LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge-file.o
diff --git a/cache.h b/cache.h
index 231c06d7726b575f6e522d5b0c0fe43557e8c651..9adc4a224648bb17a50e6792274225eeb6144451 100644
--- a/cache.h
+++ b/cache.h
@@ -721,6 +721,21 @@ struct checkout {
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
 extern int has_symlink_leading_path(int len, const char *name);
 
+#define LSTAT_DIR       (1u << 0)
+#define LSTAT_NOENT     (1u << 1)
+#define LSTAT_SYMLINK   (1u << 2)
+#define LSTAT_LSTATERR  (1u << 3)
+#define LSTAT_ERR       (1u << 4)
+extern unsigned int check_lstat_cache(int len, const char *name,
+				      unsigned int track_flags);
+static inline unsigned int lstat_cache(int len, const char *name,
+				       unsigned int track_flags,
+				       unsigned int mask_flags)
+{
+	return check_lstat_cache(len, name, track_flags) & mask_flags;
+}
+extern void clear_lstat_cache(void);
+
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
 	char *name;
diff --git a/lstat_cache.c b/lstat_cache.c
new file mode 100644
index 0000000000000000000000000000000000000000..2f025c87b0be0e713af7b1400e71284a22c25e9f
--- /dev/null
+++ b/lstat_cache.c
@@ -0,0 +1,99 @@
+#include "cache.h"
+
+static char         cache_path[PATH_MAX];
+static int          cache_len   = 0;
+static unsigned int cache_flags = 0;
+
+static inline int
+greatest_common_path_cache_prefix(int len, const char *name)
+{
+	int max_len, match_len = 0, i = 0;
+
+	max_len = len < cache_len ? len : cache_len;
+	while (i < max_len && name[i] == cache_path[i]) {
+		if (name[i] == '/') match_len = i;
+		i++;
+	}
+	if (i == cache_len && len > cache_len && name[cache_len] == '/')
+		match_len = cache_len;
+	return match_len;
+}
+
+/*
+ * Check if name 'name' of length 'len' has a symlink leading
+ * component, or if the directory exists and is real, or not.
+ *
+ * To speed up the check, some information is allowed to be cached.
+ * This is indicated by the 'track_flags' argument.
+ */
+unsigned int
+check_lstat_cache(int len, const char *name, unsigned int track_flags)
+{
+	int match_len, last_slash, max_len;
+	unsigned int match_flags, ret_flags, save_flags;
+	struct stat st;
+
+	/* Check if match from the cache for 2 "excluding" path types.
+	 */
+	match_len = last_slash =
+		greatest_common_path_cache_prefix(len, name);
+	match_flags =
+		cache_flags & track_flags & (LSTAT_NOENT|LSTAT_SYMLINK);
+	if (match_flags && match_len == cache_len)
+		return match_flags;
+
+	/* Okay, no match from the cache so far, so now we have to
+	 * check the rest of the path components.
+	 */
+	ret_flags = LSTAT_DIR;
+	max_len = len < PATH_MAX ? len : PATH_MAX;
+	while (match_len < max_len) {
+		do {
+			cache_path[match_len] = name[match_len];
+			match_len++;
+		} while (match_len < max_len && name[match_len] != '/');
+		if (match_len >= max_len)
+			break;
+		last_slash = match_len;
+		cache_path[last_slash] = '\0';
+
+		if (lstat(cache_path, &st)) {
+			ret_flags = LSTAT_LSTATERR;
+			if (errno == ENOENT)
+				ret_flags |= LSTAT_NOENT;
+		} else if (S_ISDIR(st.st_mode)) {
+			continue;
+		} else if (S_ISLNK(st.st_mode)) {
+			ret_flags = LSTAT_SYMLINK;
+		} else {
+			ret_flags = LSTAT_ERR;
+		}
+		break;
+	}
+
+	/* At the end update the cache.  Note that max 3 different
+	 * path types can be cached for the moment!
+	 */
+	save_flags = ret_flags & track_flags &
+		(LSTAT_NOENT|LSTAT_SYMLINK|LSTAT_DIR);
+	if (save_flags && last_slash > 0 && last_slash < PATH_MAX) {
+		cache_path[last_slash] = '\0';
+		cache_len   = last_slash;
+		cache_flags = save_flags;
+	} else {
+		clear_lstat_cache();
+	}
+	return ret_flags;
+}
+
+/*
+ * Before usage of the check_lstat_cache() function one should call
+ * clear_lstat_cache() (at an appropriate place) to make sure that the
+ * cache is clean.
+ */
+void clear_lstat_cache(void)
+{
+	cache_path[0] = '\0';
+	cache_len     = 0;
+	cache_flags   = 0;
+}
-- 
1.6.1.rc1.49.g7f705
