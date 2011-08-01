From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 3/8] xdiff/xprepare: refactor abort cleanups
Date: Mon,  1 Aug 2011 11:16:43 +0800
Message-ID: <1312168608-10828-4-git-send-email-rctay89@gmail.com>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
 <1312168608-10828-1-git-send-email-rctay89@gmail.com>
 <1312168608-10828-2-git-send-email-rctay89@gmail.com>
 <1312168608-10828-3-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 05:17:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnj0S-00032i-4G
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 05:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab1HADRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 23:17:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57478 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab1HADRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 23:17:14 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so6396293iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 20:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4MoJdTKGO281tE2aK5FxLCdfLUsBxfBYhD+0GLISS6g=;
        b=uthpPAMvvv595gAsAHB+qxazfYs7fVvnmaU/6CxYnBvp38LFf9jq7R1OhiQpKzkQDS
         N7H4uYxfjFKWrZwBbsb134r7S1IjGcwvYgqw4wOp9UyCNASYAo2sstggtWYK6YM5jAUM
         BR/+Bv33sPhwaXcFpPEgIq9F4wbLwhoP9/ZGI=
Received: by 10.231.200.82 with SMTP id ev18mr2725979ibb.0.1312168634249;
        Sun, 31 Jul 2011 20:17:14 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id a11sm3071938ibg.38.2011.07.31.20.17.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 20:17:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1312168608-10828-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178299>

Group free()'s that are called when a malloc() fails in
xdl_prepare_ctx(), making for more readable code.

Also add a free() on ha, in case future git hackers add allocs after the
ha malloc.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 xdiff/xprepare.c |   91 +++++++++++++++++++-----------------------------------
 1 files changed, 32 insertions(+), 59 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 49c7e8a..3ebad0f 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -143,24 +143,21 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 	char *rchg;
 	long *rindex;
 
-	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0) {
+	ha = NULL;
+	rindex = NULL;
+	rchg = NULL;
+	rhash = NULL;
+	recs = NULL;
 
-		return -1;
-	}
-	if (!(recs = (xrecord_t **) xdl_malloc(narec * sizeof(xrecord_t *)))) {
-
-		xdl_cha_free(&xdf->rcha);
-		return -1;
-	}
+	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
+		goto abort;
+	if (!(recs = (xrecord_t **) xdl_malloc(narec * sizeof(xrecord_t *))))
+		goto abort;
 
 	hbits = xdl_hashbits((unsigned int) narec);
 	hsize = 1 << hbits;
-	if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *)))) {
-
-		xdl_free(recs);
-		xdl_cha_free(&xdf->rcha);
-		return -1;
-	}
+	if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *))))
+		goto abort;
 	memset(rhash, 0, hsize * sizeof(xrecord_t *));
 
 	nrec = 0;
@@ -170,63 +167,30 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 			hav = xdl_hash_record(&cur, top, xpp->flags);
 			if (nrec >= narec) {
 				narec *= 2;
-				if (!(rrecs = (xrecord_t **) xdl_realloc(recs, narec * sizeof(xrecord_t *)))) {
-
-					xdl_free(rhash);
-					xdl_free(recs);
-					xdl_cha_free(&xdf->rcha);
-					return -1;
-				}
+				if (!(rrecs = (xrecord_t **) xdl_realloc(recs, narec * sizeof(xrecord_t *))))
+					goto abort;
 				recs = rrecs;
 			}
-			if (!(crec = xdl_cha_alloc(&xdf->rcha))) {
-
-				xdl_free(rhash);
-				xdl_free(recs);
-				xdl_cha_free(&xdf->rcha);
-				return -1;
-			}
+			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
+				goto abort;
 			crec->ptr = prev;
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
 			recs[nrec++] = crec;
 
-			if (xdl_classify_record(cf, rhash, hbits, crec) < 0) {
-
-				xdl_free(rhash);
-				xdl_free(recs);
-				xdl_cha_free(&xdf->rcha);
-				return -1;
-			}
+			if (xdl_classify_record(cf, rhash, hbits, crec) < 0)
+				goto abort;
 		}
 	}
 
-	if (!(rchg = (char *) xdl_malloc((nrec + 2) * sizeof(char)))) {
-
-		xdl_free(rhash);
-		xdl_free(recs);
-		xdl_cha_free(&xdf->rcha);
-		return -1;
-	}
+	if (!(rchg = (char *) xdl_malloc((nrec + 2) * sizeof(char))))
+		goto abort;
 	memset(rchg, 0, (nrec + 2) * sizeof(char));
 
-	if (!(rindex = (long *) xdl_malloc((nrec + 1) * sizeof(long)))) {
-
-		xdl_free(rchg);
-		xdl_free(rhash);
-		xdl_free(recs);
-		xdl_cha_free(&xdf->rcha);
-		return -1;
-	}
-	if (!(ha = (unsigned long *) xdl_malloc((nrec + 1) * sizeof(unsigned long)))) {
-
-		xdl_free(rindex);
-		xdl_free(rchg);
-		xdl_free(rhash);
-		xdl_free(recs);
-		xdl_cha_free(&xdf->rcha);
-		return -1;
-	}
+	if (!(rindex = (long *) xdl_malloc((nrec + 1) * sizeof(long))))
+		goto abort;
+	if (!(ha = (unsigned long *) xdl_malloc((nrec + 1) * sizeof(unsigned long))))
+		goto abort;
 
 	xdf->nrec = nrec;
 	xdf->recs = recs;
@@ -240,6 +204,15 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 	xdf->dend = nrec - 1;
 
 	return 0;
+
+abort:
+	xdl_free(ha);
+	xdl_free(rindex);
+	xdl_free(rchg);
+	xdl_free(rhash);
+	xdl_free(recs);
+	xdl_cha_free(&xdf->rcha);
+	return -1;
 }
 
 
-- 
1.7.3.4.730.g67af1.dirty
