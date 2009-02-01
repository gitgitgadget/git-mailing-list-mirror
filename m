From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v2 1/7] symlinks.c: small cleanup and optimisation
Date: Sun, 01 Feb 2009 21:23:09 +0100
Message-ID: <8f32b315490bb0c48263a0be34b9ea4f9d6fbbbb.1233499703.git.barvik@broadpark.no>
References: <cover.1233499703.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 21:24:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTis8-0001kb-GL
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 21:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbZBAUXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 15:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752837AbZBAUXV
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 15:23:21 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:55724 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbZBAUXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 15:23:19 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEE00589LYTCP80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 01 Feb 2009 21:23:17 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.229])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KEE00JWOLYRG920@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 01 Feb 2009 21:23:17 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1233499703.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107993>

Simplify the if-else test in longest_match_lstat_cache() such that we
only have one simple if test.  Instead of testing for 'i == cache.len'
or 'i == len', we transform this to a common test for 'i == max_len'.

And to further optimise we use 'i >= max_len' instead of 'i ==
max_len', the reason is that it is now the exact opposite of one part
inside the while-loop termination expression 'i < max_len && name[i]
== cache.path[i]', and then the compiler can probably reuse a test
instruction from it.

We also throw away the arguments to reset_lstat_cache(), such that all
the safeguard logic inside lstat_cache() is handled at one place.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 symlinks.c |   44 ++++++++++++++++++++++++--------------------
 1 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index f262b7c..ae57e56 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -25,27 +25,30 @@ static inline int longest_match_lstat_cache(int len, const char *name,
 		}
 		i++;
 	}
-	/* Is the cached path string a substring of 'name'? */
-	if (i == cache.len && cache.len < len && name[cache.len] == '/') {
-		match_len_prev = match_len;
-		match_len = cache.len;
-	/* Is 'name' a substring of the cached path string? */
-	} else if ((i == len && len < cache.len && cache.path[len] == '/') ||
-		   (i == len && len == cache.len)) {
+	/*
+	 * Is the cached path string a substring of 'name', is 'name'
+	 * a substring of the cached path string, or is 'name' and the
+	 * cached path string the exact same string?
+	 */
+	if (i >= max_len && ((len > cache.len && name[cache.len] == '/') ||
+			     (len < cache.len && cache.path[len] == '/') ||
+			     (len == cache.len))) {
 		match_len_prev = match_len;
-		match_len = len;
+		match_len = i;
 	}
 	*previous_slash = match_len_prev;
 	return match_len;
 }
 
-static inline void reset_lstat_cache(int track_flags, int prefix_len_stat_func)
+static inline void reset_lstat_cache(void)
 {
 	cache.path[0] = '\0';
 	cache.len = 0;
 	cache.flags = 0;
-	cache.track_flags = track_flags;
-	cache.prefix_len_stat_func = prefix_len_stat_func;
+	/*
+	 * The track_flags and prefix_len_stat_func members is only
+	 * set by the safeguard rule inside lstat_cache()
+	 */
 }
 
 #define FL_DIR      (1 << 0)
@@ -77,11 +80,13 @@ static int lstat_cache(int len, const char *name,
 	if (cache.track_flags != track_flags ||
 	    cache.prefix_len_stat_func != prefix_len_stat_func) {
 		/*
-		 * As a safeguard we clear the cache if the values of
-		 * track_flags and/or prefix_len_stat_func does not
-		 * match with the last supplied values.
+		 * As a safeguard rule we clear the cache if the
+		 * values of track_flags and/or prefix_len_stat_func
+		 * does not match with the last supplied values.
 		 */
-		reset_lstat_cache(track_flags, prefix_len_stat_func);
+		reset_lstat_cache();
+		cache.track_flags = track_flags;
+		cache.prefix_len_stat_func = prefix_len_stat_func;
 		match_len = last_slash = 0;
 	} else {
 		/*
@@ -153,7 +158,7 @@ static int lstat_cache(int len, const char *name,
 		cache.path[last_slash] = '\0';
 		cache.len = last_slash;
 		cache.flags = save_flags;
-	} else if (track_flags & FL_DIR &&
+	} else if ((track_flags & FL_DIR) &&
 		   last_slash_dir > 0 && last_slash_dir <= PATH_MAX) {
 		/*
 		 * We have a separate test for the directory case,
@@ -170,7 +175,7 @@ static int lstat_cache(int len, const char *name,
 		cache.len = last_slash_dir;
 		cache.flags = FL_DIR;
 	} else {
-		reset_lstat_cache(track_flags, prefix_len_stat_func);
+		reset_lstat_cache();
 	}
 	return ret_flags;
 }
@@ -190,8 +195,7 @@ void invalidate_lstat_cache(int len, const char *name)
 			cache.len = previous_slash;
 			cache.flags = FL_DIR;
 		} else
-			reset_lstat_cache(cache.track_flags,
-					  cache.prefix_len_stat_func);
+			reset_lstat_cache();
 	}
 }
 
@@ -200,7 +204,7 @@ void invalidate_lstat_cache(int len, const char *name)
  */
 void clear_lstat_cache(void)
 {
-	reset_lstat_cache(0, 0);
+	reset_lstat_cache();
 }
 
 #define USE_ONLY_LSTAT  0
-- 
1.6.1.349.g99fa5
