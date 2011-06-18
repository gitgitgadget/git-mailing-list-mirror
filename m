From: Yann Dirson <ydirson@free.fr>
Subject: [PATCH 2/6] Factorize shortening of notes refname for display.
Date: Sat, 18 Jun 2011 23:06:44 +0200
Message-ID: <1308431208-13353-3-git-send-email-ydirson@free.fr>
References: <201106151253.57908.johan@herland.net>
 <1308431208-13353-1-git-send-email-ydirson@free.fr>
Cc: Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 23:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY2jt-0007jg-AW
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 23:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111Ab1FRVHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 17:07:13 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:42447 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968Ab1FRVHK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 17:07:10 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 78DDCD4802A;
	Sat, 18 Jun 2011 23:07:04 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.76)
	(envelope-from <ydirson@free.fr>)
	id 1QY2jF-0003V1-GB; Sat, 18 Jun 2011 23:06:53 +0200
X-Mailer: git-send-email 1.7.5.3
In-Reply-To: <1308431208-13353-1-git-send-email-ydirson@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175987>

Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 notes.c |   24 ++++++++++++++++--------
 notes.h |    7 +++++++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/notes.c b/notes.c
index f6ce848..1a5676a 100644
--- a/notes.c
+++ b/notes.c
@@ -1235,16 +1235,11 @@ void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 		msglen--;
 
 	if (flags & NOTES_SHOW_HEADER) {
-		const char *ref = t->ref;
-		if (!ref || !strcmp(ref, GIT_NOTES_DEFAULT_REF)) {
+		const char *ref = notes_ref_shortname(t->ref);
+		if (!ref)
 			strbuf_addstr(sb, "\nNotes:\n");
-		} else {
-			if (!prefixcmp(ref, "refs/"))
-				ref += 5;
-			if (!prefixcmp(ref, "notes/"))
-				ref += 6;
+		else
 			strbuf_addf(sb, "\nNotes (%s):\n", ref);
-		}
 	}
 
 	for (msg_p = msg; msg_p < msg + msglen; msg_p += linelen + 1) {
@@ -1296,3 +1291,16 @@ void expand_notes_ref(struct strbuf *sb)
 	else
 		strbuf_insert(sb, 0, "refs/notes/", 11);
 }
+
+const char *notes_ref_shortname(const char *ref)
+{
+	if (!ref || !strcmp(ref, GIT_NOTES_DEFAULT_REF))
+		return NULL;
+	else {
+		if (!prefixcmp(ref, "refs/"))
+			ref += 5;
+		if (!prefixcmp(ref, "notes/"))
+			ref += 6;
+		return ref;
+	}
+}
diff --git a/notes.h b/notes.h
index c716694..d8ae29d 100644
--- a/notes.h
+++ b/notes.h
@@ -64,6 +64,13 @@ extern struct notes_tree {
 const char *default_notes_ref(void);
 
 /*
+ * Return a short name for a notes ref, suitable for display to the user.
+ *
+ * No copy is done, the return value is a pointer into the original string.
+ */
+const char *notes_ref_shortname(const char *ref);
+
+/*
  * Flags controlling behaviour of notes tree initialization
  *
  * Default behaviour is to initialize the notes tree from the tree object
-- 
1.7.5.3
