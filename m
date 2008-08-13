From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH] Allow emails with boundaries to work again
Date: Wed, 13 Aug 2008 18:45:59 -0400
Message-ID: <1218667559-26618-1-git-send-email-dzickus@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 00:47:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTP7U-0005GU-D7
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 00:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbYHMWqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 18:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbYHMWqE
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 18:46:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47053 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875AbYHMWqB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 18:46:01 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m7DMk0bt029025
	for <git@vger.kernel.org>; Wed, 13 Aug 2008 18:46:00 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m7DMk069023665;
	Wed, 13 Aug 2008 18:46:00 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m7DMjx0r022130;
	Wed, 13 Aug 2008 18:45:59 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m7DMjxUl026644;
	Wed, 13 Aug 2008 18:45:59 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m7DMjxxb026643;
	Wed, 13 Aug 2008 18:45:59 -0400
X-Mailer: git-send-email 1.5.5.1
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92289>

Recent changes to is_multipart_boundary() caused git-mailinfo to segfault.
The reason was after handling the end of the boundary the code tried to look
for another boundary.  Because the boundary list was empty, dereferencing
the pointer to the top of the boundary caused the program to go boom.

The fix is to check to see if the list is empty and if so go on its merry
way instead of looking for another boundary.

I also fixed a couple of increments and decrements that didn't look correct
relating to content_top.

Signed-Off-by: Don Zickus <dzickus@redhat.com>
---
 builtin-mailinfo.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 6ae2bf3..0209e82 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -175,7 +175,7 @@ static void handle_content_type(struct strbuf *line)
 		 message_type = TYPE_OTHER;
 	if (slurp_attr(line->buf, "boundary=", boundary)) {
 		strbuf_insert(boundary, 0, "--", 2);
-		if (content_top++ >= &content[MAX_BOUNDARIES]) {
+		if (++content_top > &content[MAX_BOUNDARIES]) {
 			fprintf(stderr, "Too many boundaries to handle\n");
 			exit(1);
 		}
@@ -626,7 +626,7 @@ again:
 		/* technically won't happen as is_multipart_boundary()
 		   will fail first.  But just in case..
 		 */
-		if (content_top-- < content) {
+		if (--content_top < content) {
 			fprintf(stderr, "Detected mismatched boundaries, "
 					"can't recover\n");
 			exit(1);
@@ -635,9 +635,11 @@ again:
 		strbuf_release(&newline);
 
 		/* skip to the next boundary */
-		if (!find_boundary())
-			return 0;
-		goto again;
+		if (*content_top) {
+			if (!find_boundary())
+				return 0;
+			goto again;
+		}
 	}
 
 	/* set some defaults */
-- 
1.5.5.1
