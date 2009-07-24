From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH 2/2] After renaming a section, print any trailing variable definitions
Date: Fri, 24 Jul 2009 17:21:44 -0400
Message-ID: <1248470504-16326-3-git-send-email-alex@chmrr.net>
References: <1248470504-16326-1-git-send-email-alex@chmrr.net>
 <1248470504-16326-2-git-send-email-alex@chmrr.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 23:22:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUSDg-0004l0-EA
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 23:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298AbZGXVWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 17:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754218AbZGXVWK
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 17:22:10 -0400
Received: from chmrr.net ([209.67.253.66]:39055 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754252AbZGXVWI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 17:22:08 -0400
Received: from c-67-186-135-139.hsd1.ma.comcast.net ([67.186.135.139] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alex@chmrr.net>)
	id 1MUSDO-0001dq-5n
	for git@vger.kernel.org; Fri, 24 Jul 2009 17:22:08 -0400
X-Mailer: git-send-email 1.6.3.3.473.gb74fc4.dirty
In-Reply-To: <1248470504-16326-2-git-send-email-alex@chmrr.net>
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Spam-Score: -4.4
X-Spam-Score-Int: -43
X-Exim-Version: 4.69 (build at 07-Feb-2009 20:08:51)
X-Date: 2009-07-24 17:22:08
X-Connected-IP: 67.186.135.139:41933
X-Message-Linecount: 98
X-Body-Linecount: 88
X-Message-Size: 2650
X-Body-Size: 2170
X-Received-Count: 1
X-Recipient-Count: 1
X-Local-Recipient-Count: 1
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123948>


Signed-off-by: Alex Vandiver <alex@chmrr.net>
---
 config.c               |   22 +++++++++++++++++++---
 t/t1300-repo-config.sh |   22 ++++++++++++++++++++++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 7d6f6f6..3a2965e 100644
--- a/config.c
+++ b/config.c
@@ -1257,6 +1257,7 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 	while (fgets(buf, sizeof(buf), config_file)) {
 		int i;
 		int length;
+		char* output = buf;
 		for (i = 0; buf[i] && isspace(buf[i]); i++)
 			; /* do nothing */
 		if (buf[i] == '[') {
@@ -1273,14 +1274,29 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 					ret = write_error(lock->filename);
 					goto out;
 				}
-				continue;
+				/*
+				 * We wrote out the new section, with
+				 * a newline, now skip the old
+				 * section's length
+				 */
+				output += offset + i;
+				if (strlen(output) > 0) {
+					/*
+					 * More content means there's
+					 * a declaration to put on the
+					 * next line; indent with a
+					 * tab
+					 */
+					output -= 1;
+					output[0] = '\t';
+				}
 			}
 			remove = 0;
 		}
 		if (remove)
 			continue;
-		length = strlen(buf);
-		if (write_in_full(out_fd, buf, length) != length) {
+		length = strlen(output);
+		if (write_in_full(out_fd, output, length) != length) {
 			ret = write_error(lock->filename);
 			goto out;
 		}
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 43ea283..8c43dcd 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -460,6 +460,28 @@ EOF
 test_expect_success "rename succeeded" "test_cmp expect .git/config"
 
 cat >> .git/config << EOF
+[branch "vier"] z = 1
+EOF
+
+test_expect_success "rename a section with a var on the same line" \
+	'git config --rename-section branch.vier branch.zwei'
+
+cat > expect << EOF
+# Hallo
+	#Bello
+[branch "zwei"]
+	x = 1
+[branch "zwei"]
+	y = 1
+[branch "drei"]
+weird
+[branch "zwei"]
+	z = 1
+EOF
+
+test_expect_success "rename succeeded" "test_cmp expect .git/config"
+
+cat >> .git/config << EOF
   [branch "zwei"] a = 1 [branch "vier"]
 EOF
 
-- 
1.6.3.3.473.gb74fc4.dirty
