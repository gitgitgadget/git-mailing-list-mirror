Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4B51207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755402AbdEDN4x (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:56:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:64008 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755377AbdEDN4u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:56:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcmN9-1doecg3vOB-00k7JP; Thu, 04
 May 2017 15:56:42 +0200
Date:   Thu, 4 May 2017 15:56:40 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 11/25] checkout: fix memory leak
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <2704e145927c851c4163a68cfdfd5ada48fff21d.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UQp2udptHAraqWgDFRTnv+cWsiEmhqn3nMcwdEfTypA0c0aTz7t
 RJjBst7UHVwPceaCvZQhqddEU0+euX5jeJ3VzzYqB4ub8nwaYzvXENNuF7pcCaddr346js7
 gsPfNRzilwoSV/Sbn03YRdJqtjyABTQfFF8I2cP4ph5u7VwT2GZxX/4SA4HVb1ijp+JrwZY
 npfRrlpra6VsnCCfbCjAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lPuDQFGkBDo=:K8xHxOHT4TsKC4PSuY+5vE
 mSrqSGLZ2Fs9TzjmcxxsE51jjm5JL8arp+s7VxDnHIKD/azeTYoGfZAAUAUdW8SOtZi4rz8R4
 pr6N7zHhy+G4s/jvyxsPMmE2eBBrwkSRJma9vyOZ+IwhHGL6XQlOJ4oy2aDstqvQEc+LBmAKY
 mTR48RtQOCzDbgEwbmkC6qvBMbpVfv5AG0cCgk2c6CYhTL2beUfsnoJ7ij76hLChL+Rr1Hm2q
 UazgigWBq8lvEM+A6wSePRNbvkwWyCyJvH36G3I3wmtiLgzrEhQPzlu5iWTPLA6ylTMH/7Kg6
 72WTuJabsph4blxHcfHlBkkXrWkyv/m1EtNjXfFBp0LXJfTsIMDk4/SAvlUJ1G734b3Tdg3YP
 ZEeLSg0o+lQ9FeNDxNukcn0vMzNiIVqyDIgipnr5yga5qTJ/I0tIM06qzCAcaL9HpDNiHbwI+
 uyb5cPkEdf/IwP3+w1MbI8SODQ8aVJZmvVYWWrbAxThYM37LI9irUsV9FXr1YZslvjqhauE3J
 Op7DtHr2TvTgBb1yqt3/i8rt9vjIK63m+IB4X6tFD46zOh4Ju0ziQdwUM7ByRKZdgG2vFVf0+
 3lgAZPCWq983HrUEi90LY59RPCwlnIPv2uS4f/XPYVQh/b9T7IAtxy9XBBAmMprkxhH9UzqgF
 F9f+R9FfUyH3eR9c3GmiHLCnGXojGQIK26hgq3jU9wvG+VyCF9tHxONsscJ5qJdGnC/SPGRSv
 dqzD/E7uIjuvbx/RyjvNCZpW/EgaKC6ps7ZzxhoBCKmDlL41GIQoeQkZyxbaMZGTE4OrZB3hL
 4OzPztv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change addresses part of the NEEDSWORK comment above the code,
therefore the comment needs to be adjusted, too.

Discovered via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/checkout.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfa5419f335..5faea3a05fa 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -235,14 +235,14 @@ static int checkout_merged(int pos, const struct checkout *state)
 	/*
 	 * NEEDSWORK:
 	 * There is absolutely no reason to write this as a blob object
-	 * and create a phony cache entry just to leak.  This hack is
-	 * primarily to get to the write_entry() machinery that massages
-	 * the contents to work-tree format and writes out which only
-	 * allows it for a cache entry.  The code in write_entry() needs
-	 * to be refactored to allow us to feed a <buffer, size, mode>
-	 * instead of a cache entry.  Such a refactoring would help
-	 * merge_recursive as well (it also writes the merge result to the
-	 * object database even when it may contain conflicts).
+	 * and create a phony cache entry.  This hack is primarily to get
+	 * to the write_entry() machinery that massages the contents to
+	 * work-tree format and writes out which only allows it for a
+	 * cache entry.  The code in write_entry() needs to be refactored
+	 * to allow us to feed a <buffer, size, mode> instead of a cache
+	 * entry.  Such a refactoring would help merge_recursive as well
+	 * (it also writes the merge result to the object database even
+	 * when it may contain conflicts).
 	 */
 	if (write_sha1_file(result_buf.ptr, result_buf.size,
 			    blob_type, oid.hash))
@@ -251,6 +251,7 @@ static int checkout_merged(int pos, const struct checkout *state)
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
 	status = checkout_entry(ce, state, NULL);
+	free(ce);
 	return status;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


