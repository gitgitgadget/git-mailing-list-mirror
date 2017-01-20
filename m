Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF16B20756
	for <e@80x24.org>; Fri, 20 Jan 2017 21:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbdATVtP (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 16:49:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:42341 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbdATVsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 16:48:16 -0500
Received: (qmail 24636 invoked by uid 109); 20 Jan 2017 21:48:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 21:48:15 +0000
Received: (qmail 930 invoked by uid 111); 20 Jan 2017 21:49:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 16:49:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jan 2017 16:48:13 -0500
Date:   Fri, 20 Jan 2017 16:48:13 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] Disallow commands from within unpopulated submodules.
Message-ID: <20170120214812.hhyjj3ldhhbrohlw@sigill.intra.peff.net>
References: <20170119193023.26837-1-sbeller@google.com>
 <20170120191728.l3ne5tt5pwbmafjh@sigill.intra.peff.net>
 <CAGZ79kaJQefSDkV-LKxRCTtSepsNsX7U+AZqy3Z_YCd1xsmTxQ@mail.gmail.com>
 <20170120194224.vikzovupwqx53x2c@sigill.intra.peff.net>
 <CAGZ79kYKY=hDVjUx7AkeWZ=3V8Fy2hqQMFPZcoxT4NvXTFgG=Q@mail.gmail.com>
 <20170120200041.hefg44stddqe344z@sigill.intra.peff.net>
 <xmqq37gdxvbx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37gdxvbx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 01:41:54PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> And in my current understanding of submodules the check in
> >> .gitmodules ought to be enough, too.
> >
> > Yeah, that probably makes sense. You can have a gitlink without a
> > .gitmodules file, but I don't quite know what that would mean in terms
> > of submodules (I guess it's not a submodule but "something else").
> 
> That may be a lot better than reading the index unconditionally, but
> I'd rather not to see "git rev-parse" read ".gitmodules" at all.  It
> would discourage scripted use of Git for no good reason.

Why is that? Just because it makes rev-parse seem more bloated?

I think Stefan's putting it into git.c is confusing the issue a bit.
This is fundamentally about figuring out which git repository we're in,
and that procedure is the right place to put the check.

IOW, when we call setup_git_repository() we are already walking up the
tree and looking at .git/HEAD, .git/config, etc to see if we are in a
valid git repository. It doesn't seem unreasonable to me to make this
part of that check. I.e.:

  - if we we walked up from the working tree (so we have a non-NULL
    prefix); and

  - if there is a .gitmodules file; and

  - if the .gitmodules file shows that we were inside what _should_ have
    been a submodule; then

  - complain and do not accept the outer repository as a valid repo.

That adds only an extra failed open() for people who do not use
submodules, and an extra config-file parse for people who do. And then
only when they are not in the top-level of the working tree (so scripts,
etc that cd_to_toplevel wouldn't pay per-invocation).

-Peff
