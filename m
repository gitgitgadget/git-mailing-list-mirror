Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A74491FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 23:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933674AbdBPXWE (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 18:22:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:56751 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933609AbdBPXWD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 18:22:03 -0500
Received: (qmail 1176 invoked by uid 109); 16 Feb 2017 23:22:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 23:22:03 +0000
Received: (qmail 28426 invoked by uid 111); 16 Feb 2017 23:22:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 18:22:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:22:00 -0500
Date:   Thu, 16 Feb 2017 18:22:00 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] submodule config does not apply to upper case submodules?
Message-ID: <20170216232200.ysnho6rzpsn65y6v@sigill.intra.peff.net>
References: <20170215111704.78320-1-larsxschneider@gmail.com>
 <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
 <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
 <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
 <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaKhjNPGRVJ6H=CMKQ1RKXmVvSPOMo4c3haNeS60aWQXA@mail.gmail.com>
 <xmqqh93v10vy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh93v10vy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 03:37:37PM -0800, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> > Yes; though I'd place it in strbuf.{c,h} as it is operating
> > on the internals of the strbuf. (Do we make any promises outside of
> > strbuf about the internals? I mean we use .buf all the time, so maybe
> > I am overly cautious here)
> 
> I'd rather have it not use struct strbuf as an interface.  It only
> needs to pass "char *" and its promise that it touches the string
> in-place without changing the length need to be documented as a
> comment before the function.

This code also uses the hacky strbuf_split() interface. It would be nice
to one day move off of it (the only other strbuf-specific function used
there is strbuf_trim).

One _could_ actually parse the whole thing left-to-right (soaking up
whitespace and doing the canonicalizing) instead of dealing with a split
function at all. But the canonicalize bit you added here would not be
reusable then. And it's probably not worth holding up the bugfix here.

> >> +static void canonicalize_config_variable_name(struct strbuf *var)
> >> +{
> >> +       char *first_dot = strchr(var->buf, '.');
> >> +       char *last_dot = strrchr(var->buf, '.');
> >
> > If first_dot != NULL, then last_dot !+ NULL as well.
> > (either both are NULL or none of them),
> > so we can loose one condition below.
> 
> I do not think it is worth it, though.

If you really want to be picky, you do not need to find the first dot
at all. You can downcase everything until you see a dot, and then
find the last dot (if any) from there.

I don't think it matters much in practice.

-Peff
