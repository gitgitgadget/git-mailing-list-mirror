From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv7 16/22] Notes API: init_notes(): Initialize the notes tree
 from the given notes ref
Date: Fri, 09 Oct 2009 12:22:12 +0200
Message-ID: <1255083738-23263-18-git-send-email-johan@herland.net>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:32:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwClV-0004PL-3l
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760706AbZJIKYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760704AbZJIKYj
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:24:39 -0400
Received: from smtp.getmail.no ([84.208.15.66]:58012 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760695AbZJIKYi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 06:24:38 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800BU7SUC8I20@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:23:00 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800IEJST91V00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:23:00 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.9.101220
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1255083738-23263-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129774>

Created by a simple refactoring of initialize_notes().

Also add a new 'flags' parameter, which is a bitwise combination of notes
initialization flags. For now, there is only one flag - NOTES_INIT_EMPTY -
which indicates that the notes tree should not auto-load the contents of
the given (or default) notes ref, but rather should leave the notes tree
initialized to an empty state. This will become useful in the future when
manipulating the notes tree through the notes API.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |   27 ++++++++++++++++-----------
 notes.h |   20 ++++++++++++++++++++
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/notes.c b/notes.c
index 0f7082f..f2bacbb 100644
--- a/notes.c
+++ b/notes.c
@@ -339,13 +339,25 @@ static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 	free(buf);
 }
 
-static void initialize_notes(const char *notes_ref_name)
+void init_notes(const char *notes_ref, int flags)
 {
 	unsigned char sha1[20], object_sha1[20];
 	unsigned mode;
 	struct leaf_node root_tree;
 
-	if (!notes_ref_name || read_ref(notes_ref_name, object_sha1) ||
+	assert(!initialized);
+	initialized = 1;
+
+	if (!notes_ref) {
+		const char *env = getenv(GIT_NOTES_REF_ENVIRONMENT);
+		if (env)
+			notes_ref = getenv(GIT_NOTES_REF_ENVIRONMENT);
+		else
+			notes_ref = GIT_NOTES_DEFAULT_REF;
+	}
+
+	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
+	    read_ref(notes_ref, object_sha1) ||
 	    get_tree_entry(object_sha1, "", sha1, &mode))
 		return;
 
@@ -378,15 +390,8 @@ void format_note(const unsigned char *object_sha1, struct strbuf *sb,
 	unsigned long linelen, msglen;
 	enum object_type type;
 
-	if (!initialized) {
-		const char *env = getenv(GIT_NOTES_REF_ENVIRONMENT);
-		if (env)
-			notes_ref_name = getenv(GIT_NOTES_REF_ENVIRONMENT);
-		else if (!notes_ref_name)
-			notes_ref_name = GIT_NOTES_DEFAULT_REF;
-		initialize_notes(notes_ref_name);
-		initialized = 1;
-	}
+	if (!initialized)
+		init_notes(NULL, 0);
 
 	sha1 = lookup_notes(object_sha1);
 	if (!sha1)
diff --git a/notes.h b/notes.h
index d745ed1..6b52799 100644
--- a/notes.h
+++ b/notes.h
@@ -1,6 +1,26 @@
 #ifndef NOTES_H
 #define NOTES_H
 
+/*
+ * Flags controlling behaviour of notes tree initialization
+ *
+ * Default behaviour is to initialize the notes tree from the tree object
+ * specified by the given (or default) notes ref.
+ */
+#define NOTES_INIT_EMPTY 1
+
+/*
+ * Initialize internal notes tree structure with the notes tree at the given
+ * ref. If given ref is NULL, the value of the $GIT_NOTES_REF environment
+ * variable is used, and if that is missing, the default notes ref is used
+ * ("refs/notes/commits").
+ *
+ * If you need to re-intialize the internal notes tree structure (e.g. loading
+ * from a different notes ref), please first de-initialize the current notes
+ * tree by calling free_notes().
+ */
+void init_notes(const char *notes_ref, int flags);
+
 /* Free (and de-initialize) the internal notes tree structure */
 void free_notes(void);
 
-- 
1.6.4.304.g1365c.dirty
