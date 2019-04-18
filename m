Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1652D20248
	for <e@80x24.org>; Thu, 18 Apr 2019 21:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbfDRVYH (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 17:24:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:34444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728264AbfDRVYH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 17:24:07 -0400
Received: (qmail 5777 invoked by uid 109); 18 Apr 2019 21:24:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Apr 2019 21:24:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4735 invoked by uid 111); 18 Apr 2019 21:24:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Apr 2019 17:24:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2019 17:24:05 -0400
Date:   Thu, 18 Apr 2019 17:24:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 4/3] untracked-cache: use FLEX_ALLOC to create internal
 structs
Message-ID: <20190418212405.GA18623@sigill.intra.peff.net>
References: <pull.178.git.gitgitgadget@gmail.com>
 <a7f75cefb682546862be4dd8b48f91c4034c5d5a.1554901006.git.gitgitgadget@gmail.com>
 <20190410162029.GA30818@sigill.intra.peff.net>
 <xmqq7ec00z9t.fsf@gitster-ct.c.googlers.com>
 <20190418211408.GA18011@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418211408.GA18011@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 18, 2019 at 05:14:08PM -0400, Jeff King wrote:

> Just so we don't forget about it, I wrote this fix up as a patch. And in
> fact it led to a few other cleanups. I think the first one is definitely
> worth doing now, even if there are other similar cases lurking in the
> rest of the index code.
> 
> The other two are optional, though I think they are worth it (and not
> too hard to verify that they are doing the right thing).
> 
> These are on top of js/untracked-cache-allocfix (though they could
> easily be ported to a separate topic if we want).
> 
>   [1/3]: untracked-cache: be defensive about missing NULs in index
>   [2/3]: untracked-cache: simplify parsing by dropping "next"
>   [3/3]: untracked-cache: simplify parsing by dropping "len"

I also wondered if we could just accept the cost of calloc() here and
use FLEX_ALLOC to simplify things. That resulted in the patch below, but
I didn't include it with the initial 3, because I think it's too
subtle/gross for my tastes.

-- >8 --
Subject: untracked-cache: use FLEX_ALLOC to create internal structs

The untracked_cache_dir struct has a FLEX_ARRAY in it. Let's use
FLEX_ALLOC_MEM to allocate it, which saves us having to compute the
length ourselves.

In theory this could be slightly slower, since the FLEX_ALLOC macros use
calloc (and we just memcpy over most of the contents anyway). But in
practice this distinction is not generally measurable.

Note that because we then fill in the pre-flex elements of the struct
using a memcpy, we need to take care to use the exact size of that
space and _not_ "sizeof(ud)", since the latter may include padding (or
even an extra byte on systems where FLEX_ARRAY is 1).

Signed-off-by: Jeff King <peff@peff.net>
---
If we wanted to go this route, I think it would make sense to provide a
FLEX_ALLOC macro that takes a "template" set of bytes as a ptr/len pair,
and writes it before we fill in the flex portion.

Then we could do something like:

  FLEX_ALLOC_COPY(untracked, &ud, sizeof(ud), name, data, eos - data);

If this is the only such case, it's probably not worth it (I didn't
really look around for more, though).

 dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 60438b2cdc..7cd4eec198 100644
--- a/dir.c
+++ b/dir.c
@@ -2757,9 +2757,9 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 	if (!eos || eos == end)
 		return -1;
 
-	*untracked_ = untracked = xmalloc(st_add3(sizeof(*untracked), eos - data, 1));
-	memcpy(untracked, &ud, sizeof(ud));
-	memcpy(untracked->name, data, eos - data + 1);
+	FLEX_ALLOC_MEM(untracked, name, data, eos - data);
+	memcpy(untracked, &ud, offsetof(struct untracked_cache_dir, name));
+	*untracked_ = untracked;
 	data = eos + 1;
 
 	for (i = 0; i < untracked->untracked_nr; i++) {
-- 
2.21.0.1092.g8b0302e9c4

