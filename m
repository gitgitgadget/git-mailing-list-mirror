Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 470582022A
	for <e@80x24.org>; Fri, 28 Oct 2016 07:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758800AbcJ1HvI (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 03:51:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:35269 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755187AbcJ1HvI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 03:51:08 -0400
Received: (qmail 15066 invoked by uid 109); 28 Oct 2016 07:51:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Oct 2016 07:51:06 +0000
Received: (qmail 27196 invoked by uid 111); 28 Oct 2016 07:51:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Oct 2016 03:51:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Oct 2016 03:51:05 -0400
Date:   Fri, 28 Oct 2016 03:51:05 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with
 O_CLOEXEC
Message-ID: <20161028075104.la24zydnr3ogb6qv@sigill.intra.peff.net>
References: <20161025181621.4201-1-gitster@pobox.com>
 <20161025181621.4201-3-gitster@pobox.com>
 <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net>
 <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
 <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net>
 <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
 <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net>
 <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
 <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net>
 <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 03:38:59PM -0700, Linus Torvalds wrote:

> On Thu, Oct 27, 2016 at 3:24 AM, Jeff King <peff@peff.net> wrote:
> >
> > +cc Linus as the original author of 144bde78e9 in case there is
> > something subtle I'm missing, but this really just seems like it's
> > an outdated optimization.
> 
> I'd *really* like to keep O_NOATIME if at all possible. It made a huge
> difference on older kernels, and I'm not convinced that relatime
> really fixes it as well as O_NOATIME.
> 
> There are people who don't like relatime. And even if you do have
> relatime enabled, it will update atime once every day, so then this
> makes your filesystem have a storm of nasty inode writebacks if you
> haven't touched that git repo in a while.

The existence of "relatime" is only half the story of its outdatedness.

The other half is packfiles, so that we are paying atime only once per
packfile, not once per object (technically once per mmap(), so on a
32-bit system with large packfiles, it would be multiple, depending on
your window size).

So I'm not convinced that "storm" is really the right word in a modern
context. The atime updates due to object accesses are probably smaller
than those from all the other read() calls being done on non-object
files (like config, refs, etc).

That being said, if you really care, it's not that much code to keep.

-Peff
