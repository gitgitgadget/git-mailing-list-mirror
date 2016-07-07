Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 052B620705
	for <e@80x24.org>; Thu,  7 Jul 2016 22:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbcGGWJp (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 18:09:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:41722 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752028AbcGGWJo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 18:09:44 -0400
Received: (qmail 10147 invoked by uid 102); 7 Jul 2016 22:09:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jul 2016 18:09:44 -0400
Received: (qmail 8635 invoked by uid 107); 7 Jul 2016 22:10:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jul 2016 18:10:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jul 2016 18:09:41 -0400
Date:	Thu, 7 Jul 2016 18:09:41 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
Message-ID: <20160707220941.GA27779@sigill.intra.peff.net>
References: <20160707011218.3690-1-sbeller@google.com>
 <20160707011218.3690-3-sbeller@google.com>
 <xmqqa8htp4kc.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbkv5P0wP2kKt9gzmZBe1DjLSB8JpZD66DT_Xd4NKqmKQ@mail.gmail.com>
 <20160707215638.GA27627@sigill.intra.peff.net>
 <CAGZ79kbrZuDEN58sdBUQEbLeJbqVo5wNzXRjqAouRGqP=mw01A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbrZuDEN58sdBUQEbLeJbqVo5wNzXRjqAouRGqP=mw01A@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 07, 2016 at 03:06:31PM -0700, Stefan Beller wrote:

> > The problem is for hosting sites which serve repositories via git-daemon
> > from untrusted users who have real shell accounts (e.g., you set up
> > git-daemon to run as the "daemon" user serving repositories out of
> > people's home directories; you don't want users to escalate their shell
> > access into running arbitrary code as "daemon").
> 
> I think you would want to lock down the
> hosting site as much as possible and not put untrusted users home
> directories on there? So it is hard for me to imagine you'd go for such a setup
> in practice.

Sure, I think that's a good way to run a hosting site, too. But it
doesn't mean people don't have other needs. kernel.org was run as I
mentioned above for many years.

Another related case: you have a multi-user server where Alice might run
"git fetch server:~bob/repo.git". Alice does not want to run arbitrary
code based on what is in Bob's repo.git. Even if they are in the same
company, it is a poor security practice.

> > But I don't think that case applies here. That is about running
> > upload-pack on an untrusted repository, but your changes here are part
> > of receive-pack. In such a scenario, users should be pushing as
> > themselves via ssh. And if they are not (e.g., the admin set up
> > push-over-smart-http centrally), they are already screwed, as a
> > malicious user could just set up a pre-receive hook.
> 
> I hear that as: "The pre-receive hook itself can do much more
> damage than an oversized push option payload".

Exactly. Or more to the point: we promise nothing here except for
upload-pack, so changes to receive-pack do not have to worry about this
issue at all.

-Peff
