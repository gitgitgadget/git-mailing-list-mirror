From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 4/5] Allow xdiff machinery to cache hash results for a file
Date: Thu, 21 Aug 2008 18:22:00 -0500
Message-ID: <1219360921-28529-5-git-send-email-bdowning@lavos.net>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net>
 <1219360921-28529-2-git-send-email-bdowning@lavos.net>
 <1219360921-28529-3-git-send-email-bdowning@lavos.net>
 <1219360921-28529-4-git-send-email-bdowning@lavos.net>
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 01:34:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWJfG-0003Ti-9v
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 01:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051AbYHUXcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 19:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755882AbYHUXcv
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 19:32:51 -0400
Received: from mail.somat.com ([63.252.84.66]:50096 "EHLO somat1.somat.local"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755560AbYHUXct (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 19:32:49 -0400
X-Greylist: delayed 634 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Aug 2008 19:32:39 EDT
Received: from silvara.lavos.net ([192.168.0.108]) by somat1.somat.local with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 21 Aug 2008 18:22:01 -0500
Received: (nullmailer pid 28572 invoked by uid 1000);
	Thu, 21 Aug 2008 23:22:01 -0000
X-Mailer: git-send-email 1.5.6.1
In-Reply-To: <1219360921-28529-4-git-send-email-bdowning@lavos.net>
X-OriginalArrivalTime: 21 Aug 2008 23:22:01.0695 (UTC) FILETIME=[B7267EF0:01C903E4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93229>

When generating diffs against the same file multiple times, it is a
waste of work to regenerate the hash values for each line each time.
Instead, allow a cache pointer to be passed in xpparam_t; set mf1_cache
to the cache for the first mmfile_t to xdl_diff, and mf2_cache for the
second.

This works like:

	xdcache_t cache;
	memset(cache, 0, sizeof(cache));
	/* ... */
	xpp.mf1_cache = &cache;
	xdl_diff(file1, file2, &xpp, &xecfg, &ecb);
	/* ...later... */
	xpp.mf1_cache = &cache;
	xdl_diff(file1, file3, &xpp, &xecfg, &ecb);
	/* The cache for file1 will be reused. */
	xdl_cache_free(&cache);

Note that this isn't compatible with xdi_diff as-is, as getting a
complete cache is incompatible with tail trimming.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 xdiff/xdiff.h    |   11 ++++++++++
 xdiff/xprepare.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++------
 xdiff/xtypes.h   |    1 +
 3 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 281fc0b..6fd922b 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -65,8 +65,17 @@ typedef struct s_mmbuffer {
 	long size;
 } mmbuffer_t;
 
+typedef struct s_xdcache_int {
+	long nrec;
+	unsigned long flags;
+	unsigned long *ha;
+	long *size;
+} xdcache_t;
+
 typedef struct s_xpparam {
 	unsigned long flags;
+	xdcache_t *mf1_cache;
+	xdcache_t *mf2_cache;
 } xpparam_t;
 
 typedef struct s_xdemitcb {
@@ -104,6 +113,8 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		mmfile_t *mf2, const char *name2,
 		xpparam_t const *xpp, int level, mmbuffer_t *result);
 
+void xdl_cache_free(xdcache_t *cache);
+
 #ifdef __cplusplus
 }
 #endif /* #ifdef __cplusplus */
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index e87ab57..291caf9 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -54,7 +54,8 @@ static void xdl_free_classifier(xdlclassifier_t *cf);
 static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t **rhash, unsigned int hbits,
 			       xrecord_t *rec);
 static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
-			   xdlclassifier_t *cf, xdfile_t *xdf);
+			   xdlclassifier_t *cf, xdfile_t *xdf,
+			   xdcache_t *cache);
 static void xdl_free_ctx(xdfile_t *xdf);
 static int xdl_clean_mmatch(char const *dis, long i, long s, long e);
 static int xdl_cleanup_records(xdfile_t *xdf1, xdfile_t *xdf2);
@@ -135,7 +136,8 @@ static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t **rhash, unsigned
 
 
 static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
-			   xdlclassifier_t *cf, xdfile_t *xdf) {
+			   xdlclassifier_t *cf, xdfile_t *xdf,
+			   xdcache_t *cache) {
 	unsigned int hbits;
 	long i, nrec, hsize, bsize;
 	unsigned long hav;
@@ -177,7 +179,12 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 				top = blk + bsize;
 			}
 			prev = cur;
-			hav = xdl_hash_record(&cur, top, xpp->flags);
+			if (cache && cache->ha) {
+				hav = cache->ha[nrec];
+				cur += cache->size[nrec];
+			} else {
+				hav = xdl_hash_record(&cur, top, xpp->flags);
+			}
 			if (nrec >= narec) {
 				narec *= 2;
 				if (!(rrecs = (xrecord_t **) xdl_realloc(recs, narec * sizeof(xrecord_t *)))) {
@@ -199,6 +206,7 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 			crec->ptr = prev;
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
+			crec->original_ha = hav;
 			recs[nrec++] = crec;
 
 			if (xdl_classify_record(cf, rhash, hbits, crec) < 0) {
@@ -249,6 +257,23 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 	xdf->dstart = 0;
 	xdf->dend = nrec - 1;
 
+	if (cache && !cache->ha) {
+		cache->nrec = nrec;
+		cache->ha = xdl_malloc(nrec * sizeof(unsigned long));
+		if (!cache->ha)
+			return 0;
+		cache->size = xdl_malloc(nrec * sizeof(long));
+		if (!cache->size) {
+			xdl_free(cache->ha);
+			cache->ha = NULL;
+			return 0;
+		}
+		for (i = 0; i < nrec; ++i) {
+			cache->ha[i] = recs[i]->original_ha;
+			cache->size[i] = recs[i]->size;
+		}
+	}
+
 	return 0;
 }
 
@@ -268,21 +293,34 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		    xdfenv_t *xe) {
 	long enl1, enl2;
 	xdlclassifier_t cf;
+	xdcache_t *c1 = xpp->mf1_cache;
+	xdcache_t *c2 = xpp->mf2_cache;
 
-	enl1 = xdl_guess_lines(mf1) + 1;
-	enl2 = xdl_guess_lines(mf2) + 1;
+	if (c1) {
+		if (c1->flags != xpp->flags)
+			xdl_cache_free(c1);
+		c1->flags = xpp->flags;
+	}
+	if (c2) {
+		if (c2->flags != xpp->flags)
+			xdl_cache_free(c2);
+		c2->flags = xpp->flags;
+	}
+
+	enl1 = c1 && c1->nrec ? c1->nrec : (xdl_guess_lines(mf1) + 1);
+	enl2 = c2 && c2->nrec ? c2->nrec : (xdl_guess_lines(mf2) + 1);
 
 	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0) {
 
 		return -1;
 	}
 
-	if (xdl_prepare_ctx(mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
+	if (xdl_prepare_ctx(mf1, enl1, xpp, &cf, &xe->xdf1, c1) < 0) {
 
 		xdl_free_classifier(&cf);
 		return -1;
 	}
-	if (xdl_prepare_ctx(mf2, enl2, xpp, &cf, &xe->xdf2) < 0) {
+	if (xdl_prepare_ctx(mf2, enl2, xpp, &cf, &xe->xdf2, c2) < 0) {
 
 		xdl_free_ctx(&xe->xdf1);
 		xdl_free_classifier(&cf);
@@ -309,6 +347,13 @@ void xdl_free_env(xdfenv_t *xe) {
 }
 
 
+void xdl_cache_free(xdcache_t *cache) {
+	xdl_free(cache->ha);
+	xdl_free(cache->size);
+	memset(cache, 0, sizeof(xdcache_t));
+}
+
+
 static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
 	long r, rdis0, rpdis0, rdis1, rpdis1;
 
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 2511aef..e6f6890 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -43,6 +43,7 @@ typedef struct s_xrecord {
 	char const *ptr;
 	long size;
 	unsigned long ha;
+	unsigned long original_ha;
 } xrecord_t;
 
 typedef struct s_xdfile {
-- 
1.5.6.1
