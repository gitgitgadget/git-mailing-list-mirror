From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 09/15] contrib/git-credential-gnome-keyring.c: use secure memory functions for passwds
Date: Sun, 22 Sep 2013 22:08:05 -0700
Message-ID: <1379912891-12277-10-git-send-email-drafnel@gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:09:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyOg-00022i-RP
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab3IWFJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:09:18 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:64732 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab3IWFJO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:09:14 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so3095083pad.19
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5N68id4yoWOZ3e/hQd2iditBNBG5YzHBFRMXVIhGqps=;
        b=sEbnlbH0O4kElGYkRnXd2aysigSwhlMIBITGnTLvrcH96v6JIqSUsuchxd6OR/rcNI
         yp5DL2NwqYkYBRRmkazvYnCNHFSTO8fP2fBTOAbYlfJ31nyvuFck4gLHR365zDn7IJNY
         YIYvYStsthI8JQ96kjVzDCWb4ASRA6/gPfN0fQ/8JxAk8grknp8YAXrCpliLfN3if1tR
         h9WvMGFo5kmIM6VUhq1I8SBrtexRBX/ubfk2CtMIG/fQ4NsXp7aA/q5+CuOIM3XsfLW2
         fuPP/Nh+6fO/tqXCjGN9PKO5xtyJ6uy6k8kA6buZAn33sruVTCQHBFViIIBUZlOP5A4w
         ATHQ==
X-Received: by 10.68.215.38 with SMTP id of6mr22029544pbc.14.1379912954255;
        Sun, 22 Sep 2013 22:09:14 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:09:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235190>

gnome-keyring provides functions for allocating non-pageable memory (if
possible) intended to be used for storing passwords.  Let's use them.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../gnome-keyring/git-credential-gnome-keyring.c    | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 7565765..ff2f48c 100644
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
1.8.4.489.g545bc72
