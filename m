Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4894211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfAKWRY (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:17:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:34234 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725767AbfAKWRY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:17:24 -0500
Received: (qmail 15841 invoked by uid 109); 11 Jan 2019 22:17:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Jan 2019 22:17:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13487 invoked by uid 111); 11 Jan 2019 22:17:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 Jan 2019 17:17:24 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2019 17:17:22 -0500
Date:   Fri, 11 Jan 2019 17:17:22 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] builtin_diff(): read $GIT_DIFF_OPTS closer to use
Message-ID: <20190111221722.GF10188@sigill.intra.peff.net>
References: <20190111221414.GA31335@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111221414.GA31335@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The value returned by getenv() is not guaranteed to remain valid across
other environment function calls. But in between our call and using the
value, we run fill_textconv(), which may do quite a bit of work,
including spawning sub-processes.

We can make this safer by calling getenv() right before we actually look
at its value.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 15556c190d..6751ec29f0 100644
--- a/diff.c
+++ b/diff.c
@@ -3476,7 +3476,7 @@ static void builtin_diff(const char *name_a,
 		o->found_changes = 1;
 	} else {
 		/* Crazy xdl interfaces.. */
-		const char *diffopts = getenv("GIT_DIFF_OPTS");
+		const char *diffopts;
 		const char *v;
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
@@ -3519,12 +3519,15 @@ static void builtin_diff(const char *name_a,
 			xecfg.flags |= XDL_EMIT_FUNCCONTEXT;
 		if (pe)
 			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
+
+		diffopts = getenv("GIT_DIFF_OPTS");
 		if (!diffopts)
 			;
 		else if (skip_prefix(diffopts, "--unified=", &v))
 			xecfg.ctxlen = strtoul(v, NULL, 10);
 		else if (skip_prefix(diffopts, "-u", &v))
 			xecfg.ctxlen = strtoul(v, NULL, 10);
+
 		if (o->word_diff)
 			init_diff_words_data(&ecbdata, o, one, two);
 		if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
-- 
2.20.1.651.g2d41a78c67
