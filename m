From: David Kastrup <dak@gnu.org>
Subject: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue,  4 Feb 2014 22:40:11 +0100
Message-ID: <1391550011-17015-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 22:40:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAnjG-0008Jf-O6
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 22:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933595AbaBDVkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 16:40:21 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:53717 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933564AbaBDVkS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 16:40:18 -0500
Received: from localhost ([127.0.0.1]:52760 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WAnj7-0005zU-8t; Tue, 04 Feb 2014 16:40:17 -0500
Received: by lola (Postfix, from userid 1000)
	id C899EE0478; Tue,  4 Feb 2014 22:40:16 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241558>

Making a single preparation run for counting the lines will avoid memory
fragmentation.  Also, fix the allocated memory size which was wrong
when sizeof(int *) != sizeof(int), and would have been too small
for sizeof(int *) < sizeof(int), admittedly unlikely.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 builtin/blame.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e44a6bb..c422584 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2006, Junio C Hamano
  */
 
+#include "git-compat-util.h"
 #include "cache.h"
 #include "builtin.h"
 #include "blob.h"
@@ -1772,25 +1773,38 @@ static int prepare_lines(struct scoreboard *sb)
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
+	for (p = buf;; num++) {
+		p = memchr(p, '\n', end - p);
+		if (p) {
+			p++;
+			continue;
 		}
-		if (*buf++ == '\n') {
-			num++;
-			bol = 1;
+		break;
+	}
+
+	if (len && end[-1] != '\n')
+		incomplete++; /* incomplete line at the end */
+
+	sb->lineno = lineno = xmalloc(sizeof(int) * (num + incomplete + 1));
+
+	for (p = buf;;) {
+		*lineno++ = p - buf;
+		p = memchr(p, '\n', end - p);
+		if (p) {
+			p++;
+			continue;
 		}
+		break;
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
