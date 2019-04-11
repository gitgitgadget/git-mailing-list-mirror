Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE84720248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfDKNt1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:49:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:54922 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726630AbfDKNt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:49:27 -0400
Received: (qmail 7158 invoked by uid 109); 11 Apr 2019 13:49:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Apr 2019 13:49:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27924 invoked by uid 111); 11 Apr 2019 13:49:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Apr 2019 09:49:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2019 09:49:25 -0400
Date:   Thu, 11 Apr 2019 09:49:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?546L5YGl5by6?= <jianqiang.wang@securitygossip.com>
Subject: [PATCH 3/4] xdiff: use xmalloc/xrealloc
Message-ID: <20190411134925.GC9182@sigill.intra.peff.net>
References: <20190411134736.GA28543@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411134736.GA28543@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of xdiff uses a bare malloc() to allocate memory, and returns an
error when we get NULL. However, there are a few spots which don't check
the return value and may segfault, including at least xdl_merge() and
xpatience.c's find_longest_common_sequence().

Let's use xmalloc() everywhere instead, so that we get a graceful die()
for these cases, without having to do further auditing. This does mean
the existing cases which check errors will now die() instead of
returning an error up the stack. But:

  - that's how the rest of Git behaves already for malloc errors

  - all of the callers of xdi_diff(), etc, die upon seeing an error

So while we might one day want to fully lib-ify the diff code and make
it possible to use as part of a long-running process, we're not close to
that now. And because we're just tweaking the xdl_malloc() macro here,
we're not really moving ourselves any further away from that. We
could, for example, simplify some of the functions which handle malloc()
errors which can no longer occur. But that would probably be taking us
in the wrong direction.

This also makes our malloc handling more consistent with the rest of
Git, including enforcing GIT_ALLOC_LIMIT and trying to reclaim pack
memory when needed.

Reported-by: 王健强 <jianqiang.wang@securitygossip.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 xdiff/xdiff.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index b158369020..032e3a9f41 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -113,9 +113,9 @@ typedef struct s_bdiffparam {
 } bdiffparam_t;
 
 
-#define xdl_malloc(x) malloc(x)
+#define xdl_malloc(x) xmalloc(x)
 #define xdl_free(ptr) free(ptr)
-#define xdl_realloc(ptr,x) realloc(ptr,x)
+#define xdl_realloc(ptr,x) xrealloc(ptr,x)
 
 void *xdl_mmfile_first(mmfile_t *mmf, long *size);
 long xdl_mmfile_size(mmfile_t *mmf);
-- 
2.21.0.922.g1a559e573c

