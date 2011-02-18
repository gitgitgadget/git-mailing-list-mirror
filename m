From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 2/2] git-patch-id: do not trip over "no newline" markers
Date: Fri, 18 Feb 2011 11:12:42 +0100
Message-ID: <c0ee81b29d902e773dc851aaf86b99c9337079c9.1298023827.git.git@drmicha.warpmail.net>
References: <4D5E278F.2010509@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 18 11:16:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqNNb-0008JG-S1
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 11:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673Ab1BRKP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 05:15:57 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33156 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753161Ab1BRKPz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 05:15:55 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 889A320E5D;
	Fri, 18 Feb 2011 05:15:55 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 18 Feb 2011 05:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=kOEPsf1NJCP9gaSShfbHD8IY7bI=; b=nK7HAg+5FEwqLUO81yIXuPeFUio07Upv7yeIWzI76TE8nGg2g8Vhl3xC/z98N4YNiNs1qRjgJN6D4H1o/gDcTQaBBsgKGcjzRztxRer41wu7RO1fyqMEB+eJ9pqizOcPRkIH6FTtUUCMgNBhTbRWBYkAfPb7Wop85VIn2/o98Lo=
X-Sasl-enc: eHasLKRYg0cv91fm/Z1r6dWdBsTE5oi93QMQHy4wavUL 1298024155
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 093BB44A1C8;
	Fri, 18 Feb 2011 05:15:54 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <4D5E278F.2010509@drmicha.warpmail.net>
In-Reply-To: <26bc8a07f1b965a3022c3a1542f95422a8462e42.1298023827.git.git@drmicha.warpmail.net>
References: <26bc8a07f1b965a3022c3a1542f95422a8462e42.1298023827.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167191>

Currently, patch-id trips over the diff extension for marking
the absence of newline at EOF.

Fix it. (Ignore it, it's whitespace.)

This uses the same detection rationale as in buitlin/apply.c, which was
introduced in

433ef8a ([PATCH] Make git-apply understand incomplete lines in non-C locales, 2005-09-04)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
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
