From: David Kastrup <dak@gnu.org>
Subject: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue,  4 Feb 2014 21:06:07 +0100
Message-ID: <1391544367-14599-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 21:06:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAmGW-0005gL-Vx
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 21:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596AbaBDUGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 15:06:37 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:51632 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbaBDUGf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 15:06:35 -0500
Received: from localhost ([127.0.0.1]:50673 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WAmGQ-0004Zi-Qr; Tue, 04 Feb 2014 15:06:35 -0500
Received: by lola (Postfix, from userid 1000)
	id EA08CE0B66; Tue,  4 Feb 2014 21:06:16 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241545>

Making a single preparation run for counting the lines will avoid memory
fragmentation.  Also, fix the allocated memory size which was wrong
when sizeof(int *) != sizeof(int), and would have been too small
for sizeof(int *) < sizeof(int), admittedly unlikely.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 builtin/blame.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e44a6bb..522986d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1772,25 +1772,33 @@ static int prepare_lines(struct scoreboard *sb)
 {
 	const char *buf = sb->final_buf;
 	unsigned long len = sb->final_buf_size;
-	int num = 0, incomplete = 0, bol = 1;
+	const char *end = buf + len;
+	const char *p;
+	int *lineno;
+	
+	int num = 0, incomplete = 0;
+
+	for (p = buf;;) {
+		if ((p = memchr(p, '\n', end-p)) == NULL)
+			break;
+		++num, ++p;
+	}
 
-	if (len && buf[len-1] != '\n')
+	if (len && end[-1] != '\n')
 		incomplete++; /* incomplete line at the end */
-	while (len--) {
-		if (bol) {
-			sb->lineno = xrealloc(sb->lineno,
-					      sizeof(int *) * (num + 1));
-			sb->lineno[num] = buf - sb->final_buf;
-			bol = 0;
-		}
-		if (*buf++ == '\n') {
-			num++;
-			bol = 1;
-		}
+
+	sb->lineno = lineno = xmalloc(sizeof(int) * (num + incomplete + 1));
+
+	for (p = buf;;) {
+		*lineno++ = p-buf;
+		if ((p = memchr(p, '\n', end-p)) == NULL)
+			break;
+		++p;
 	}
-	sb->lineno = xrealloc(sb->lineno,
-			      sizeof(int *) * (num + incomplete + 1));
-	sb->lineno[num + incomplete] = buf - sb->final_buf;
+
+	if (incomplete)
+		*lineno++ = len;
+
 	sb->num_lines = num + incomplete;
 	return sb->num_lines;
 }
-- 
1.8.3.2
