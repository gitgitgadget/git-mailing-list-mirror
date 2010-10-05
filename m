From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] tag,verify-tag: do not trip over rfc1991 signatures
Date: Tue,  5 Oct 2010 17:40:07 +0200
Message-ID: <5cea498f34522d603a1561bfe69e2f92caa39ced.1286293083.git.git@drmicha.warpmail.net>
References: <4CAB46C0.9000807@drmicha.warpmail.net>
Cc: Stephan Hugel <urschrei@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 17:40:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P39cb-0004pl-Fz
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 17:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658Ab0JEPj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 11:39:56 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:49058 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754457Ab0JEPj4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 11:39:56 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D07511CCC;
	Tue,  5 Oct 2010 11:39:55 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 05 Oct 2010 11:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=9AEyMo+iDDQ/g+7cGCaSfvC5bUY=; b=mrjgR/lu37JDS9mfxVKgWDSL3qk3HO6G4WL23DRTO1wlglqdbwiRPLEcEFOtJp4u1/PXJ41wlVTf5jEHqD73BMbG4eFtvF6uIqEviuC1DW4KETe1UnJCmh045Uy1Ish6w8pzQqMaoduO8JSpAN5MiTIfX5F0V/5iXUoA3Jf+rrI=
X-Sasl-enc: mDJBNE+si3ivU7EHZ3GLuTO37txjVPGIgzqwjQnZj7KX 1286293195
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 502505E80D7;
	Tue,  5 Oct 2010 11:39:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.98.g5ad7d
In-Reply-To: <4CAB46C0.9000807@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158206>

Currently, git expects "-----BEGIN PGP SIGNATURE-----" at the beginning of a
signature. But gpg uses "MESSAGE" instead of "SIGNATURE" when used with
the "rfc1991" option. This leads to git's faling to verify it's own
signed tags.

Be more lenient and take "-----BEGIN PGP " as the indicator.

Reported-by: Stephan Hugel <urschrei@gmail.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/tag.c        |    6 +++---
 builtin/verify-tag.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index d311491..04bec17 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -29,7 +29,7 @@ struct tag_filter {
 	struct commit_list *with_commit;
 };
 
-#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
+#define PGP_SIGNATURE "-----BEGIN PGP "
 
 static int show_reference(const char *refname, const unsigned char *sha1,
 			  int flag, void *cb_data)
@@ -72,7 +72,7 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 		/* only take up to "lines" lines, and strip the signature */
 		for (i = 0, sp += 2;
 				i < filter->lines && sp < buf + size &&
-				prefixcmp(sp, PGP_SIGNATURE "\n");
+				prefixcmp(sp, PGP_SIGNATURE);
 				i++) {
 			if (i)
 				printf("\n    ");
@@ -256,7 +256,7 @@ static void write_tag_body(int fd, const unsigned char *sha1)
 		return;
 	}
 	sp += 2; /* skip the 2 LFs */
-	eob = strstr(sp, "\n" PGP_SIGNATURE "\n");
+	eob = strstr(sp, "\n" PGP_SIGNATURE);
 	if (eob)
 		len = eob - sp;
 	else
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 9f482c2..3c85d0a 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -17,7 +17,7 @@ static const char * const verify_tag_usage[] = {
 		NULL
 };
 
-#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
+#define PGP_SIGNATURE "-----BEGIN PGP "
 
 static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 {
-- 
1.7.3.98.g5ad7d
