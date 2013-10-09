From: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
Subject: [PATCH] diffcore-delta: optimize renames and copies detection (git  diff -M/-C)
Date: Wed, 9 Oct 2013 13:27:23 +0300
Message-ID: <50C898B5-8B7A-420B-AB35-7D7776DD9920@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 09 12:27:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTqzL-0001Ch-VR
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 12:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839Ab3JIK12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 06:27:28 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:54489 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab3JIK11 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 06:27:27 -0400
Received: by mail-lb0-f177.google.com with SMTP id w7so576945lbi.36
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=3dUJf58+8v0qUbtBHh3D4uFw2kGkN74kqi4xEcn9q7U=;
        b=TFv1bDqf3YmysiUcQFADHV/e03tG8uibOnz9vTSInhwgW0IOzIs37UZDWxZQsDhDWZ
         SlsQBfrbQ/nGtmc6K0RANabDNAsCkSwGx61BatEGio/+bzHBRbVEGj5fiXgXWk7ME4PA
         NQ/snqZh81I//hU1vtpvO8R2B5Nz21CBZiam4+a8Wm0+QDjl4zOSd1r1LUs3XW1MbfbK
         f+bRowu0p/FDHmfxC/y/CJGCrUuXmQr++cEcCkeS5RUEfYzbcYcctsdYK9J2N1jtIHKr
         9YtZ/wF2LmCBLjFUw/cDTDOuFH63VoZheoyzuiioALAE5gVbARfURRcZFNijMseJeRI9
         IbDg==
X-Received: by 10.112.168.3 with SMTP id zs3mr6821956lbb.2.1381314446230;
        Wed, 09 Oct 2013 03:27:26 -0700 (PDT)
Received: from [10.128.134.109] (fsgw.f-secure.com. [193.110.108.33])
        by mx.google.com with ESMTPSA id kx1sm34570410lac.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 03:27:25 -0700 (PDT)
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235804>

diffcore_count_changes() can return -1 when src_copied is greater than
delta_limit, without counting all the src_copied.
By that, performance of "diff -M/-C" can be improved.

Signed-off-by: Tsuneo Yoshioka <yoshiokatsuneo@gmail.com>
---
 diffcore-delta.c  | 11 ++++++++---
 diffcore-rename.c |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index 7cf431d..0a9290e 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -173,7 +173,7 @@ int diffcore_count_changes(struct diff_filespec *src,
 {
 	struct spanhash *s, *d;
 	struct spanhash_top *src_count, *dst_count;
-	unsigned long sc, la;
+	unsigned long sc, not_sc, la;
 
 	src_count = dst_count = NULL;
 	if (src_count_p)
@@ -190,7 +190,7 @@ int diffcore_count_changes(struct diff_filespec *src,
 		if (dst_count_p)
 			*dst_count_p = dst_count;
 	}
-	sc = la = 0;
+	sc = not_sc = la = 0;
 
 	s = src_count->data;
 	d = dst_count->data;
@@ -214,8 +214,13 @@ int diffcore_count_changes(struct diff_filespec *src,
 			la += dst_cnt - src_cnt;
 			sc += src_cnt;
 		}
-		else
+		else{
 			sc += dst_cnt;
+			not_sc += (src_cnt - dst_cnt);
+			if(delta_limit != 0 && not_sc > delta_limit){
+				return -1;
+			}
+		}
 		s++;
 	}
 	while (d->cnt) {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6c7a72f..d52b2c8 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -181,7 +181,7 @@ static int estimate_similarity(struct diff_filespec *src,
 		return 0;
 
 	delta_limit = (unsigned long)
-		(base_size * (MAX_SCORE-minimum_score) / MAX_SCORE);
+		(max_size * (MAX_SCORE-minimum_score) / MAX_SCORE);
 	if (diffcore_count_changes(src, dst,
 				   &src->cnt_data, &dst->cnt_data,
 				   delta_limit,
-- 
1.7.12.4 (Apple Git-37)
