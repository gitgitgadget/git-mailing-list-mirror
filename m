From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] notes: make expand_notes_ref globally accessible
Date: Tue, 29 Mar 2011 16:55:32 -0400
Message-ID: <20110329205532.GA23466@sigill.intra.peff.net>
References: <20110329205307.GA30959@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:55:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4fwy-0002YT-A4
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 22:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab1C2Uzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 16:55:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48171
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975Ab1C2Uze (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 16:55:34 -0400
Received: (qmail 315 invoked by uid 107); 29 Mar 2011 20:56:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 16:56:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 16:55:32 -0400
Content-Disposition: inline
In-Reply-To: <20110329205307.GA30959@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170321>

This function is useful for other commands besides "git
notes" which want to let users refer to notes by their
shorthand name.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/notes.c |   10 ----------
 notes.c         |   10 ++++++++++
 notes.h         |    3 +++
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index a0f310b..6227607 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -100,16 +100,6 @@ struct msg_arg {
 	struct strbuf buf;
 };
 
-static void expand_notes_ref(struct strbuf *sb)
-{
-	if (!prefixcmp(sb->buf, "refs/notes/"))
-		return; /* we're happy */
-	else if (!prefixcmp(sb->buf, "notes/"))
-		strbuf_insert(sb, 0, "refs/", 5);
-	else
-		strbuf_insert(sb, 0, "refs/notes/", 11);
-}
-
 static int list_each_note(const unsigned char *object_sha1,
 		const unsigned char *note_sha1, char *note_path,
 		void *cb_data)
diff --git a/notes.c b/notes.c
index a013c1b..f6b9b6a 100644
--- a/notes.c
+++ b/notes.c
@@ -1285,3 +1285,13 @@ int copy_note(struct notes_tree *t,
 
 	return 0;
 }
+
+void expand_notes_ref(struct strbuf *sb)
+{
+	if (!prefixcmp(sb->buf, "refs/notes/"))
+		return; /* we're happy */
+	else if (!prefixcmp(sb->buf, "notes/"))
+		strbuf_insert(sb, 0, "refs/", 5);
+	else
+		strbuf_insert(sb, 0, "refs/notes/", 11);
+}
diff --git a/notes.h b/notes.h
index 83bd6e0..60bdf28 100644
--- a/notes.h
+++ b/notes.h
@@ -307,4 +307,7 @@ void string_list_add_refs_by_glob(struct string_list *list, const char *glob);
 void string_list_add_refs_from_colon_sep(struct string_list *list,
 					 const char *globs);
 
+/* Expand inplace a note ref like "foo" or "notes/foo" into "refs/notes/foo" */
+void expand_notes_ref(struct strbuf *sb);
+
 #endif
-- 
1.7.4.2.7.g9407
