From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH v4 2/9] lstat_cache(): generalise longest_match_lstat_cache()
Date: Mon, 09 Feb 2009 21:54:05 +0100
Message-ID: <a660c05cd92cd87d7fb08a884b2e5450b34eee45.1234211595.git.barvik@broadpark.no>
References: <cover.1234211594.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 21:55:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdAS-0002Ax-3u
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 21:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbZBIUyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 15:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752919AbZBIUyV
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 15:54:21 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:36097 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbZBIUyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 15:54:18 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KET00IDWGQHPR80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 21:54:17 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.166])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KET007FSGQC8090@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 21:54:17 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1234211594.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109122>

Rename the function to longst_path_match() and generalise it such that
it can also be used by other functions.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 symlinks.c |   46 ++++++++++++++++++++++++----------------------
 1 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index ae57e56..4596aee 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,38 +1,30 @@
 #include "cache.h"
 
-static struct cache_def {
-	char path[PATH_MAX + 1];
-	int len;
-	int flags;
-	int track_flags;
-	int prefix_len_stat_func;
-} cache;
-
 /*
  * Returns the length (on a path component basis) of the longest
- * common prefix match of 'name' and the cached path string.
+ * common prefix match of 'name_a' and 'name_b'.
  */
-static inline int longest_match_lstat_cache(int len, const char *name,
-					    int *previous_slash)
+static int longest_path_match(const char *name_a, int len_a,
+			      const char *name_b, int len_b,
+			      int *previous_slash)
 {
 	int max_len, match_len = 0, match_len_prev = 0, i = 0;
 
-	max_len = len < cache.len ? len : cache.len;
-	while (i < max_len && name[i] == cache.path[i]) {
-		if (name[i] == '/') {
+	max_len = len_a < len_b ? len_a : len_b;
+	while (i < max_len && name_a[i] == name_b[i]) {
+		if (name_a[i] == '/') {
 			match_len_prev = match_len;
 			match_len = i;
 		}
 		i++;
 	}
 	/*
-	 * Is the cached path string a substring of 'name', is 'name'
-	 * a substring of the cached path string, or is 'name' and the
-	 * cached path string the exact same string?
+	 * Is 'name_b' a substring of 'name_a', the other way around,
+	 * or is 'name_a' and 'name_b' the exact same string?
 	 */
-	if (i >= max_len && ((len > cache.len && name[cache.len] == '/') ||
-			     (len < cache.len && cache.path[len] == '/') ||
-			     (len == cache.len))) {
+	if (i >= max_len && ((len_a > len_b && name_a[len_b] == '/') ||
+			     (len_a < len_b && name_b[len_a] == '/') ||
+			     (len_a == len_b))) {
 		match_len_prev = match_len;
 		match_len = i;
 	}
@@ -40,6 +32,14 @@ static inline int longest_match_lstat_cache(int len, const char *name,
 	return match_len;
 }
 
+static struct cache_def {
+	char path[PATH_MAX + 1];
+	int len;
+	int flags;
+	int track_flags;
+	int prefix_len_stat_func;
+} cache;
+
 static inline void reset_lstat_cache(void)
 {
 	cache.path[0] = '\0';
@@ -94,7 +94,8 @@ static int lstat_cache(int len, const char *name,
 		 * the 2 "excluding" path types.
 		 */
 		match_len = last_slash =
-			longest_match_lstat_cache(len, name, &previous_slash);
+			longest_path_match(name, len, cache.path, cache.len,
+					   &previous_slash);
 		match_flags = cache.flags & track_flags & (FL_NOENT|FL_SYMLINK);
 		if (match_flags && match_len == cache.len)
 			return match_flags;
@@ -188,7 +189,8 @@ void invalidate_lstat_cache(int len, const char *name)
 {
 	int match_len, previous_slash;
 
-	match_len = longest_match_lstat_cache(len, name, &previous_slash);
+	match_len = longest_path_match(name, len, cache.path, cache.len,
+				       &previous_slash);
 	if (len == match_len) {
 		if ((cache.track_flags & FL_DIR) && previous_slash > 0) {
 			cache.path[previous_slash] = '\0';
-- 
1.6.1.349.g99fa5
