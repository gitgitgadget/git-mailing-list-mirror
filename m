From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 2/4] xdiff/xprepare: refactor abort cleanups
Date: Thu,  7 Jul 2011 00:38:55 +0800
Message-ID: <1309970337-6016-3-git-send-email-rctay89@gmail.com>
References: <1309970337-6016-1-git-send-email-rctay89@gmail.com>
 <1309970337-6016-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 18:39:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeV8M-0006My-B8
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 18:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757Ab1GFQjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 12:39:24 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33952 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713Ab1GFQjY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 12:39:24 -0400
Received: by mail-qw0-f46.google.com with SMTP id 3so39836qwk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gA3VrYZHT5LlrzoT/y/bwHO1KjCou9bJ8sSjNJYjE0Y=;
        b=TDZBJSHXhdnJXPfbscD/i9GjN05AscO+LC8OGLZE1DztsQxrltiAeby9UtQ8L12f/H
         6JnYB0iBNKUTnTEaDD09OdaDmBLkwOA8KkXFpvUSMgDjycqRqMI8PUIGdhPj4fO80pxw
         s46baEq/wt3pBDy19qF07b6UMeiiI+q/fuhe0=
Received: by 10.229.137.149 with SMTP id w21mr6738891qct.59.1309970363586;
        Wed, 06 Jul 2011 09:39:23 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id e18sm6512687qcs.5.2011.07.06.09.39.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 09:39:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1309970337-6016-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176712>

Group free()'s that are called when a malloc() fails in
xdl_prepare_ctx(), making for more readable code.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 xdiff/xprepare.c |   94 +++++++++++++++++++----------------------------------
 1 files changed, 34 insertions(+), 60 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 783631a..6168327 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -143,24 +143,15 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 	char *rchg;
 	long *rindex;
 
-	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0) {
-
-		return -1;
-	}
-	if (!(recs = (xrecord_t **) xdl_malloc(narec * sizeof(xrecord_t *)))) {
-
-		xdl_cha_free(&xdf->rcha);
-		return -1;
-	}
+	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
+		goto abort_rcha;
+	if (!(recs = (xrecord_t **) xdl_malloc(narec * sizeof(xrecord_t *))))
+		goto abort_recs;
 
 	hbits = xdl_hashbits((unsigned int) narec);
 	hsize = 1 << hbits;
-	if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *)))) {
-
-		xdl_free(recs);
-		xdl_cha_free(&xdf->rcha);
-		return -1;
-	}
+	if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *))))
+		goto abort_rhash;
 	memset(rhash, 0, hsize * sizeof(xrecord_t *));
 
 	nrec = 0;
@@ -175,63 +166,30 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
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
+					goto abort_rrecs;
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
+				goto abort_crec;
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
+				goto abort_classify;
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
+		goto abort_rchg;
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
+		goto abort_rindex;
+	if (!(ha = (unsigned long *) xdl_malloc((nrec + 1) * sizeof(unsigned long))))
+		goto abort_ha;
 
 	xdf->nrec = nrec;
 	xdf->recs = recs;
@@ -245,6 +203,22 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 	xdf->dend = nrec - 1;
 
 	return 0;
+
+abort_ha:
+	xdl_free(rindex);
+abort_rindex:
+	xdl_free(rchg);
+abort_rchg:
+abort_classify:
+abort_crec:
+abort_rrecs:
+	xdl_free(rhash);
+abort_rhash:
+	xdl_free(recs);
+abort_recs:
+	xdl_cha_free(&xdf->rcha);
+abort_rcha:
+	return -1;
 }
 
 
-- 
1.7.3.4.721.g4666.dirty
