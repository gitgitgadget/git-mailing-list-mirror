Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E06C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FEAD64DFB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhA2BLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 20:11:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:42832 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231601AbhA2BLt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 20:11:49 -0500
Received: (qmail 20855 invoked by uid 109); 29 Jan 2021 01:11:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 01:11:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4624 invoked by uid 111); 29 Jan 2021 01:11:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 20:11:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 20:11:07 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] pretty: lazy-load commit data when expanding user-format
Message-ID: <YBNgq++oV3HorxVM@coredump.intra.peff.net>
References: <YBMXM83xCZvC5WyA@coredump.intra.peff.net>
 <87eei4pu3c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eei4pu3c.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 11:36:23PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > -for format in %H %h %T %t %P %p %h-%h-%h
> > +for format in %H %h %T %t %P %p %h-%h-%h %an-%ae-%s
> >  do
> >  	test_perf "log with $format" "
> >  		git log --format=\"$format\" >/dev/null
> 
> 
> While we're at it it would be nice to have a few more formats that have
> to do with the body in some way in those tests, and stess things like
> mailmap/trailers etc.
> 
>     %s
>     %b
>     %B
>     %N
>     %aN-%aE
>     %cn-%ce
>     %cN-%cE
>     %d
>     %D
>     %(trailers)
> 
> Just paging over the git-log manpage, that seems to stress most of the
> codepaths, i.e. subject/body, but also things like notes, .mailmap, ref
> names, and body parsing (trailers).

I'd prefer not to do so in this patch, since most of those aren't
providing any new data.

I don't mind _too_ much if you'd like to do so on top for general
regression-testing, but I'm generally a bit hesitant to throw a lot of
stuff into the perf suite without a sense of what it's measuring, just
because it already takes forever to run. So for example, is the
difference between %aN-%aE and %cN-%cE worth spending 21 seconds of CPU
(3 times the 7 seconds it takes to run on the kernel)?

One test to check mailmap performance, or one for trailers, seems like
it might be more directed. I think the existing test is likewise a bit
wasteful in checking %h _and_ %t _and_ %p), though at least it is now
much faster after my patch. ;)

(In the regular test suite, we of course should be covering all these
for correctness already, and I think we do).

-Peff
