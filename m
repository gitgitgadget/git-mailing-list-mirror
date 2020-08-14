Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE5DC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 10:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D613E2074D
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 10:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgHNKNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:13:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:58856 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgHNKNX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 06:13:23 -0400
Received: (qmail 30499 invoked by uid 109); 14 Aug 2020 10:13:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2020 10:13:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23582 invoked by uid 111); 14 Aug 2020 10:13:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2020 06:13:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Aug 2020 06:13:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] make git-bugreport a builtin
Message-ID: <20200814101321.GB3312240@coredump.intra.peff.net>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145936.GC891370@coredump.intra.peff.net>
 <f576fdce-9005-4653-3f91-0ddd2fff125d@gmail.com>
 <20200813173845.GA1598703@coredump.intra.peff.net>
 <xmqqa6yy2yjb.fsf@gitster.c.googlers.com>
 <xmqqr1sa1iym.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1sa1iym.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 11:47:29AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >>     macros). That could change eventually of course, but it's not like
> >>     switching back to a stand-alone at that point is a big deal.
> >
> > If it is not a big deal, then I am fine, but at the same time it
> > becomes unclear why we can say "we can use X and Y niceties only
> > available for builtins".
> 
> Actually, there is another issue that is potentially a lot worse.
> 
> "git bugreport" not being built-in would mean that the compiled-in
> git-version MUST not be relied upon (it merely is a version of the
> source "git bugreport" came from, it does not necessarily match the
> main "git" binary when we are dealing with a confused user with
> GIT_EXEC_PATH problem), but has to be asked to "git" binary on the
> $PATH externally.  That needs to be done for any non-builtin
> binaries (e.g. when user is having issue with git-remote--curl")
> anyway, keeping "git bugreport" out of builtin would force us the
> necessary discipline from early on.

I'm skeptical that an external program would help at all there. If you
say "git bugreport" you are going to get the "git" on your PATH. If it's
a builtin, then obviously we'd run that version. If it's not, then it
would run the first one from GIT_EXEC_PATH. That would normally be the
matching version. If there's a misconfiguration where that is not true,
then I'd argue the builtin version is likely to produce a better
response anyway.

If there were some mechanism by which that caused a failure that we
might notice and correct, I'd agree with your "necessary discipline"
comment. But in practice I think that:

  - it will either not matter for the details collected in the bug
    report, in which case nobody will notice the misconfiguration anyway

  - it will lead to confusing details in the report, at which point
    people will work manually with the submitter to figure out what is
    going on (just like they do now)

But I don't see a way that it systematically identifies such
misconfigurations or helps us avoid them. If it is a type of issue that
comes up a lot, then that's something the tool ought to be examining
systematically (looking at GIT* in the environment, reporting the
baked-in exec path, etc). Trying to glean that from behavior differences
in an external bugreport program sounds fragile and confusing.

-Peff
