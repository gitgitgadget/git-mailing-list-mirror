Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7696203BD
	for <e@80x24.org>; Wed, 26 Oct 2016 16:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754286AbcJZQru (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 12:47:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:34432 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752427AbcJZQrt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 12:47:49 -0400
Received: (qmail 19485 invoked by uid 109); 26 Oct 2016 16:47:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 16:47:48 +0000
Received: (qmail 12497 invoked by uid 111); 26 Oct 2016 16:48:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 12:48:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Oct 2016 12:47:46 -0400
Date:   Wed, 26 Oct 2016 12:47:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with
 O_CLOEXEC
Message-ID: <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
 <20161025181621.4201-1-gitster@pobox.com>
 <20161025181621.4201-3-gitster@pobox.com>
 <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net>
 <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 09:23:21AM -0700, Junio C Hamano wrote:

> >> +		/* Might the failure be due to O_NOATIME? */
> >> +		if (errno != ENOENT && (sha1_file_open_flag & O_NOATIME)) {
> >> +			sha1_file_open_flag &= ~O_NOATIME;
> >> +			continue;
> >> +		}
> >
> > We drop O_NOATIME, and end up with an empty flag field.
> >
> > But we will never have tried just O_CLOEXEC, which might have worked.
> 
> Yes, doing so would smudge atime, so one question is which one
> between noatime or cloexec is more important to be done at open(2)
> time.

Yes, but the missing case is one where we know that O_NOATIME does not
work (but O_CLOEXEC does), so we know we have to smudge the atime.

Of the two flags, I would say CLOEXEC is the more important one to
respect because it may actually impact correctness (e.g., leaking
descriptors to sub-processes). Whereas O_NOATIME is purely a performance
optimization.

I actually wonder if it is worth carrying around the O_NOATIME hack at
all.  Linus added it on 2005-04-23 via 144bde78e9; the aim was to reduce
the cost of opening loose object files. Some things have changed since
then:

  1. In June 2005, git learned about packfiles, which means we would do
     a lot fewer atime updates (rather than one per object access, we'd
     generally get one per packfile).

  2. In late 2006, Linux learned about "relatime", which is generally
     the default on modern installs. So performance around atime updates
     is a non-issue there these days.

     All the world isn't Linux, of course, but I can't help that feel
     that atime performance hackery is something that belongs at the
     system level, not in individual applications.

So I don't have hard numbers, but I'd be surprised if O_NOATIME is
really buying us anything these days.

-Peff
