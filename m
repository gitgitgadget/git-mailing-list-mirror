From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Ignore blank lines among this inbody headers
Date: Mon, 12 Jun 2006 13:29:56 -0600
Message-ID: <m1odwy5g0b.fsf_-_@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0606111535310.5498@g5.osdl.org>
	<m1wtbn468o.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0606111735440.5498@g5.osdl.org>
	<m17j3m6wmw.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 21:30:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fps6z-0002Ay-JJ
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 21:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWFLTaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 15:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752247AbWFLTaF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 15:30:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14749 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1752245AbWFLTaC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 15:30:02 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Debian-1) with ESMTP id k5CJTuR2006855;
	Mon, 12 Jun 2006 13:29:56 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Submit) id k5CJTusf006854;
	Mon, 12 Jun 2006 13:29:56 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <m17j3m6wmw.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Mon, 12 Jun 2006 12:45:27 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21734>


This is a fix for a regression introduced in:
8b4525fb3c6d79bd3a64b8f441237a4095db4e22.

When I refactored the inbody header parsing into a state machine I failed
to see the logic that skipped multiple leading spaces if they are present.
I think I assumed that logic was just there to skip the initial blank
line between the mail headers and the body.

This restores that behaviour and since we ignore all leading blank lines
in commit messages now this code removes the special case for the blank
line between the mail headers and the body.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

This is a resend to add my missing Signed-off-by line.
---
 mailinfo.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 5b6c215..3696d61 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -229,6 +229,14 @@ static int is_multipart_boundary(const c
 	return (!memcmp(line, multipart_boundary, multipart_boundary_len));
 }
 
+static int is_blank(char *line)
+{
+	char *ch;
+	for (ch = line; isspace(*ch); ch++)
+		;
+	return *ch == '\0';
+}
+
 static int eatspace(char *line)
 {
 	int len = strlen(line);
@@ -243,7 +251,7 @@ #define SEEN_SUBJECT 04
 #define SEEN_BOGUS_UNIX_FROM 010
 #define SEEN_PREFIX  020
 
-/* First lines of body can have From:, Date:, and Subject: */
+/* First lines of body can have From:, Date:, and Subject: or be blank */
 static void handle_inbody_header(int *seen, char *line)
 {
 	if (!memcmp(">From", line, 5) && isspace(line[5])) {
@@ -279,6 +287,10 @@ static void handle_inbody_header(int *se
 			return;
 		}
 	}
+	if (isspace(line[0])) {
+		if (!(*seen & SEEN_PREFIX) && is_blank(line))
+			return;
+	}
 	*seen |= SEEN_PREFIX;
 }
 
@@ -420,9 +432,7 @@ static int read_one_header_line(char *li
 		if (fgets(line + ofs, sz - ofs, in) == NULL)
 			break;
 		len = eatspace(line + ofs);
-		if (len == 0)
-			break;
-		if (!is_rfc2822_header(line)) {
+		if ((len == 0) || !is_rfc2822_header(line)) {
 			/* Re-add the newline */
 			line[ofs + len] = '\n';
 			line[ofs + len + 1] = '\0';
@@ -762,10 +772,8 @@ static void handle_body(void)
 {
 	int seen = 0;
 
-	if (line[0] || fgets(line, sizeof(line), stdin) != NULL) {
-		handle_commit_msg(&seen);
-		handle_patch();
-	}
+	handle_commit_msg(&seen);
+	handle_patch();
 	fclose(patchfile);
 	if (!patch_lines) {
 		fprintf(stderr, "No patch found\n");
-- 
1.4.0.g25f48-dirty
