From: Johan Herland <johan@herland.net>
Subject: [PATCH 07/18] builtin/notes.c: Split notes ref DWIMmery into a
 separate function
Date: Wed, 29 Sep 2010 02:23:20 +0200
Message-ID: <1285719811-10871-8-git-send-email-johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 02:24:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0kTW-0001F0-3a
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 02:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049Ab0I2AYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 20:24:34 -0400
Received: from smtp.getmail.no ([84.208.15.66]:44298 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab0I2AXt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 20:23:49 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H003Z7FRLTS70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:45 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 287BF1EEF845_CA28711B	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:45 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 189031EEF844_CA28711F	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:44 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H00IQEFRHZC10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:42 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1285719811-10871-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157515>

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
