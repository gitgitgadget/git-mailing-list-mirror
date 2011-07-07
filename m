From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 3/4] xdiff/xpatience: factor out fall-back-diff function
Date: Thu,  7 Jul 2011 12:23:57 +0800
Message-ID: <1310012638-3668-4-git-send-email-rctay89@gmail.com>
References: <1309970337-6016-1-git-send-email-rctay89@gmail.com>
 <1310012638-3668-1-git-send-email-rctay89@gmail.com>
 <1310012638-3668-2-git-send-email-rctay89@gmail.com>
 <1310012638-3668-3-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 07 06:24:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qeg8g-0008Kl-KD
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 06:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823Ab1GGEYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 00:24:31 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52104 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab1GGEYa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 00:24:30 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so535294iyb.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 21:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zoaBhjNc58lTkr3GEmYGAJkzMh2l7td4gSEOU+SCQpc=;
        b=ajd5sJceFCxFz/BGkQWujgN6wMPviSSE0oD6QzrV7O3ZmJ3s+4PaxNekt+gtBjtaIu
         kLnKClH12j85hxAtmaQjFMzmrOEMEQOal+AlLUWcLUWiEM+678y3SB9eyOIH07CXwh0d
         yc6TIONxDduf3l48Wzkq4+gZI3AVcZYrYOsPA=
Received: by 10.42.166.131 with SMTP id o3mr383251icy.98.1310012669906;
        Wed, 06 Jul 2011 21:24:29 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id e23sm5246660ibe.57.2011.07.06.21.24.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 21:24:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1310012638-3668-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176744>

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
 
-	memcpy(map->env->xdf1.rchg + line1 - 1, env.xdf1.rchg, count1);
-	memcpy(map->env->xdf2.rchg + line2 - 1, env.xdf2.rchg, count2);
-
-	xdl_free_env(&env);
-
-	return 0;
+	return xdl_fall_back_diff(map->env, &xpp,
+				  line1, count1, line2, count2);
 }
 
 /*
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index ab65034..ded7c32 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -402,3 +402,34 @@ int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
 
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
1.7.3.4.676.gf08cd.dirty
