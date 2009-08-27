From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 11/12] Add flags to get_commit_notes() to control the format
 of the note string
Date: Thu, 27 Aug 2009 03:43:56 +0200
Message-ID: <1251337437-16947-12-git-send-email-johan@herland.net>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 03:45:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgU2u-0004PF-Hx
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 03:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbZH0Bor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 21:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbZH0Boo
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 21:44:44 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52531 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932104AbZH0Bok (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2009 21:44:40 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP0002BFI6ITPA0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 03:44:42 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP000MW0I5F4H50@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 03:44:42 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.27.13316
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1251337437-16947-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127137>

This patch adds the following flags to get_commit_notes() for adjusting the
format of the produced note string:
- NOTES_SHOW_HEADER: Print "Notes:" line before the notes contents
- NOTES_INDENT: Indent notes contents by 4 spaces

Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c  |    8 +++++---
 notes.h  |    5 ++++-
 pretty.c |    3 ++-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/notes.c b/notes.c
index 5d1ee17..bf520ae 100644
--- a/notes.c
+++ b/notes.c
@@ -282,7 +282,7 @@ static unsigned char *lookup_notes(const unsigned char *commit_sha1)
 }
 
 void get_commit_notes(const struct commit *commit, struct strbuf *sb,
-		const char *output_encoding)
+		const char *output_encoding, int flags)
 {
 	static const char utf8[] = "utf-8";
 	unsigned char *sha1;
@@ -322,12 +322,14 @@ void get_commit_notes(const struct commit *commit, struct strbuf *sb,
 	if (msglen && msg[msglen - 1] == '\n')
 		msglen--;
 
-	strbuf_addstr(sb, "\nNotes:\n");
+	if (flags & NOTES_SHOW_HEADER)
+		strbuf_addstr(sb, "\nNotes:\n");
 
 	for (msg_p = msg; msg_p < msg + msglen; msg_p += linelen + 1) {
 		linelen = strchrnul(msg_p, '\n') - msg_p;
 
-		strbuf_addstr(sb, "    ");
+		if (flags & NOTES_INDENT)
+			strbuf_addstr(sb, "    ");
 		strbuf_add(sb, msg_p, linelen);
 		strbuf_addch(sb, '\n');
 	}
diff --git a/notes.h b/notes.h
index 79d21b6..7f3eed4 100644
--- a/notes.h
+++ b/notes.h
@@ -1,7 +1,10 @@
 #ifndef NOTES_H
 #define NOTES_H
 
+#define NOTES_SHOW_HEADER 1
+#define NOTES_INDENT 2
+
 void get_commit_notes(const struct commit *commit, struct strbuf *sb,
-		const char *output_encoding);
+		const char *output_encoding, int flags);
 
 #endif
diff --git a/pretty.c b/pretty.c
index e25db81..01eadd0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -978,7 +978,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 		strbuf_addch(sb, '\n');
 
 	if (fmt != CMIT_FMT_ONELINE)
-		get_commit_notes(commit, sb, encoding);
+		get_commit_notes(commit, sb, encoding,
+				 NOTES_SHOW_HEADER | NOTES_INDENT);
 
 	free(reencoded);
 }
-- 
1.6.4.304.g1365c.dirty
