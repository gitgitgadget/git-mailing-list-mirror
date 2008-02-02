From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/13] builtin-apply.c: restructure "offset" matching
Date: Sat,  2 Feb 2008 02:54:08 -0800
Message-ID: <1201949659-27725-3-git-send-email-gitster@pobox.com>
References: <1201949659-27725-1-git-send-email-gitster@pobox.com>
 <1201949659-27725-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 11:55:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLG1h-0005A3-SN
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762133AbYBBKyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762252AbYBBKyj
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:54:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43745 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761830AbYBBKy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:54:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F275850EC
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C68850EB
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:26 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.g41ac4
In-Reply-To: <1201949659-27725-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72246>

This restructures code to find matching location with offset
in find_offset() function, so that there is need for only one
call site of match_fragment() function.  There still isn't a
change in the logic of the program.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |   49 +++++++++++++++++++++++++------------------------
 1 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 2c052f8..0a304ab 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1452,8 +1452,8 @@ static int find_offset(const char *buf, unsigned long size,
 		       const char *fragment, unsigned long fragsize,
 		       int line, int *lines)
 {
-	int i;
-	unsigned long start, backwards, forwards;
+	int i, no_more_backwards, no_more_forwards;
+	unsigned long start, backwards, forwards, try;
 
 	if (fragsize > size)
 		return -1;
@@ -1471,32 +1471,44 @@ static int find_offset(const char *buf, unsigned long size,
 		}
 	}
 
-	/* Exact line number? */
-	if (match_fragment(buf, size, start, fragment, fragsize))
-		return start;
-
 	/*
 	 * There's probably some smart way to do this, but I'll leave
 	 * that to the smart and beautiful people. I'm simple and stupid.
 	 */
 	backwards = start;
 	forwards = start;
+	try = start;
+
 	for (i = 0; ; i++) {
-		unsigned long try;
-		int n;
+		no_more_backwards = !backwards;
+		no_more_forwards = (forwards + fragsize > size);
+
+		if (match_fragment(buf, size, try, fragment, fragsize)) {
+			int shift = ((i+1) >> 1);
+			if (i & 1)
+				shift = -shift;
+			*lines = shift;
+			return try;
+		}
+
+	again:
+		if (no_more_backwards && no_more_forwards)
+			break;
 
-		/* "backward" */
 		if (i & 1) {
-			if (!backwards) {
-				if (forwards + fragsize > size)
-					break;
-				continue;
+			if (no_more_backwards) {
+				i++;
+				goto again;
 			}
 			do {
 				--backwards;
 			} while (backwards && buf[backwards-1] != '\n');
 			try = backwards;
 		} else {
+			if (no_more_forwards) {
+				i++;
+				goto again;
+			}
 			while (forwards + fragsize <= size) {
 				if (buf[forwards++] == '\n')
 					break;
@@ -1504,18 +1516,7 @@ static int find_offset(const char *buf, unsigned long size,
 			try = forwards;
 		}
 
-		if (!match_fragment(buf, size, try, fragment, fragsize))
-			continue;
-		n = (i >> 1)+1;
-		if (i & 1)
-			n = -n;
-		*lines = n;
-		return try;
 	}
-
-	/*
-	 * We should start searching forward and backward.
-	 */
 	return -1;
 }
 
-- 
1.5.4.2.g41ac4
