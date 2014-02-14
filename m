From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH] config: git_config_from_file(): handle "-" filename as stdin
Date: Fri, 14 Feb 2014 15:34:38 +0200
Message-ID: <1392384878-7080-1-git-send-email-kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 14 14:40:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEJ0g-0000fq-DC
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 14:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbaBNNku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 08:40:50 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:58536 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbaBNNkt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 08:40:49 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Feb 2014 08:40:49 EST
Received: from node.shutemov.name (80.220.224.16) by jenni1.inet.fi (8.5.140.03)
        id 527750DA08931CF1 for git@vger.kernel.org; Fri, 14 Feb 2014 15:34:44 +0200
Received: by node.shutemov.name (Postfix, from userid 1000)
	id 57BC040647; Fri, 14 Feb 2014 15:34:43 +0200 (EET)
X-Mailer: git-send-email 1.8.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242102>

The patch extends git config --file interface to allow read config from
stdin.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 config.c               | 10 ++++++----
 t/t1300-repo-config.sh |  4 ++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index d969a5aefc2b..f80cc7e657e8 100644
--- a/config.c
+++ b/config.c
@@ -1032,10 +1032,11 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
 
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
-	int ret;
-	FILE *f = fopen(filename, "r");
+	int from_stdin = !strcmp(filename, "-");
+	int ret = -1;
+	FILE *f;
 
-	ret = -1;
+	f = from_stdin ? stdin : fopen(filename, "r");
 	if (f) {
 		struct config_source top;
 
@@ -1048,7 +1049,8 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 
 		ret = do_config_from(&top, fn, data);
 
-		fclose(f);
+		if (!from_stdin)
+			fclose(f);
 	}
 	return ret;
 }
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 967359344dab..f1a63075e34f 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -484,6 +484,10 @@ test_expect_success 'alternative GIT_CONFIG (--file)' '
 	test_cmp expect output
 '
 
+test_expect_success 'alternative GIT_CONFIG (--file=-)' '
+	git config --file - -l < other-config > output &&
+	test_cmp expect output
+'
 test_expect_success 'refer config from subdirectory' '
 	mkdir x &&
 	(
-- 
1.8.5.2
