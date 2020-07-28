Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F72C433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A2492065E
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgG1UVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:21:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:40190 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgG1UVx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:21:53 -0400
Received: (qmail 29703 invoked by uid 109); 28 Jul 2020 20:21:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 20:21:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28472 invoked by uid 111); 28 Jul 2020 20:21:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 16:21:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 16:21:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/11] argv-array: use size_t for count and alloc
Message-ID: <20200728202152.GA1021513@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728202124.GA1021264@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On most 64-bit platforms, "int" is significantly smaller than a size_t,
which could lead to integer overflow and under-allocation of the array.
It's probably impossible to trigger in practice, as it would imply on
the order of 2^32 individual allocations. Even if was possible to grow
an array in that way (and we typically only use it for sets of strings,
like command line options), each allocation needs a pointer, malloc
overhead, etc. You'd quite likely run out of RAM before succeeding in
such an overflow.

But all that hand-waving aside, it's easy enough to use the correct
type, so let's do so.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is obviously of value even without the renaming.

 argv-array.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/argv-array.h b/argv-array.h
index a7d3b10707..4fc57b6902 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -29,8 +29,8 @@ extern const char *empty_argv[];
  */
 struct argv_array {
 	const char **argv;
-	int argc;
-	int alloc;
+	size_t argc;
+	size_t alloc;
 };
 
 #define ARGV_ARRAY_INIT { empty_argv, 0, 0 }
-- 
2.28.0.rc2.475.g53c7e1c7f4

