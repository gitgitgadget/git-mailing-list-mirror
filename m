From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5/3] Prepare symlink caching for thread-safety
Date: Thu, 9 Jul 2009 13:47:01 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907091344530.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain> <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain> <7vab3d3dpc.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907091153130.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 22:47:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP0X3-0007DN-Fi
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 22:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460AbZGIUrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 16:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754216AbZGIUrp
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 16:47:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55818 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753653AbZGIUro (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 16:47:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69Kl2Ej017890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jul 2009 13:47:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69Kl1Ef009409;
	Thu, 9 Jul 2009 13:47:01 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123006>



From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Jul 2009 13:23:59 -0700
Subject: [PATCH 5/3] Prepare symlink caching for thread-safety

This doesn't actually change the external interfaces, so they are still
thread-unsafe, but it makes the code internally pass a pointer to a
local 'struct cache_def' around, so that the core code can be made
thread-safe.

The threaded index preloading will want to verify that the paths leading
up to a pathname are all real directories.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

No real changes, but I renamed the static 'cache' data structure 
'default_cache', and made all the internal functions take a pointer 
instead of using the static version.

The functions with external linkage are left semantically unchanged by 
just making them do a simple

	struct cache_def *cache = &default_cache;

and then using that.

 symlinks.c |   75 ++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 8dcd632..08ad353 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -38,13 +38,13 @@ static struct cache_def {
 	int flags;
 	int track_flags;
 	int prefix_len_stat_func;
-} cache;
+} default_cache;
 
-static inline void reset_lstat_cache(void)
+static inline void reset_lstat_cache(struct cache_def *cache)
 {
-	cache.path[0] = '\0';
-	cache.len = 0;
-	cache.flags = 0;
+	cache->path[0] = '\0';
+	cache->len = 0;
+	cache->flags = 0;
 	/*
 	 * The track_flags and prefix_len_stat_func members is only
 	 * set by the safeguard rule inside lstat_cache()
@@ -70,23 +70,23 @@ static inline void reset_lstat_cache(void)
  * of the prefix, where the cache should use the stat() function
  * instead of the lstat() function to test each path component.
  */
-static int lstat_cache(const char *name, int len,
+static int lstat_cache(struct cache_def *cache, const char *name, int len,
 		       int track_flags, int prefix_len_stat_func)
 {
 	int match_len, last_slash, last_slash_dir, previous_slash;
 	int match_flags, ret_flags, save_flags, max_len, ret;
 	struct stat st;
 
-	if (cache.track_flags != track_flags ||
-	    cache.prefix_len_stat_func != prefix_len_stat_func) {
+	if (cache->track_flags != track_flags ||
+	    cache->prefix_len_stat_func != prefix_len_stat_func) {
 		/*
 		 * As a safeguard rule we clear the cache if the
 		 * values of track_flags and/or prefix_len_stat_func
 		 * does not match with the last supplied values.
 		 */
-		reset_lstat_cache();
-		cache.track_flags = track_flags;
-		cache.prefix_len_stat_func = prefix_len_stat_func;
+		reset_lstat_cache(cache);
+		cache->track_flags = track_flags;
+		cache->prefix_len_stat_func = prefix_len_stat_func;
 		match_len = last_slash = 0;
 	} else {
 		/*
@@ -94,10 +94,10 @@ static int lstat_cache(const char *name, int len,
 		 * the 2 "excluding" path types.
 		 */
 		match_len = last_slash =
-			longest_path_match(name, len, cache.path, cache.len,
+			longest_path_match(name, len, cache->path, cache->len,
 					   &previous_slash);
-		match_flags = cache.flags & track_flags & (FL_NOENT|FL_SYMLINK);
-		if (match_flags && match_len == cache.len)
+		match_flags = cache->flags & track_flags & (FL_NOENT|FL_SYMLINK);
+		if (match_flags && match_len == cache->len)
 			return match_flags;
 		/*
 		 * If we now have match_len > 0, we would know that
@@ -121,18 +121,18 @@ static int lstat_cache(const char *name, int len,
 	max_len = len < PATH_MAX ? len : PATH_MAX;
 	while (match_len < max_len) {
 		do {
-			cache.path[match_len] = name[match_len];
+			cache->path[match_len] = name[match_len];
 			match_len++;
 		} while (match_len < max_len && name[match_len] != '/');
 		if (match_len >= max_len && !(track_flags & FL_FULLPATH))
 			break;
 		last_slash = match_len;
-		cache.path[last_slash] = '\0';
+		cache->path[last_slash] = '\0';
 
 		if (last_slash <= prefix_len_stat_func)
-			ret = stat(cache.path, &st);
+			ret = stat(cache->path, &st);
 		else
-			ret = lstat(cache.path, &st);
+			ret = lstat(cache->path, &st);
 
 		if (ret) {
 			ret_flags = FL_LSTATERR;
@@ -156,9 +156,9 @@ static int lstat_cache(const char *name, int len,
 	 */
 	save_flags = ret_flags & track_flags & (FL_NOENT|FL_SYMLINK);
 	if (save_flags && last_slash > 0 && last_slash <= PATH_MAX) {
-		cache.path[last_slash] = '\0';
-		cache.len = last_slash;
-		cache.flags = save_flags;
+		cache->path[last_slash] = '\0';
+		cache->len = last_slash;
+		cache->flags = save_flags;
 	} else if ((track_flags & FL_DIR) &&
 		   last_slash_dir > 0 && last_slash_dir <= PATH_MAX) {
 		/*
@@ -172,11 +172,11 @@ static int lstat_cache(const char *name, int len,
 		 * can still cache the path components before the last
 		 * one (the found symlink or non-existing component).
 		 */
-		cache.path[last_slash_dir] = '\0';
-		cache.len = last_slash_dir;
-		cache.flags = FL_DIR;
+		cache->path[last_slash_dir] = '\0';
+		cache->len = last_slash_dir;
+		cache->flags = FL_DIR;
 	} else {
-		reset_lstat_cache();
+		reset_lstat_cache(cache);
 	}
 	return ret_flags;
 }
@@ -188,16 +188,17 @@ static int lstat_cache(const char *name, int len,
 void invalidate_lstat_cache(const char *name, int len)
 {
 	int match_len, previous_slash;
+	struct cache_def *cache = &default_cache;	/* FIXME */
 
-	match_len = longest_path_match(name, len, cache.path, cache.len,
+	match_len = longest_path_match(name, len, cache->path, cache->len,
 				       &previous_slash);
 	if (len == match_len) {
-		if ((cache.track_flags & FL_DIR) && previous_slash > 0) {
-			cache.path[previous_slash] = '\0';
-			cache.len = previous_slash;
-			cache.flags = FL_DIR;
+		if ((cache->track_flags & FL_DIR) && previous_slash > 0) {
+			cache->path[previous_slash] = '\0';
+			cache->len = previous_slash;
+			cache->flags = FL_DIR;
 		} else {
-			reset_lstat_cache();
+			reset_lstat_cache(cache);
 		}
 	}
 }
@@ -207,7 +208,8 @@ void invalidate_lstat_cache(const char *name, int len)
  */
 void clear_lstat_cache(void)
 {
-	reset_lstat_cache();
+	struct cache_def *cache = &default_cache;	/* FIXME */
+	reset_lstat_cache(cache);
 }
 
 #define USE_ONLY_LSTAT  0
@@ -217,7 +219,8 @@ void clear_lstat_cache(void)
  */
 int has_symlink_leading_path(const char *name, int len)
 {
-	return lstat_cache(name, len,
+	struct cache_def *cache = &default_cache;	/* FIXME */
+	return lstat_cache(cache, name, len,
 			   FL_SYMLINK|FL_DIR, USE_ONLY_LSTAT) &
 		FL_SYMLINK;
 }
@@ -228,7 +231,8 @@ int has_symlink_leading_path(const char *name, int len)
  */
 int has_symlink_or_noent_leading_path(const char *name, int len)
 {
-	return lstat_cache(name, len,
+	struct cache_def *cache = &default_cache;	/* FIXME */
+	return lstat_cache(cache, name, len,
 			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT) &
 		(FL_SYMLINK|FL_NOENT);
 }
@@ -242,7 +246,8 @@ int has_symlink_or_noent_leading_path(const char *name, int len)
  */
 int has_dirs_only_path(const char *name, int len, int prefix_len)
 {
-	return lstat_cache(name, len,
+	struct cache_def *cache = &default_cache;	/* FIXME */
+	return lstat_cache(cache, name, len,
 			   FL_DIR|FL_FULLPATH, prefix_len) &
 		FL_DIR;
 }
-- 
1.6.3.3.415.ga8877
