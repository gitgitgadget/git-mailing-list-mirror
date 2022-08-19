Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B71C25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 08:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347507AbiHSIto (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 04:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347702AbiHSItn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 04:49:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EEBB602C
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 01:49:42 -0700 (PDT)
Received: (qmail 17528 invoked by uid 109); 19 Aug 2022 08:49:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 08:49:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 380 invoked by uid 111); 19 Aug 2022 08:49:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 04:49:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 04:49:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/6] xdiff: drop unused mmfile parameters from
 xdl_do_histogram_diff()
Message-ID: <Yv9OpXIQ9dYMQJ4B@coredump.intra.peff.net>
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are no longer used since 9df0fc3d57 (xdiff: fix a memory leak,
2022-02-16), as the caller is expected to call xdl_prepare_env() itself.
After that change the histogram code only examines the prepared
xdfenv_t, not the original buffers.

Signed-off-by: Jeff King <peff@peff.net>
---
 xdiff/xdiffi.c     | 2 +-
 xdiff/xdiffi.h     | 3 +--
 xdiff/xhistogram.c | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 53e803e6bc..8c64519eac 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -326,7 +326,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	}
 
 	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF) {
-		res = xdl_do_histogram_diff(mf1, mf2, xpp, xe);
+		res = xdl_do_histogram_diff(xpp, xe);
 		goto out;
 	}
 
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index 8f1c7c8b04..9d988e0263 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -58,7 +58,6 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg);
 int xdl_do_patience_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		xdfenv_t *env);
-int xdl_do_histogram_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
-		xdfenv_t *env);
+int xdl_do_histogram_diff(xpparam_t const *xpp, xdfenv_t *env);
 
 #endif /* #if !defined(XDIFFI_H) */
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index df909004c1..16a8fe2f3f 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -362,8 +362,7 @@ static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
 	return result;
 }
 
-int xdl_do_histogram_diff(mmfile_t *file1, mmfile_t *file2,
-	xpparam_t const *xpp, xdfenv_t *env)
+int xdl_do_histogram_diff(xpparam_t const *xpp, xdfenv_t *env)
 {
 	return histogram_diff(xpp, env,
 		env->xdf1.dstart + 1, env->xdf1.dend - env->xdf1.dstart + 1,
-- 
2.37.2.928.g0821088f4a

