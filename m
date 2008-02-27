From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 11/40] Windows: Handle absolute paths in safe_create_leading_directories().
Date: Wed, 27 Feb 2008 19:54:34 +0100
Message-ID: <1204138503-6126-12-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVL-00022R-Q3
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107AbYB0Szb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756131AbYB0Sz3
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:29 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40438 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334AbYB0SzI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:08 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id DB4A697609;
	Wed, 27 Feb 2008 19:55:05 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75276>

In this function we must be careful to handle drive-local paths else there
is a danger that it runs into an infinite loop.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 sha1_file.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 453bc43..0c60849 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -83,14 +83,20 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
 	return 0;
 }
 
+static inline int offset_1st_component(const char *path)
+{
+#ifdef __MINGW32__
+	if (isalpha(path[0]) && path[1] == ':')
+		return 2 + (path[2] == '/');
+#endif
+	return *path == '/';
+}
+
 int safe_create_leading_directories(char *path)
 {
-	char *pos = path;
+	char *pos = path + offset_1st_component(path);
 	struct stat st;
 
-	if (is_absolute_path(path))
-		pos++;
-
 	while (pos) {
 		pos = strchr(pos, '/');
 		if (!pos)
-- 
1.5.4.1.126.ge5a7d
