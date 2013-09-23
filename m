From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 10/16] contrib/git-credential-gnome-keyring.c: use secure memory functions for passwds
Date: Mon, 23 Sep 2013 11:49:11 -0700
Message-ID: <1379962157-1338-11-git-send-email-bcasey@nvidia.com>
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
	id 1VOBCz-0007oY-NE
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab3IWStv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:49:51 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9062 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab3IWSt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:49:26 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com
	id <B52408d210000>; Mon, 23 Sep 2013 11:49:05 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Mon, 23 Sep 2013 11:49:26 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Mon, 23 Sep 2013 11:49:26 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.327.1; Mon, 23 Sep 2013
 11:49:25 -0700
X-Mailer: git-send-email 1.8.4.rc4.6.g5555d19
In-Reply-To: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235226>

From: Brandon Casey <drafnel@gmail.com>

gnome-keyring provides functions for allocating non-pageable memory (if
possible) intended to be used for storing passwords.  Let's use them.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../gnome-keyring/git-credential-gnome-keyring.c    | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index b692e1f..d8a7038 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -30,6 +30,7 @@
 #include <errno.h>
 #include <glib.h>
 #include <gnome-keyring.h>
+#include <gnome-keyring-memory.h>
 
 /*
  * This credential struct and API is simplified from git's credential.{h,c}
@@ -60,16 +61,6 @@ struct credential_operation
 
 /* ---------------- common helper functions ----------------- */
 
-static inline void free_password(char *password)
-{
-	char *c = password;
-	if (!password)
-		return;
-
-	while (*c) *c++ = '\0';
-	free(password);
-}
-
 static inline void warning(const char *fmt, ...)
 {
 	va_list ap;
@@ -159,8 +150,8 @@ static int keyring_get(struct credential *c)
 	/* pick the first one from the list */
 	password_data = (GnomeKeyringNetworkPasswordData *) entries->data;
 
-	free_password(c->password);
-	c->password = xstrdup(password_data->password);
+	gnome_keyring_memory_free(c->password);
+	c->password = gnome_keyring_memory_strdup(password_data->password);
 
 	if (!c->username)
 		c->username = xstrdup(password_data->user);
@@ -291,7 +282,7 @@ static void credential_clear(struct credential *c)
 	free(c->host);
 	free(c->path);
 	free(c->username);
-	free_password(c->password);
+	gnome_keyring_memory_free(c->password);
 
 	credential_init(c);
 }
@@ -338,8 +329,8 @@ static int credential_read(struct credential *c)
 			free(c->username);
 			c->username = xstrdup(value);
 		} else if (!strcmp(key, "password")) {
-			free_password(c->password);
-			c->password = xstrdup(value);
+			gnome_keyring_memory_free(c->password);
+			c->password = gnome_keyring_memory_strdup(value);
 			while (*value) *value++ = '\0';
 		}
 		/*
-- 
1.8.4.rc4.6.g5555d19


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
