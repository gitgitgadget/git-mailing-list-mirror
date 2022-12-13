Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D06C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 11:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbiLMLPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 06:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbiLMLOm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 06:14:42 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600AB1FFA0
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 03:13:10 -0800 (PST)
Received: (qmail 14485 invoked by uid 109); 13 Dec 2022 11:13:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Dec 2022 11:13:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4309 invoked by uid 111); 13 Dec 2022 11:13:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Dec 2022 06:13:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Dec 2022 06:13:08 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/9] xdiff: drop unused parameter in def_ff()
Message-ID: <Y5heRPpGYD1v5Z7X@coredump.intra.peff.net>
References: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The def_ff() function is the default "find_func" for finding hunk
headers. It has never used its "priv" argument since it was introduced
in f258475a6e (Per-path attribute based hunk header selection.,
2007-07-06). But back then we used a function pointer to switch between
a caller-provided function and the default, so the two had to conform to
the same interface.

In ff2981f724 (xdiff: factor out match_func_rec(), 2016-05-28), that
pointer indirection went away in favor of code which directly calls
either of the two functions. So there's no need for def_ff() to retain
this unused parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 xdiff/xemit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index c4ccd68d47..75f0fe4986 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -95,7 +95,7 @@ xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg)
 }
 
 
-static long def_ff(const char *rec, long len, char *buf, long sz, void *priv)
+static long def_ff(const char *rec, long len, char *buf, long sz)
 {
 	if (len > 0 &&
 			(isalpha((unsigned char)*rec) || /* identifier? */
@@ -117,7 +117,7 @@ static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 	const char *rec;
 	long len = xdl_get_rec(xdf, ri, &rec);
 	if (!xecfg->find_func)
-		return def_ff(rec, len, buf, sz, xecfg->find_func_priv);
+		return def_ff(rec, len, buf, sz);
 	return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
 }
 
-- 
2.39.0.546.g5ea984bc66

