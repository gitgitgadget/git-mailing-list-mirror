From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] xdiff/xprepare: improve O(n*m) performance in
 xdl_cleanup_records()
Date: Tue, 16 Aug 2011 11:37:10 +0800
Message-ID: <20110816113710.000025a7@unknown>
References: <loom.20110809T093124-847@post.gmane.org>
	<1313464312-5132-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 05:37:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtAT8-0006EM-Ih
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 05:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373Ab1HPDh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 23:37:28 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59203 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab1HPDh1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2011 23:37:27 -0400
Received: by yxj19 with SMTP id 19so3526961yxj.19
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 20:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=dd8eRK9vG0GSWndoVQOLRFmv8dDTXCQrxAGuGpptXNg=;
        b=KG/Mkd68ikdQ//ivXDYpyr8+WYF4ZGTvV4Mxy6nadw2WBBvSeJZUHJYDZPtTOfDHw8
         U/uziLM4lmIWek5yzUIzJ3O+bkeQdvp1o4YJWg8Pc5DJQekZbBXRdWjqztuFKQLSvMDq
         XZiFMgTC7G04wN/D4MwvXWdNWf49l5YpLlprM=
Received: by 10.150.194.10 with SMTP id r10mr5487300ybf.318.1313465846986;
        Mon, 15 Aug 2011 20:37:26 -0700 (PDT)
Received: from unknown (nusnet-18-4.dynip.nus.edu.sg [137.132.18.4])
        by mx.google.com with ESMTPS id f5sm2245534ybf.16.2011.08.15.20.37.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Aug 2011 20:37:25 -0700 (PDT)
In-Reply-To: <1313464312-5132-1-git-send-email-rctay89@gmail.com>
X-Mailer: Claws Mail 3.7.8cvs47 (GTK+ 2.16.6; i586-pc-mingw32msvc)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179402>

>From 0da9ec94604978f877e7f7c00d307b5cdbb22b29 Mon Sep 17 00:00:00 2001
From: Tay Ray Chuan <rctay89@gmail.com>
Date: Tue, 16 Aug 2011 11:35:28 +0800
Subject: [PATCH] xdiff/xprepare: improve O(n*m) performance in
 xdl_cleanup_records()

In xdl_cleanup_records(), we see O(n*m) performance, where n is the
number of records from xdf->dstart to xdf->dend, and m is the size of a
bucket in xdf->rhash (<= by mlim).

Here, we improve this to O(n) by pre-computing nm (in rcrec->len(1|2))
in xdl_classify_record().

Reported-by: Marat Radchenko <marat@slonopotamus.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Junio, this one is rebased on v1.7.6, instead of rc/histogram-diff.

 xdiff/xprepare.c |   85 +++++++++++++++++++++++++++++++-----------------------
 1 files changed, 49 insertions(+), 36 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 1689085..ebbec19 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -34,6 +34,7 @@ typedef struct s_xdlclass {
 	char const *line;
 	long size;
 	long idx;
+	long len1, len2;
 } xdlclass_t;
 
 typedef struct s_xdlclassifier {
@@ -41,6 +42,8 @@ typedef struct s_xdlclassifier {
 	long hsize;
 	xdlclass_t **rchash;
 	chastore_t ncha;
+	xdlclass_t **rcrecs;
+	long alloc;
 	long count;
 	long flags;
 } xdlclassifier_t;
@@ -50,15 +53,15 @@ typedef struct s_xdlclassifier {
 
 static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags);
 static void xdl_free_classifier(xdlclassifier_t *cf);
-static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t **rhash, unsigned int hbits,
-			       xrecord_t *rec);
-static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
+static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t **rhash,
+			       unsigned int hbits, xrecord_t *rec);
+static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf);
 static void xdl_free_ctx(xdfile_t *xdf);
 static int xdl_clean_mmatch(char const *dis, long i, long s, long e);
-static int xdl_cleanup_records(xdfile_t *xdf1, xdfile_t *xdf2);
+static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2);
 static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2);
-static int xdl_optimize_ctxs(xdfile_t *xdf1, xdfile_t *xdf2);
+static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2);
 
 
 
@@ -83,6 +86,14 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 	for (i = 0; i < cf->hsize; i++)
 		cf->rchash[i] = NULL;
 
+	cf->alloc = size;
+	if (!(cf->rcrecs = (xdlclass_t **) xdl_malloc(cf->alloc * sizeof(xdlclass_t *)))) {
+
+		xdl_free(cf->rchash);
+		xdl_cha_free(&cf->ncha);
+		return -1;
+	}
+
 	cf->count = 0;
 
 	return 0;
@@ -96,11 +107,12 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 }
 
 
-static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t **rhash, unsigned int hbits,
-			       xrecord_t *rec) {
+static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t **rhash,
+			       unsigned int hbits, xrecord_t *rec) {
 	long hi;
 	char const *line;
 	xdlclass_t *rcrec;
+	xdlclass_t **rcrecs;
 
 	line = rec->ptr;
 	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
@@ -116,13 +128,25 @@ static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t **rhash, unsigned
 			return -1;
 		}
 		rcrec->idx = cf->count++;
+		if (cf->count > cf->alloc) {
+			cf->alloc *= 2;
+			if (!(rcrecs = (xdlclass_t **) xdl_realloc(cf->rcrecs, cf->alloc * sizeof(xdlclass_t *)))) {
+
+				return -1;
+			}
+			cf->rcrecs = rcrecs;
+		}
+		cf->rcrecs[rcrec->idx] = rcrec;
 		rcrec->line = line;
 		rcrec->size = rec->size;
 		rcrec->ha = rec->ha;
+		rcrec->len1 = rcrec->len2 = 0;
 		rcrec->next = cf->rchash[hi];
 		cf->rchash[hi] = rcrec;
 	}
 
+	(pass == 1) ? rcrec->len1++ : rcrec->len2++;
+
 	rec->ha = (unsigned long) rcrec->idx;
 
 	hi = (long) XDL_HASHLONG(rec->ha, hbits);
@@ -133,7 +157,7 @@ static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t **rhash, unsigned
 }
 
 
-static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
+static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
 	unsigned int hbits;
 	long i, nrec, hsize, bsize;
@@ -200,7 +224,7 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 			crec->ha = hav;
 			recs[nrec++] = crec;
 
-			if (xdl_classify_record(cf, rhash, hbits, crec) < 0) {
+			if (xdl_classify_record(pass, cf, rhash, hbits, crec) < 0) {
 
 				xdl_free(rhash);
 				xdl_free(recs);
@@ -276,28 +300,28 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		return -1;
 	}
 
-	if (xdl_prepare_ctx(mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
+	if (xdl_prepare_ctx(1, mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
 
 		xdl_free_classifier(&cf);
 		return -1;
 	}
-	if (xdl_prepare_ctx(mf2, enl2, xpp, &cf, &xe->xdf2) < 0) {
+	if (xdl_prepare_ctx(2, mf2, enl2, xpp, &cf, &xe->xdf2) < 0) {
 
 		xdl_free_ctx(&xe->xdf1);
 		xdl_free_classifier(&cf);
 		return -1;
 	}
 
-	xdl_free_classifier(&cf);
-
 	if (!(xpp->flags & XDF_PATIENCE_DIFF) &&
-			xdl_optimize_ctxs(&xe->xdf1, &xe->xdf2) < 0) {
+			xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2) < 0) {
 
 		xdl_free_ctx(&xe->xdf2);
 		xdl_free_ctx(&xe->xdf1);
 		return -1;
 	}
 
+	xdl_free_classifier(&cf);
+
 	return 0;
 }
 
@@ -372,11 +396,10 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
  * matches on the other file. Also, lines that have multiple matches
  * might be potentially discarded if they happear in a run of discardable.
  */
-static int xdl_cleanup_records(xdfile_t *xdf1, xdfile_t *xdf2) {
-	long i, nm, rhi, nreff, mlim;
-	unsigned long hav;
+static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
+	long i, nm, nreff;
 	xrecord_t **recs;
-	xrecord_t *rec;
+	xdlclass_t *rcrec;
 	char *dis, *dis1, *dis2;
 
 	if (!(dis = (char *) xdl_malloc(xdf1->nrec + xdf2->nrec + 2))) {
@@ -387,26 +410,16 @@ static int xdl_cleanup_records(xdfile_t *xdf1, xdfile_t *xdf2) {
 	dis1 = dis;
 	dis2 = dis1 + xdf1->nrec + 1;
 
-	if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
-		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
-		hav = (*recs)->ha;
-		rhi = (long) XDL_HASHLONG(hav, xdf2->hbits);
-		for (nm = 0, rec = xdf2->rhash[rhi]; rec; rec = rec->next)
-			if (rec->ha == hav && ++nm == mlim)
-				break;
-		dis1[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
+		rcrec = cf->rcrecs[(*recs)->ha];
+		nm = rcrec ? rcrec->len2 : 0;
+		dis1[i] = (nm == 0) ? 0: 1;
 	}
 
-	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
-		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
-		hav = (*recs)->ha;
-		rhi = (long) XDL_HASHLONG(hav, xdf1->hbits);
-		for (nm = 0, rec = xdf1->rhash[rhi]; rec; rec = rec->next)
-			if (rec->ha == hav && ++nm == mlim)
-				break;
-		dis2[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
+		rcrec = cf->rcrecs[(*recs)->ha];
+		nm = rcrec ? rcrec->len1 : 0;
+		dis2[i] = (nm == 0) ? 0: 1;
 	}
 
 	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
@@ -468,10 +481,10 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 }
 
 
-static int xdl_optimize_ctxs(xdfile_t *xdf1, xdfile_t *xdf2) {
+static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
 
 	if (xdl_trim_ends(xdf1, xdf2) < 0 ||
-	    xdl_cleanup_records(xdf1, xdf2) < 0) {
+	    xdl_cleanup_records(cf, xdf1, xdf2) < 0) {
 
 		return -1;
 	}
-- 
1.7.6
