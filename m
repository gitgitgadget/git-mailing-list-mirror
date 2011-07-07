From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 2/4] xdiff/xprepare: refactor abort cleanups
Date: Thu,  7 Jul 2011 12:23:56 +0800
Message-ID: <1310012638-3668-3-git-send-email-rctay89@gmail.com>
References: <1309970337-6016-1-git-send-email-rctay89@gmail.com>
 <1310012638-3668-1-git-send-email-rctay89@gmail.com>
 <1310012638-3668-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 07 06:24:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qeg8g-0008Kl-3t
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 06:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562Ab1GGEYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 00:24:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60634 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab1GGEYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 00:24:24 -0400
Received: by mail-iw0-f174.google.com with SMTP id 6so513718iwn.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 21:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QQenImGWDwUUBmMPYTwpMzUO3Lx4jmXDA76WaA2BqWA=;
        b=epJGT47V56McJnUxEo5/BEQUfl3WN6nzCvOFDse40pv2ixmAQkrp7opHa/8dUx1RjL
         bs/Jg2TY280yeekgUWPr5RSGF2BZYoy3B/Ft8VO7SfKWuZp+hCLs3XeugY1txEAySFYX
         tiSIRcmEo6RRmI9gUv0DlofTKaaiGKZ6h7FZg=
Received: by 10.231.61.198 with SMTP id u6mr304881ibh.160.1310012664053;
        Wed, 06 Jul 2011 21:24:24 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id my4sm5248001ibb.37.2011.07.06.21.24.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 21:24:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1310012638-3668-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176745>

Group free()'s that are called when a malloc() fails in
xdl_prepare_ctx(), making for more readable code.

Also add a free() on ha, in case future git hackers add allocs after the
ha malloc.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed from v2: took up Junio's suggestion and used one cleanup label
only.

 xdiff/xprepare.c |   91 +++++++++++++++++++-----------------------------------
 1 files changed, 32 insertions(+), 59 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 783631a..0f571db 100644
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
@@ -175,63 +172,30 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
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
@@ -245,6 +209,15 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
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
1.7.3.4.676.gf08cd.dirty
