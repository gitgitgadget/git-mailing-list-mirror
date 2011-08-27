From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/2] check-ref-format --print: Normalize refnames that start with slashes
Date: Sat, 27 Aug 2011 06:12:43 +0200
Message-ID: <1314418364-2532-2-git-send-email-mhagger@alum.mit.edu>
References: <1314418364-2532-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 06:13:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxAHE-0006jJ-8m
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 06:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824Ab1H0ENl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 00:13:41 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35077 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab1H0ENj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 00:13:39 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BED1A9.dip.t-dialin.net [84.190.209.169])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7R4DCBW009101;
	Sat, 27 Aug 2011 06:13:33 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1314418364-2532-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180218>

And add tests that such refnames are accepted and normalized
correctly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

This patch includes the simplification suggested by Junio on the
mailing list.

 builtin/check-ref-format.c  |    6 +++---
 t/t1402-check-ref-format.sh |    6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index ae3f281..0723cf2 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -12,8 +12,8 @@ static const char builtin_check_ref_format_usage[] =
 "   or: git check-ref-format --branch <branchname-shorthand>";
 
 /*
- * Replace each run of adjacent slashes in src with a single slash,
- * and write the result to dst.
+ * Remove leading slashes and replace each run of adjacent slashes in
+ * src with a single slash, and write the result to dst.
  *
  * This function is similar to normalize_path_copy(), but stripped down
  * to meet check_ref_format's simpler needs.
@@ -21,7 +21,7 @@ static const char builtin_check_ref_format_usage[] =
 static void collapse_slashes(char *dst, const char *src)
 {
 	char ch;
-	char prev = '\0';
+	char prev = '/';
 
 	while ((ch = *src++) != '\0') {
 		if (prev == '/' && ch == prev)
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 1b0f82f..7563043 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -18,6 +18,9 @@ invalid_ref 'foo'
 valid_ref 'foo/bar/baz'
 valid_ref 'refs///heads/foo'
 invalid_ref 'heads/foo/'
+valid_ref '/heads/foo'
+valid_ref '///heads/foo'
+invalid_ref '/foo'
 invalid_ref './foo'
 invalid_ref '.refs/foo'
 invalid_ref 'heads/foo..bar'
@@ -70,7 +73,10 @@ invalid_ref_normalized() {
 
 valid_ref_normalized 'heads/foo' 'heads/foo'
 valid_ref_normalized 'refs///heads/foo' 'refs/heads/foo'
+valid_ref_normalized '/heads/foo' 'heads/foo'
+valid_ref_normalized '///heads/foo' 'heads/foo'
 invalid_ref_normalized 'foo'
+invalid_ref_normalized '/foo'
 invalid_ref_normalized 'heads/foo/../bar'
 invalid_ref_normalized 'heads/./foo'
 invalid_ref_normalized 'heads\foo'
-- 
1.7.6.8.gd2879
