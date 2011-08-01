From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 7/8] xdiff/xprepare: skip classification
Date: Mon,  1 Aug 2011 11:16:47 +0800
Message-ID: <1312168608-10828-8-git-send-email-rctay89@gmail.com>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
 <1312168608-10828-1-git-send-email-rctay89@gmail.com>
 <1312168608-10828-2-git-send-email-rctay89@gmail.com>
 <1312168608-10828-3-git-send-email-rctay89@gmail.com>
 <1312168608-10828-4-git-send-email-rctay89@gmail.com>
 <1312168608-10828-5-git-send-email-rctay89@gmail.com>
 <1312168608-10828-6-git-send-email-rctay89@gmail.com>
 <1312168608-10828-7-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 05:17:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnj0l-0003AB-PC
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 05:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab1HADRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 23:17:41 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57478 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab1HADRj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 23:17:39 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so6396293iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 20:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OeOazoaN8QhoUsMwE0hwFwVQrCU3EIoLQpn54dM46Hw=;
        b=f9IA86LCHnCmCtMHJ+nQ8vHoGYdQFpZExOmqzYzrBJzm8bZY3bbjXPRScpB2HvbU2y
         YMywxiuU0Z3QEQuWJ0EOWkGpDTNSmxMQ609eb3+7ySSymm3kxD5MZKvjKub6y0yLBnLA
         4Z9ScJTJdgPLihB2EJDPGRlR5xnk1+DMwDXKg=
Received: by 10.231.148.131 with SMTP id p3mr642787ibv.157.1312168659651;
        Sun, 31 Jul 2011 20:17:39 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id b6sm3071329ibg.48.2011.07.31.20.17.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 20:17:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1312168608-10828-7-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178302>

xdiff performs "classification" of records (xdl_classify_record()),
replacing hashes (xrecord_t.ha) with a unique identifier of the
record/line and building a hash table (xrecord_t.rhash) of records. This
is then used to "cleanup" records (xdl_cleanup_records()).

We don't need any of that in histogram diff, so we omit calls to these
functions. We also skip allocating memory to the hash table, rhash, as
it is no longer used.

This gives us a small boost in performance.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 xdiff/xprepare.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 3ebad0f..c139ba8 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -154,11 +154,15 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 	if (!(recs = (xrecord_t **) xdl_malloc(narec * sizeof(xrecord_t *))))
 		goto abort;
 
-	hbits = xdl_hashbits((unsigned int) narec);
-	hsize = 1 << hbits;
-	if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *))))
-		goto abort;
-	memset(rhash, 0, hsize * sizeof(xrecord_t *));
+	if (xpp->flags & XDF_HISTOGRAM_DIFF)
+		hbits = hsize = 0;
+	else {
+		hbits = xdl_hashbits((unsigned int) narec);
+		hsize = 1 << hbits;
+		if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *))))
+			goto abort;
+		memset(rhash, 0, hsize * sizeof(xrecord_t *));
+	}
 
 	nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize)) != NULL) {
@@ -178,7 +182,8 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 			crec->ha = hav;
 			recs[nrec++] = crec;
 
-			if (xdl_classify_record(cf, rhash, hbits, crec) < 0)
+			if (!(xpp->flags & XDF_HISTOGRAM_DIFF) &&
+				xdl_classify_record(cf, rhash, hbits, crec) < 0)
 				goto abort;
 		}
 	}
@@ -235,7 +240,8 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	enl1 = xdl_guess_lines(mf1) + 1;
 	enl2 = xdl_guess_lines(mf2) + 1;
 
-	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0) {
+	if (!(xpp->flags & XDF_HISTOGRAM_DIFF) &&
+		xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0) {
 
 		return -1;
 	}
@@ -252,10 +258,12 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		return -1;
 	}
 
-	xdl_free_classifier(&cf);
+	if (!(xpp->flags & XDF_HISTOGRAM_DIFF))
+		xdl_free_classifier(&cf);
 
-	if (!(xpp->flags & XDF_PATIENCE_DIFF) &&
-			xdl_optimize_ctxs(&xe->xdf1, &xe->xdf2) < 0) {
+	if ((xpp->flags & XDF_HISTOGRAM_DIFF) ?
+		xdl_trim_ends(&xe->xdf1, &xe->xdf2) < 0
+		: (!(xpp->flags & XDF_PATIENCE_DIFF) && xdl_optimize_ctxs(&xe->xdf1, &xe->xdf2) < 0)) {
 
 		xdl_free_ctx(&xe->xdf2);
 		xdl_free_ctx(&xe->xdf1);
-- 
1.7.3.4.730.g67af1.dirty
