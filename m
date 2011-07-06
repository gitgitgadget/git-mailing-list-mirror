From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 1/4] xdiff/xprepare: use memset()
Date: Thu,  7 Jul 2011 00:38:54 +0800
Message-ID: <1309970337-6016-2-git-send-email-rctay89@gmail.com>
References: <1309970337-6016-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 18:39:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeV8G-0006LD-TR
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 18:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666Ab1GFQjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 12:39:19 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33952 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab1GFQjS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 12:39:18 -0400
Received: by qwk3 with SMTP id 3so39836qwk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ou4KArw4V8WaJ3bhfuaUvTI4P5Vl4yf0ol/FbFEHKr0=;
        b=g/o6GGrqL1KGOc2IOeXXAC+E38Mnsl3ANEKuXqrfoxhVXaI1iSy9s896IXA9h+vM90
         HP26L4MYb2+ebH/Nvncm6bwsDEzzJSyOELWRh+Fksb7AA6znjPUi1s/kS2ri1LW5e0hn
         Xl4DsUoqanXVjc6CKxlzvMe4QHO8IvqnPdcDQ=
Received: by 10.224.204.66 with SMTP id fl2mr6909286qab.78.1309970357692;
        Wed, 06 Jul 2011 09:39:17 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id i7sm4992595qcb.22.2011.07.06.09.39.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 09:39:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1309970337-6016-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176711>

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
1.7.3.4.721.g4666.dirty
