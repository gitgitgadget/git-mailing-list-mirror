From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Teach fsck and prune about the new location of temporary
 objects
Date: Thu, 24 Jul 2008 17:41:12 -0500
Message-ID: <6ruv3Y98_kSSVnJFTkV0PNdiNcQ3g-a3M4BhGoT7S1PorElp5tJAkw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 00:42:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM9WI-0003wm-EL
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 00:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbYGXWlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 18:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbYGXWlq
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 18:41:46 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46389 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYGXWlq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 18:41:46 -0400
Received: by mail.nrlssc.navy.mil id m6OMfDwK030988; Thu, 24 Jul 2008 17:41:13 -0500
X-OriginalArrivalTime: 24 Jul 2008 22:41:13.0253 (UTC) FILETIME=[6032E550:01C8EDDE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89967>

Since 5723fe7e, temporary objects are now created in their final destination
directories, rather than in .git/objects/. Teach fsck to recognize and
ignore the temporary objects it encounters, and teach prune to remove them.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-fsck.c  |    4 ++++
 builtin-prune.c |   41 ++++++++++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 7326dc3..7a4a4f1 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -377,6 +377,10 @@ static void fsck_dir(int i, char *path)
 			if (de->d_name[0] != '.')
 				break;
 			continue;
+		case 14:
+			if (prefixcmp(de->d_name, "tmp_obj_"))
+				break;
+			continue;
 		case 38:
 			sprintf(name, "%02x", i);
 			memcpy(name+2, de->d_name, len+1);
diff --git a/builtin-prune.c b/builtin-prune.c
index 7de4cab..947de8c 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -13,6 +13,22 @@ static const char * const prune_usage[] = {
 static int show_only;
 static unsigned long expire;
 
+static int prune_tmp_object(char *path, const char *filename)
+{
+	const char *fullpath = mkpath("%s/%s", path, filename);
+	if (expire) {
+		struct stat st;
+		if (lstat(fullpath, &st))
+			return error("Could not stat '%s'", fullpath);
+		if (st.st_mtime > expire)
+			return 0;
+	}
+	printf("Removing stale temporary file %s\n", fullpath);
+	if (!show_only)
+		unlink(fullpath);
+	return 0;
+}
+
 static int prune_object(char *path, const char *filename, const unsigned char *sha1)
 {
 	const char *fullpath = mkpath("%s/%s", path, filename);
@@ -53,6 +69,11 @@ static int prune_dir(int i, char *path)
 			if (de->d_name[0] != '.')
 				break;
 			continue;
+		case 14:
+			if (prefixcmp(de->d_name, "tmp_obj_"))
+				break;
+			prune_tmp_object(path, de->d_name);
+			continue;
 		case 38:
 			sprintf(name, "%02x", i);
 			memcpy(name+2, de->d_name, len+1);
@@ -105,23 +126,9 @@ static void remove_temporary_files(void)
 			dirname);
 		return;
 	}
-	while ((de = readdir(dir)) != NULL) {
-		if (!prefixcmp(de->d_name, "tmp_")) {
-			char name[PATH_MAX];
-			int c = snprintf(name, PATH_MAX, "%s/%s",
-					 dirname, de->d_name);
-			if (c < 0 || c >= PATH_MAX)
-				continue;
-			if (expire) {
-				struct stat st;
-				if (stat(name, &st) != 0 || st.st_mtime >= expire)
-					continue;
-			}
-			printf("Removing stale temporary file %s\n", name);
-			if (!show_only)
-				unlink(name);
-		}
-	}
+	while ((de = readdir(dir)) != NULL)
+		if (!prefixcmp(de->d_name, "tmp_"))
+			prune_tmp_object(dirname, de->d_name);
 	closedir(dir);
 }
 
-- 
1.6.0.rc0.55.g160ae.dirty
