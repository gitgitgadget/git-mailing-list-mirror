From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH v4 9/9] lstat_cache(): print a warning if doing ping-pong
 between cache types
Date: Mon, 09 Feb 2009 21:54:53 +0100
Message-ID: <82c70ec625052b93dae3f7b24a79fe058257f494.1234211595.git.barvik@broadpark.no>
References: <cover.1234211594.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 21:57:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdBP-0002aa-Bp
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 21:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbZBIUzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 15:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbZBIUzF
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 15:55:05 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:36121 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbZBIUzA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 15:55:00 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KET00IFQGRLPR80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 21:54:57 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.166])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KET007G9GRH8090@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 21:54:57 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1234211594.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109128>

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

I hope someone is willing to use this patch for a while, to be able to
catch possible ping-pong's.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 symlinks.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 1d6b35b..cb255a3 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -51,6 +51,11 @@ static inline void reset_lstat_cache(void)
 	 */
 }
 
+#define SWITCHES_BEFORE_WARNING 10
+static unsigned int cache_switches, number_of_warnings;
+static unsigned int current_cache_func, last_cache_func;
+static unsigned int total_calls;
+
 #define FL_DIR      (1 << 0)
 #define FL_NOENT    (1 << 1)
 #define FL_SYMLINK  (1 << 2)
@@ -77,6 +82,7 @@ static int lstat_cache(const char *name, int len,
 	int match_flags, ret_flags, save_flags, max_len, ret;
 	struct stat st;
 
+	total_calls++;
 	if (cache.track_flags != track_flags ||
 	    cache.prefix_len_stat_func != prefix_len_stat_func) {
 		/*
@@ -88,6 +94,17 @@ static int lstat_cache(const char *name, int len,
 		cache.track_flags = track_flags;
 		cache.prefix_len_stat_func = prefix_len_stat_func;
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
@@ -216,6 +233,8 @@ void clear_lstat_cache(void)
  */
 int has_symlink_leading_path(const char *name, int len)
 {
+	last_cache_func = current_cache_func;
+	current_cache_func = 1;
 	return lstat_cache(name, len,
 			   FL_SYMLINK|FL_DIR, USE_ONLY_LSTAT) &
 		FL_SYMLINK;
@@ -227,6 +246,8 @@ int has_symlink_leading_path(const char *name, int len)
  */
 int has_symlink_or_noent_leading_path(const char *name, int len)
 {
+	last_cache_func = current_cache_func;
+	current_cache_func = 2;
 	return lstat_cache(name, len,
 			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT) &
 		(FL_SYMLINK|FL_NOENT);
@@ -241,6 +262,8 @@ int has_symlink_or_noent_leading_path(const char *name, int len)
  */
 int has_dirs_only_path(const char *name, int len, int prefix_len)
 {
+	last_cache_func = current_cache_func;
+	current_cache_func = 3;
 	return lstat_cache(name, len,
 			   FL_DIR|FL_FULLPATH, prefix_len) &
 		FL_DIR;
-- 
1.6.1.349.g99fa5
