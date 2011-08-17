From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2] xdiff/xprepare: improve O(n*m) performance in xdl_cleanup_records()
Date: Wed, 17 Aug 2011 09:53:57 +0800
Message-ID: <1313546037-4104-1-git-send-email-rctay89@gmail.com>
References: <7vd3g5i7ci.fsf@alter.siamese.dyndns.org>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 03:54:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtVKj-0002aK-Oi
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 03:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab1HQByM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 21:54:12 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52650 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab1HQByK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 21:54:10 -0400
Received: by yxj19 with SMTP id 19so418246yxj.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 18:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uGjFUdYLcL/Oaw2RIHbHVZgx4SECHjUukZ4Yc7bDKrQ=;
        b=dojVAYd1+ejMFEM2Pm0e3xr9Xuf+WpUEp+LyYyks3uuhV2eMOGEyKBcYHrUhNqam14
         hp7l93V46Bq2UCj1ud5LdIdR5NV9q4TJTj0/LCvSLCxeog7yQq6VTTM3ly3LMkLuLPB4
         I+EgXT1B+WnSYqYlWrssLTXdjyaJ5taP8UMCk=
Received: by 10.101.192.29 with SMTP id u29mr461713anp.66.1313546049399;
        Tue, 16 Aug 2011 18:54:09 -0700 (PDT)
Received: from localhost (nusnet-141-123.dynip.nus.edu.sg [137.132.141.123])
        by mx.google.com with ESMTPS id z7sm538746anz.0.2011.08.16.18.54.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 18:54:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <7vd3g5i7ci.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179494>

In xdl_cleanup_records(), we see O(n*m) performance, where n is the
number of records from xdf->dstart to xdf->dend, and m is the size of a
bucket in xdf->rhash (<= by mlim).

Here, we improve this to O(n) by pre-computing nm (in rcrec->len(1|2))
in xdl_classify_record().

Reported-by: Marat Radchenko <marat@slonopotamus.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed in v2:
 - free() xdlclassifier_t->rcrecs

On Wed, Aug 17, 2011 at 1:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> From 0da9ec94604978f877e7f7c00d307b5cdbb22b29 Mon Sep 17 00:00:00 2001
>> From: Tay Ray Chuan <rctay89@gmail.com>
>> Date: Tue, 16 Aug 2011 11:35:28 +0800
>> Subject: [PATCH] xdiff/xprepare: improve O(n*m) performance in
>> ?xdl_cleanup_records()
>
> You do not need these four lines. Thanks.

Oops, I directly pasted git-format-patch output into Claws-mail, sorry
about that.

>> In xdl_cleanup_records(), we see O(n*m) performance, where n is the
>> number of records from xdf->dstart to xdf->dend, and m is the size of a
>> bucket in xdf->rhash (<= by mlim).
>>
>> Here, we improve this to O(n) by pre-computing nm (in rcrec->len(1|2))
>> in xdl_classify_record().
>
> Could we have some benchmarks to let the readers get a feel of how much
> improvement this patch brings in?

On my msysgit machine with Marat's problematic repo
(git://slonopotamus.org/git-diff):

 rctay@TEST-123 /tmp/slono
 $ time git show >/dev/null

 real    0m8.538s
 user    0m0.000s
 sys     0m0.031s

 rctay@TEST-123 /tmp/slono
 $ time /git/git show >/dev/null

 real    0m0.672s
 user    0m0.031s
 sys     0m0.031s

> This tries to trade cycles with memory, right? How much bloat are we
> talking about here?

The main source of memory bloat would be the xdlclassifier_t->rcrecs
lookup table. This is needed to find the classifier record (xdlclass_t)
associated with a xrecord_t.

In an earlier iteration, I had a pointer on each xrecord_t to the
classifier record, instead of a lookup table, but I casted it to void*,
since I wasn't sure if the xdlclass_t definition should be shifted to
xtypes.h (and thus made public to xdiff and git).

The first is cleaner but the second is lighter. I'd appreciate comments
on this.

 xdiff/xprepare.c |   86 +++++++++++++++++++++++++++++++----------------------
 1 files changed, 50 insertions(+), 36 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 1689085..05a8f01 100644
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
@@ -91,16 +102,18 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {

 static void xdl_free_classifier(xdlclassifier_t *cf) {

+	xdl_free(cf->rcrecs);
 	xdl_free(cf->rchash);
 	xdl_cha_free(&cf->ncha);
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
@@ -116,13 +129,25 @@ static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t **rhash, unsigned
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
@@ -133,7 +158,7 @@ static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t **rhash, unsigned
 }


-static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
+static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
 	unsigned int hbits;
 	long i, nrec, hsize, bsize;
@@ -200,7 +225,7 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 			crec->ha = hav;
 			recs[nrec++] = crec;

-			if (xdl_classify_record(cf, rhash, hbits, crec) < 0) {
+			if (xdl_classify_record(pass, cf, rhash, hbits, crec) < 0) {

 				xdl_free(rhash);
 				xdl_free(recs);
@@ -276,28 +301,28 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
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

@@ -372,11 +397,10 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
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
@@ -387,26 +411,16 @@ static int xdl_cleanup_records(xdfile_t *xdf1, xdfile_t *xdf2) {
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
@@ -468,10 +482,10 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 }


-static int xdl_optimize_ctxs(xdfile_t *xdf1, xdfile_t *xdf2) {
+static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {

 	if (xdl_trim_ends(xdf1, xdf2) < 0 ||
-	    xdl_cleanup_records(xdf1, xdf2) < 0) {
+	    xdl_cleanup_records(cf, xdf1, xdf2) < 0) {

 		return -1;
 	}
--
1.7.6.12.g6486a.dirty
