Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54775C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 15:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiKQPDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 10:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbiKQPDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 10:03:09 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62135F54
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 07:03:07 -0800 (PST)
Received: (qmail 25342 invoked by uid 109); 17 Nov 2022 15:03:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Nov 2022 15:03:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12719 invoked by uid 111); 17 Nov 2022 15:03:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Nov 2022 10:03:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Nov 2022 10:03:06 -0500
From:   Jeff King <peff@peff.net>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 0/2] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y3ZNKhr3kMZLmQnh@coredump.intra.peff.net>
References: <Y3K//kO3fxD7Pl3/@coredump.intra.peff.net>
 <20221117141933.73790-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221117141933.73790-1-tenglong.tl@alibaba-inc.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 10:19:33PM +0800, Teng Long wrote:

> > I doubt this buys us much in practice. After patch 2, looking for extra
> > bitmaps is much cheaper. It's one open() call per pack (which will
> > return ENOENT normally) looking for a bitmap. And while it's only 2
> > lines of code, it does increase coupling of assumptions between the two
> > functions. So maybe not worth doing. I dunno.
> 
> I agree and I think it's reasonable.
> 
> So If I bring it into the patch how about the commit message:
> [...]

Both the commit messages you proposed look accurate to me.

I was a bit skeptical on the second one (warning about skipping the
pack bitmap when a midx is present) just because we really did do that
intentionally at one point. But then I remembered that these are no
longer producing warnings, but trace output. So in that sense, nobody
will really be bothered by them.

I do wonder if there are people who have trace2 on all the time (for
performance tracing, telemetry, etc) who would find these to be junk in
their logs. IMHO the trace2 mechanism is a bit coarse grained in that we
can only check "is it on". One of the nice things about the original
trace facility is that we could stuff this behind GIT_TRACE_BITMAPS
which would really only be turned on if somebody wanted to debug
bitmaps.

-Peff
