From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [RFC/PATCH 3/3] xdiff/xprepare: use a smaller sample size for histogram diff
Date: Tue, 12 Jul 2011 14:10:27 +0800
Message-ID: <1310451027-15148-4-git-send-email-rctay89@gmail.com>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
 <1310451027-15148-2-git-send-email-rctay89@gmail.com>
 <1310451027-15148-3-git-send-email-rctay89@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 08:10:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgWBN-0003gC-1C
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 08:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980Ab1GLGKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 02:10:53 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:62481 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686Ab1GLGKw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 02:10:52 -0400
Received: by yia27 with SMTP id 27so1815536yia.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 23:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5tGjdoNYbxqsdA6Y3cuxq5atm1+oC4JQmjTffUDGt/8=;
        b=jHfSe3DSnb7yjaBxfSruoTB1AXMvP8rP45dD5YiYsiqxp/c77QdmB88l6UkbEO3FAl
         PuKbU8kvmbK0yvzr9DcA+U9FcadclpzjNLCC0MXYBSxspRHmdAGPPOCPafA9x0qCHTlw
         8Y+Iz94RiwCO104bOEfjHPIa2qivHkE2z0cfQ=
Received: by 10.151.29.16 with SMTP id g16mr1953501ybj.223.1310451051656;
        Mon, 11 Jul 2011 23:10:51 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id o47sm9877694yhn.30.2011.07.11.23.10.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 23:10:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1310451027-15148-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176923>

For histogram diff, we can afford a smaller sample size and thus a
poorer estimate of the number of lines, as the hash table (rhash) won't
be filled up/grown. This is safe as the final count of lines (xdf.nrecs)
will be updated correctly anyway by xdl_prepare_ctx().

This gives us a small boost in performance.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 xdiff/xprepare.c |   17 ++++++++++++++---
 xdiff/xutils.c   |    8 ++------
 xdiff/xutils.h   |    2 +-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 7556538..dfbb0de 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -26,6 +26,8 @@
 #define XDL_KPDIS_RUN 4
 #define XDL_MAX_EQLIMIT 1024
 #define XDL_SIMSCAN_WINDOW 100
+#define XDL_GUESS_NLINES1 256
+#define XDL_GUESS_NLINES2 20
 
 
 typedef struct s_xdlclass {
@@ -239,11 +241,20 @@ static void xdl_free_ctx(xdfile_t *xdf) {
 
 int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		    xdfenv_t *xe) {
-	long enl1, enl2;
+	long enl1, enl2, sample;
 	xdlclassifier_t cf;
 
-	enl1 = xdl_guess_lines(mf1) + 1;
-	enl2 = xdl_guess_lines(mf2) + 1;
+	/*
+	 * For histogram diff, we can afford a smaller sample size and
+	 * thus a poorer estimate of the number of lines, as the hash
+	 * table (rhash) won't be filled up/grown. The number of lines
+	 * (nrecs) will be updated correctly anyway by
+	 * xdl_prepare_ctx().
+	 */
+	sample = xpp->flags & XDF_HISTOGRAM_DIFF ? XDL_GUESS_NLINES2 : XDL_GUESS_NLINES1;
+
+	enl1 = xdl_guess_lines(mf1, sample) + 1;
+	enl2 = xdl_guess_lines(mf2, sample) + 1;
 
 	if (!(xpp->flags & XDF_HISTOGRAM_DIFF) &&
 		xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0) {
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index ded7c32..a45e89b 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -24,10 +24,6 @@
 
 
 
-#define XDL_GUESS_NLINES 256
-
-
-
 
 long xdl_bogosqrt(long n) {
 	long i;
@@ -159,12 +155,12 @@ void *xdl_cha_next(chastore_t *cha) {
 }
 
 
-long xdl_guess_lines(mmfile_t *mf) {
+long xdl_guess_lines(mmfile_t *mf, long sample) {
 	long nl = 0, size, tsize = 0;
 	char const *data, *cur, *top;
 
 	if ((cur = data = xdl_mmfile_first(mf, &size)) != NULL) {
-		for (top = data + size; nl < XDL_GUESS_NLINES;) {
+		for (top = data + size; nl < sample;) {
 			if (cur >= top) {
 				tsize += (long) (cur - data);
 				if (!(cur = data = xdl_mmfile_next(mf, &size)))
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index 674a657..714719a 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -33,7 +33,7 @@ void xdl_cha_free(chastore_t *cha);
 void *xdl_cha_alloc(chastore_t *cha);
 void *xdl_cha_first(chastore_t *cha);
 void *xdl_cha_next(chastore_t *cha);
-long xdl_guess_lines(mmfile_t *mf);
+long xdl_guess_lines(mmfile_t *mf, long sample);
 int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags);
 unsigned long xdl_hash_record(char const **data, char const *top, long flags);
 unsigned int xdl_hashbits(unsigned int size);
-- 
1.7.3.4.681.gb718e
