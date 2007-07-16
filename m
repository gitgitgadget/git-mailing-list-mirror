From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 19:38:41 +0200
Message-ID: <11846075213759-git-send-email-sithglan@stud.uni-erlangen.de>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 16 19:39:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAUXN-0002mR-KD
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 19:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757556AbXGPRio (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 13:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756828AbXGPRin
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 13:38:43 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:46457 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756508AbXGPRim (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 13:38:42 -0400
Received: from faui02.informatik.uni-erlangen.de (faui02.informatik.uni-erlangen.de [131.188.30.102])
	by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id DFAB43F40C;
	Mon, 16 Jul 2007 19:38:41 +0200 (CEST)
Received: (from sithglan@localhost)
	by faui02.informatik.uni-erlangen.de (8.13.8/8.12.3/Debian-8) id l6GHcfUk029426;
	Mon, 16 Jul 2007 19:38:41 +0200
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52694>

Calling unlink on a directory on a Solaris UFS filesystem as root makes it
inconsistent. Thanks to Johannes Sixt for the obvious fix.

Signed-off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
---
 entry.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/entry.c b/entry.c
index 82bf725..907293f 100644
--- a/entry.c
+++ b/entry.c
@@ -6,18 +6,18 @@ static void create_directories(const char *path, const struct checkout *state)
 	int len = strlen(path);
 	char *buf = xmalloc(len + 1);
 	const char *slash = path;
+        struct stat st;
 
 	while ((slash = strchr(slash+1, '/')) != NULL) {
 		len = slash - path;
 		memcpy(buf, path, len);
 		buf[len] = 0;
+                if (!stat(buf, &st) && S_ISDIR(st.st_mode))
+                        continue; /* ok */
 		if (mkdir(buf, 0777)) {
 			if (errno == EEXIST) {
-				struct stat st;
 				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
 					continue;
-				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
-					continue; /* ok */
 			}
 			die("cannot create directory at %s", buf);
 		}
-- 
1.5.2.1
