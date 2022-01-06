Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20867C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 22:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245208AbiAFWmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245189AbiAFWmW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 17:42:22 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11756C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 14:42:22 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 202so4158649qkg.13
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 14:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5FB9y+ypTjyQ9ZFI+uo24PWFFuDpX/he4vbmdVUajaM=;
        b=EN4nxaVz1dHVZTpTcnSrA+Pe2tQODblq2gHjpEgiA3/LXcVVLaDOtyf2gzhqrqvcCM
         tc1J9mZzrHnTZsOJvYBddTPs2KBchQWnGd7Bj2KWy+6nwDvhMJLy+PCURDn6OkiuCs5/
         mxMfF4KNCE7BG2EkVY2Hb4dVA50J/7VOrs0fIPYeeaQvc7/I0PRlHP5qZTR5OgECUGCy
         ClfsEjphAxsXI3XP0yxskxli4nIq/cjkgS8FOTiK+EWucg5mAFEKRQb1zOd1eZuE2GFK
         QeC4Eem4sT9GWXqiB7C6vBa+ziUITszKzHrL16QXUj97kB5mNVQX46fWVk3y8UaKj3GJ
         4Q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5FB9y+ypTjyQ9ZFI+uo24PWFFuDpX/he4vbmdVUajaM=;
        b=3IE4XJ54ONvhoda5E7R+pHSy+i5bybFVlbsz7GV2xLfljAaMNhs2a1ZCRW8QS9wayE
         2ki6KWQvC7FKKrK0ya/Mk84qv4Ra+NcM1M8LJZpFw04UanB5tOMr2OOkCn3RiaSfzG6L
         kuDOREEn4KJ51648iU+Z2c6vWv7ceDkPNAXjURImhhuLPekYF1SevgvV86+tJvQ6Q2Lp
         iiiNNY9kb3laQrCuR+pOFvJioFAPBzBzEuwWYYeD1Jt0j7xrwJPSdx/CVczc9kUMoAI+
         F+PWKcjIhxsmPaG+A4UnOsqk2q8kcj5tt/4wrJT02KBDsgApnfj4Fum3ScccLQ7ExEnQ
         QmFA==
X-Gm-Message-State: AOAM530uWSV+iewKC4WMf4VfV/Ov2/J/NlSSAJvPhwa+Fk1quG7lJqPh
        a1jZiUmJKFCPjEt8kU2kyIfojtPWOoBTHQ==
X-Google-Smtp-Source: ABdhPJx1O270u1kta33ZSLOmuSyrFr+dhuO2eELW3ZgPqdfayyqNUSnmi2c/xkh7n+MKXcXAKwjNRA==
X-Received: by 2002:a05:620a:f0b:: with SMTP id v11mr42224897qkl.243.1641508941117;
        Thu, 06 Jan 2022 14:42:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8sm2567045qtz.28.2022.01.06.14.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 14:42:20 -0800 (PST)
Date:   Thu, 6 Jan 2022 17:42:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     l.s.r@web.de, gitster@pobox.com
Subject: [PATCH v2 1/2] grep: extract grep_binexp() from grep_or_expr()
Message-ID: <dae476d1bd14608358b6c103e2b5dda76d294687.1641508884.git.me@ttaylorr.com>
References: <cover.1641498525.git.me@ttaylorr.com>
 <cover.1641508884.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1641508884.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When constructing an OR node, the grep.c code uses `grep_or_expr()` to
make a node, assign its kind, and set its left and right children. The
same is not done for AND nodes.

Prepare to introduce a new `grep_and_expr()` function which will share
code with the existing implementation of `grep_or_expr()` by introducing
a new function which compiles either kind of binary expression, and
reimplement `grep_or_expr()` in terms of it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index bdbd06d437..d772fe6cc5 100644
--- a/grep.c
+++ b/grep.c
@@ -603,15 +603,22 @@ static struct grep_expr *grep_not_expr(struct grep_expr *expr)
 	return z;
 }
 
-static struct grep_expr *grep_or_expr(struct grep_expr *left, struct grep_expr *right)
+static struct grep_expr *grep_binexp(enum grep_expr_node kind,
+				     struct grep_expr *left,
+				     struct grep_expr *right)
 {
 	struct grep_expr *z = xcalloc(1, sizeof(*z));
-	z->node = GREP_NODE_OR;
+	z->node = kind;
 	z->u.binary.left = left;
 	z->u.binary.right = right;
 	return z;
 }
 
+static struct grep_expr *grep_or_expr(struct grep_expr *left, struct grep_expr *right)
+{
+	return grep_binexp(GREP_NODE_OR, left, right);
+}
+
 static struct grep_expr *compile_pattern_or(struct grep_pat **);
 static struct grep_expr *compile_pattern_atom(struct grep_pat **list)
 {
-- 
2.34.1.455.gd6eb6fd089

