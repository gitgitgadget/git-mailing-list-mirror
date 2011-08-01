From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 4/8] xdiff/xpatience: factor out fall-back-diff function
Date: Mon,  1 Aug 2011 11:16:44 +0800
Message-ID: <1312168608-10828-5-git-send-email-rctay89@gmail.com>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
 <1312168608-10828-1-git-send-email-rctay89@gmail.com>
 <1312168608-10828-2-git-send-email-rctay89@gmail.com>
 <1312168608-10828-3-git-send-email-rctay89@gmail.com>
 <1312168608-10828-4-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 05:17:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnj0S-00032i-LA
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 05:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab1HADRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 23:17:22 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57478 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab1HADRU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 23:17:20 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so6396293iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 20:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PGiKBwczPP6HcnoPHWh6avXuV3g+4FklHVU69AaKG+w=;
        b=BSABweoJmnowiMI5eVOWKQjalzgxp/tPyP1ylVOZGZ4fLa5KxcwurbZfWu8KLtfe8J
         ZNRPjVfAYQq4HyqqD0/Tj4aaAqnnUtAPdCM1bhM+9FRTlCXVstV5g2wIfxSUgNz8TxUr
         ByNRGSQPi7EpWbdGBkD1d2m2diE/ON3X3hAE4=
Received: by 10.231.47.136 with SMTP id n8mr2678942ibf.19.1312168640251;
        Sun, 31 Jul 2011 20:17:20 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id b6sm3074751ibg.14.2011.07.31.20.17.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 20:17:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1312168608-10828-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178298>

This is in preparation for the histogram diff algorithm, which will also
re-use much of the code to call the default Meyers diff algorithm.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 xdiff/xpatience.c |   27 ++-------------------------
 xdiff/xutils.c    |   31 +++++++++++++++++++++++++++++++
 xdiff/xutils.h    |    2 ++
 3 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index e42c16a..fdd7d02 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -287,34 +287,11 @@ static int walk_common_sequence(struct hashmap *map, struct entry *first,
 static int fall_back_to_classic_diff(struct hashmap *map,
 		int line1, int count1, int line2, int count2)
 {
-	/*
-	 * This probably does not work outside Git, since
-	 * we have a very simple mmfile structure.
-	 *
-	 * Note: ideally, we would reuse the prepared environment, but
-	 * the libxdiff interface does not (yet) allow for diffing only
-	 * ranges of lines instead of the whole files.
-	 */
-	mmfile_t subfile1, subfile2;
 	xpparam_t xpp;
-	xdfenv_t env;
-
-	subfile1.ptr = (char *)map->env->xdf1.recs[line1 - 1]->ptr;
-	subfile1.size = map->env->xdf1.recs[line1 + count1 - 2]->ptr +
-		map->env->xdf1.recs[line1 + count1 - 2]->size - subfile1.ptr;
-	subfile2.ptr = (char *)map->env->xdf2.recs[line2 - 1]->ptr;
-	subfile2.size = map->env->xdf2.recs[line2 + count2 - 2]->ptr +
-		map->env->xdf2.recs[line2 + count2 - 2]->size - subfile2.ptr;
 	xpp.flags = map->xpp->flags & ~XDF_PATIENCE_DIFF;
-	if (xdl_do_diff(&subfile1, &subfile2, &xpp, &env) < 0)
-		return -1;
-
-	memcpy(map->env->xdf1.rchg + line1 - 1, env.xdf1.rchg, count1);
-	memcpy(map->env->xdf2.rchg + line2 - 1, env.xdf2.rchg, count2);
-
-	xdl_free_env(&env);
 
-	return 0;
+	return xdl_fall_back_diff(map->env, &xpp,
+				  line1, count1, line2, count2);
 }
 
 /*
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index ea1357d..890cc4f 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -390,3 +390,34 @@ int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
 
 	return 0;
 }
+
+int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
+		int line1, int count1, int line2, int count2)
+{
+	/*
+	 * This probably does not work outside Git, since
+	 * we have a very simple mmfile structure.
+	 *
+	 * Note: ideally, we would reuse the prepared environment, but
+	 * the libxdiff interface does not (yet) allow for diffing only
+	 * ranges of lines instead of the whole files.
+	 */
+	mmfile_t subfile1, subfile2;
+	xdfenv_t env;
+
+	subfile1.ptr = (char *)diff_env->xdf1.recs[line1 - 1]->ptr;
+	subfile1.size = diff_env->xdf1.recs[line1 + count1 - 2]->ptr +
+		diff_env->xdf1.recs[line1 + count1 - 2]->size - subfile1.ptr;
+	subfile2.ptr = (char *)diff_env->xdf2.recs[line2 - 1]->ptr;
+	subfile2.size = diff_env->xdf2.recs[line2 + count2 - 2]->ptr +
+		diff_env->xdf2.recs[line2 + count2 - 2]->size - subfile2.ptr;
+	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
+		return -1;
+
+	memcpy(diff_env->xdf1.rchg + line1 - 1, env.xdf1.rchg, count1);
+	memcpy(diff_env->xdf2.rchg + line2 - 1, env.xdf2.rchg, count2);
+
+	xdl_free_env(&env);
+
+	return 0;
+}
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index d5de829..674a657 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -41,6 +41,8 @@ int xdl_num_out(char *out, long val);
 long xdl_atol(char const *str, char const **next);
 int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
 		      const char *func, long funclen, xdemitcb_t *ecb);
+int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
+		       int line1, int count1, int line2, int count2);
 
 
 
-- 
1.7.3.4.730.g67af1.dirty
