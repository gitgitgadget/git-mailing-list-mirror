From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 09/23] builtin/notes.c: Split notes ref DWIMmery into a
 separate function
Date: Mon, 25 Oct 2010 02:08:39 +0200
Message-ID: <1287965333-5099-10-git-send-email-johan@herland.net>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 25 02:10:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAAdk-0000ju-59
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 02:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878Ab0JYAJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 20:09:24 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59867 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794Ab0JYAJV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 20:09:21 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT00504KFHGG50@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:17 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 6487017990AE_CC4CAADB	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:17 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 4D0D2179677A_CC4CAADF	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:17 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT004SRKFAVB20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:12 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1287965333-5099-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159903>

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
1.7.3.98.g5ad7d9
