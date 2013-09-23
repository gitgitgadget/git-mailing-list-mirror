From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 15/16] contrib/git-credential-gnome-keyring.c: support ancient gnome-keyring
Date: Mon, 23 Sep 2013 11:49:16 -0700
Message-ID: <1379962157-1338-16-git-send-email-bcasey@nvidia.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <john@szakmeister.net>, <pah@qo.cx>, <felipe.contreras@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:49:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBCg-0007aR-AY
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549Ab3IWStk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:49:40 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14687 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab3IWSt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:49:26 -0400
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com
	id <B52408d0e0002>; Mon, 23 Sep 2013 11:48:46 -0700
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235223>

From: Brandon Casey <drafnel@gmail.com>

The gnome-keyring lib distributed with RHEL 5.X is ancient and does
not provide a few of the functions/defines that more recent versions
do, but mostly the API is the same.  Let's provide the missing bits
via macro definitions and function implementation.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../gnome-keyring/git-credential-gnome-keyring.c   | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 447e9aa..e1bc3fa 100644
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
+ * Setting NO_MATCH to DENIED will prevent us from reporting DENIED
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
1.8.4.rc4.6.g5555d19


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
