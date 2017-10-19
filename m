Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300B6202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 17:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753867AbdJSRqZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 13:46:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:57806 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753855AbdJSRqX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 13:46:23 -0400
Received: (qmail 28958 invoked by uid 109); 19 Oct 2017 17:46:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 17:46:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10080 invoked by uid 111); 19 Oct 2017 17:46:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 13:46:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 13:46:21 -0400
Date:   Thu, 19 Oct 2017 13:46:21 -0400
From:   Jeff King <peff@peff.net>
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com,
        l.s.r@web.de, avarab@gmail.com, krh@redhat.com, rctay89@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Subject: [PATCH 1/4] test-ref-store: avoid passing NULL to printf
Message-ID: <20171019174620.4ajc3yxogzdcqksj@sigill.intra.peff.net>
References: <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible for resolve_ref_unsafe() to return NULL (e.g.,
if we are reading and the ref does not exist), in which case
we'll pass NULL to printf. On glibc systems this produces
"(null)", but on others it may segfault.

The tests don't expect any such case, but if we ever did
trigger this, we would prefer to cleanly fail the test with
unexpected input rather than segfault. Let's manually
replace NULL with "(null)". The exact value doesn't matter,
as it won't match any possible ref the caller could expect
(and anyway, the exit code of the program will tell whether
"ref" is valid or not).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-ref-store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 05d8c4d8af..6ec2670044 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -135,7 +135,7 @@ static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 
 	ref = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
 				      sha1, &flags);
-	printf("%s %s 0x%x\n", sha1_to_hex(sha1), ref, flags);
+	printf("%s %s 0x%x\n", sha1_to_hex(sha1), ref ? ref : "(null)", flags);
 	return ref ? 0 : 1;
 }
 
-- 
2.15.0.rc1.560.g5f0609e481

