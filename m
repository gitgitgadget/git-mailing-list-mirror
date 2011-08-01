From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 2/8] do away with xdl_mmfile_next()
Date: Mon,  1 Aug 2011 11:16:42 +0800
Message-ID: <1312168608-10828-3-git-send-email-rctay89@gmail.com>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
 <1312168608-10828-1-git-send-email-rctay89@gmail.com>
 <1312168608-10828-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 05:17:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnj0H-0002z9-QG
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 05:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab1HADRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 23:17:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57478 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab1HADRH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 23:17:07 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so6396293iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 20:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jDdTFzaMkaB9ape4fccBkB74OJK1UYv0DwrrNgP8lW0=;
        b=Di+QP1IksBHTRTzEXoosZsuUlAo5jhZdXnDyCC6TaNJDxrxburzMbgvQgtp/PPvGGD
         mGQJMxLKLNMiFAQ8nwSIFfE7PxPaoPUXEVQCt4p+EUJ1nmSiRXgYe0eZ9zs4i9R5BviW
         HZognKUUmiDSGI4rGTGSwrzs+PcyjeuNb8Fdk=
Received: by 10.231.123.10 with SMTP id n10mr679906ibr.182.1312168627471;
        Sun, 31 Jul 2011 20:17:07 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id v16sm3074915ibe.17.2011.07.31.20.17.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 20:17:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1312168608-10828-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178297>

Given our simple mmfile structure, xdl_mmfile_next() calls are
redundant. Do away with calls to them.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

New in v2.

 xdiff/xdiff.h    |    1 -
 xdiff/xprepare.c |    7 +------
 xdiff/xutils.c   |   14 +-------------
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 711048e..6ea1d0e 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -105,7 +105,6 @@ typedef struct s_bdiffparam {
 #define xdl_realloc(ptr,x) realloc(ptr,x)
 
 void *xdl_mmfile_first(mmfile_t *mmf, long *size);
-void *xdl_mmfile_next(mmfile_t *mmf, long *size);
 long xdl_mmfile_size(mmfile_t *mmf);
 
 int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 783631a..49c7e8a 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -165,12 +165,7 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 
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
index ab65034..ea1357d 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -71,12 +71,6 @@ void *xdl_mmfile_first(mmfile_t *mmf, long *size)
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
@@ -164,13 +158,7 @@ long xdl_guess_lines(mmfile_t *mf) {
 	char const *data, *cur, *top;
 
 	if ((cur = data = xdl_mmfile_first(mf, &size)) != NULL) {
-		for (top = data + size; nl < XDL_GUESS_NLINES;) {
-			if (cur >= top) {
-				tsize += (long) (cur - data);
-				if (!(cur = data = xdl_mmfile_next(mf, &size)))
-					break;
-				top = data + size;
-			}
+		for (top = data + size; nl < XDL_GUESS_NLINES && cur < top; ) {
 			nl++;
 			if (!(cur = memchr(cur, '\n', top - cur)))
 				cur = top;
-- 
1.7.3.4.730.g67af1.dirty
