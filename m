From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH 3/5] restrict the patch filtering
Date: Wed, 14 Mar 2007 16:12:24 -0400
Message-ID: <1173903147792-git-send-email-dzickus@redhat.com>
References: <11739031463211-git-send-email-dzickus@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 21:14:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRZrE-0003IB-3n
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 21:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933131AbXCNUN4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 16:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933120AbXCNUN4
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 16:13:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38210 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933113AbXCNUNy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 16:13:54 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2EKDrAc014187
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:13:53 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2EKDq3T025155
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:13:52 -0400
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2EKDqa6007060;
	Wed, 14 Mar 2007 16:13:52 -0400
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l2EKCRt1009151;
	Wed, 14 Mar 2007 16:12:27 -0400
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l2EKCRQI009150;
	Wed, 14 Mar 2007 16:12:27 -0400
X-Mailer: git-send-email 1.5.0.2.213.g18c8-dirty
In-Reply-To: <11739031463211-git-send-email-dzickus@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42223>

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
