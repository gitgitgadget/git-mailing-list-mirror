From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 13/16] contrib/git-credential-gnome-keyring.c: use glib messaging functions
Date: Mon, 23 Sep 2013 11:49:14 -0700
Message-ID: <1379962157-1338-14-git-send-email-bcasey@nvidia.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <john@szakmeister.net>, <pah@qo.cx>, <felipe.contreras@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:49:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBCf-0007aR-Om
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab3IWStm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:49:42 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14686 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab3IWSt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:49:26 -0400
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com
	id <B52408d0e0001>; Mon, 23 Sep 2013 11:48:46 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Mon, 23 Sep 2013 11:45:53 -0700
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Mon, 23 Sep 2013 11:45:53 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.327.1; Mon, 23 Sep 2013
 11:49:26 -0700
X-Mailer: git-send-email 1.8.4.rc4.6.g5555d19
In-Reply-To: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235224>

From: Brandon Casey <drafnel@gmail.com>

Rather than roll our own, let's use the messaging functions provided
by glib.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../gnome-keyring/git-credential-gnome-keyring.c   | 33 +++-------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 273c43b..b70bd53 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -25,7 +25,6 @@
 
 #include <stdio.h>
 #include <string.h>
-#include <stdarg.h>
 #include <stdlib.h>
 #include <glib.h>
 #include <gnome-keyring.h>
@@ -58,30 +57,6 @@ struct credential_operation
 #define CREDENTIAL_OP_END \
   { NULL,NULL }
 
-/* ---------------- common helper functions ----------------- */
-
-static inline void warning(const char *fmt, ...)
-{
-	va_list ap;
-
-	va_start(ap, fmt);
-	fprintf(stderr, "warning: ");
-	vfprintf(stderr, fmt, ap);
-	fprintf(stderr, "\n" );
-	va_end(ap);
-}
-
-static inline void error(const char *fmt, ...)
-{
-	va_list ap;
-
-	va_start(ap, fmt);
-	fprintf(stderr, "error: ");
-	vfprintf(stderr, fmt, ap);
-	fprintf(stderr, "\n" );
-	va_end(ap);
-}
-
 /* ----------------- GNOME Keyring functions ----------------- */
 
 /* create a special keyring option string, if path is given */
@@ -127,7 +102,7 @@ static int keyring_get(struct credential *c)
 		return EXIT_SUCCESS;
 
 	if (result != GNOME_KEYRING_RESULT_OK) {
-		error("%s",gnome_keyring_result_to_message(result));
+		g_critical("%s", gnome_keyring_result_to_message(result));
 		return EXIT_FAILURE;
 	}
 
@@ -220,7 +195,7 @@ static int keyring_erase(struct credential *c)
 
 	if (result != GNOME_KEYRING_RESULT_OK)
 	{
-		error("%s",gnome_keyring_result_to_message(result));
+		g_critical("%s", gnome_keyring_result_to_message(result));
 		return EXIT_FAILURE;
 	}
 
@@ -234,7 +209,7 @@ static int keyring_erase(struct credential *c)
 
 	if (result != GNOME_KEYRING_RESULT_OK)
 	{
-		error("%s",gnome_keyring_result_to_message(result));
+		g_critical("%s", gnome_keyring_result_to_message(result));
 		return EXIT_FAILURE;
 	}
 
@@ -292,7 +267,7 @@ static int credential_read(struct credential *c)
 
 		value = strchr(buf,'=');
 		if (!value) {
-			warning("invalid credential line: %s", key);
+			g_warning("invalid credential line: %s", key);
 			gnome_keyring_memory_free(buf);
 			return -1;
 		}
-- 
1.8.4.rc4.6.g5555d19


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
