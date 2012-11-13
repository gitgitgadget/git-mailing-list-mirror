From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv4] replace: parse revision argument for -d
Date: Tue, 13 Nov 2012 11:34:11 +0100
Message-ID: <848bc8f48885acd63b4f6d29eea0543e73d86451.1352802239.git.git@drmicha.warpmail.net>
References: <50A22026.60506@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 11:34:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYDp6-0000yS-OR
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 11:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794Ab2KMKeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 05:34:15 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42416 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753421Ab2KMKeO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2012 05:34:14 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 35B4D20BA0;
	Tue, 13 Nov 2012 05:34:14 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Tue, 13 Nov 2012 05:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=RhpUw/QAWnmQFULhh3YwiWsij
	64=; b=V0BvmctWFUbD3LJCieEq0mUvtNJohmP8HEByCBG+NuZ4G1ts8E7eWtxXm
	XDBLAIg7I21F6R+ag8fO3XqtvJL99bZ/u/gVt3zqZiJ03BW4FQxAYeCbnD8RZTqV
	PiT4wM5q54O9ojiYxdRkbFmihQOmTvbQHwicSuQQTbiIHy2ey4=
X-Sasl-enc: skrfEF2MOiDgkFt+my8MNoUWCp97AjWpNikey+SMe3Uw 1352802853
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B994C4827C7;
	Tue, 13 Nov 2012 05:34:13 -0500 (EST)
X-Mailer: git-send-email 1.8.0.311.gdd08018
In-Reply-To: <50A22026.60506@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209595>

'git replace' parses the revision arguments when it creates replacements
(so that a sha1 can be abbreviated, e.g.) but not when deleting
replacements.

Make it parse the argument to 'replace -d' in the same way.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    v4 names the aux variable more concisely and does away with a superfluous
    assignment.
 builtin/replace.c  | 15 +++++++++------
 t/t6050-replace.sh | 11 +++++++++++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index e3aaf70..398ccd5 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -46,24 +46,27 @@ typedef int (*each_replace_name_fn)(const char *name, const char *ref,
 
 static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 {
-	const char **p;
+	const char **p, *full_hex;
 	char ref[PATH_MAX];
 	int had_error = 0;
 	unsigned char sha1[20];
 
 	for (p = argv; *p; p++) {
-		if (snprintf(ref, sizeof(ref), "refs/replace/%s", *p)
-					>= sizeof(ref)) {
-			error("replace ref name too long: %.*s...", 50, *p);
+		if (get_sha1(*p, sha1)) {
+			error("Failed to resolve '%s' as a valid ref.", *p);
 			had_error = 1;
 			continue;
 		}
+		full_hex = sha1_to_hex(sha1);
+		snprintf(ref, sizeof(ref), "refs/replace/%s", full_hex);
+		/* read_ref() may reuse the buffer */
+		full_hex = ref + strlen("refs/replace/");
 		if (read_ref(ref, sha1)) {
-			error("replace ref '%s' not found.", *p);
+			error("replace ref '%s' not found.", full_hex);
 			had_error = 1;
 			continue;
 		}
-		if (fn(*p, ref, sha1))
+		if (fn(full_hex, ref, sha1))
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
