From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 2/4] cat-file: do not die on --textconv without textconv filters
Date: Wed,  6 Feb 2013 16:08:51 +0100
Message-ID: <b20e91bc71e59b5390005f2e6428e69a467e80b5.1360162813.git.git@drmicha.warpmail.net>
References: <20130205201106.GA29248@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 16:09:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U36cq-0003Fu-My
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 16:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034Ab3BFPI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 10:08:59 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41881 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754572Ab3BFPI4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 10:08:56 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6BD52215BE;
	Wed,  6 Feb 2013 10:08:55 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 06 Feb 2013 10:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=dy
	DEB6HMGSMZ3GXLpWaFgrBpE5A=; b=JyDSZqqQvNmmPFTF3WkjYj5ZJHr8Jn7+lD
	ztgBl7wRU8zDleQuncfG/Wc4V5ioqwuh22YHyOSgYl5LbwXT4CvQK9SAmSBeAbTP
	5q32vWURzZ7n0UgjDrAMlQnlZ1WNPaUqmtX/HD0jEZ0ZP31SgdKHM3jyvnhnbiYu
	Qc4d+4I4A=
X-Sasl-enc: /2VD5BLoQQ/zlej9DoJPKS1fzqTe9I25sUd19d2k3vQw 1360163335
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 07BCB4827DE;
	Wed,  6 Feb 2013 10:08:54 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.752.g32d147e
In-Reply-To: <20130205201106.GA29248@sigill.intra.peff.net>
In-Reply-To: <cover.1360162813.git.git@drmicha.warpmail.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215583>

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
index 00528dd..6912dc2 100644
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
1.8.1.2.752.g32d147e
