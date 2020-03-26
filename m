Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490BAC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 11:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2908F20409
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 11:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgCZLMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:12:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:52052 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727560AbgCZLMD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 07:12:03 -0400
Received: (qmail 3613 invoked by uid 109); 26 Mar 2020 11:12:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Mar 2020 11:12:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13858 invoked by uid 111); 26 Mar 2020 11:21:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2020 07:21:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Mar 2020 07:12:01 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] p5310: stop timing non-bitmap pack-to-disk
Message-ID: <20200326111201.GA4193632@coredump.intra.peff.net>
References: <20200326075436.GA2199958@coredump.intra.peff.net>
 <cf64c47a-481e-3802-3ce6-a2a583cd7c75@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf64c47a-481e-3802-3ce6-a2a583cd7c75@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 26, 2020 at 06:48:37AM -0400, Derrick Stolee wrote:

> >   - the point of the t/perf suite is to find performance regressions,
> >     and it won't help with that. We don't compare the numbers between
> >     two tests (which the perf suite has no idea are even related), and
> >     any change in its numbers would have nothing to do with bitmaps.
> 
> This does make me think if there is a way to adjust "./run" to test two
> different config settings or command-line options instead of just two
> different build versions. Perhaps something like
> 
>  ./run "HEAD -c core.commitGraph=true" "HEAD -c core.commitGraph=false" -- p4200-line-log.sh
> 
> But that's just musing on my part.

I think that's the right direction, but it would require tests knowing
how to make use of those extra parameters. What I'd _really_ like is a
way to parameterize a whole bunch of things:

 - test repo
 - git version
 - particular config settings

do runs with whatever combinations of parameters you choose, and then
create tables showing differences across various settings of a
parameter. Some parameters would be automatically set up, but test
scripts would have to advertise other parameters they know about.

I don't think it's conceptually hard, but the existing perf code is
pretty hacked-together and relies on the filesystem for storage. So the
notion that we'd only ever compare different versions runs deep; that's
how the on-disk storage is organized.

> > So let's just drop it. It's not useful and is adding minutes to perf
> > runs.
> 
> I agree with your reasoning. This is not a critical path for clients,
> and all servers should be using bitmaps.

Yeah, I should have noted that we're not actually testing the
performance of a stock repack anywhere else. It wouldn't belong in
p5310, but in theory it might be of interest in another script. But I
agree for the reasons you gave that it's not all that interesting a
timing.

-Peff
