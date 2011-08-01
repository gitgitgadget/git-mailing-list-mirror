From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/4] xdiff/xhistogram: rework handling of recursed results
Date: Mon,  1 Aug 2011 12:20:08 +0800
Message-ID: <1312172410-4380-3-git-send-email-rctay89@gmail.com>
References: <1312168608-10828-1-git-send-email-rctay89@gmail.com>
 <1312172410-4380-1-git-send-email-rctay89@gmail.com>
 <1312172410-4380-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 06:20:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnjzV-0002go-5J
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 06:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818Ab1HAEUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 00:20:30 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37546 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab1HAEU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 00:20:28 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so6447661iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 21:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=l8e17EOfPLE6GRU1RqEeKtlOhf9xqsyfICOIY7W7lP8=;
        b=CztA6Z0C31XGBmBZCBRc5mAyT9ZZDs4brtKtPw8APrv37+xfL+IaLnlL6eaIQTTnmX
         2Enf1rQM08S6mkCFk+8GAhhCneVUb2OQEJRM/C1bZaEap6Ii8e7GdnF+k6QU2ZDcMxge
         Q6pQtpjOHxX7qkK9e2LaNU8WLuCdIUhPcm/+w=
Received: by 10.231.112.98 with SMTP id v34mr2757881ibp.85.1312172428048;
        Sun, 31 Jul 2011 21:20:28 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id 3sm3106562ibm.27.2011.07.31.21.20.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 21:20:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1312172410-4380-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178310>

Previously we were over-complicating matters by trying to combine the
recursed results. Now, terminate immediately if a recursive call failed
and return its result.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 xdiff/xhistogram.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 391333a..9cb69ea 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -339,21 +339,22 @@ static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
 	if (find_lcs(&index, &lcs, line1, count1, line2, count2))
 		result = fall_back_to_classic_diff(&index, line1, count1, line2, count2);
 	else {
-		result = 0;
 		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
 			int ptr;
 			for (ptr = 0; ptr < count1; ptr++)
 				env->xdf1.rchg[line1 + ptr - 1] = 1;
 			for (ptr = 0; ptr < count2; ptr++)
 				env->xdf2.rchg[line2 + ptr - 1] = 1;
+			result = 0;
 		} else {
-			result = histogram_diff(xpp, env,
+			if (result = histogram_diff(xpp, env,
 				line1, lcs.begin1 - line1,
-				line2, lcs.begin2 - line2);
-			result = histogram_diff(xpp, env,
+				line2, lcs.begin2 - line2))
+				goto cleanup;
+			if (result = histogram_diff(xpp, env,
 				lcs.end1 + 1, LINE_END(1) - lcs.end1,
-				lcs.end2 + 1, LINE_END(2) - lcs.end2);
-			result *= -1;
+				lcs.end2 + 1, LINE_END(2) - lcs.end2))
+				goto cleanup;
 		}
 	}
 
-- 
1.7.3.4.730.g67af1.dirty
