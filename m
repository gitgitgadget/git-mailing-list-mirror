From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 08/15] contrib/git-credential-gnome-keyring.c: use gnome helpers in keyring_object()
Date: Sun, 22 Sep 2013 22:08:04 -0700
Message-ID: <1379912891-12277-9-git-send-email-drafnel@gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:09:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyOg-00022i-9Q
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab3IWFJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:09:14 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:48408 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab3IWFJN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:09:13 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so1808757pad.23
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gQnMHp9r8Zk0638NV79gP5Ig+wEYdRrBVIA0C2oqzVc=;
        b=fYvMj/MItxkIguH6kuarzZEKDhQZksEYJxEMh9XiXi3gkxt0NYdgFfeIc8eNESlpYq
         leVF2a9L9npmCQKWeTsU4HS5PWQZXF9lZjPi9litXvrEHsbCd5KeI5v5dJqBczLXqm4R
         YEgK87a3HtnMB7Din5ofsl3jCZCoA3RKLIz+yjb14kiNCOIhe8LvPuDrx7kSyTBzRj0P
         3vtAozzm3xCaYIFTBGMdMTPFjbxdyp1qGSoi0oqBFfrgXw82OFdR+hf6GI/PFTz1iGds
         QKXp1KOWy9PBdb8LPFVfqj0CvKUqOyjx5pg4zr7xlh8A+12gG8zFGBDrlc29xN8zvxqj
         TT3w==
X-Received: by 10.66.233.37 with SMTP id tt5mr22563139pac.95.1379912952553;
        Sun, 22 Sep 2013 22:09:12 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:09:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235191>

Rather than carefully allocating memory for sprintf() to write into,
let's make use of the glib helper function g_strdup_printf(), which
makes things a lot easier and less error-prone.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../gnome-keyring/git-credential-gnome-keyring.c           | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 8ae2eab..7565765 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -112,21 +112,13 @@ static inline char *xstrdup(const char *str)
 /* create a special keyring option string, if path is given */
 static char* keyring_object(struct credential *c)
 {
-	char* object = NULL;
-
 	if (!c->path)
-		return object;
-
-	object = (char*) malloc(strlen(c->host)+strlen(c->path)+8);
-	if(!object)
-		die_errno(errno);
+		return NULL;
 
 	if(c->port)
-		sprintf(object,"%s:%hd/%s",c->host,c->port,c->path);
-	else
-		sprintf(object,"%s/%s",c->host,c->path);
+		return g_strdup_printf("%s:%hd/%s", c->host, c->port, c->path);
 
-	return object;
+	return g_strdup_printf("%s/%s", c->host, c->path);
 }
 
 static int keyring_get(struct credential *c)
-- 
1.8.4.489.g545bc72
