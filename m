From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH 3/5] restrict the patch filtering
Date: Mon, 12 Mar 2007 15:52:06 -0400
Message-ID: <1173729128920-git-send-email-dzickus@redhat.com>
References: <11737291282223-git-send-email-dzickus@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 20:54:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQqaw-0002Ui-EC
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbXCLTxm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbXCLTxl
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:53:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55955 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbXCLTxk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:53:40 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2CJreLG022119
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 15:53:40 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2CJrY9a020370
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 15:53:34 -0400
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2CJrXKY029975;
	Mon, 12 Mar 2007 15:53:33 -0400
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l2CJq89k019771;
	Mon, 12 Mar 2007 15:52:08 -0400
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l2CJq87S019770;
	Mon, 12 Mar 2007 15:52:08 -0400
X-Mailer: git-send-email 1.5.0.2.211.g2ca9-dirty
In-Reply-To: <11737291282223-git-send-email-dzickus@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42077>

I have come across many emails that use long strings of '-'s as separators
for ideas.  This patch below limits the separator to only 3 '-', with the
intent that long string of '-'s will stay in the commit msg and not in the
patch file.

Signed-off-by: Don Zickus <dzickus@redhat.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

---
I purposedly separated this patch out because I wasn't sure if anyone would
have objections to it.  I tested it on numerous emails with and with patches
and didn't see any issues.
---
 builtin-mailinfo.c |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index dd0f563..a8d5b60 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -652,6 +652,39 @@ again:
 	return (fgets(line, sizeof(line), fin) != NULL);
 }
 
+static inline int patchbreak(const char *line)
+{
+	/* Beginning of a "diff -" header? */
+	if (!memcmp("diff -", line, 6))
+		return 1;
+
+	/* CVS "Index: " line? */
+	if (!memcmp("Index: ", line, 7))
+		return 1;
+
+	/*
+	 * "--- <filename>" starts patches without headers
+	 * "---<sp>*" is a manual separator
+	 */
+	if (!memcmp("---", line, 3)) {
+		line += 3;
+		/* space followed by a filename? */
+		if (line[0] == ' ' && !isspace(line[1]))
+			return 1;
+		/* Just whitespace? */
+		for (;;) {
+			unsigned char c = *line++;
+			if (c == '\n')
+				return 1;
+			if (!isspace(c))
+				break;
+		}
+		return 0;
+	}
+	return 0;
+}
+
+
 static int handle_commit_msg(char *line)
 {
 	static int still_looking=1;
@@ -673,9 +706,7 @@ static int handle_commit_msg(char *line)
 			return 0;
 	}
 
-	if (!memcmp("diff -", line, 6) ||
-	    !memcmp("---", line, 3) ||
-	    !memcmp("Index: ", line, 7)) {
+	if (patchbreak(line)) {
 		fclose(cmitmsg);
 		cmitmsg = NULL;
 		return 1;
-- 
1.5.0.2.211.g2ca9-dirty
