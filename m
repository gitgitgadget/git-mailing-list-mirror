Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF10C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B1E60462
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbhHaGEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 02:04:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:34688 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239702AbhHaGE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 02:04:27 -0400
Received: (qmail 3763 invoked by uid 109); 31 Aug 2021 06:03:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Aug 2021 06:03:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19359 invoked by uid 111); 31 Aug 2021 06:03:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Aug 2021 02:03:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 31 Aug 2021 02:03:30 -0400
From:   Jeff King <peff@peff.net>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     git@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Problem accessing git.kernel.org with git v2.33 plus gitproxy
Message-ID: <YS3GMqz4WHUS0Cjt@coredump.intra.peff.net>
References: <20210830161149.xggfosjthnjxcoxp@box.shutemov.name>
 <YS0gZNRqz72hs/a5@coredump.intra.peff.net>
 <20210830182845.pnv7ywnc364jnblt@box>
 <YS1Bni+QuZBOgkUI@coredump.intra.peff.net>
 <20210830224215.hay6rjbt3vk26nk5@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210830224215.hay6rjbt3vk26nk5@box>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 01:42:15AM +0300, Kirill A. Shutemov wrote:

> On Mon, Aug 30, 2021 at 04:37:50PM -0400, Jeff King wrote:
> > I am sympathetic that this used to work, and now doesn't. But this proxy
> > case is affected by the problem that ae1a7eefff was solving. The root of
> > the issue is just that "socat" in its default form is not doing the
> > right thing. So I'd prefer not to try to make any change to Git's
> > behavior here.
> 
> As a kernel developer I learned hard way that breaking user experience by
> kernel changes considered a kernel regression, even if userspace "does it
> wrong"™. I'm not sure what standard of care for Git users is.
> 
> I'm fine adjusting the proxy script and make my colleagues aware about the
> issue, but the approach doesn't scale.

I think we're a little less extreme there than the kernel. Like I said,
my preference is to leave Git as-is, but if somebody feels strongly, I
don't think it would be that hard to leave core.gitproxy untouched here.

I agree it doesn't scale, but my suspicion is that we're talking about
an extremely small population here. IMHO we should be considering
deprecating git:// entirely (from Git itself, and kernel.org should
consider turning it off). In the v2 protocol, there's no advantage to
using it over HTTP.

> > But one option would be to limit it only to ssh, and not
> > git:// proxies (we already don't do that half-duplex shutdown for raw
> > TCP git://, for reasons discussed in that commit message).
> 
> I wounder if it's possible to detect the situation, warn the user that
> gitproxy has to be fixed and retry fetching pack without closing fd[1].

I don't think it can be easily distinguished from an actual network
hangup (or proxy command failure, etc). I would much rather stop doing
the close() entirely than add any kind of heuristic retry.

-Peff
