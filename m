From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 12/16] contrib/git-credential-gnome-keyring.c: use glib memory allocation functions
Date: Mon, 23 Sep 2013 11:49:13 -0700
Message-ID: <1379962157-1338-13-git-send-email-bcasey@nvidia.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <john@szakmeister.net>, <pah@qo.cx>, <felipe.contreras@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:49:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBCf-0007aR-5L
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567Ab3IWStm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:49:42 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9064 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319Ab3IWSt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:49:26 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com
	id <B52408d210001>; Mon, 23 Sep 2013 11:49:05 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Mon, 23 Sep 2013 11:49:26 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Mon, 23 Sep 2013 11:49:26 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.327.1; Mon, 23 Sep 2013
 11:49:26 -0700
X-Mailer: git-send-email 1.8.4.rc4.6.g5555d19
In-Reply-To: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235217>

From: Brandon Casey <drafnel@gmail.com>

Rather than roll our own, let's use the memory allocation/free routines
provided by glib.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../gnome-keyring/git-credential-gnome-keyring.c   | 48 ++++++++--------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 5e79669..273c43b 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -27,7 +27,6 @@
 #include <string.h>
 #include <stdarg.h>
 #include <stdlib.h>
-#include <errno.h>
 #include <glib.h>
 #include <gnome-keyring.h>
 #include <gnome-keyring-memory.h>
@@ -83,21 +82,6 @@ static inline void error(const char *fmt, ...)
 	va_end(ap);
 }
 
-static inline void die_errno(int err)
-{
-	error("%s", strerror(err));
-	exit(EXIT_FAILURE);
-}
-
-static inline char *xstrdup(const char *str)
-{
-	char *ret = strdup(str);
-	if (!ret)
-		die_errno(errno);
-
-	return ret;
-}
-
 /* ----------------- GNOME Keyring functions ----------------- */
 
 /* create a special keyring option string, if path is given */
@@ -134,7 +118,7 @@ static int keyring_get(struct credential *c)
 				c->port,
 				&entries);
 
-	free(object);
+	g_free(object);
 
 	if (result == GNOME_KEYRING_RESULT_NO_MATCH)
 		return EXIT_SUCCESS;
@@ -154,7 +138,7 @@ static int keyring_get(struct credential *c)
 	c->password = gnome_keyring_memory_strdup(password_data->password);
 
 	if (!c->username)
-		c->username = xstrdup(password_data->user);
+		c->username = g_strdup(password_data->user);
 
 	gnome_keyring_network_password_list_free(entries);
 
@@ -192,7 +176,7 @@ static int keyring_store(struct credential *c)
 				c->password,
 				&item_id);
 
-	free(object);
+	g_free(object);
 	return EXIT_SUCCESS;
 }
 
@@ -226,7 +210,7 @@ static int keyring_erase(struct credential *c)
 				c->port,
 				&entries);
 
-	free(object);
+	g_free(object);
 
 	if (result == GNOME_KEYRING_RESULT_NO_MATCH)
 		return EXIT_SUCCESS;
@@ -278,10 +262,10 @@ static void credential_init(struct credential *c)
 
 static void credential_clear(struct credential *c)
 {
-	free(c->protocol);
-	free(c->host);
-	free(c->path);
-	free(c->username);
+	g_free(c->protocol);
+	g_free(c->host);
+	g_free(c->path);
+	g_free(c->username);
 	gnome_keyring_memory_free(c->password);
 
 	credential_init(c);
@@ -315,22 +299,22 @@ static int credential_read(struct credential *c)
 		*value++ = '\0';
 
 		if (!strcmp(key, "protocol")) {
-			free(c->protocol);
-			c->protocol = xstrdup(value);
+			g_free(c->protocol);
+			c->protocol = g_strdup(value);
 		} else if (!strcmp(key, "host")) {
-			free(c->host);
-			c->host = xstrdup(value);
+			g_free(c->host);
+			c->host = g_strdup(value);
 			value = strrchr(c->host,':');
 			if (value) {
 				*value++ = '\0';
 				c->port = atoi(value);
 			}
 		} else if (!strcmp(key, "path")) {
-			free(c->path);
-			c->path = xstrdup(value);
+			g_free(c->path);
+			c->path = g_strdup(value);
 		} else if (!strcmp(key, "username")) {
-			free(c->username);
-			c->username = xstrdup(value);
+			g_free(c->username);
+			c->username = g_strdup(value);
 		} else if (!strcmp(key, "password")) {
 			gnome_keyring_memory_free(c->password);
 			c->password = gnome_keyring_memory_strdup(value);
-- 
1.8.4.rc4.6.g5555d19


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
