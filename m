From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 11/16] contrib/git-credential-gnome-keyring.c: use secure memory for reading passwords
Date: Mon, 23 Sep 2013 11:49:12 -0700
Message-ID: <1379962157-1338-12-git-send-email-bcasey@nvidia.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <john@szakmeister.net>, <pah@qo.cx>, <felipe.contreras@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:50:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBCz-0007oY-4L
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606Ab3IWStu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:49:50 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2463 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab3IWSt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:49:26 -0400
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com
	id <B52408d190001>; Mon, 23 Sep 2013 11:48:57 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Mon, 23 Sep 2013 11:45:52 -0700
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Mon, 23 Sep 2013 11:45:52 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.327.1; Mon, 23 Sep 2013
 11:49:25 -0700
X-Mailer: git-send-email 1.8.4.rc4.6.g5555d19
In-Reply-To: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235227>

From: Brandon Casey <drafnel@gmail.com>

gnome-keyring provides functions to allocate non-pageable memory (if
possible).  Let's use them to allocate memory that may be used to hold
secure data read from the keyring.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../credential/gnome-keyring/git-credential-gnome-keyring.c  | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index d8a7038..5e79669 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -289,12 +289,14 @@ static void credential_clear(struct credential *c)
 
 static int credential_read(struct credential *c)
 {
-	char    buf[1024];
+	char    *buf;
 	size_t line_len;
-	char   *key      = buf;
+	char   *key;
 	char   *value;
 
-	while (fgets(buf, sizeof(buf), stdin))
+	key = buf = gnome_keyring_memory_alloc(1024);
+
+	while (fgets(buf, 1024, stdin))
 	{
 		line_len = strlen(buf);
 
@@ -307,6 +309,7 @@ static int credential_read(struct credential *c)
 		value = strchr(buf,'=');
 		if (!value) {
 			warning("invalid credential line: %s", key);
+			gnome_keyring_memory_free(buf);
 			return -1;
 		}
 		*value++ = '\0';
@@ -339,6 +342,9 @@ static int credential_read(struct credential *c)
 		 * learn new lines, and the helpers are updated to match.
 		 */
 	}
+
+	gnome_keyring_memory_free(buf);
+
 	return 0;
 }
 
-- 
1.8.4.rc4.6.g5555d19


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
