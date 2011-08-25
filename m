From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] check-ref-format --print: Normalize refnames that start with slashes
Date: Thu, 25 Aug 2011 21:19:24 +0200
Message-ID: <1314299964-21866-1-git-send-email-mhagger@alum.mit.edu>
References: <7v39gpmk3x.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 21:19:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwfT2-0003qp-CV
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 21:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437Ab1HYTTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 15:19:51 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:55259 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab1HYTTv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 15:19:51 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BE9A98.dip.t-dialin.net [84.190.154.152])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7PJJVxT006145;
	Thu, 25 Aug 2011 21:19:31 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <7v39gpmk3x.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180104>

And add tests that such refnames are accepted and normalized
correctly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

I didn't convince Junio that it is preferable to reject refnames that
start with slashes, so go the other way instead.

This patch should be applied to maint, as it fixes a bug.  The
normalization should probably be moved to refs.[ch] as mentioned on
the mailing list, but that can be done separately, on master.

 builtin/check-ref-format.c  |    6 ++++--
 t/t1402-check-ref-format.sh |    7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index ae3f281..7118021 100644
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
@@ -23,6 +23,8 @@ static void collapse_slashes(char *dst, const char *src)
 	char ch;
 	char prev = '\0';
 
+	while (*src == '/')
+		src++;
 	while ((ch = *src++) != '\0') {
 		if (prev == '/' && ch == prev)
 			continue;
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 1b0f82f..e6fafb2 100755
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
@@ -28,6 +31,7 @@ valid_ref 'heads/foo@bar'
 invalid_ref 'heads/v@{ation'
 invalid_ref 'heads/foo\bar'
 
+
 test_expect_success "check-ref-format --branch @{-1}" '
 	T=$(git write-tree) &&
 	sha1=$(echo A | git commit-tree $T) &&
@@ -70,7 +74,10 @@ invalid_ref_normalized() {
 
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
