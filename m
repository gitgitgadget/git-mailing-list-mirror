From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] git-patch-id: do not trip over "no newline" markers
Date: Wed, 16 Feb 2011 17:55:38 +0100
Message-ID: <144f7a4824abecaf87f862ed9e60587456128b41.1297875236.git.git@drmicha.warpmail.net>
References: <4D5BF73E.50002@drmicha.warpmail.net>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 17:58:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpkiL-0004jx-9a
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 17:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370Ab1BPQ6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 11:58:49 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36899 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752191Ab1BPQ6r (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 11:58:47 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3DD4D205C5;
	Wed, 16 Feb 2011 11:58:47 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 16 Feb 2011 11:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=COLu707mZKoQTTAz4QAkP2D810Q=; b=M8GETkJ2J1G+o0FhPiuoWAXknGDipoq+6itw7/OrseH3CyYdYG13vc2E1r3FyaKyc6skackyhXDUInumngppqpVMRxt8KI2mSuSpP085idS5Hm9VeKqB2C3TjlzqQNsxyrUx+D2ALhEd3/sftBqxeGLvL2PO/7bpiktJsxl1OXw=
X-Sasl-enc: 2BqdLxp2CzvM0acnbJAgt3SY7rwmihj8ckb5AijQPkIn 1297875526
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B4DD84436C0;
	Wed, 16 Feb 2011 11:58:46 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <4D5BF73E.50002@drmicha.warpmail.net>
In-Reply-To: <d27aa07556df763b34b980d3706320216094d592.1297875236.git.git@drmicha.warpmail.net>
References: <d27aa07556df763b34b980d3706320216094d592.1297875236.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166977>

Currently, patch-id trips over our very own diff extension for marking
the absence of newline at EOF.

Fix it. (Ignore it, it's whitespace.)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/patch-id.c  |    2 ++
 t/t4204-patch-id.sh |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 5125300..653d958 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -73,6 +73,8 @@ int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx)
 			p += 7;
 		else if (!memcmp(line, "From ", 5))
 			p += 5;
+		else if (!memcmp(line, "\\ No newline at end of file", 27))
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
