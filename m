From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH 1/2] Make section_name_match start on '[', and return the length on success
Date: Fri, 24 Jul 2009 17:21:43 -0400
Message-ID: <1248470504-16326-2-git-send-email-alex@chmrr.net>
References: <1248470504-16326-1-git-send-email-alex@chmrr.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 23:22:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUSDe-0004l0-W4
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 23:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbZGXVWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 17:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754218AbZGXVWH
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 17:22:07 -0400
Received: from chmrr.net ([209.67.253.66]:39053 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754146AbZGXVWG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 17:22:06 -0400
Received: from c-67-186-135-139.hsd1.ma.comcast.net ([67.186.135.139] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alex@chmrr.net>)
	id 1MUSDN-0001dq-F1
	for git@vger.kernel.org; Fri, 24 Jul 2009 17:22:06 -0400
X-Mailer: git-send-email 1.6.3.3.473.gb74fc4.dirty
In-Reply-To: <1248470504-16326-1-git-send-email-alex@chmrr.net>
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Spam-Score: -4.4
X-Spam-Score-Int: -43
X-Exim-Version: 4.69 (build at 07-Feb-2009 20:08:51)
X-Date: 2009-07-24 17:22:06
X-Connected-IP: 67.186.135.139:41933
X-Message-Linecount: 62
X-Body-Linecount: 53
X-Message-Size: 1885
X-Body-Size: 1452
X-Received-Count: 1
X-Recipient-Count: 1
X-Local-Recipient-Count: 1
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123949>


Signed-off-by: Alex Vandiver <alex@chmrr.net>
---
 config.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 04380bb..7d6f6f6 100644
--- a/config.c
+++ b/config.c
@@ -1194,7 +1194,9 @@ write_err_out:
 static int section_name_match (const char *buf, const char *name)
 {
 	int i = 0, j = 0, dot = 0;
-	for (; buf[i] && buf[i] != ']'; i++) {
+	if (buf[i] != '[')
+		return 0;
+	for (i = 1; buf[i] && buf[i] != ']'; i++) {
 		if (!dot && isspace(buf[i])) {
 			dot = 1;
 			if (name[j++] != '.')
@@ -1215,7 +1217,17 @@ static int section_name_match (const char *buf, const char *name)
 		if (buf[i] != name[j++])
 			break;
 	}
-	return (buf[i] == ']' && name[j] == 0);
+	if (buf[i] == ']' && name[j] == 0) {
+		/*
+		 * We match, now just find the right length offset by
+		 * gobbling up any whitespace after it, as well
+		 */
+		i++;
+		for (; buf[i] && isspace(buf[i]); i++)
+			; /* do nothing */
+		return i;
+	}
+	return 0;
 }
 
 /* if new_name == NULL, the section is removed instead */
@@ -1249,7 +1261,8 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 			; /* do nothing */
 		if (buf[i] == '[') {
 			/* it's a section */
-			if (section_name_match (&buf[i+1], old_name)) {
+			int offset = section_name_match (&buf[i], old_name);
+			if (offset > 0) {
 				ret++;
 				if (new_name == NULL) {
 					remove = 1;
-- 
1.6.3.3.473.gb74fc4.dirty
