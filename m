From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 15/15] contrib/git-credential-gnome-keyring.c: support really ancient gnome-keyring
Date: Sun, 22 Sep 2013 22:08:11 -0700
Message-ID: <1379912891-12277-16-git-send-email-drafnel@gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:09:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyP0-0002BY-G9
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302Ab3IWFJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:09:30 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:43952 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285Ab3IWFJY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:09:24 -0400
Received: by mail-pa0-f44.google.com with SMTP id lf10so1827670pab.31
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NRlFAGFxe7ijCARBOZg3Wlm/zfv+5OFMVM1DfSeEPM8=;
        b=uGBSF0CyS6wMN5JSQDfD0y43gy/9jF4p4BEJsEiXT6mcMYAuUwD3RsN5I6FGdgurHg
         V93g4MOy6xJyrI1Wzs2OqPGgUjfbm5yEGDGfZLYYCQALC75knCaCXdxLOW33ySXj+1m1
         KMHVJtoxQpVAe/PFkIjMAwSyFsSLC+GywSSjzPwFW+nSH9dfjktnQ9DgIdSR/4B5ZY7d
         MxNOPlhvK9f9g9c52jhm48B0CTSVhNgq0SdgzBXLkkXMmgq0X/0vEIMjWRKGsr/mhK9z
         IKJpmGjfcPUWHRAx+VcGRwNdCA0LagnQysVNdxsaD4e71+aV219+hN7iRodqBjaEl3pb
         NP5g==
X-Received: by 10.68.219.194 with SMTP id pq2mr21995350pbc.52.1379912963955;
        Sun, 22 Sep 2013 22:09:23 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:09:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235197>

The gnome-keyring lib (0.4) distributed with RHEL 4.X is really ancient
and does not provide most of the synchronous functions that even ancient
releases do.  Thankfully, we're only using one function that is missing.
Let's emulate gnome_keyring_item_delete_sync() by calling the asynchronous
function and then triggering the event loop processing until our
callback is called.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../gnome-keyring/git-credential-gnome-keyring.c   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index f8f4df9..ce2ddee 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -86,6 +86,45 @@ static const char* gnome_keyring_result_to_message(GnomeKeyringResult result)
 	}
 }
 
+/*
+ * Just a guess to support RHEL 4.X.
+ * Glib 2.8 was roughly Gnome 2.12 ?
+ * Which was released with gnome-keyring 0.4.3 ??
+ */
+#if GLIB_MAJOR_VERSION == 2 && GLIB_MINOR_VERSION < 8
+
+static void gnome_keyring_done_cb(GnomeKeyringResult result, gpointer user_data)
+{
+	gpointer *data = (gpointer*) user_data;
+	int *done = (int*) data[0];
+	GnomeKeyringResult *r = (GnomeKeyringResult*) data[1];
+
+	*r = result;
+	*done = 1;
+}
+
+static void wait_for_request_completion(int *done)
+{
+	GMainContext *mc = g_main_context_default();
+	while (!*done)
+		g_main_context_iteration(mc, TRUE);
+}
+
+static GnomeKeyringResult gnome_keyring_item_delete_sync(const char *keyring, guint32 id)
+{
+	int done = 0;
+	GnomeKeyringResult result;
+	gpointer data[] = { &done, &result };
+
+	gnome_keyring_item_delete(keyring, id, gnome_keyring_done_cb, data,
+		NULL);
+
+	wait_for_request_completion(&done);
+
+	return result;
+}
+
+#endif
 #endif
 
 /*
-- 
1.8.4.489.g545bc72
