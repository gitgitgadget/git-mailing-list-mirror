From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3] replace: parse revision argument for -d
Date: Mon, 12 Nov 2012 15:18:02 +0100
Message-ID: <a35a8f44b908bded0b475b02e7917011fb3bf90b.1352728712.git.git@drmicha.warpmail.net>
References: <50A0B896.8050700@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 15:18:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXuqC-0008Ou-GG
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 15:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206Ab2KLOSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 09:18:06 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48836 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753111Ab2KLOSE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2012 09:18:04 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3087120ABA;
	Mon, 12 Nov 2012 09:18:04 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 12 Nov 2012 09:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=Yrf1VCAV8o3/z6mTE2Pa5nIzA
	Xo=; b=f/UF0zb8xMaUCui81gmxJX8GynvLXcxN6bUpm08xsFfY9BwEmxytyTX3e
	gGQJ8No63UxS2uiiTi3R2YNZimBboo7H1cxV9KeCTDA2Fl2j6Y3LQxheccP+J39i
	gwiGd+itfcyTFk/5J2i37PZMSmjUUpcNqboQwpUpeckOIotI9s=
X-Sasl-enc: U49zWfAGIxZXnvQWGyAlvQUJtT3Wlrb4Vw4sKqskc+5S 1352729883
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 923B48E04C3;
	Mon, 12 Nov 2012 09:18:03 -0500 (EST)
X-Mailer: git-send-email 1.8.0.311.gdd08018
In-Reply-To: <50A0B896.8050700@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209478>

'git replace' parses the revision arguments when it creates replacements
(so that a sha1 can be abbreviated, e.g.) but not when deleting
replacements.

Make it parse the argument to 'replace -d' in the same way.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    v3 safeguards the hex buffer against reuse
 builtin/replace.c  | 16 ++++++++++------
 t/t6050-replace.sh | 11 +++++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index e3aaf70..33e6ec3 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -46,24 +46,28 @@ typedef int (*each_replace_name_fn)(const char *name, const char *ref,
 
 static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 {
-	const char **p;
+	const char **p, *q;
 	char ref[PATH_MAX];
 	int had_error = 0;
 	unsigned char sha1[20];
 
 	for (p = argv; *p; p++) {
-		if (snprintf(ref, sizeof(ref), "refs/replace/%s", *p)
-					>= sizeof(ref)) {
-			error("replace ref name too long: %.*s...", 50, *p);
+		q = *p;
+		if (get_sha1(q, sha1)) {
+			error("Failed to resolve '%s' as a valid ref.", q);
 			had_error = 1;
 			continue;
 		}
+		q = sha1_to_hex(sha1);
+		snprintf(ref, sizeof(ref), "refs/replace/%s", q);
+		/* read_ref() may reuse the buffer */
+		q = ref + strlen("refs/replace/");
 		if (read_ref(ref, sha1)) {
-			error("replace ref '%s' not found.", *p);
+			error("replace ref '%s' not found.", q);
 			had_error = 1;
 			continue;
 		}
-		if (fn(*p, ref, sha1))
+		if (fn(q, ref, sha1))
 			had_error = 1;
 	}
 	return had_error;
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 5c87f28..decdc33 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -140,6 +140,17 @@ test_expect_success '"git replace" replacing' '
      test "$HASH2" = "$(git replace)"
 '
 
+test_expect_success '"git replace" resolves sha1' '
+     SHORTHASH2=$(git rev-parse --short=8 $HASH2) &&
+     git replace -d $SHORTHASH2 &&
+     git replace $SHORTHASH2 $R &&
+     git show $HASH2 | grep "O Thor" &&
+     test_must_fail git replace $HASH2 $R &&
+     git replace -f $HASH2 $R &&
+     test_must_fail git replace -f &&
+     test "$HASH2" = "$(git replace)"
+'
+
 # This creates a side branch where the bug in H2
 # does not appear because P2 is created by applying
 # H2 and squashing H5 into it.
-- 
1.8.0.311.gdd08018
