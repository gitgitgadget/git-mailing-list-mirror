From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] replace: parse revision argument for -d
Date: Mon, 29 Oct 2012 14:23:27 +0100
Message-ID: <24b0f81315ddab8cc37133d5b3bec8aec90ed652.1351516888.git.git@drmicha.warpmail.net>
References: <508E55B2.6060502@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 29 14:23:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSpJh-00024U-9Y
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 14:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756896Ab2J2NXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 09:23:32 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47498 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756543Ab2J2NX3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Oct 2012 09:23:29 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4D6B820486;
	Mon, 29 Oct 2012 09:23:29 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 29 Oct 2012 09:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=epGqf+2/9q0EqvwcY1beU25qX
	Ic=; b=i85gU3fmI8syOzkuhKFp4FmFEPYzI7Wn5BvJXnx3FFfwDEnT8RpMV0rez
	R8NAgndT+4gb+mOlMBk7OV1MlTTSWru/NshtbfyWh3fgVacUDxMZ/8n0ublobjFp
	lOp/w14hFA8Zxvv3YUFporJZ5UYho2KAVM9jyOj5we8uw1Wkto=
X-Sasl-enc: DqnPGl5g3eQY4jpDasXT+iERD1LjcwIrgrMFq+P3vkh5 1351517008
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DF40E48265F;
	Mon, 29 Oct 2012 09:23:28 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.370.g8cbad08
In-Reply-To: <508E55B2.6060502@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208622>

'git replace' parses the revision arguments when it creates replacements
(so that a sha1 can be abbreviated, e.g.) but not when deleting
replacements.

Make it parse the arguments to 'replace -d' in the same way.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
v2 has the simplified error check as per Jeff, and a reworded message.
Comes with a free test case, too.

 builtin/replace.c  | 14 ++++++++------
 t/t6050-replace.sh | 11 +++++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index e3aaf70..7b00055 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -46,24 +46,26 @@ typedef int (*each_replace_name_fn)(const char *name, const char *ref,
 
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
1.8.0.370.g8cbad08
