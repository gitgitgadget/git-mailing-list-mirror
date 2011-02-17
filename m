From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/2] git-patch-id: do not trip over "no newline" markers
Date: Thu, 17 Feb 2011 08:44:42 +0100
Message-ID: <536855b39d0ab5bb657ee6117a7e7c6bb0de0027.1297928549.git.git@drmicha.warpmail.net>
References: <7vwrkziw2i.fsf@alter.siamese.dyndns.org>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 08:47:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppyak-0007Fv-Fr
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 08:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780Ab1BQHrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 02:47:53 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44271 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752670Ab1BQHrv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 02:47:51 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0E69D20832;
	Thu, 17 Feb 2011 02:47:51 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 17 Feb 2011 02:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=xV+01dbLBTRzNqY8TQ/fmqh8ZUM=; b=G3QId6luZRTlIyNGZgQdNaiSK9Bh41Cf2gFnfgqiXMbPKNmPYLzTKg4/6hi1TS07ZiJ0IUpvASIRLhM/n/+N6pCQuUxRsQZDyDx7mezl4I4TzMDmFoe80gxGQFc7Bw5zbf0CrXPJ3vpStogqiq5P2AfbuzVj0nejLZNTsqreMpo=
X-Sasl-enc: qGagA/z43Rs0PNNqJ43L5zmTo8jgLKcFrDYkuerZWEg1 1297928870
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A0421400FD7;
	Thu, 17 Feb 2011 02:47:50 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <7vwrkziw2i.fsf@alter.siamese.dyndns.org>
In-Reply-To: <d27aa07556df763b34b980d3706320216094d592.1297928549.git.git@drmicha.warpmail.net>
References: <d27aa07556df763b34b980d3706320216094d592.1297928549.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167052>

Currently, patch-id trips over our very own diff extension for marking
the absence of newline at EOF.

Fix it. (Ignore it, it's whitespace.)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
v2 has the more fuzzy marker detection from "apply" as suggested by Junio.

 builtin/patch-id.c  |    2 ++
 t/t4204-patch-id.sh |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 5125300..e1c3cb9 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -73,6 +73,8 @@ int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx)
 			p += 7;
 		else if (!memcmp(line, "From ", 5))
 			p += 5;
+		else if (!memcmp(line, "\\ ", 2) && strlen(line)>=12)
+			continue;
 
 		if (!get_sha1_hex(p, next_sha1)) {
 			found_next = 1;
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index db96064..d2c930d 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -94,7 +94,7 @@ index e69de29..6178079 100644
 +b
 EOF
 
-test_expect_failure 'patch-id handles no-nl-at-eof markers' '
+test_expect_success 'patch-id handles no-nl-at-eof markers' '
 	cat nonl | calc_patch_id nonl &&
 	cat withnl | calc_patch_id withnl &&
 	test_cmp patch-id_nonl patch-id_withnl
-- 
1.7.4.1.74.gf39475.dirty
