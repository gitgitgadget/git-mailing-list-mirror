From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 07/30] Notes API: get_note(): Return the note annotating the
 given object
Date: Sat, 13 Feb 2010 22:28:15 +0100
Message-ID: <1266096518-2104-8-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:29:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPYL-00018f-47
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758088Ab0BMV3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:29:16 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62186 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758079Ab0BMV3G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:06 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00FJ4UCH5490@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:05 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:05 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139838>

Created by a simple cleanup and rename of lookup_notes().

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |   15 ++++++++-------
 notes.h |    7 +++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/notes.c b/notes.c
index 2e82d71..a0a85b4 100644
--- a/notes.c
+++ b/notes.c
@@ -462,12 +462,13 @@ void remove_note(const unsigned char *object_sha1)
 	return note_tree_remove(&root_node, 0, &l);
 }
 
-static unsigned char *lookup_notes(const unsigned char *object_sha1)
+const unsigned char *get_note(const unsigned char *object_sha1)
 {
-	struct leaf_node *found = note_tree_find(&root_node, 0, object_sha1);
-	if (found)
-		return found->val_sha1;
-	return NULL;
+	struct leaf_node *found;
+
+	assert(initialized);
+	found = note_tree_find(&root_node, 0, object_sha1);
+	return found ? found->val_sha1 : NULL;
 }
 
 void free_notes(void)
@@ -481,7 +482,7 @@ void format_note(const unsigned char *object_sha1, struct strbuf *sb,
 		const char *output_encoding, int flags)
 {
 	static const char utf8[] = "utf-8";
-	unsigned char *sha1;
+	const unsigned char *sha1;
 	char *msg, *msg_p;
 	unsigned long linelen, msglen;
 	enum object_type type;
@@ -489,7 +490,7 @@ void format_note(const unsigned char *object_sha1, struct strbuf *sb,
 	if (!initialized)
 		init_notes(NULL, 0);
 
-	sha1 = lookup_notes(object_sha1);
+	sha1 = get_note(object_sha1);
 	if (!sha1)
 		return;
 
diff --git a/notes.h b/notes.h
index 9e66855..0041aec 100644
--- a/notes.h
+++ b/notes.h
@@ -28,6 +28,13 @@ void add_note(const unsigned char *object_sha1,
 /* Remove the given note object from the internal notes tree structure */
 void remove_note(const unsigned char *object_sha1);
 
+/*
+ * Get the note object SHA1 containing the note data for the given object
+ *
+ * Return NULL if the given object has no notes.
+ */
+const unsigned char *get_note(const unsigned char *object_sha1);
+
 /* Free (and de-initialize) the internal notes tree structure */
 void free_notes(void);
 
-- 
1.7.0.rc1.141.gd3fd
