From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] attr: fix segfault in gitattributes parsing code
Date: Thu, 18 Oct 2007 22:02:35 +0200
Message-ID: <11927377551318-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Oct 18 22:03:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiba6-0002hT-5X
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 22:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763323AbXJRUCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 16:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbXJRUCl
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 16:02:41 -0400
Received: from mailer.zib.de ([130.73.108.11]:45203 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933070AbXJRUCk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 16:02:40 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9IK2a14022273;
	Thu, 18 Oct 2007 22:02:36 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9IK2aqY011575;
	Thu, 18 Oct 2007 22:02:36 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61557>

git may segfault if gitattributes contains an invalid
entry. A test is added to t0020 that triggers the segfault.
The parsing code is fixed to avoid the crash.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 attr.c          |    5 ++++-
 t/t0020-crlf.sh |    7 +++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/attr.c b/attr.c
index 92704a3..741db3b 100644
--- a/attr.c
+++ b/attr.c
@@ -209,8 +209,11 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		num_attr = 0;
 		cp = name + namelen;
 		cp = cp + strspn(cp, blank);
-		while (*cp)
+		while (*cp) {
 			cp = parse_attr(src, lineno, cp, &num_attr, res);
+			if (!cp)
+				return NULL;
+		}
 		if (pass)
 			break;
 		res = xcalloc(1,
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 0807d9f..62bc4bb 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -371,4 +371,11 @@ test_expect_success 'in-tree .gitattributes (4)' '
 	}
 '
 
+test_expect_success 'invalid .gitattributes (must not crash)' '
+
+	echo "three +crlf" >>.gitattributes &&
+	git diff
+
+'
+
 test_done
-- 
1.5.3.4.1261.g626eb
