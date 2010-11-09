From: Johan Herland <johan@herland.net>
Subject: [PATCHv6 09/23] builtin/notes.c: Split notes ref DWIMmery into a
 separate function
Date: Tue, 09 Nov 2010 22:49:45 +0100
Message-ID: <1289339399-4733-10-git-send-email-johan@herland.net>
References: <1289339399-4733-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 22:53:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFw7v-0001tk-Sw
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 22:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544Ab0KIVvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 16:51:45 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61168 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755435Ab0KIVuT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 16:50:19 -0500
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBN005X70NOCV30@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 09 Nov 2010 22:50:12 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 362F81799CF2_CD9C214B	for <git@vger.kernel.org>; Tue,
 09 Nov 2010 21:50:12 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id C76C51799C92_CD9C213F	for <git@vger.kernel.org>; Tue,
 09 Nov 2010 21:50:11 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBN00HVN0NLS730@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 09 Nov 2010 22:50:11 +0100 (MET)
X-Mailer: git-send-email 1.7.3.2.173.gab1c9.dirty
In-reply-to: <1289339399-4733-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161096>

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
1.7.3.2.173.gab1c9.dirty
