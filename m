From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Do not change the file type if the filesystem does not support symlinks.
Date: Tue, 27 Feb 2007 22:41:38 +0100
Message-ID: <1172612504272-git-send-email-johannes.sixt@telecom.at>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at> <11726125033437-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 22:41:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMA57-0000yR-Hq
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 22:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbXB0Vls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 16:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbXB0Vlr
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 16:41:47 -0500
Received: from smtp4.noc.eunet-ag.at ([193.154.160.226]:46975 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbXB0Vlq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 16:41:46 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 8A846976D0;
	Tue, 27 Feb 2007 22:41:44 +0100 (CET)
X-Mailer: git-send-email 1.5.0.19.gddff
In-Reply-To: <11726125033437-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40811>

Upon git add and git update-index, if core.symlinks = false, do not change
an entry from symbolic link to regular file even if the filesystem entry
is a regular file.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-update-index.c |    6 +++---
 cache.h                |    6 +++++-
 read-cache.c           |   12 +++++++-----
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 772aaba..cf8c069 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -109,11 +109,11 @@ static int add_file_to_cache(const char *path)
 	ce->ce_flags = htons(namelen);
 	fill_stat_cache_info(ce, &st);
 
-	if (trust_executable_bit)
+	if (trust_executable_bit && trust_symlink_fmt)
 		ce->ce_mode = create_ce_mode(st.st_mode);
 	else {
-		/* If there is an existing entry, pick the mode bits
-		 * from it, otherwise assume unexecutable.
+		/* If there is an existing entry, pick the mode bits and format
+		 * from it, otherwise assume unexecutable regular file.
 		 */
 		struct cache_entry *ent;
 		int pos = cache_name_pos(path, namelen);
diff --git a/cache.h b/cache.h
index 6cbb9d8..298cdd2 100644
--- a/cache.h
+++ b/cache.h
@@ -108,7 +108,11 @@ static inline unsigned int create_ce_mode(unsigned int mode)
 }
 static inline unsigned int ce_mode_from_stat(struct cache_entry *ce, unsigned int mode)
 {
-	extern int trust_executable_bit;
+	extern int trust_executable_bit, trust_symlink_fmt;
+	/* note: !trust_symlink_fmt trumps !trust_executable_bit */
+	if (!trust_symlink_fmt && S_ISREG(mode) &&
+	    ce && S_ISLNK(ntohl(ce->ce_mode)))
+		return ce->ce_mode;
 	if (!trust_executable_bit && S_ISREG(mode)) {
 		if (ce && S_ISREG(ntohl(ce->ce_mode)))
 			return ce->ce_mode;
diff --git a/read-cache.c b/read-cache.c
index 605b352..f09ee2e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -116,7 +116,8 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 
 	switch (ntohl(ce->ce_mode) & S_IFMT) {
 	case S_IFREG:
-		changed |= !S_ISREG(st->st_mode) ? TYPE_CHANGED : 0;
+		if (trust_symlink_fmt && !S_ISREG(st->st_mode))
+			changed |= TYPE_CHANGED;
 		/* We consider only the owner x bit to be relevant for
 		 * "mode changes"
 		 */
@@ -125,7 +126,8 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 			changed |= MODE_CHANGED;
 		break;
 	case S_IFLNK:
-		changed |= !S_ISLNK(st->st_mode) ? TYPE_CHANGED : 0;
+		if (trust_symlink_fmt && !S_ISLNK(st->st_mode))
+			changed |= TYPE_CHANGED;
 		break;
 	default:
 		die("internal error: ce_mode is %o", ntohl(ce->ce_mode));
@@ -344,11 +346,11 @@ int add_file_to_index(const char *path, int verbose)
 	ce->ce_flags = htons(namelen);
 	fill_stat_cache_info(ce, &st);
 
-	if (trust_executable_bit)
+	if (trust_executable_bit && trust_symlink_fmt)
 		ce->ce_mode = create_ce_mode(st.st_mode);
 	else {
-		/* If there is an existing entry, pick the mode bits
-		 * from it, otherwise assume unexecutable.
+		/* If there is an existing entry, pick the mode bits and format
+		 * from it, otherwise assume unexecutable regular file.
 		 */
 		struct cache_entry *ent;
 		int pos = cache_name_pos(path, namelen);
-- 
1.5.0.19.gddff
