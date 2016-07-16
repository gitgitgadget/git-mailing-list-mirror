Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24D4E203BD
	for <e@80x24.org>; Sat, 16 Jul 2016 08:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbcGPIHT (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 04:07:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:45884 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751405AbcGPIG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 04:06:58 -0400
Received: (qmail 8651 invoked by uid 102); 16 Jul 2016 08:06:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 16 Jul 2016 04:06:59 -0400
Received: (qmail 23025 invoked by uid 107); 16 Jul 2016 08:07:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 16 Jul 2016 04:07:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Jul 2016 04:06:54 -0400
Date:	Sat, 16 Jul 2016 04:06:54 -0400
From:	Jeff King <peff@peff.net>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Eric Wong <e@80x24.org>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Ben Peart <peartben@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Turner <novalis@novalis.org>,
	Joey Hess <joey@kitenet.net>,
	Ronnie Sahlberg <rsahlberg@google.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Subject: Re: Plugin mechanism(s) for Git?
Message-ID: <20160716080654.GA10538@sigill.intra.peff.net>
References: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com>
 <2C31984D-310C-4E8C-927B-6D98B7D7570B@gmail.com>
 <loom.20160715T181543-821@post.gmane.org>
 <20160715194752.f10351ae84346bd533495496@domain007.com>
 <20160715212843.GA5131@dcvr.yhbt.net>
 <CACsJy8AZak5LyLhLz-6YX0vB8uevKt--Fe9EAMAe1_=14JaaVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8AZak5LyLhLz-6YX0vB8uevKt--Fe9EAMAe1_=14JaaVQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 16, 2016 at 07:31:25AM +0200, Duy Nguyen wrote:

> >> > I wouldn’t be too quick to dismiss dynamically loaded libraries as
> >> > there are some distinct advantages over the other patterns especially
> >> > performance and simplicity.  I realize it requires us to version the
> >> > ABI but there are established patterns to manage this.  It also isn’t
> >> > that much different than us having to freeze or version the protocol
> >> > for communicating with a remote-helper.
> >
> > (re-adding dropped CCs)
> >
> > The critical difference is protocols can be tested and debugged
> > in a language/tool-independent way.
> 
> Not using dynamic libraries also makes it possible for other git
> reimplementations to reuse the same plugins.

Good point.

I think for the ref backends (which so far are the main pluggable thing
that people expect to link in), the assumption was that the on-disk
formats would be documented, and implementations would then write their
own plugins to match the on-disk formats.

I think all of the other implementations _except_ core git already have
their own internal pluggable ref formats (I know libgit2 and JGit do).

In theory if Git defines the API for the plugin to meet, then one could
use those plugins with other implementations. In practice, I think ref
plugins will also make use of Git functions (even things as simple as
xmalloc), and the ABI there is anything but stable. So I think ref
backends are "pluggable" in the sense of "configurable", but not in
the sense of dynamically linking third party code that git has never
seen.

Likewise, I don't think licensing issues have really been discussed. I'd
think at this point that any ref backends would need to be GPL, as they
are quite intimately part of git, and not true pluggable modules.

-Peff
