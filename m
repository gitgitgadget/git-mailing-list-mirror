From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] xdiff/xmerge: fix memory leak in xdl_merge
Date: Tue, 23 Feb 2016 09:45:51 +0100
Message-ID: <1456217151-16473-1-git-send-email-ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 09:46:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY8bj-00056z-Jj
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 09:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbcBWIqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 03:46:06 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39258 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750704AbcBWIqE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 03:46:04 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 576AC225BC
	for <git@vger.kernel.org>; Tue, 23 Feb 2016 03:46:01 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 23 Feb 2016 03:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=j4LqqHdHgv+X/wdjfYYZcD5a33
	Q=; b=ssKuVfgl7D3CiFbgWPX0OgkcEBDiBo6rSGQ2JeUV2VI9X1irjzOjdgbnRI
	PGIDbZa/HSu2/VE8x3NXdP7T+d0CocwpRNMA0+irerdC0+Xi3Oba3sdgRAFGmQYT
	uxzUURgDWi2+5QwGCU2CimYL5qHSrrJ8asQcOGj2Bk7vk4PSs=
X-Sasl-enc: CmtVYombeNUFx1lLWCD5UiLdFE6kFXW6843W06/sBZVG 1456217160
Received: from localhost (x5ce0f886.dyn.telefonica.de [92.224.248.134])
	by mail.messagingengine.com (Postfix) with ESMTPA id D8064C00016;
	Tue, 23 Feb 2016 03:46:00 -0500 (EST)
X-Mailer: git-send-email 2.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287034>

When building the script for the second file that is to be merged
we have already allocated memory for data structures related to
the first file. When we encounter an error in building the second
script we only free allocated memory related to the second file
before erroring out.

Fix this memory leak by also releasing allocated memory related
to the first file.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 xdiff/xmerge.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index d98f430..d04eb46 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -654,6 +654,8 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 	if (xdl_change_compact(&xe2.xdf1, &xe2.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe2.xdf2, &xe2.xdf1, xpp->flags) < 0 ||
 	    xdl_build_script(&xe2, &xscr2) < 0) {
+		xdl_free_script(xscr1);
+		xdl_free_env(&xe1);
 		xdl_free_env(&xe2);
 		return -1;
 	}
-- 
2.7.1
