From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 13/15] contrib/git-credential-gnome-keyring.c: report failure to store password
Date: Sun, 22 Sep 2013 22:08:09 -0700
Message-ID: <1379912891-12277-14-git-send-email-drafnel@gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:09:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyP1-0002BY-1j
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321Ab3IWFJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:09:31 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36675 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab3IWFJU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:09:20 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so1819293pab.4
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ggs4rRmgEGkdtJO0msC6utMfh3bKL8P5t+CdZdRrJRA=;
        b=UAppvf6/z4r7ndwqaPvGsLn8/mantCuwB4PKmseDIMqd4RCSaxcRRaVegKBfVcFhzE
         +2psU4MacnMNmvXXNUM9PkfExJYCg2KMfReXBuMSNaAkMIKrw50kLNx38YzYHK4XK5Ux
         iXxS0EBz0d2e7ZvvBdMdW1QpV2VvQSnQgOs8p82sn71TNU7/3iXmcIDp/36x2pwE/aC3
         YnRIqiEaMRJQlmZN+kgQ2t+UX5oFuB7Wa4yuH84mendE2DvjA3UkyG9ZqLznRHw537Oq
         F6bHM8WhkFzwbZCAUBbowWWte11rE5BPBgM9ZnzGBWo79OwXAIjKrcjbeNUPIdxpGV5F
         yJcA==
X-Received: by 10.68.88.161 with SMTP id bh1mr22088726pbb.49.1379912960520;
        Sun, 22 Sep 2013 22:09:20 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:09:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235196>

Produce an error message when we fail to store a password to the keyring.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 contrib/credential/gnome-keyring/git-credential-gnome-keyring.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index a6369a3..6fa1278 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -125,6 +125,7 @@ static int keyring_store(struct credential *c)
 {
 	guint32 item_id;
 	char  *object = NULL;
+	GnomeKeyringResult result;
 
 	/*
 	 * Sanity check that what we are storing is actually sensible.
@@ -139,7 +140,7 @@ static int keyring_store(struct credential *c)
 
 	object = keyring_object(c);
 
-	gnome_keyring_set_network_password_sync(
+	result = gnome_keyring_set_network_password_sync(
 				GNOME_KEYRING_DEFAULT,
 				c->username,
 				NULL /* domain */,
@@ -152,6 +153,12 @@ static int keyring_store(struct credential *c)
 				&item_id);
 
 	g_free(object);
+
+	if (result != GNOME_KEYRING_RESULT_OK) {
+		g_critical("%s", gnome_keyring_result_to_message(result));
+		return EXIT_FAILURE;
+	}
+
 	return EXIT_SUCCESS;
 }
 
-- 
1.8.4.489.g545bc72
