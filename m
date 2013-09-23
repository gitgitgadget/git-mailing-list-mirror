From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 14/16] contrib/git-credential-gnome-keyring.c: report failure to store password
Date: Mon, 23 Sep 2013 11:49:15 -0700
Message-ID: <1379962157-1338-15-git-send-email-bcasey@nvidia.com>
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
	id 1VOBCe-0007aR-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559Ab3IWStl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:49:41 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2467 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab3IWSt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:49:26 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com
	id <B52408d190002>; Mon, 23 Sep 2013 11:48:57 -0700
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235219>

From: Brandon Casey <drafnel@gmail.com>

Produce an error message when we fail to store a password to the keyring.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---

Difference from v1:
Additionally interpret GNOME_KEYRING_RESULT_CANCELLED as a successful exit
status, since that means that the user intentionally cancelled the
operation from the gui.  We should not produce a warning in that case.

 .../credential/gnome-keyring/git-credential-gnome-keyring.c    | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index b70bd53..447e9aa 100644
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
@@ -152,6 +153,13 @@ static int keyring_store(struct credential *c)
 				&item_id);
 
 	g_free(object);
+
+	if (result != GNOME_KEYRING_RESULT_OK &&
+	    result != GNOME_KEYRING_RESULT_CANCELLED) {
+		g_critical("%s", gnome_keyring_result_to_message(result));
+		return EXIT_FAILURE;
+	}
+
 	return EXIT_SUCCESS;
 }
 
-- 
1.8.4.rc4.6.g5555d19


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
