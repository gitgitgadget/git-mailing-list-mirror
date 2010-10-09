From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 09/21] builtin/notes.c: Split notes ref DWIMmery into a separate function
Date: Sat,  9 Oct 2010 03:11:29 +0200
Message-ID: <1286586701-3586-10-git-send-email-johan@herland.net>
References: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 03:13:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4O0B-0002yh-4r
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387Ab0JIBNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 21:13:14 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:63669 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932281Ab0JIBNM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:13:12 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=localhost.localdomain)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4Nzr-0001bt-El; Sat, 09 Oct 2010 03:13:11 +0200
X-Mailer: git-send-email 1.7.3.1.104.g92b87a
In-Reply-To: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158559>

expand_notes_ref() is a new function that performs the DWIM transformation
of "foo" -> "refs/notes/foo" where notes refs are expected.

This is done in preparation for future patches which will also need this
DWIM functionality.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 35f6eb6..9c91c59 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -83,6 +83,16 @@ struct msg_arg {
 	struct strbuf buf;
 };
 
+static void expand_notes_ref(struct strbuf *sb)
+{
+	if (!prefixcmp(sb->buf, "refs/notes/"))
+		return; /* we're happy */
+	else if (!prefixcmp(sb->buf, "notes/"))
+		strbuf_insert(sb, 0, "refs/", 5);
+	else
+		strbuf_insert(sb, 0, "refs/notes/", 11);
+}
+
 static int list_each_note(const unsigned char *object_sha1,
 		const unsigned char *note_sha1, char *note_path,
 		void *cb_data)
@@ -839,13 +849,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	if (override_notes_ref) {
 		struct strbuf sb = STRBUF_INIT;
-		if (!prefixcmp(override_notes_ref, "refs/notes/"))
-			/* we're happy */;
-		else if (!prefixcmp(override_notes_ref, "notes/"))
-			strbuf_addstr(&sb, "refs/");
-		else
-			strbuf_addstr(&sb, "refs/notes/");
 		strbuf_addstr(&sb, override_notes_ref);
+		expand_notes_ref(&sb);
 		setenv("GIT_NOTES_REF", sb.buf, 1);
 		strbuf_release(&sb);
 	}
-- 
1.7.3.1.104.g92b87a
