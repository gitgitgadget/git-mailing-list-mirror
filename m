From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 1/4] show: obey --textconv for blobs
Date: Wed,  6 Feb 2013 16:08:50 +0100
Message-ID: <883f0163cb732932061a368ea9bc187c13e4ecca.1360162813.git.git@drmicha.warpmail.net>
References: <20130205201106.GA29248@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 16:09:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U36cf-00035Z-Lh
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 16:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755968Ab3BFPIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 10:08:55 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55097 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754572Ab3BFPIy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 10:08:54 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CC925215D2;
	Wed,  6 Feb 2013 10:08:53 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 06 Feb 2013 10:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=n3
	jxWcqCXqWU39UaCu7ks0++8sE=; b=jfoC8+kkxEsfoiU+25ctX20fQSCTIHr4YA
	Re3m1JfIZJoKV3BSmshxnMCvHNjeD8TLkgrPDXGNCO1Z9EBE7cb02VPyCVAG14Ym
	7tCaNEsoeYkTZh/qPhbr4+7EVVe5MKWbZF5ZA9GmdI9S0APW4vaa/aG1jpcyzO1u
	pI2hYFWsE=
X-Sasl-enc: I/HDOiVSfULuv/05TIGmZfg6p3UMwfDHOVCG1r/ZL2gA 1360163333
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5D6D38E094A;
	Wed,  6 Feb 2013 10:08:53 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.752.g32d147e
In-Reply-To: <20130205201106.GA29248@sigill.intra.peff.net>
In-Reply-To: <cover.1360162813.git.git@drmicha.warpmail.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215582>

Currently, "diff" and "cat-file" for blobs obey "--textconv" options
(with the former defaulting to "--textconv" and the latter to
"--no-textconv") whereas "show" does not obey this option, even though
it takes diff options.

Make "show" on blobs behave like "diff", i.e. obey "--textconv" by
default and "--no-textconv" when given.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/log.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 8f0b2e8..f83870d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -402,10 +402,28 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)
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
@@ -491,7 +509,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		const char *name = objects[i].name;
 		switch (o->type) {
 		case OBJ_BLOB:
-			ret = show_blob_object(o->sha1, NULL);
+			ret = show_blob_object(o->sha1, &rev, name);
 			break;
 		case OBJ_TAG: {
 			struct tag *t = (struct tag *)o;
-- 
1.8.1.2.752.g32d147e
