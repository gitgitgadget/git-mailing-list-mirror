From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH 3/5] restrict the patch filtering v2
Date: Tue,  6 Mar 2007 17:59:57 -0500
Message-ID: <11732219972409-git-send-email-dzickus@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 00:01:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOies-0002RX-SL
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030579AbXCFXBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030608AbXCFXBY
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:01:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42737 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030579AbXCFXBX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:01:23 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l26N1MML005836
	for <git@vger.kernel.org>; Tue, 6 Mar 2007 18:01:22 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l26N1Mwq004019
	for <git@vger.kernel.org>; Tue, 6 Mar 2007 18:01:22 -0500
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l26N1LHh016976;
	Tue, 6 Mar 2007 18:01:21 -0500
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l26MxvwK024158;
	Tue, 6 Mar 2007 17:59:57 -0500
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l26Mxv1K024157;
	Tue, 6 Mar 2007 17:59:57 -0500
X-Mailer: git-send-email 1.5.0.2.213.g23f4-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41607>

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

Update: compiled and tested with my test mbox (~1200 emails).  output is
identical to the previous patch. 

---
 builtin-mailinfo.c |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 0532003..7b04179 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -644,6 +644,39 @@ again:
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
@@ -665,9 +698,7 @@ static int handle_commit_msg(char *line)
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
1.5.0.2.213.g23f4-dirty
