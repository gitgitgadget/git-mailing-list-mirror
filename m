From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH] Allow emails with boundaries to work again [v2]
Date: Thu, 14 Aug 2008 11:35:42 -0400
Message-ID: <1218728142-23780-1-git-send-email-dzickus@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 17:37:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTesz-0002Ha-CX
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 17:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbYHNPgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 11:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbYHNPgI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 11:36:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46001 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351AbYHNPgG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 11:36:06 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m7EFZidu017338
	for <git@vger.kernel.org>; Thu, 14 Aug 2008 11:35:44 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m7EFZhVI022789;
	Thu, 14 Aug 2008 11:35:43 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m7EFZh74000451;
	Thu, 14 Aug 2008 11:35:43 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m7EFZguh023805;
	Thu, 14 Aug 2008 11:35:43 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m7EFZgxq023804;
	Thu, 14 Aug 2008 11:35:42 -0400
X-Mailer: git-send-email 1.5.5.1
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92366>

Recent changes to is_multipart_boundary() caused git-mailinfo to segfault.
The reason was after handling the end of the boundary the code tried to look
for another boundary.  Because the boundary list was empty, dereferencing
the pointer to the top of the boundary caused the program to go boom.

The fix is to check to see if the list is empty and if so go on its merry
way instead of looking for another boundary.

I also fixed a couple of increments and decrements that didn't look correct
relating to content_top.

The boundary test case was updated to catch future problems like this again.

Signed-Off-by: Don Zickus <dzickus@redhat.com>

---
Junio,

I modified the patch more to your liking, I think.  You inquired about
returning after failing from find_boundary() and I gave you a not so correct
answer.  Once I re-read the code this morning (minus a screaming kid in the
background), I realized it was easy to do and more correct.

I also figured out why the boundary test case didn't catch this.  Apparently
find_boundary() went to read another line and found none, so it returned 0.
Adding an empty line to sample.mbox, caused git-mailinfo to segfault like
the way I saw it.  My fix allows everything to work again.

Cheers,
Don
---
 builtin-mailinfo.c  |    6 +++---
 t/t5100/sample.mbox |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 6ae2bf3..207d0ef 100644
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
@@ -603,7 +603,7 @@ static void handle_filter(struct strbuf *line);
 static int find_boundary(void)
 {
 	while (!strbuf_getline(&line, fin, '\n')) {
-		if (is_multipart_boundary(&line))
+		if (*content_top && is_multipart_boundary(&line))
 			return 1;
 	}
 	return 0;
@@ -626,7 +626,7 @@ again:
 		/* technically won't happen as is_multipart_boundary()
 		   will fail first.  But just in case..
 		 */
-		if (content_top-- < content) {
+		if (--content_top < content) {
 			fprintf(stderr, "Detected mismatched boundaries, "
 					"can't recover\n");
 			exit(1);
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index d7ca79b..4bf7947 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -500,3 +500,4 @@ index 3e5fe51..aabfe5c 100644
 1.6.0.rc2
 
 --=-=-=--
+
-- 
1.5.5.1
