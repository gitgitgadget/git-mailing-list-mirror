From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [RFC/PATCH 2/3] xdiff/xprepare: skip classification
Date: Tue, 12 Jul 2011 14:10:26 +0800
Message-ID: <1310451027-15148-3-git-send-email-rctay89@gmail.com>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
 <1310451027-15148-2-git-send-email-rctay89@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 08:10:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgWBL-0003gC-E6
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 08:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab1GLGKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 02:10:47 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64097 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686Ab1GLGKq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 02:10:46 -0400
Received: by mail-gy0-f174.google.com with SMTP id 3so1811102gyh.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 23:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=D0xzqicombebLjWZVooI1og6rzh6o/Y0araZrUk0dqg=;
        b=fmV10GpPNjaD5Mv0vBiiiWfYrK6syW6ZPs5T4wzs43znqF52OvcMt8QlcvSGwW0P3h
         l7y6OlHbX1yqrxb1oCMGmArDXJF8qYhm5QjjOEqasCHFWqvnt9ms0yWNS1NZc+7S8O+2
         7ehbx9ERIiwSQtD1PJDPTuNzh33drBrJYl/Is=
Received: by 10.150.1.6 with SMTP id 6mr149305yba.357.1310451046180;
        Mon, 11 Jul 2011 23:10:46 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id c63sm3207602yhe.4.2011.07.11.23.10.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 23:10:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1310451027-15148-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176922>

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
 xdiff/xprepare.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 0f571db..7556538 100644
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
@@ -183,7 +187,8 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 			crec->ha = hav;
 			recs[nrec++] = crec;
 
-			if (xdl_classify_record(cf, rhash, hbits, crec) < 0)
+			if (!(xpp->flags & XDF_HISTOGRAM_DIFF) &&
+				xdl_classify_record(cf, rhash, hbits, crec) < 0)
 				goto abort;
 		}
 	}
@@ -240,7 +245,8 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	enl1 = xdl_guess_lines(mf1) + 1;
 	enl2 = xdl_guess_lines(mf2) + 1;
 
-	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0) {
+	if (!(xpp->flags & XDF_HISTOGRAM_DIFF) &&
+		xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0) {
 
 		return -1;
 	}
@@ -257,9 +263,11 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		return -1;
 	}
 
-	xdl_free_classifier(&cf);
+	if (!(xpp->flags & XDF_HISTOGRAM_DIFF))
+		xdl_free_classifier(&cf);
 
 	if (!(xpp->flags & XDF_PATIENCE_DIFF) &&
+			!(xpp->flags & XDF_HISTOGRAM_DIFF) &&
 			xdl_optimize_ctxs(&xe->xdf1, &xe->xdf2) < 0) {
 
 		xdl_free_ctx(&xe->xdf2);
-- 
1.7.3.4.681.gb718e
