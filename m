From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH] Revert
 "lstat_cache(): print a warning if doing ping-pong between cache types"
Date: Tue, 17 Mar 2009 19:20:29 +0100
Message-ID: <1237314029-30782-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 19:22:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljdvo-0004z9-RV
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 19:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070AbZCQSUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 14:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755891AbZCQSUh
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 14:20:37 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:54352 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819AbZCQSUh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 14:20:37 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGN00AKOXMAUR20@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 17 Mar 2009 19:20:34 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.137])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KGN00A7RXM64U20@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 17 Mar 2009 19:20:34 +0100 (CET)
X-Mailer: git-send-email 1.6.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113513>

This reverts commit 7734f04873cfaddd0b148074a633f1f824fd961f.

I guess that the revert commit, 7734f048, has been in test long
enough, and should now be reverted.  I have not received any info
regarding any debug output of the reverted commit, so lets hope that
the lstat_cache() function do not cause any ping-pong.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---

  Junio, I do not know what type of people who use, test and play
  around with the master branch, but I guess that not all of them
  expect to get a debug output from the program.  

  So, therefore, I have made this revert now, but you can decide when
  it should be aplayed, now and right before the patch is merged into
  master or right before the next release, v1.6.3, is made.


 symlinks.c |   23 -----------------------
 1 files changed, 0 insertions(+), 23 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index cb255a3..1d6b35b 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -51,11 +51,6 @@ static inline void reset_lstat_cache(void)
 	 */
 }
 
-#define SWITCHES_BEFORE_WARNING 10
-static unsigned int cache_switches, number_of_warnings;
-static unsigned int current_cache_func, last_cache_func;
-static unsigned int total_calls;
-
 #define FL_DIR      (1 << 0)
 #define FL_NOENT    (1 << 1)
 #define FL_SYMLINK  (1 << 2)
@@ -82,7 +77,6 @@ static int lstat_cache(const char *name, int len,
 	int match_flags, ret_flags, save_flags, max_len, ret;
 	struct stat st;
 
-	total_calls++;
 	if (cache.track_flags != track_flags ||
 	    cache.prefix_len_stat_func != prefix_len_stat_func) {
 		/*
@@ -94,17 +88,6 @@ static int lstat_cache(const char *name, int len,
 		cache.track_flags = track_flags;
 		cache.prefix_len_stat_func = prefix_len_stat_func;
 		match_len = last_slash = 0;
-		cache_switches++;
-		if (cache_switches > SWITCHES_BEFORE_WARNING) {
-			if (number_of_warnings < 10 || number_of_warnings % 1000 == 0)
-				printf("warning from %s:%d cache_switches:%u > %u "\
-				       "(current:%u last:%u total:%u)\n",
-				       __FILE__, __LINE__,
-				       cache_switches, SWITCHES_BEFORE_WARNING,
-				       current_cache_func, last_cache_func,
-				       total_calls);
-			number_of_warnings++;
-		}
 	} else {
 		/*
 		 * Check to see if we have a match from the cache for
@@ -233,8 +216,6 @@ void clear_lstat_cache(void)
  */
 int has_symlink_leading_path(const char *name, int len)
 {
-	last_cache_func = current_cache_func;
-	current_cache_func = 1;
 	return lstat_cache(name, len,
 			   FL_SYMLINK|FL_DIR, USE_ONLY_LSTAT) &
 		FL_SYMLINK;
@@ -246,8 +227,6 @@ int has_symlink_leading_path(const char *name, int len)
  */
 int has_symlink_or_noent_leading_path(const char *name, int len)
 {
-	last_cache_func = current_cache_func;
-	current_cache_func = 2;
 	return lstat_cache(name, len,
 			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT) &
 		(FL_SYMLINK|FL_NOENT);
@@ -262,8 +241,6 @@ int has_symlink_or_noent_leading_path(const char *name, int len)
  */
 int has_dirs_only_path(const char *name, int len, int prefix_len)
 {
-	last_cache_func = current_cache_func;
-	current_cache_func = 3;
 	return lstat_cache(name, len,
 			   FL_DIR|FL_FULLPATH, prefix_len) &
 		FL_DIR;
-- 
1.6.2.GIT
