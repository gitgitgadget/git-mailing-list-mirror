From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 3/7] cat-file: do not die on --textconv without textconv filters
Date: Tue, 23 Apr 2013 14:11:55 +0200
Message-ID: <10c691f7003f1f211f265abb177dd2a1b511b7e2.1366718624.git.git@drmicha.warpmail.net>
References: <517298D4.3030802@drmicha.warpmail.net>
Cc: Matthieu.Moy@grenoble-inp.fr, jeremy.rosen@openwide.fr,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 14:12:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUc4x-0002Fq-OO
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 14:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890Ab3DWMMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 08:12:03 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58857 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755836Ab3DWML5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Apr 2013 08:11:57 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D89ED20C23;
	Tue, 23 Apr 2013 08:11:56 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 23 Apr 2013 08:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=F7
	y/90wIsYBfrU8rgnGo+Zxep0U=; b=q3tCJrUOjD1gCJNsDIVsP/l7xnwPcTj3Ot
	EZqScWzMSt+93/q/NPwkWOpWeW4gDgGxRo5nbWxeZX/PCMMKN++tnBAbBAoWKBMV
	Ygb9KKNBYIu6S7dStwy8HUTLvJ341pOZ9EFiyxtXwo6hrLBLi1LuT2K4t3PNAyor
	sGTUz8peQ=
X-Sasl-enc: 39V3VYViErGok/ywolDyDfmB8Ovh40cNJGSW3MS4Rjb7 1366719116
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7834D2001CE;
	Tue, 23 Apr 2013 08:11:56 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.1.799.g1ac2534
In-Reply-To: <517298D4.3030802@drmicha.warpmail.net>
In-Reply-To: <cover.1366718624.git.git@drmicha.warpmail.net>
References: <cover.1366718624.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222151>

When a command is supposed to use textconv filters (by default or with
"--textconv") and none are configured then the blob is output without
conversion; the only exception to this rule is "cat-file --textconv".

Make it behave like the rest of textconv aware commands.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/cat-file.c           | 18 ++++++++----------
 t/t8007-cat-file-textconv.sh | 20 +++++---------------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 045cee7..bd62373 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -48,6 +48,14 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	case 'e':
 		return !has_sha1_file(sha1);
 
+	case 'c':
+		if (!obj_context.path[0])
+			die("git cat-file --textconv %s: <object> must be <sha1:path>",
+			    obj_name);
+
+		if (textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
+			break;
+
 	case 'p':
 		type = sha1_object_info(sha1, NULL);
 		if (type < 0)
@@ -70,16 +78,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		/* otherwise just spit out the data */
 		break;
 
-	case 'c':
-		if (!obj_context.path[0])
-			die("git cat-file --textconv %s: <object> must be <sha1:path>",
-			    obj_name);
-
-		if (!textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
-			die("git cat-file --textconv: unable to run textconv on %s",
-			    obj_name);
-		break;
-
 	case 0:
 		if (type_from_string(exp_type) == OBJ_BLOB) {
 			unsigned char blob_sha1[20];
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
1.8.2.1.799.g1ac2534
