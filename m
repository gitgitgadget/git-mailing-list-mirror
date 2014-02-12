From: David Kastrup <dak@gnu.org>
Subject: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Wed, 12 Feb 2014 15:27:24 +0100
Message-ID: <1392215244-26785-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 12 15:30:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDapR-0007rf-NE
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 15:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbaBLOaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 09:30:15 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:50735 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbaBLOaO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 09:30:14 -0500
Received: from localhost ([127.0.0.1]:49776 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WDapI-0006FN-V9; Wed, 12 Feb 2014 09:30:13 -0500
Received: by lola (Postfix, from userid 1000)
	id 18C95E047A; Wed, 12 Feb 2014 15:27:33 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241993>

Making a single preparation run for counting the lines will avoid memory
fragmentation.  Also, fix the allocated memory size which was wrong
when sizeof(int *) != sizeof(int), and would have been too small
for sizeof(int *) < sizeof(int), admittedly unlikely.

Signed-off-by: David Kastrup <dak@gnu.org>
---

Since there was no feedback after the last defense/explanation of the
coding choices, the code rewritten by this patch was much more awful,
and the kind of style requests (fixed already in the last iteration)
are not actually heeded by the core developers themselves, I have no
idea whether this patch will be dropped just like the last one.

As opposed to the last try, this incorporates a suggestion from Jeff
to change sizeof(type) to sizeof(expression) which is not helping much
since the types of lineno and sb->lineno still need to be changed in
sync.

It also fiddles cosmetically with the code layout of the loops.

builtin/blame.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e44a6bb..1aefedf 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1772,25 +1772,41 @@ static int prepare_lines(struct scoreboard *sb)
 {
 	const char *buf = sb->final_buf;
 	unsigned long len = sb->final_buf_size;
-	int num = 0, incomplete = 0, bol = 1;
+	const char *end = buf + len;
+	const char *p;
+	int *lineno;
+	int num = 0, incomplete = 0;
 
-	if (len && buf[len-1] != '\n')
-		incomplete++; /* incomplete line at the end */
-	while (len--) {
-		if (bol) {
-			sb->lineno = xrealloc(sb->lineno,
-					      sizeof(int *) * (num + 1));
-			sb->lineno[num] = buf - sb->final_buf;
-			bol = 0;
-		}
-		if (*buf++ == '\n') {
+	for (p = buf;;) {
+		p = memchr(p, '\n', end - p);
+		if (p) {
+			p++;
 			num++;
-			bol = 1;
+			continue;
 		}
+		break;
 	}
-	sb->lineno = xrealloc(sb->lineno,
-			      sizeof(int *) * (num + incomplete + 1));
-	sb->lineno[num + incomplete] = buf - sb->final_buf;
+
+	if (len && end[-1] != '\n')
+		incomplete++; /* incomplete line at the end */
+
+	sb->lineno = xmalloc(sizeof(*sb->lineno) * (num + incomplete + 1));
+	lineno = sb->lineno;
+
+	*lineno++ = 0;
+	for (p = buf;;) {
+		p = memchr(p, '\n', end - p);
+		if (p) {
+			p++;
+			*lineno++ = p - buf;
+			continue;
+		}
+		break;
+	}
+
+	if (incomplete)
+		*lineno++ = len;
+
 	sb->num_lines = num + incomplete;
 	return sb->num_lines;
 }
-- 
1.8.3.2
