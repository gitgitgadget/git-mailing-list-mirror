Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE10E1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 19:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755392AbeFNTjq (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 15:39:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:44906 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755390AbeFNTjp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 15:39:45 -0400
Received: (qmail 28205 invoked by uid 109); 14 Jun 2018 19:39:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Jun 2018 19:39:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14771 invoked by uid 111); 14 Jun 2018 19:40:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Jun 2018 15:40:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jun 2018 15:39:43 -0400
Date:   Thu, 14 Jun 2018 15:39:43 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bryan Turner <bturner@atlassian.com>,
        Brandon Williams <bmwill@google.com>,
        Ben Humphreys <behumphreys@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
Message-ID: <20180614193943.GA2226@sigill.intra.peff.net>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
 <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
 <20180103053516.GB87855@aiede.mtv.corp.google.com>
 <20180608045028.GA17528@sigill.intra.peff.net>
 <xmqqzi009deu.fsf@gitster-ct.c.googlers.com>
 <20180614183018.GA1911@sigill.intra.peff.net>
 <20180614185522.GA255581@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180614185522.GA255581@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 11:55:22AM -0700, Jonathan Nieder wrote:

> > No, my wrapper _isn't_ simple. It passes most options to openssh, but
> > just doesn't understand the "-G" probing.  So if the default was
> > openssh-like instead of "simple", then that would work fine without me
> > setting anything, just like it did before.
> >
> > Which I thought was where the discussion ended up, but perhaps I'm
> > misunderstanding.
> 
> Do you mean that it doesn't pass "-G" through, or that when using old
> versions of openssh that doesn't support "-G" the probing fails?

It just doesn't pass "-G" through.

> If the former, then detecting the wrapper as something other than
> "ssh" is intended behavior (though we might want to change what that
> something is, as discussed in the previous thread).  If the latter,
> then this is https://crbug.com/git/7 which I consider to be a bug.

I certainly see the argument that "well, if it doesn't do '-G' then it's
not _really_ openssh". My counter to that is that we don't actually
_care_ about -G (and never did before recently). It's just a proxy for
"do we understand -p", which my script does understand. My wrapper might
eventually break if we depend on new options (like "-o SendEnv"), but
the worst case there is generally no different before or after your
patch: the command barfs.

I say "generally" because of course you can come up with an example
where my script quietly interprets "-o" as something else, but it seems
like most uses there would cause an error.  And anyway, by making me set
GIT_SSH_VARIANT all we've bought is plausible deniability that it's _my_
fault for doing so when my script doesn't handle the new option
gracefully. ;)

But again, I'm just describing what makes sense to me. If you feel
strongly about requiring the variant to be explicitly specified, I can
certainly live with that.

-Peff
