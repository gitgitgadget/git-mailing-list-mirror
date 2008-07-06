From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH] git-mailinfo may corrupt patch headers on attached files
Date: Sun,  6 Jul 2008 17:21:01 -0400
Message-ID: <1215379261-10802-1-git-send-email-dzickus@redhat.com>
References: <alpine.LFD.1.10.0807061036500.3016@woody.linux-foundation.org>
Cc: torvalds@linux-foundation.org, Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 23:22:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFbgW-000222-ID
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 23:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758003AbYGFVVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 17:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757627AbYGFVVT
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 17:21:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51627 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757530AbYGFVVS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 17:21:18 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m66LL4v5027925;
	Sun, 6 Jul 2008 17:21:04 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m66LL3aG013178;
	Sun, 6 Jul 2008 17:21:03 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m66LL27X028321;
	Sun, 6 Jul 2008 17:21:02 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m66LL2is010892;
	Sun, 6 Jul 2008 17:21:02 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m66LL2H0010891;
	Sun, 6 Jul 2008 17:21:02 -0400
X-Mailer: git-send-email 1.5.6.rc2.48.g13da
In-Reply-To: <alpine.LFD.1.10.0807061036500.3016@woody.linux-foundation.org>
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87557>

Boundary lines in emails are treated as a special case.  As a result of
processing the boundary line a new line will be read into the buffer.

The string length variable 'len' is evaluated before the boundary case, thus
there is the possibility the length of the string does not match the new
line read in (in the boundary line case).  This causes a partial output of
the line to the patch file.

The fix is trivial, evaluate the length of the string right before
processing it.

Signed-off-by: Don Zickus <dzickus@redhat.com>
---

I noticed this the other day, just never got a chance to send the fix out.
This might be the same problem I ran into.

Cheers,
Don

 builtin-mailinfo.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 2894e34..cedda18 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -795,7 +795,7 @@ static void handle_body(void)
 	int rc = 0;
 	static char newline[2000];
 	static char *np = newline;
-	int len = strlen(line);
+	int len;
 
 	/* Skip up to the first boundary */
 	if (content_top->boundary) {
@@ -814,6 +814,9 @@ static void handle_body(void)
 				return;
 		}
 
+		/* line may have changed after handling boundary, check len */
+		len = strlen(line);
+
 		/* Unwrap transfer encoding */
 		len = decode_transfer_encoding(line, sizeof(line), len);
 		if (len < 0) {
-- 
1.5.6.rc2.48.g13da
