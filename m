From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 3/7] show: honor --textconv for blobs
Date: Fri, 10 May 2013 17:10:12 +0200
Message-ID: <c4ed1e0b67877e6453b8c269290e09e1672ce37d.1368197380.git.git@drmicha.warpmail.net>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 17:11:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaoz0-0006zX-4s
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 17:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574Ab3EJPLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 11:11:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40185 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754135Ab3EJPLd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 May 2013 11:11:33 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D845520CB3;
	Fri, 10 May 2013 11:11:32 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 10 May 2013 11:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=2o
	UVUMWww6qaMJ94rsgq9lxYa3k=; b=gTIAn4a6tCPN0RwlvQaozNgEnCr2PK8jSR
	JcIhNKL7KLxMXXR32PXp6oOmXG8DtZPJ/E1lKZXXO9Ft2FeKUbsvq6NMTFXWNBws
	CHk1JyYkt2yzPs6vZ6kojIpgXz7+ctoBxdZnEE7PP8FbQfoafrMQnQaHpG3vObdy
	Va3RLGzKY=
X-Sasl-enc: lUPyfH4hOpROw80RORYm9qEyT5qvrPHmqt5zB8VtqFTk 1368198692
Received: from localhost (unknown [213.221.117.228])
	by mail.messagingengine.com (Postfix) with ESMTPA id 294D9200161;
	Fri, 10 May 2013 11:11:32 -0400 (EDT)
X-Mailer: git-send-email 1.8.3.rc1.406.gf4dce7e
In-Reply-To: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1368197380.git.git@drmicha.warpmail.net>
References: <cover.1368197380.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223865>

Currently, "diff" and "cat-file" for blobs honor "--textconv" options
(with the former defaulting to "--textconv" and the latter to
"--no-textconv") whereas "show" does not honor this option, even though
it takes diff options.

Make "show" on blobs behave like "diff", i.e. honor "--textconv" by
default and "--no-textconv" when given.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/log.c            | 25 ++++++++++++++++++++++---
 t/t4030-diff-textconv.sh |  6 +++---
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f19d779..dd3f108 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -437,10 +437,29 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)
 	strbuf_release(&out);
 }
 
-static int show_blob_object(const unsigned char *sha1, struct rev_info *rev)
+static int show_blob_object(const unsigned char *sha1, struct rev_info *rev, const char *obj_name)
 {
+	unsigned char sha1c[20];
+	struct object_context obj_context;
+	char *buf;
+	unsigned long size;
+
 	fflush(stdout);
-	return stream_blob_to_fd(1, sha1, NULL, 0);
+	if (!DIFF_OPT_TOUCHED(&rev->diffopt, ALLOW_TEXTCONV) ||
+	    !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
+		return stream_blob_to_fd(1, sha1, NULL, 0);
+
+	if (get_sha1_with_context(obj_name, 0, sha1c, &obj_context))
+		die("Not a valid object name %s", obj_name);
+	if (!obj_context.path[0] ||
+	    !textconv_object(obj_context.path, obj_context.mode, sha1c, 1, &buf, &size))
+		return stream_blob_to_fd(1, sha1, NULL, 0);
+
+	if (!buf)
+		die("git show %s: bad file", obj_name);
+
+	write_or_die(1, buf, size);
+	return 0;
 }
 
 static int show_tag_object(const unsigned char *sha1, struct rev_info *rev)
@@ -526,7 +545,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		const char *name = objects[i].name;
 		switch (o->type) {
 		case OBJ_BLOB:
-			ret = show_blob_object(o->sha1, NULL);
+			ret = show_blob_object(o->sha1, &rev, name);
 			break;
 		case OBJ_TAG: {
 			struct tag *t = (struct tag *)o;
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 3950fc9..0ebb028 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -96,14 +96,14 @@ test_expect_success 'show blob produces binary' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'show --textconv blob produces text' '
+test_expect_success 'show --textconv blob produces text' '
 	git show --textconv HEAD:file >actual &&
 	printf "0\\n1\\n" >expect &&
 	test_cmp expect actual
 '
 
-test_success 'show --no-textconv blob produces binary' '
-	git show --textconv HEAD:file >actual &&
+test_expect_success 'show --no-textconv blob produces binary' '
+	git show --no-textconv HEAD:file >actual &&
 	printf "\\0\\n\\01\\n" >expect &&
 	test_cmp expect actual
 '
-- 
1.8.3.rc1.406.gf4dce7e
