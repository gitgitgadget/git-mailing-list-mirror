From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 1/8] xdiff/xprepare: use memset()
Date: Mon,  1 Aug 2011 11:16:41 +0800
Message-ID: <1312168608-10828-2-git-send-email-rctay89@gmail.com>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
 <1312168608-10828-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 05:17:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnj0H-0002z9-8P
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 05:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab1HADRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 23:17:03 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57478 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab1HADRB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 23:17:01 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so6396293iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 20:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zc+NC/SkoBWp77UKIZhjkOAocvKkuDIQV+M4zSY/SbQ=;
        b=SzFt/DLQzFhzCld9OXbJAvxItnvh4Q3DcG3OOEOA1Ugy98Tg8IxrCge40jm7WIt8Re
         pqjoeNJUmTSL+I72EtxRSyasjQsc8g/oK7qk6041gMw1/w+HPOVTbYfFfYKvJy+MDPSl
         ECSxp1KGSfx4nYOuS/eh4UlOeMOH1p/7iJpU4=
Received: by 10.231.112.98 with SMTP id v34mr2709495ibp.85.1312168621142;
        Sun, 31 Jul 2011 20:17:01 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id s2sm6159453icw.17.2011.07.31.20.16.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 20:17:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1312168608-10828-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178296>

Use memset() instead of a for loop to initialize. This could give a
performance advantage.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 xdiff/xprepare.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 1689085..783631a 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -64,8 +64,6 @@ static int xdl_optimize_ctxs(xdfile_t *xdf1, xdfile_t *xdf2);
 
 
 static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
-	long i;
-
 	cf->flags = flags;
 
 	cf->hbits = xdl_hashbits((unsigned int) size);
@@ -80,8 +78,7 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 		xdl_cha_free(&cf->ncha);
 		return -1;
 	}
-	for (i = 0; i < cf->hsize; i++)
-		cf->rchash[i] = NULL;
+	memset(cf->rchash, 0, cf->hsize * sizeof(xdlclass_t *));
 
 	cf->count = 0;
 
@@ -136,7 +133,7 @@ static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t **rhash, unsigned
 static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
 	unsigned int hbits;
-	long i, nrec, hsize, bsize;
+	long nrec, hsize, bsize;
 	unsigned long hav;
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
@@ -164,8 +161,7 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 		xdl_cha_free(&xdf->rcha);
 		return -1;
 	}
-	for (i = 0; i < hsize; i++)
-		rhash[i] = NULL;
+	memset(rhash, 0, hsize * sizeof(xrecord_t *));
 
 	nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize)) != NULL) {
-- 
1.7.3.4.730.g67af1.dirty
