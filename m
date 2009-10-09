From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv7 18/22] Notes API: get_note(): Return the note annotating
 the given object
Date: Fri, 09 Oct 2009 12:22:14 +0200
Message-ID: <1255083738-23263-20-git-send-email-johan@herland.net>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:32:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwClX-0004PL-7n
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760713AbZJIKY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760716AbZJIKY4
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:24:56 -0400
Received: from smtp.getmail.no ([84.208.15.66]:54694 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760712AbZJIKYy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 06:24:54 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800BSTSUE9320@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:23:02 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800IEJST91V00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:23:02 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.9.101220
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1255083738-23263-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129788>

Created by a simple cleanup and rename of lookup_notes().

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |   15 ++++++++-------
 notes.h |    3 +++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/notes.c b/notes.c
index 49a3e86..2196a5f 100644
--- a/notes.c
+++ b/notes.c
@@ -377,12 +377,13 @@ void add_note(const unsigned char *object_sha1, const unsigned char *note_sha1)
 	note_tree_insert(&root_node, 0, l, PTR_TYPE_NOTE);
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
@@ -396,7 +397,7 @@ void format_note(const unsigned char *object_sha1, struct strbuf *sb,
 		const char *output_encoding, int flags)
 {
 	static const char utf8[] = "utf-8";
-	unsigned char *sha1;
+	const unsigned char *sha1;
 	char *msg, *msg_p;
 	unsigned long linelen, msglen;
 	enum object_type type;
@@ -404,7 +405,7 @@ void format_note(const unsigned char *object_sha1, struct strbuf *sb,
 	if (!initialized)
 		init_notes(NULL, 0);
 
-	sha1 = lookup_notes(object_sha1);
+	sha1 = get_note(object_sha1);
 	if (!sha1)
 		return;
 
diff --git a/notes.h b/notes.h
index 5f22852..21a8930 100644
--- a/notes.h
+++ b/notes.h
@@ -25,6 +25,9 @@ void init_notes(const char *notes_ref, int flags);
 void add_note(const unsigned char *object_sha1,
 		const unsigned char *note_sha1);
 
+/* Get the note object SHA1 containing the note data for the given object */
+const unsigned char *get_note(const unsigned char *object_sha1);
+
 /* Free (and de-initialize) the internal notes tree structure */
 void free_notes(void);
 
-- 
1.6.4.304.g1365c.dirty
