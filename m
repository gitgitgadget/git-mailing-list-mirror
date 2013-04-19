From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/6] cat-file: do not die on --textconv without textconv filters
Date: Fri, 19 Apr 2013 18:44:46 +0200
Message-ID: <06f2d51bf0479f3231b707d88d8d04fcd306c973.1366389739.git.git@drmicha.warpmail.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 18:45:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTERe-0000Ao-ED
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 18:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031142Ab3DSQpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 12:45:42 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33806 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030840Ab3DSQpk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Apr 2013 12:45:40 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 24BA320D33
	for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:45:40 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 19 Apr 2013 12:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=C6SKUgdHrzR2Y+xXFmOQgxVZE
	u0=; b=UsUnbDgCR/hTZB57oF+UhAqQtFwFpW7aKbvN/Gj9zk5fr+3ctFZeUxM9p
	RLNDSwXw9plThe7RCRy4DhTujuE2F2NsWPmQ//yt89XWZEJ0ih5zibt570I88VLw
	SvtECBzetcaVOkmrVODdhwLWufTQU5xW7dHypjSMMXJw1N8KhE=
X-Sasl-enc: O1YpH9kHoaAqDDiFyx5hNp729406HFa+xk6HgoeiSZAy 1366389939
Received: from localhost (unknown [46.115.51.241])
	by mail.messagingengine.com (Postfix) with ESMTPA id A62F1C80007;
	Fri, 19 Apr 2013 12:45:39 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.1.728.ge98e8b0
In-Reply-To: <cover.1366389739.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221773>

When a command is supposed to use textconv filters (by default or with
"--textconv") and none are configured then the blob is output without
conversion; the only exception to this rule is "cat-file --textconv".

Make it behave like the rest of textconv aware commands.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/cat-file.c           |  9 +++++----
 t/t8007-cat-file-textconv.sh | 20 +++++---------------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 40f87b4..dd4e063 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -146,10 +146,11 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 			die("git cat-file --textconv %s: <object> must be <sha1:path>",
 			    obj_name);
 
-		if (!textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
-			die("git cat-file --textconv: unable to run textconv on %s",
-			    obj_name);
-		break;
+		if (textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
+			break;
+
+		/* otherwise expect a blob */
+		exp_type = "blob";
 
 	case 0:
 		if (type_from_string(exp_type) == OBJ_BLOB) {
diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
index 78a0085..83c6636 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -22,11 +22,11 @@ test_expect_success 'setup ' '
 '
 
 cat >expected <<EOF
-fatal: git cat-file --textconv: unable to run textconv on :one.bin
+bin: test version 2
 EOF
 
 test_expect_success 'no filter specified' '
-	git cat-file --textconv :one.bin 2>result
+	git cat-file --textconv :one.bin >result &&
 	test_cmp expected result
 '
 
@@ -36,10 +36,6 @@ test_expect_success 'setup textconv filters' '
 	git config diff.test.cachetextconv false
 '
 
-cat >expected <<EOF
-bin: test version 2
-EOF
-
 test_expect_success 'cat-file without --textconv' '
 	git cat-file blob :one.bin >result &&
 	test_cmp expected result
@@ -73,25 +69,19 @@ test_expect_success 'cat-file --textconv on previous commit' '
 '
 
 test_expect_success SYMLINKS 'cat-file without --textconv (symlink)' '
+	printf "%s" "one.bin" >expected &&
 	git cat-file blob :symlink.bin >result &&
-	printf "%s" "one.bin" >expected
 	test_cmp expected result
 '
 
 
 test_expect_success SYMLINKS 'cat-file --textconv on index (symlink)' '
-	! git cat-file --textconv :symlink.bin 2>result &&
-	cat >expected <<\EOF &&
-fatal: git cat-file --textconv: unable to run textconv on :symlink.bin
-EOF
+	git cat-file --textconv :symlink.bin >result &&
 	test_cmp expected result
 '
 
 test_expect_success SYMLINKS 'cat-file --textconv on HEAD (symlink)' '
-	! git cat-file --textconv HEAD:symlink.bin 2>result &&
-	cat >expected <<EOF &&
-fatal: git cat-file --textconv: unable to run textconv on HEAD:symlink.bin
-EOF
+	git cat-file --textconv HEAD:symlink.bin >result &&
 	test_cmp expected result
 '
 
-- 
1.8.2.1.728.ge98e8b0
