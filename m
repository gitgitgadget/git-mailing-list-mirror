Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28D952036B
	for <e@80x24.org>; Fri,  6 Oct 2017 08:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbdJFIhW (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 04:37:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:34926 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750886AbdJFIhW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 04:37:22 -0400
Received: (qmail 18639 invoked by uid 109); 6 Oct 2017 08:37:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 08:37:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3810 invoked by uid 111); 6 Oct 2017 08:37:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 04:37:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 04:37:19 -0400
Date:   Fri, 6 Oct 2017 04:37:19 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     Git Users <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Regression in 'git branch -m'?
Message-ID: <20171006083719.jap56jucgmlsuvuo@sigill.intra.peff.net>
References: <20171005172552.GA11497@inner.h.apk.li>
 <20171005183303.f77dpkhs5ztxlmyv@sigill.intra.peff.net>
 <20171006073913.yavdbdd3p3y5vjhd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171006073913.yavdbdd3p3y5vjhd@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 06, 2017 at 03:39:13AM -0400, Jeff King wrote:

> I got a chance to look at this again. I think the root of the problem is
> that resolve_ref() as it is implemented now is just totally unsuitable
> for asking the question "what does this symbolic link point to?".
> 
> Because you end up with either:
> 
>   1. If we pass RESOLVE_REF_READING, then we do not return the target
>      refname for orphaned commits (which is why 31824d180d dropped it).
> 
>   2. If not, then we do not return the target refname for commits with
>      names that are not available for writing. The d/f conflict here is
>      one example, but there may be others.
> 
> So I think we need to teach resolve_ref() a new mode that's like
> "reading", but just follows the symref chain.

This analysis is not _quite_ right. The "not available for writing"
thing actually isn't intentionally enforced by the resolve_ref. It's
just that it's not careful enough about checking errno. We see EISDIR
instead of ENOENT when there's a d/f situation, but both have the same
practical effect: that ref doesn't exist.

I.e., this lookup has _always_ been broken, even in the "reading" case.
It's just that the fix from 31824d180d (correctly) made git-branch more
careful about handling the cases where we couldn't resolve a HEAD.

So this patch fixes the problem:

diff --git a/refs.c b/refs.c
index df075fcd06..2ba74720c8 100644
--- a/refs.c
+++ b/refs.c
@@ -1435,7 +1435,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		if (refs_read_raw_ref(refs, refname,
 				      sha1, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
-			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
+			if ((errno != ENOENT && errno != EISDIR) ||
+			    (resolve_flags & RESOLVE_REF_READING))
 				return NULL;
 			hashclr(sha1);
 			if (*flags & REF_BAD_NAME)

but seems to stimulate a test failure in t3308. I have a suspicion that
I've just uncovered another bug, but I'll dig in that. In the meantime I
wanted to post this update in case anybody else was looking into it.

-Peff
