From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 14/15] contrib/git-credential-gnome-keyring.c: support ancient gnome-keyring
Date: Sun, 22 Sep 2013 22:08:10 -0700
Message-ID: <1379912891-12277-15-git-send-email-drafnel@gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:09:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyOp-00026d-3b
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab3IWFJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:09:25 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:41321 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab3IWFJW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:09:22 -0400
Received: by mail-pa0-f52.google.com with SMTP id kl14so1814512pab.39
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SECaFc/88RYUhJE0BUH4NlwSW3ZhHv8Hznhv4xTJb6o=;
        b=VtIAXEM8Av+ipfyoGLdBiRx7Ad76e85NqIGqI9F9cHR2OEg9J/85CDLGc26P2e/g0m
         4R8JaUKElJJFu8+VM8CVNlnJOBrWwggF6599Yxl5ktJOfFKcq6iQrZdXLfU8jjwAbalX
         oj0IINuBSbdMVuDN8mmsSj5cWtPj16xK74fO4X5evbr5trYSX4UFhV4Wz71uIjN6ydc3
         M3bfIIUDwT7rf6TOpXF6JSPEuSdcBlbmSkbamiHCcqZoeccjIGPYsnuW31dmtpJUFTwX
         9kq3LX2lC3lp05ortouEv9ddgzp3uq665XKgMf5OGjG9Y7FfnUFsOjSpPXL2Ml8AHWBV
         aBzw==
X-Received: by 10.68.225.42 with SMTP id rh10mr19951pbc.176.1379912962381;
        Sun, 22 Sep 2013 22:09:22 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:09:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235193>

The gnome-keyring lib distributed with RHEL 5.X is ancient and does
not provide a few of the functions/defines that more recent versions
do, but mostly the API is the same.  Let's provide the missing bits
via macro definitions and function implementation.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../gnome-keyring/git-credential-gnome-keyring.c   | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 6fa1278..f8f4df9 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -28,8 +28,66 @@
 #include <stdlib.h>
 #include <glib.h>
 #include <gnome-keyring.h>
+
+#ifdef GNOME_KEYRING_DEFAULT
+
+   /* Modern gnome-keyring */
+
 #include <gnome-keyring-memory.h>
 
+#else
+
+   /*
+    * Support ancient gnome-keyring, circ. RHEL 5.X.
+    * GNOME_KEYRING_DEFAULT seems to have been introduced with Gnome 2.22,
+    * and the other features roughly around Gnome 2.20, 6 months before.
+    * Ubuntu 8.04 used Gnome 2.22 (I think).  Not sure any distro used 2.20.
+    * So the existence/non-existence of GNOME_KEYRING_DEFAULT seems like
+    * a decent thing to use as an indicator.
+    */
+
+#define GNOME_KEYRING_DEFAULT NULL
+
+/*
+ * ancient gnome-keyring returns DENIED when an entry is not found.
+ * Setting NO_MATCH to DENIED will prevent us from reporting denied
+ * errors during get and erase operations, but we will still report
+ * DENIED errors during a store.
+ */
+#define GNOME_KEYRING_RESULT_NO_MATCH GNOME_KEYRING_RESULT_DENIED
+
+#define gnome_keyring_memory_alloc g_malloc
+#define gnome_keyring_memory_free gnome_keyring_free_password
+#define gnome_keyring_memory_strdup g_strdup
+
+static const char* gnome_keyring_result_to_message(GnomeKeyringResult result)
+{
+	switch (result) {
+	case GNOME_KEYRING_RESULT_OK:
+		return "OK";
+	case GNOME_KEYRING_RESULT_DENIED:
+		return "Denied";
+	case GNOME_KEYRING_RESULT_NO_KEYRING_DAEMON:
+		return "No Keyring Daemon";
+	case GNOME_KEYRING_RESULT_ALREADY_UNLOCKED:
+		return "Already UnLocked";
+	case GNOME_KEYRING_RESULT_NO_SUCH_KEYRING:
+		return "No Such Keyring";
+	case GNOME_KEYRING_RESULT_BAD_ARGUMENTS:
+		return "Bad Arguments";
+	case GNOME_KEYRING_RESULT_IO_ERROR:
+		return "IO Error";
+	case GNOME_KEYRING_RESULT_CANCELLED:
+		return "Cancelled";
+	case GNOME_KEYRING_RESULT_ALREADY_EXISTS:
+		return "Already Exists";
+	default:
+		return "Unknown Error";
+	}
+}
+
+#endif
+
 /*
  * This credential struct and API is simplified from git's credential.{h,c}
  */
-- 
1.8.4.489.g545bc72
