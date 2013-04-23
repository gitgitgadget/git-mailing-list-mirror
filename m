From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/7] show: obey --textconv for blobs
Date: Tue, 23 Apr 2013 14:11:54 +0200
Message-ID: <c631e41a9f9b02f1ad5e40dd4bcaf18670b27c59.1366718624.git.git@drmicha.warpmail.net>
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
	id 1UUc4w-0002Fq-Ny
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 14:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837Ab3DWML5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 08:11:57 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52621 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755769Ab3DWMLz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Apr 2013 08:11:55 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2BF7620BF0;
	Tue, 23 Apr 2013 08:11:55 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 23 Apr 2013 08:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=0B
	KV02s9Ky36e64T+NM2giculKo=; b=SRtaMv7RfxQuqmdwAe/EwjjQTMN9dxN98v
	lVnRJ2fwLxSE2VEGyiKg6qbJ5vff27UBwMLsfT08/rVhkQdf4Id6QOWSS475yvF6
	ZvQfKVCsKV8zP5fbwEIFONjb33vtGIKSG40My9EF+DeghNycR6zuftnKbJkfl3tF
	6l4g0UtO0=
X-Sasl-enc: NTVJ305TYJ3sAxchhSEBDfeJr49PfniR4eD74zGKdl5g 1366719114
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C424BC80008;
	Tue, 23 Apr 2013 08:11:54 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.1.799.g1ac2534
In-Reply-To: <517298D4.3030802@drmicha.warpmail.net>
In-Reply-To: <cover.1366718624.git.git@drmicha.warpmail.net>
References: <cover.1366718624.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222150>

Currently, "diff" and "cat-file" for blobs honor "--textconv" options
(with the former defaulting to "--textconv" and the latter to
"--no-textconv") whereas "show" does not honor this option, even though
it takes diff options.

Make "show" on blobs behave like "diff", i.e. honor "--textconv" by
default and "--no-textconv" when given.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/log.c            | 24 +++++++++++++++++++++---
 t/t4030-diff-textconv.sh |  8 +++++++-
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 5f3ed77..fe0275e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -436,10 +436,28 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)
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
+	if (!DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
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
@@ -525,7 +543,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		const char *name = objects[i].name;
 		switch (o->type) {
 		case OBJ_BLOB:
-			ret = show_blob_object(o->sha1, NULL);
+			ret = show_blob_object(o->sha1, &rev, name);
 			break;
 		case OBJ_TAG: {
 			struct tag *t = (struct tag *)o;
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 260ea92..f9d55e1 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -90,12 +90,18 @@ test_expect_success 'status -v produces text' '
 	git reset --soft HEAD@{1}
 '
 
-test_expect_failure 'show blob produces text' '
+test_expect_success 'show blob produces text' '
 	git show HEAD:file >actual &&
 	printf "0\\n1\\n" >expect &&
 	test_cmp expect actual
 '
 
+test_expect_success 'show --no-textconv blob produces binary' '
+	git show --no-textconv HEAD:file >actual &&
+	printf "\\0\\n\\1\\n" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'grep-diff (-G) operates on textconv data (add)' '
 	echo one >expect &&
 	git log --root --format=%s -G0 >actual &&
-- 
1.8.2.1.799.g1ac2534
