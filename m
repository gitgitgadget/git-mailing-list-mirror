From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v1 6/6] lstat_cache(): print a warning if doing ping-pong
 between cache types
Date: Mon, 26 Jan 2009 22:18:42 +0100
Message-ID: <1233004722-15142-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 22:20:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYsN-0000wO-PY
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 22:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbZAZVSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 16:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbZAZVSq
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 16:18:46 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:62297 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbZAZVSp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 16:18:45 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KE3003WMKJ8XC90@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 26 Jan 2009 22:18:44 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.144])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KE3009YBKJ62S70@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 26 Jan 2009 22:18:44 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107286>

This is a debug patch which is only to be used while the lstat_cache()
is in the test stage, and should be removed/reverted before the final
relase.

I think it should be useful to catch these warnings, as I it could be
an indication of that the cache would not be very effective if it is
doing ping-pong by switching between different cache types too many
times.

Also, if someone is experimenting with the lstat_cache(), this patch
will maybe be useful while debugging.

If someone is able to trigger the warning, then send a mail to the GIT
mailing list, containing the first 15 lines of the warning, and a
short description of the GIT commands to trigger the warnings.

This patch is against the 'next' branch.  I hope someone is willing to
use this patch for a while, to be able to catch possible ping-pong's.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---

Hmmm, it seems that 'git send-email' always fails for this mail, with
the following error message:

   Died at /usr/local/libexec/git-core/git-send-email line 882.

So I send this as a separate command from 'git send-email', sorry
abouth that.


 symlinks.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 81f490c..1c07ae0 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -49,6 +49,11 @@ static inline void reset_lstat_cache(int track_flags, int prefix_len_stat_func)
 	cache.prefix_len_stat_func = prefix_len_stat_func;
 }
 
+#define SWITCHES_BEFORE_WARNING 10
+static unsigned int cache_switches = 0, number_of_warnings = 0;
+static unsigned int current_cache_func = 0, last_cache_func = 0;
+static unsigned int total_calls = 0;
+
 #define FL_DIR      (1 << 0)
 #define FL_NOENT    (1 << 1)
 #define FL_SYMLINK  (1 << 2)
@@ -75,6 +80,7 @@ static int lstat_cache(int len, const char *name,
 	int match_flags, ret_flags, save_flags, max_len, ret;
 	struct stat st;
 
+	total_calls++;
 	if (cache.track_flags != track_flags ||
 	    cache.prefix_len_stat_func != prefix_len_stat_func) {
 		/*
@@ -84,6 +90,17 @@ static int lstat_cache(int len, const char *name,
 		 */
 		reset_lstat_cache(track_flags, prefix_len_stat_func);
 		match_len = last_slash = 0;
+		cache_switches++;
+		if (cache_switches > SWITCHES_BEFORE_WARNING) {
+			if (number_of_warnings < 10 || number_of_warnings % 1000 == 0)
+				printf("warning from %s:%d cache_switches:%u > %u "\
+				       "(current:%u last:%u total:%u)\n",
+				       __FILE__, __LINE__,
+				       cache_switches, SWITCHES_BEFORE_WARNING,
+				       current_cache_func, last_cache_func,
+				       total_calls);
+			number_of_warnings++;
+		}
 	} else {
 		/*
 		 * Check to see if we have a match from the cache for
@@ -211,6 +228,8 @@ void clear_lstat_cache(void)
  */
 int has_symlink_leading_path(int len, const char *name)
 {
+	last_cache_func = current_cache_func;
+	current_cache_func = 1;
 	return lstat_cache(len, name,
 			   FL_SYMLINK|FL_DIR, USE_ONLY_LSTAT) &
 		FL_SYMLINK;
@@ -222,6 +241,8 @@ int has_symlink_leading_path(int len, const char *name)
  */
 int has_symlink_or_noent_leading_path(int len, const char *name)
 {
+	last_cache_func = current_cache_func;
+	current_cache_func = 2;
 	return lstat_cache(len, name,
 			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT) &
 		(FL_SYMLINK|FL_NOENT);
@@ -236,6 +257,8 @@ int has_symlink_or_noent_leading_path(int len, const char *name)
  */
 int has_dirs_only_path(int len, const char *name, int prefix_len)
 {
+	last_cache_func = current_cache_func;
+	current_cache_func = 3;
 	return lstat_cache(len, name,
 			   FL_DIR|FL_FULLPATH, prefix_len) &
 		FL_DIR;
-- 
1.6.1.349.g99fa5
