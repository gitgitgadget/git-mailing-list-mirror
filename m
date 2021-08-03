Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAFAC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 14:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33D160F58
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 14:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhHCOzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 10:55:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:36904 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236204AbhHCOzb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 10:55:31 -0400
Received: (qmail 1009 invoked by uid 109); 3 Aug 2021 14:55:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Aug 2021 14:55:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14149 invoked by uid 111); 3 Aug 2021 14:55:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Aug 2021 10:55:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Aug 2021 10:55:19 -0400
From:   Jeff King <peff@peff.net>
To:     heapcrash heapcrash <heapcrash@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Enhancing --show-function and --function-context in default
 configurations
Message-ID: <YQlY18DK198JF22E@coredump.intra.peff.net>
References: <CAM1Tk15N6uK3aU5bY6mWQVX5UdEOraysrRmO+v4TA+P-Wa9_hQ@mail.gmail.com>
 <875ywoqldr.fsf@evledraar.gmail.com>
 <YQgahVPT8g0+U1B3@coredump.intra.peff.net>
 <xmqqmtpzwzbm.fsf@gitster.g>
 <CAM1Tk16Duh9ySS1xwW3yK4ogz=HbMp9k5B7bjCGSgqOEx=pdtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM1Tk16Duh9ySS1xwW3yK4ogz=HbMp9k5B7bjCGSgqOEx=pdtA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 02, 2021 at 09:34:32PM -0500, heapcrash heapcrash wrote:

> Thanks all for the feedback!  I'll try to address it below:
> 
> > Two other places may be diff hunk headers and --diff-words output, I think.
> 
> I didn't think of those.  Does this mean that diffs generated with a
> given e.g. diff=cpp configuration might not apply cleanly if run on
> some other user's system without that setting?

No, because the text in the hunk headers is purely cosmetic. They are
just for humans, and applying the patch ignores them.

The word-diffs are likewise just meant for human consumption, and can't
be applied at all.

> > It makes emitting the diffs take more CPU, but the same is true of other
> > options like colorMoved etc, so that in itself is not a dealbreaker.
> 
> I didn't think of this scenario, that it would add CPU time even
> without -W/--function-context/--show-function.  I'd definitely be fine
> with preserving the current behavior in these cases (more below).

I think the CPU increase is negligible. Either way, the funcname header
involves walking backwards through the file applying a pattern to see if
a line is a good candidate. The type-specific patterns are a little more
complicated, but I doubt the difference is even measurable in practice.

If we are going to have defaults for extension-to-diff mapping, I would
prefer apply them consistently (so for -W, but also for funcnames,
word-diffs, etc). That is both easier to implement and easier to explain
to users (and assuming our mapping is accurate, more likely to be what
they want).

> Another case I didn't think of in the original post is with the "git
> log -L:funcname:path/to/file.cpp" option, which tracks changes within
> a function over time.  Having "better" default function boundary
> detection here would also be useful.

Yes, I think this uses the same diff funcname patterns, so once we have
default mappings, it would start to use them.

-Peff
