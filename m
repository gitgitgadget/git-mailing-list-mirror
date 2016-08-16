Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64D971F859
	for <e@80x24.org>; Tue, 16 Aug 2016 14:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbcHPOzp (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 10:55:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:56248 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752499AbcHPOzp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 10:55:45 -0400
Received: (qmail 12192 invoked by uid 109); 16 Aug 2016 14:55:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 14:55:35 +0000
Received: (qmail 26828 invoked by uid 111); 16 Aug 2016 14:55:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 10:55:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 10:55:33 -0400
Date:	Tue, 16 Aug 2016 10:55:33 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/Makefile: make sure that file names are truly
 platform-independent
Message-ID: <20160816145532.nfooqmkaostc2e7t@sigill.intra.peff.net>
References: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de>
 <xmqqk2fihv90.fsf@gitster.mtv.corp.google.com>
 <xmqq4m6mhsvj.fsf@gitster.mtv.corp.google.com>
 <20160815184315.cyhln2bxg465lq2l@sigill.intra.peff.net>
 <alpine.DEB.2.20.1608161502240.4924@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608161502240.4924@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 03:10:46PM +0200, Johannes Schindelin wrote:

> > I am not convinced this mechanism needs to be built into git. Because it
> > happens to be about filenames, git at least has a hope of making sense
> > of the various project rules.
> 
> Both of you gentle people may recall a conversation in December 2014 when
> we scrambled to plug a hole where maliciously-chosen file names would have
> allowed to wreak havoc with a local Git repository's config (among other
> things).
> 
> We did plug it, but not before I proposed to exclude many more file names
> than just maliciously-chosen ones. For example, I wanted to exclude all
> file names that are illegal on Windows when core.protectNTFS was set to
> true.
> 
> If we were to implement this "let's help cross-platform projects"
> functionality, it would be at that same level.

Hrm. I am not sure I agree. At GitHub, for instance, we turn on
core.protectNTFS for all repositories because we do want to be a vector
for attacks. So the tradeoff is a good one: the restrictions on
filenames are not that big, and we gain a lot of safety (i.e., a known
remote code execution bug).

Whereas if core.protectNTFS started disallowing trees with both "foo"
and "FOO", that is a much different tradeoff. It is much more likely to
come up, and it is protecting a much less valuable thing (it's an
annoyance, not a security hole). Projects which do not care about people
on case-insensitive filesystems will be annoyed to have their commits
rejected (whether they are right to be so uncaring or not can be
debated, but I am not sure that GitHub wants to enforce a hard policy at
the fsck layer).

So even if we wanted a similar mechanism, I think it has to be triggered
by a separate config option. And I do not think general hosting sites
would turn it on. It's really a project decision, not a hosting-site
one.

There may be some rules that are in between. I.e., names that are
illegal on some common platform but are extremely unlikely to be chosen
in general. I'd have to see the rules to give an opinion.

-Peff
