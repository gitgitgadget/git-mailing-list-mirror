From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH v10 1/5] lstat_cache(): more cache effective symlink/directory
 detection
Date: Sun, 18 Jan 2009 16:14:50 +0100
Message-ID: <1232291694-18083-2-git-send-email-barvik@broadpark.no>
References: <1232291694-18083-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 18 16:16:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZO4-00067Y-5q
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763542AbZARPPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763333AbZARPPB
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:15:01 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:56567 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762419AbZARPPA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:15:00 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDO00A8GACYIU70@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 18 Jan 2009 16:14:58 +0100 (CET)
Received: from localhost.localdomain ([80.203.29.59])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KDO00BSIACUNG70@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 18 Jan 2009 16:14:58 +0100 (CET)
X-Mailer: git-send-email 1.6.1.83.gd727f
In-reply-to: <1232291694-18083-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106218>

Make the cache functionality more effective.  Previously when A/B/C/D
was in the cache and A/B/C/E/file.c was called for, there was no match
at all from the cache.  Now we use the fact that the paths "A", "A/B"
and "A/B/C" are already tested, and we only need to do an lstat() call
on "A/B/C/E".

We only cache/store the last path regardless of its type.  Since the
cache functionality is always used with alphabetically sorted names
(at least it seems so for me), there is no need to store both the last
symlink-leading path and the last real-directory path.  Note that if
the cache is not called with (mostly) alphabetically sorted names,
neither the old, nor this new one, would be very effective.

Previously, when symlink A/B/C/S was cached/stored in the symlink-
leading path, and A/B/C/file.c was called for, it was not easy to use
the fact that we already knew that the paths "A", "A/B" and "A/B/C"
are real directories.

Avoid copying the first path components of the name 2 zillion times
when we test new path components.  Since we always cache/store the
last path, we can copy each component as we test those directly into
the cache.  Previously we ended up doing a memcpy() for the full
path/name right before each lstat() call, and when updating the cache
for each time we have tested a new path component.

We also use less memory, that is, PATH_MAX bytes less memory on the
stack and PATH_MAX bytes less memory on the heap.

Thanks to Junio C Hamano, Linus Torvalds and Rene Scharfe for valuable
comments to this patch!

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 symlinks.c |  165 +++++++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 125 insertions(+), 40 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 5a5e781..49fb4d8 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,64 +1,149 @@
 #include "cache.h"
 
-struct pathname {
-	int len;
+static struct cache_def {
 	char path[PATH_MAX];
-};
+	int len;
+	int flags;
+} cache;
 
-/* Return matching pathname prefix length, or zero if not matching */
-static inline int match_pathname(int len, const char *name, struct pathname *match)
+/*
+ * Returns the length (on a path component basis) of the longest
+ * common prefix match of 'name' and the cached path string.
+ */
+static inline int longest_match_lstat_cache(int len, const char *name)
 {
-	int match_len = match->len;
-	return (len > match_len &&
-		name[match_len] == '/' &&
-		!memcmp(name, match->path, match_len)) ? match_len : 0;
+	int max_len, match_len = 0, i = 0;
+
+	max_len = len < cache.len ? len : cache.len;
+	while (i < max_len && name[i] == cache.path[i]) {
+		if (name[i] == '/')
+			match_len = i;
+		i++;
+	}
+	/* Is the cached path string a substring of 'name'? */
+	if (i == cache.len && cache.len < len && name[cache.len] == '/')
+		match_len = cache.len;
+	/* Is 'name' a substring of the cached path string? */
+	else if ((i == len && len < cache.len && cache.path[len] == '/') ||
+		 (i == len && len == cache.len))
+		match_len = len;
+	return match_len;
 }
 
-static inline void set_pathname(int len, const char *name, struct pathname *match)
+static inline void reset_lstat_cache(void)
 {
-	if (len < PATH_MAX) {
-		match->len = len;
-		memcpy(match->path, name, len);
-		match->path[len] = 0;
-	}
+	cache.path[0] = '\0';
+	cache.len = 0;
+	cache.flags = 0;
 }
 
-int has_symlink_leading_path(int len, const char *name)
+#define FL_DIR      (1 << 0)
+#define FL_SYMLINK  (1 << 1)
+#define FL_LSTATERR (1 << 2)
+#define FL_ERR      (1 << 3)
+
+/*
+ * Check if name 'name' of length 'len' has a symlink leading
+ * component, or if the directory exists and is real.
+ *
+ * To speed up the check, some information is allowed to be cached.
+ * This can be indicated by the 'track_flags' argument.
+ */
+static int lstat_cache(int len, const char *name,
+		       int track_flags)
 {
-	static struct pathname link, nonlink;
-	char path[PATH_MAX];
+	int match_len, last_slash, last_slash_dir;
+	int match_flags, ret_flags, save_flags, max_len;
 	struct stat st;
-	char *sp;
-	int known_dir;
 
 	/*
-	 * See if the last known symlink cache matches.
+	 * Check to see if we have a match from the cache for the
+	 * symlink path type.
 	 */
-	if (match_pathname(len, name, &link))
-		return 1;
-
+	match_len = last_slash = longest_match_lstat_cache(len, name);
+	match_flags = cache.flags & track_flags & FL_SYMLINK;
+	if (match_flags && match_len == cache.len)
+		return match_flags;
 	/*
-	 * Get rid of the last known directory part
+	 * If we now have match_len > 0, we would know that the
+	 * matched part will always be a directory.
+	 *
+	 * Also, if we are tracking directories and 'name' is a
+	 * substring of the cache on a path component basis, we can
+	 * return immediately.
 	 */
-	known_dir = match_pathname(len, name, &nonlink);
+	match_flags = track_flags & FL_DIR;
+	if (match_flags && len == match_len)
+		return match_flags;
 
-	while ((sp = strchr(name + known_dir + 1, '/')) != NULL) {
-		int thislen = sp - name ;
-		memcpy(path, name, thislen);
-		path[thislen] = 0;
+	/*
+	 * Okay, no match from the cache so far, so now we have to
+	 * check the rest of the path components.
+	 */
+	ret_flags = FL_DIR;
+	last_slash_dir = last_slash;
+	max_len = len < PATH_MAX ? len : PATH_MAX;
+	while (match_len < max_len) {
+		do {
+			cache.path[match_len] = name[match_len];
+			match_len++;
+		} while (match_len < max_len && name[match_len] != '/');
+		if (match_len >= max_len)
+			break;
+		last_slash = match_len;
+		cache.path[last_slash] = '\0';
 
-		if (lstat(path, &st))
-			return 0;
-		if (S_ISDIR(st.st_mode)) {
-			set_pathname(thislen, path, &nonlink);
-			known_dir = thislen;
+		if (lstat(cache.path, &st)) {
+			ret_flags = FL_LSTATERR;
+		} else if (S_ISDIR(st.st_mode)) {
+			last_slash_dir = last_slash;
 			continue;
-		}
-		if (S_ISLNK(st.st_mode)) {
-			set_pathname(thislen, path, &link);
-			return 1;
+		} else if (S_ISLNK(st.st_mode)) {
+			ret_flags = FL_SYMLINK;
+		} else {
+			ret_flags = FL_ERR;
 		}
 		break;
 	}
-	return 0;
+
+	/*
+	 * At the end update the cache.  Note that max 2 different
+	 * path types, FL_SYMLINK and FL_DIR, can be cached for the
+	 * moment!
+	 */
+	save_flags = ret_flags & track_flags & FL_SYMLINK;
+	if (save_flags && last_slash > 0 && last_slash < PATH_MAX) {
+		cache.path[last_slash] = '\0';
+		cache.len = last_slash;
+		cache.flags = save_flags;
+	} else if (track_flags & FL_DIR &&
+		   last_slash_dir > 0 && last_slash_dir < PATH_MAX) {
+		/*
+		 * We have a separate test for the directory case,
+		 * since it could be that we have found a symlink and
+		 * the track_flags says that we cannot cache this
+		 * fact, so the cache would then have been left empty
+		 * in this case.
+		 *
+		 * But if we are allowed to track real directories, we
+		 * can still cache the path components before the last
+		 * one (the found symlink component).
+		 */
+		cache.path[last_slash_dir] = '\0';
+		cache.len = last_slash_dir;
+		cache.flags = FL_DIR;
+	} else {
+		reset_lstat_cache();
+	}
+	return ret_flags;
+}
+
+/*
+ * Return non-zero if path 'name' has a leading symlink component
+ */
+int has_symlink_leading_path(int len, const char *name)
+{
+	return lstat_cache(len, name,
+			   FL_SYMLINK|FL_DIR) &
+		FL_SYMLINK;
 }
-- 
1.6.1.83.gd727f
