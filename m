From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 3/4] xdiff/xhistogram: rely on xdl_trim_ends()
Date: Mon,  1 Aug 2011 12:20:09 +0800
Message-ID: <1312172410-4380-4-git-send-email-rctay89@gmail.com>
References: <1312168608-10828-1-git-send-email-rctay89@gmail.com>
 <1312172410-4380-1-git-send-email-rctay89@gmail.com>
 <1312172410-4380-2-git-send-email-rctay89@gmail.com>
 <1312172410-4380-3-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 06:20:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnjze-0002kf-1l
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 06:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab1HAEUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 00:20:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37546 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982Ab1HAEUf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 00:20:35 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so6447661iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 21:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mWNPsEqNbaqd7d92paPViwWOyFe/Jv2n5GNB2uE2aXE=;
        b=ZNNEaw2ctLJTTFyG9edsWU0dd02cuDZdmuFDWu+S2/wbfN///pqgD/SXOUToMy2yLk
         8OR5d3xU5WRau9a3SOwPk35p2EGKV5KaL64ZfV4hhknf2lmL6ilQdt0PdDzfoQTjKv60
         mKCAnsrJcdll7l9rriQpSxkmL5NPkUmaM6dKg=
Received: by 10.231.181.95 with SMTP id bx31mr2658708ibb.191.1312172434046;
        Sun, 31 Jul 2011 21:20:34 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id 3sm3102456ibm.61.2011.07.31.21.20.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 21:20:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1312172410-4380-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178312>

Do away with reduce_common_start_end() and use xdf->dstart and xdf->dend
set by xdl_trim_ends() that similarly tells us where the first unmatched
line from the start and end occurs.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

On Wed, Jul 13, 2011 at 3:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>[snip]
>> +     reduce_common_start_end(xpp, env, &line1, &count1, &line2, &count2);
>
> What this does is logically not specific to histogram algorithm but can be
> applied to other backends, no? And I vaguely recall that Linus did try
> something like this once, found some issues with it when context is set to
> non zero, and stopped doing it (sorry, I do not have any more details).
>
> I am not suggesting you to remove this call or hoist the call to one level
> up to xdl_do_diff(), but I do have to wonder how much of the performance
> improvement you reported is due to this common head/tail reduction.

In a way, this patch is a response to Junio's email. It just made sense
to use existing functionality in xdiff (xdl_trim_ends() and xdf->dstart
and dend) over writing a new one (reduce_common_start_end()).

I believe Junio was referring to this patch by Linus:

  https://lkml.org/lkml/2007/12/20/692

That is an optimization on a more aggressive level - cutting out
content so that it doesn't get hashed in the first place. The
optimization used here (reduce_common_start_end()/xdl_trim_ends())
depends on the hashed result and simply reduces the "area" on which the
algorithm is applied to.

(Actually, I do have a working patch that does content trimming that is
context-length safe. But it's not specific to histogram so I'll keep it
with me till this series gets merged, lest it holds up the series.)

 xdiff/xhistogram.c |   31 ++++---------------------------
 1 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 9cb69ea..804e19b 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -102,7 +102,7 @@ static int cmp_recs(xpparam_t const *xpp,
 	(cmp_recs(xpp, REC(env, s1, l1), REC(env, s2, l2)))
 
 #define CMP(i, s1, l1, s2, l2) \
-	(CMP_ENV(i->xpp, i->env, s1, l1, s2, l2))
+	(cmp_recs(i->xpp, REC(i->env, s1, l1), REC(i->env, s2, l2)))
 
 #define TABLE_HASH(index, side, line) \
 	XDL_HASHLONG((REC(index->env, side, line))->ha, index->table_bits)
@@ -248,23 +248,6 @@ static int find_lcs(struct histindex *index, struct region *lcs,
 	return index->has_common && index->max_chain_length < index->cnt;
 }
 
-static void reduce_common_start_end(xpparam_t const *xpp, xdfenv_t *env,
-	int *line1, int *count1, int *line2, int *count2)
-{
-	if (*count1 <= 1 || *count2 <= 1)
-		return;
-	while (*count1 > 1 && *count2 > 1 && CMP_ENV(xpp, env, 1, *line1, 2, *line2)) {
-		(*line1)++;
-		(*count1)--;
-		(*line2)++;
-		(*count2)--;
-	}
-	while (*count1 > 1 && *count2 > 1 && CMP_ENV(xpp, env, 1, LINE_END_PTR(1), 2, LINE_END_PTR(2))) {
-		(*count1)--;
-		(*count2)--;
-	}
-}
-
 static int fall_back_to_classic_diff(struct histindex *index,
 		int line1, int count1, int line2, int count2)
 {
@@ -370,16 +353,10 @@ cleanup:
 int xdl_do_histogram_diff(mmfile_t *file1, mmfile_t *file2,
 	xpparam_t const *xpp, xdfenv_t *env)
 {
-	int line1, line2, count1, count2;
-
 	if (xdl_prepare_env(file1, file2, xpp, env) < 0)
 		return -1;
 
-	line1 = line2 = 1;
-	count1 = env->xdf1.nrec;
-	count2 = env->xdf2.nrec;
-
-	reduce_common_start_end(xpp, env, &line1, &count1, &line2, &count2);
-
-	return histogram_diff(xpp, env, line1, count1, line2, count2);
+	return histogram_diff(xpp, env,
+		env->xdf1.dstart + 1, env->xdf1.dend - env->xdf1.dstart + 1,
+		env->xdf2.dstart + 1, env->xdf2.dend - env->xdf2.dstart + 1);
 }
-- 
1.7.3.4.730.g67af1.dirty
