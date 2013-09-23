From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 12/15] contrib/git-credential-gnome-keyring.c: use glib messaging functions
Date: Sun, 22 Sep 2013 22:08:08 -0700
Message-ID: <1379912891-12277-13-git-send-email-drafnel@gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:09:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyOl-00024P-Oj
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab3IWFJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:09:22 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:55301 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab3IWFJT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:09:19 -0400
Received: by mail-pa0-f48.google.com with SMTP id bj1so1808228pad.7
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zhPw9zSl7Y2NjpKGhM73/yYSjihDJClaIsUEl00NIjc=;
        b=SiMzdI2GZOx+dXSf5rDCsXEWYnZD+4bAg+0lWInTLLVxIjuQ4A6D2HE6YKO/v0qB9r
         5TnrtIZKVejTX7iRpIFi2asxLsWOdSlpAHT+/TMsott8au+KITsSLt8drhXej17VhxN2
         3BvscLEmX8A79FV/haDtEASp9Hn8v4MniOmTeMsdWtYtJC4ASwHOSj8xP8bOZFuzeki7
         CheVeUfpRT8dYFcn7GUQvIqeGzZhhIEesPIKud8kpRaxVmlvhMHetu7ysIKbiyMpAnS5
         0qGvpzVJgTDN25LLMeGZqnTJwa4OrIg1LnwVvu4/sR/CVYFoPenGLSsL813x/mO2YKoX
         rXbg==
X-Received: by 10.66.136.227 with SMTP id qd3mr22489356pab.113.1379912958913;
        Sun, 22 Sep 2013 22:09:18 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:09:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235192>

Rather than roll our own, let's use the messaging functions provided
by glib.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../gnome-keyring/git-credential-gnome-keyring.c   | 33 +++-------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 5b10e3e..a6369a3 100644
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
 		if(!value) {
-			warning("invalid credential line: %s", key);
+			g_warning("invalid credential line: %s", key);
 			gnome_keyring_memory_free(buf);
 			return -1;
 		}
-- 
1.8.4.489.g545bc72
