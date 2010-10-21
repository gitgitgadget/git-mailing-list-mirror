From: Federico Cuello <fedux@lugmen.org.ar>
Subject: [PATCH] Fix git-apply with -p greater than 1
Date: Thu, 21 Oct 2010 19:12:02 -0300
Message-ID: <1287699122-26702-1-git-send-email-fedux@lugmen.org.ar>
Cc: Federico Cuello <fedux@lugmen.org.ar>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 00:19:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P93Tw-0004bl-BA
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 00:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758660Ab0JUWTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 18:19:18 -0400
Received: from 64-76-18-116.static.impsat.net.ar ([64.76.18.116]:34274 "EHLO
	mother.lugmen.org.ar" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab0JUWTR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 18:19:17 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Oct 2010 18:19:17 EDT
Received: from mail.fedux.com.ar (unknown [186.18.64.224])
	by mother.lugmen.org.ar (Postfix) with ESMTPSA id 560A819E692
	for <git@vger.kernel.org>; Thu, 21 Oct 2010 19:12:18 -0300 (ART)
Received: by mail.fedux.com.ar (Postfix, from userid 1000)
	id A8205100FB; Thu, 21 Oct 2010 19:12:16 -0300 (ART)
X-Mailer: git-send-email 1.7.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159580>

Fix the case when the patch is a rename or mode-change only
and -p is used with a value greater than one.
The git_header_name function did not remove more than one path
component.

Signed-off-by: Federico Cuello <fedux@lugmen.org.ar>
---
 builtin/apply.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 23c18c5..14996f8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1132,15 +1132,11 @@ static char *git_header_name(char *line, int llen)
 		case '\n':
 			return NULL;
 		case '\t': case ' ':
-			second = name+len;
-			for (;;) {
-				char c = *second++;
-				if (c == '\n')
-					return NULL;
-				if (c == '/')
-					break;
-			}
-			if (second[len] == '\n' && !memcmp(name, second, len)) {
+			second = stop_at_slash(name + len, (name - line) + len);
+			if (!second)
+				return NULL;
+			second++;
+			if (second[len] == '\n' && !strncmp(name, second, len)) {
 				return xmemdupz(name, len);
 			}
 		}
-- 
1.7.3.1
