From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/4] xdiff: do away with xdl_mmfile_next()
Date: Mon,  1 Aug 2011 12:20:07 +0800
Message-ID: <1312172410-4380-2-git-send-email-rctay89@gmail.com>
References: <1312168608-10828-1-git-send-email-rctay89@gmail.com>
 <1312172410-4380-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 06:20:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnjzU-0002go-Kf
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 06:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab1HAEU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 00:20:26 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37546 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab1HAEUW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 00:20:22 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so6447661iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 21:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=r15oqhBxqOFribTeVSNe6uap2PIEWTYpdQwSUBbWjtQ=;
        b=cjG8khp7TDhN9LZHi8J4nlApi9uAfpiknxMFUsk0WbVgeoGLX3hH5G5xSjt/cv9EyX
         Rz66gv/89qqNUunzsH8UXTxaO6hWJPwsPg2YylHyTvo+M8HxRf/1AUrI5bUGMnYY6leN
         L/lED5kz9T1Fgk3wL3cRH0Z9aeZV5lwTsQycw=
Received: by 10.231.8.21 with SMTP id f21mr2713572ibf.100.1312172422386;
        Sun, 31 Jul 2011 21:20:22 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id 3sm3102352ibm.61.2011.07.31.21.20.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 21:20:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1312172410-4380-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178311>

Given our simple mmfile structure, xdl_mmfile_next() calls are
redundant. Do away with calls to them.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 xdiff/xdiff.h    |    1 -
 xdiff/xprepare.c |    7 +------
 xdiff/xutils.c   |   14 +-------------
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index c26170c..4beb10c 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -106,7 +106,6 @@ typedef struct s_bdiffparam {
 #define xdl_realloc(ptr,x) realloc(ptr,x)
 
 void *xdl_mmfile_first(mmfile_t *mmf, long *size);
-void *xdl_mmfile_next(mmfile_t *mmf, long *size);
 long xdl_mmfile_size(mmfile_t *mmf);
 
 int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index dfbb0de..620fc9a 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -168,12 +168,7 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 
 	nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize)) != NULL) {
-		for (top = blk + bsize;;) {
-			if (cur >= top) {
-				if (!(cur = blk = xdl_mmfile_next(mf, &bsize)))
-					break;
-				top = blk + bsize;
-			}
+		for (top = blk + bsize; cur < top; ) {
 			prev = cur;
 			hav = xdl_hash_record(&cur, top, xpp->flags);
 			if (nrec >= narec) {
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index a45e89b..0de084e 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -67,12 +67,6 @@ void *xdl_mmfile_first(mmfile_t *mmf, long *size)
 }
 
 
-void *xdl_mmfile_next(mmfile_t *mmf, long *size)
-{
-	return NULL;
-}
-
-
 long xdl_mmfile_size(mmfile_t *mmf)
 {
 	return mmf->size;
@@ -160,13 +154,7 @@ long xdl_guess_lines(mmfile_t *mf, long sample) {
 	char const *data, *cur, *top;
 
 	if ((cur = data = xdl_mmfile_first(mf, &size)) != NULL) {
-		for (top = data + size; nl < sample;) {
-			if (cur >= top) {
-				tsize += (long) (cur - data);
-				if (!(cur = data = xdl_mmfile_next(mf, &size)))
-					break;
-				top = data + size;
-			}
+		for (top = data + size; nl < sample && cur < top; ) {
 			nl++;
 			if (!(cur = memchr(cur, '\n', top - cur)))
 				cur = top;
-- 
1.7.3.4.730.g67af1.dirty
