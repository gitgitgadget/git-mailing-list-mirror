From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/6] show: obey --textconv for blobs
Date: Fri, 19 Apr 2013 18:44:45 +0200
Message-ID: <5a8c85faddf7f93ca16d284bde415a32dd76779a.1366389739.git.git@drmicha.warpmail.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 18:45:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTERd-0000Ao-TU
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 18:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030903Ab3DSQpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 12:45:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48835 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030840Ab3DSQpi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Apr 2013 12:45:38 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id BA6A420BB9
	for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:45:37 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 19 Apr 2013 12:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=KGR0W7r4Gq6oXgn648KV++/KK
	Oc=; b=S0qrm+62njFj+UmtDFAkIddJWGA73m+vCML51c8JV3VqD9SWAUb4JBQG5
	5DEfC6Krx9ihsSB5c+Tl66WOuAWw3MIZD2Di5Nvy67G6QXs/PpKiJW5Bs5Oy9Ciw
	zrRMFVZVhf1VTMkg/t0sd+5HwQVQvwuf8k2omVAI8HsjYSXUJw=
X-Sasl-enc: sH5AbvpkG7ikJN3RvqhA+nHdYCMJDVblS+lLAfBb4RcN 1366389937
Received: from localhost (unknown [46.115.51.241])
	by mail.messagingengine.com (Postfix) with ESMTPA id 35AC52001D0;
	Fri, 19 Apr 2013 12:45:37 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.1.728.ge98e8b0
In-Reply-To: <cover.1366389739.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221772>

Currently, "diff" and "cat-file" for blobs obey "--textconv" options
(with the former defaulting to "--textconv" and the latter to
"--no-textconv") whereas "show" does not obey this option, even though
it takes diff options.

Make "show" on blobs behave like "diff", i.e. obey "--textconv" by
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
index f314ced..f9d55e1 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -90,8 +90,14 @@ test_expect_success 'status -v produces text' '
 	git reset --soft HEAD@{1}
 '
 
-test_expect_success 'show blob produces binary' '
+test_expect_success 'show blob produces text' '
 	git show HEAD:file >actual &&
+	printf "0\\n1\\n" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'show --no-textconv blob produces binary' '
+	git show --no-textconv HEAD:file >actual &&
 	printf "\\0\\n\\1\\n" >expect &&
 	test_cmp expect actual
 '
-- 
1.8.2.1.728.ge98e8b0
