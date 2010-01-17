From: Johan Herland <johan@herland.net>
Subject: [PATCHv11 07/20] Notes API: get_note(): Return the note annotating the
 given object
Date: Sun, 17 Jan 2010 22:04:24 +0100
Message-ID: <1263762277-31419-8-git-send-email-johan@herland.net>
References: <1263762277-31419-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 22:05:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWcJX-0007Cz-Vx
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 22:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab0AQVFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 16:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754725Ab0AQVFM
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 16:05:12 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62433 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754758Ab0AQVFH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jan 2010 16:05:07 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE002C8T8G0RE0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:04 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE00CILT85S310@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:04 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.17.205416
X-Mailer: git-send-email 1.6.6.rc1.321.g0496e
In-reply-to: <1263762277-31419-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137326>

Created by a simple cleanup and rename of lookup_notes().

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |   15 ++++++++-------
 notes.h |    3 +++
 2 files changed, 11 insertions(+), 7 deletions(-)

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
index 9e66855..c0714f4 100644
--- a/notes.h
+++ b/notes.h
@@ -28,6 +28,9 @@ void add_note(const unsigned char *object_sha1,
 /* Remove the given note object from the internal notes tree structure */
 void remove_note(const unsigned char *object_sha1);
 
+/* Get the note object SHA1 containing the note data for the given object */
+const unsigned char *get_note(const unsigned char *object_sha1);
+
 /* Free (and de-initialize) the internal notes tree structure */
 void free_notes(void);
 
-- 
1.6.6.rc1.321.g0496e
