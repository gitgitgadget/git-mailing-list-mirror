From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v2 4/4] remove the old 'has_symlink_leading_path()' function
Date: Tue, 06 Jan 2009 21:36:32 +0100
Message-ID: <1231274192-30478-5-git-send-email-barvik@broadpark.no>
References: <1231274192-30478-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 21:38:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKIh6-0001PD-O6
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 21:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbZAFUgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 15:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbZAFUgr
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 15:36:47 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:55282 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbZAFUgm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 15:36:42 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KD200B8MH95GN20@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 06 Jan 2009 21:36:41 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.60])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KD200CL4H8WWS00@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 06 Jan 2009 21:36:41 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.49.g7f705
In-reply-to: <1231274192-30478-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104722>

It has been replaced by the more cache effective 'lstat_cache()'
function.  see lstat_cache.c

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
:100644 100644 7449b10... edd4798... M	Makefile
:100644 100644 4c56f3f... 8b8da85... M	cache.h
:100644 000000 5a5e781... 0000000... D	symlinks.c
 Makefile   |    1 -
 cache.h    |    1 -
 symlinks.c |   64 ------------------------------------------------------------
 3 files changed, 0 insertions(+), 66 deletions(-)
 delete mode 100644 symlinks.c

diff --git a/Makefile b/Makefile
index 7449b105b03e862d53244d50ed035b4ddabef028..edd4798429ad3828f5b9dcff20f73c6a7269520e 100644
--- a/Makefile
+++ b/Makefile
@@ -483,7 +483,6 @@ LIB_OBJS += sha1_name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += strbuf.o
-LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
 LIB_OBJS += transport.o
diff --git a/cache.h b/cache.h
index 4c56f3faa0b87398e27346358e40af964a1828bb..8b8da85f32600050dddfcdf6b0c0e6ecb8f27072 100644
--- a/cache.h
+++ b/cache.h
@@ -720,7 +720,6 @@ struct checkout {
 
 extern void clear_created_dirs_cache(void);
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
-extern int has_symlink_leading_path(int len, const char *name);
 
 #define LSTAT_DIR       (1u << 0)
 #define LSTAT_NOENT     (1u << 1)
diff --git a/symlinks.c b/symlinks.c
deleted file mode 100644
index 5a5e781a15d7d9cb60797958433eca896b31ec85..0000000000000000000000000000000000000000
--- a/symlinks.c
+++ /dev/null
@@ -1,64 +0,0 @@
-#include "cache.h"
-
-struct pathname {
-	int len;
-	char path[PATH_MAX];
-};
-
-/* Return matching pathname prefix length, or zero if not matching */
-static inline int match_pathname(int len, const char *name, struct pathname *match)
-{
-	int match_len = match->len;
-	return (len > match_len &&
-		name[match_len] == '/' &&
-		!memcmp(name, match->path, match_len)) ? match_len : 0;
-}
-
-static inline void set_pathname(int len, const char *name, struct pathname *match)
-{
-	if (len < PATH_MAX) {
-		match->len = len;
-		memcpy(match->path, name, len);
-		match->path[len] = 0;
-	}
-}
-
-int has_symlink_leading_path(int len, const char *name)
-{
-	static struct pathname link, nonlink;
-	char path[PATH_MAX];
-	struct stat st;
-	char *sp;
-	int known_dir;
-
-	/*
-	 * See if the last known symlink cache matches.
-	 */
-	if (match_pathname(len, name, &link))
-		return 1;
-
-	/*
-	 * Get rid of the last known directory part
-	 */
-	known_dir = match_pathname(len, name, &nonlink);
-
-	while ((sp = strchr(name + known_dir + 1, '/')) != NULL) {
-		int thislen = sp - name ;
-		memcpy(path, name, thislen);
-		path[thislen] = 0;
-
-		if (lstat(path, &st))
-			return 0;
-		if (S_ISDIR(st.st_mode)) {
-			set_pathname(thislen, path, &nonlink);
-			known_dir = thislen;
-			continue;
-		}
-		if (S_ISLNK(st.st_mode)) {
-			set_pathname(thislen, path, &link);
-			return 1;
-		}
-		break;
-	}
-	return 0;
-}
-- 
1.6.1.rc1.49.g7f705
