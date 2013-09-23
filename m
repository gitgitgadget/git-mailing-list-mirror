From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 11/15] contrib/git-credential-gnome-keyring.c: use glib memory allocation functions
Date: Sun, 22 Sep 2013 22:08:07 -0700
Message-ID: <1379912891-12277-12-git-send-email-drafnel@gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:09:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyOt-00028Z-V8
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326Ab3IWFJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:09:32 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:55124 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab3IWFJR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:09:17 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so2770596pdj.29
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VNGV/kCwrUEsfVL2mIFrBCEcsiIzbbTGz3V0Oeq97Tg=;
        b=yleEEYm+AFEo62gwhM7t30LlihCjnxcXgFbDc6UIF+hKWJbIVWQ6F16vMFRzxwt7+I
         3+N7fLmktDTB+sACfj/s5UpbtemXQA+ZozDKlNIle2q/K9uBewqQDFABfXR5JOnbLwWd
         aeA5LRW92sr+qrn0hCRxw84BqQEYZIM1p5ewozrUw2+CTHKGp+rQtHmk0CMIhyxT35F1
         xqKFN5Ky6tztFOdixq9i0tnHrHvSb8dmzzhF+URRbvzCiIwYmWa9A2NkchkjiudAa7V4
         AJisJ028OCo2RPFl2Ze5J78IU7RguZP7Asfy7qSL5uOvku0QKSpkB2dQJUr/iqXpt2r5
         /Iug==
X-Received: by 10.68.171.193 with SMTP id aw1mr6011084pbc.131.1379912957320;
        Sun, 22 Sep 2013 22:09:17 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:09:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235195>

Rather than roll our own, let's use the memory allocation/free routines
provided by glib.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../gnome-keyring/git-credential-gnome-keyring.c   | 48 ++++++++--------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 94a65b2..5b10e3e 100644
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
1.8.4.489.g545bc72
