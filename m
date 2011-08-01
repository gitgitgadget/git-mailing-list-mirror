From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 8/8] xdiff/xprepare: use a smaller sample size for histogram diff
Date: Mon,  1 Aug 2011 11:16:48 +0800
Message-ID: <1312168608-10828-9-git-send-email-rctay89@gmail.com>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
 <1312168608-10828-1-git-send-email-rctay89@gmail.com>
 <1312168608-10828-2-git-send-email-rctay89@gmail.com>
 <1312168608-10828-3-git-send-email-rctay89@gmail.com>
 <1312168608-10828-4-git-send-email-rctay89@gmail.com>
 <1312168608-10828-5-git-send-email-rctay89@gmail.com>
 <1312168608-10828-6-git-send-email-rctay89@gmail.com>
 <1312168608-10828-7-git-send-email-rctay89@gmail.com>
 <1312168608-10828-8-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 05:17:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnj0p-0003Av-6G
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 05:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab1HADRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 23:17:47 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57478 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab1HADRp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 23:17:45 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so6396293iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 20:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pDdnz6QugOsdunlEKXUlW3yqnN+XpFLwDFSpfvPLSPg=;
        b=PuSuUsi2gSFh4gpP6ttgbq7BU3+ngmj+/2ZNMYteuVZTZNhL4UvwLcrYvRgpTQ4aI4
         9Cq/oGDvXE7jtF/swpBDN3f5zrNWBxiY2s6OWoFj3vMjYlWn6j39PQbsVsM5jCQGjnCR
         KbGYJKcNwNbJrdVql/yFXP9SyJI50HBYluOws=
Received: by 10.231.114.29 with SMTP id c29mr1233530ibq.16.1312168665705;
        Sun, 31 Jul 2011 20:17:45 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id t2sm485887ibc.12.2011.07.31.20.17.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 20:17:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1312168608-10828-8-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178303>

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
index c139ba8..b4d8402 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -26,6 +26,8 @@
 #define XDL_KPDIS_RUN 4
 #define XDL_MAX_EQLIMIT 1024
 #define XDL_SIMSCAN_WINDOW 100
+#define XDL_GUESS_NLINES1 256
+#define XDL_GUESS_NLINES2 20
 
 
 typedef struct s_xdlclass {
@@ -234,11 +236,20 @@ static void xdl_free_ctx(xdfile_t *xdf) {
 
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
index 890cc4f..0de084e 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -24,10 +24,6 @@
 
 
 
-#define XDL_GUESS_NLINES 256
-
-
-
 
 long xdl_bogosqrt(long n) {
 	long i;
@@ -153,12 +149,12 @@ void *xdl_cha_next(chastore_t *cha) {
 }
 
 
-long xdl_guess_lines(mmfile_t *mf) {
+long xdl_guess_lines(mmfile_t *mf, long sample) {
 	long nl = 0, size, tsize = 0;
 	char const *data, *cur, *top;
 
 	if ((cur = data = xdl_mmfile_first(mf, &size)) != NULL) {
-		for (top = data + size; nl < XDL_GUESS_NLINES && cur < top; ) {
+		for (top = data + size; nl < sample && cur < top; ) {
 			nl++;
 			if (!(cur = memchr(cur, '\n', top - cur)))
 				cur = top;
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
1.7.3.4.730.g67af1.dirty
