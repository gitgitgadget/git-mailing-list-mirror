From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] replace: parse revision argument for -d
Date: Fri, 26 Oct 2012 15:33:27 +0200
Message-ID: <807340e40adb1fc97cd97161fe1fabd292bc79c3.1351258394.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 15:33:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRk2j-00073H-0R
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 15:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932881Ab2JZNdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 09:33:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44005 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932123Ab2JZNda (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Oct 2012 09:33:30 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7674D209F8
	for <git@vger.kernel.org>; Fri, 26 Oct 2012 09:33:29 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 26 Oct 2012 09:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id; s=
	smtpout; bh=U093zxo/AWJAOSAULAyFX2q2ap4=; b=gd/SK/ljYupdCmVO6WrF
	8HFZ1K9i25f6wwSA3rflQRG2zJ5ree0K6xreg0Dckocmg6PSX6qLo4vsiJwD2Lq4
	flQjY6kTbOBRMmjEW6CY5Bhr50FuKCnBEUzEVd3AF9URI0Uwb5cQp8y3ALHHKmgN
	ZsYa08G6brZcK0zP1Li+Mxs=
X-Sasl-enc: zxsr8CwnUxaGSUupk5gwut7qLHnWnBR4OHk2rzCrcSZL 1351258409
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0BAB648265A;
	Fri, 26 Oct 2012 09:33:28 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.370.g8cbad08
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208442>

'git replace' parses the revision arguments when it creates replacements
(so that a sha1 can be abbreviated, e.g.) but not when deleting
replacements.

This sucks.

Make it parse the argument to 'replace -d' in the same way.

Just in case someone lost the replacement object before deleting the
replacement, take the argument literally if it can not be resolved to a
full sha1.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/replace.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index e3aaf70..80e2039 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -46,24 +46,29 @@ typedef int (*each_replace_name_fn)(const char *name, const char *ref,
 
 static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 {
-	const char **p;
+	const char **p, *q;
 	char ref[PATH_MAX];
 	int had_error = 0;
 	unsigned char sha1[20];
 
 	for (p = argv; *p; p++) {
-		if (snprintf(ref, sizeof(ref), "refs/replace/%s", *p)
+		q = *p;
+		if (get_sha1(q, sha1))
+			warning("Failed to resolve '%s' as a valid ref; taking it literally.", q);
+		else
+			q = sha1_to_hex(sha1);
+		if (snprintf(ref, sizeof(ref), "refs/replace/%s", q)
 					>= sizeof(ref)) {
-			error("replace ref name too long: %.*s...", 50, *p);
+			error("replace ref name too long: %.*s...", 50, q);
 			had_error = 1;
 			continue;
 		}
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
-- 
1.8.0.370.g8cbad08
