From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 16/16] contrib/git-credential-gnome-keyring.c: support really ancient gnome-keyring
Date: Mon, 23 Sep 2013 11:49:17 -0700
Message-ID: <1379962157-1338-17-git-send-email-bcasey@nvidia.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <john@szakmeister.net>, <pah@qo.cx>, <felipe.contreras@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:49:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBCe-0007aR-1s
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501Ab3IWSth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:49:37 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2468 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349Ab3IWSt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:49:27 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com
	id <B52408d190003>; Mon, 23 Sep 2013 11:48:57 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Mon, 23 Sep 2013 11:49:26 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Mon, 23 Sep 2013 11:49:26 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.327.1; Mon, 23 Sep 2013
 11:49:26 -0700
X-Mailer: git-send-email 1.8.4.rc4.6.g5555d19
In-Reply-To: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235222>

From: Brandon Casey <drafnel@gmail.com>

The gnome-keyring lib (0.4) distributed with RHEL 4.X is really ancient
and does not provide most of the synchronous functions that even ancient
releases do.  Thankfully, we're only using one function that is missing.
Let's emulate gnome_keyring_item_delete_sync() by calling the asynchronous
function and then triggering the event loop processing until our
callback is called.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---

Clarified the comment about RHEL 4.X support.

 .../gnome-keyring/git-credential-gnome-keyring.c   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index e1bc3fa..635c96b 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -86,6 +86,45 @@ static const char* gnome_keyring_result_to_message(GnomeKeyringResult result)
 	}
 }
 
+/*
+ * Support really ancient gnome-keyring, circ. RHEL 4.X.
+ * Just a guess for the Glib version.  Glib 2.8 was roughly Gnome 2.12 ?
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
1.8.4.rc4.6.g5555d19


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
