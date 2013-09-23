From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 10/15] contrib/git-credential-gnome-keyring.c: use secure memory for reading passwords
Date: Sun, 22 Sep 2013 22:08:06 -0700
Message-ID: <1379912891-12277-11-git-send-email-drafnel@gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:09:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyOt-00028Z-DE
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246Ab3IWFJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:09:17 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:45786 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab3IWFJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:09:16 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so2761889pdi.14
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q78FHQNMGKNg2h48Dtkp6hRnf2qNjTyoYIMqD5tnwso=;
        b=uWbNJ2+ydU9Q5XqDf2HpIcHRQ3HA10dj0HCgzaa7RvPWrpHXqzkZsdFwdBWhJ4GAUs
         qOvx5RknvNYeD18/a2xtp9qimztBwqZzcGaUyzq/TUhax6eeHw/tN39l9UDiJwuOfqrq
         Kv8PSTVjHHLSOugZs1WH7vQY09wXFbxe3dYAU0+F/KcxiAJ1z4ZL00grKUxZK8x0CIYT
         7/kaoG3DmlOO0UIYNx7PYh1wAEnaIf4JAiuOa+bHQgazs0JsChjaLC7poe440/dkBUs/
         tWErY27+Fnwti0YvGM7pwR7MlhChZqTMSNeqwqGSwg/Iov5WHCsA3OmU6yJJcCs5stqz
         34GA==
X-Received: by 10.66.246.229 with SMTP id xz5mr5900453pac.128.1379912955802;
        Sun, 22 Sep 2013 22:09:15 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:09:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235194>

gnome-keyring provides functions to allocate non-pageable memory (if
possible).  Let's use them to allocate memory that may be used to hold
secure data read from the keyring.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../credential/gnome-keyring/git-credential-gnome-keyring.c  | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index ff2f48c..94a65b2 100644
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
 		if(!value) {
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
1.8.4.489.g545bc72
