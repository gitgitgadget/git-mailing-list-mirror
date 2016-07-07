Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82FC120705
	for <e@80x24.org>; Thu,  7 Jul 2016 21:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbcGGV5N (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 17:57:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:41704 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752095AbcGGV5M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 17:57:12 -0400
Received: (qmail 9589 invoked by uid 102); 7 Jul 2016 21:56:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jul 2016 17:56:41 -0400
Received: (qmail 8438 invoked by uid 107); 7 Jul 2016 21:56:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jul 2016 17:56:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jul 2016 17:56:38 -0400
Date:	Thu, 7 Jul 2016 17:56:38 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
Message-ID: <20160707215638.GA27627@sigill.intra.peff.net>
References: <20160707011218.3690-1-sbeller@google.com>
 <20160707011218.3690-3-sbeller@google.com>
 <xmqqa8htp4kc.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbkv5P0wP2kKt9gzmZBe1DjLSB8JpZD66DT_Xd4NKqmKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbkv5P0wP2kKt9gzmZBe1DjLSB8JpZD66DT_Xd4NKqmKQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 07, 2016 at 02:41:37PM -0700, Stefan Beller wrote:

> >> +     /* NEEDSWORK: expose the limitations to be configurable. */
> >> +     int max_options = 32;
> >> +
> >> +     /*
> >> +      * NEEDSWORK: expose the limitations to be configurable;
> >> +      * Once the limit can be lifted, include a way for payloads
> >> +      * larger than one pkt, e.g allow a payload of up to
> >> +      * LARGE_PACKET_MAX - 1 only, and reserve the last byte
> >> +      * to indicate whether the next pkt continues with this
> >> +      * push option.
> >> +      */
> >> +     int max_size = 1024;
> >
> > Good NEEDSWORK comments; perhaps also hint that the configuration
> > must not come from the repository level configuration file (i.e.
> > Peff's "scoped configuration" from jk/upload-pack-hook topic)?
> 
> Ok, I reviewed that series. It is unclear to me how the attack would
> actually look like in that case.
> 
> In 20b20a22f8f Jeff writes:
> > Because we promise that
> > upload-pack is safe to run in an untrusted repository, we
> > cannot execute arbitrary code or commands found in the
> > repository (neither in hooks/, nor in the config).
> 
> I agree on this for all content that can be modified by the user
> (e.g. files in the work tree such as .gitmodules), but the .git/config
> file cannot be changed remotely. So I wonder how an attack would
> look like for a hosting provider or anyone else?
> We still rely on a sane system and trust /etc/gitconfig
> so we do trust the host/admin but not the user?

The problem is for hosting sites which serve repositories via git-daemon
from untrusted users who have real shell accounts (e.g., you set up
git-daemon to run as the "daemon" user serving repositories out of
people's home directories; you don't want users to escalate their shell
access into running arbitrary code as "daemon").

But I don't think that case applies here. That is about running
upload-pack on an untrusted repository, but your changes here are part
of receive-pack. In such a scenario, users should be pushing as
themselves via ssh. And if they are not (e.g., the admin set up
push-over-smart-http centrally), they are already screwed, as a
malicious user could just set up a pre-receive hook.

IOW, we promise only that upload-pack is safe to run an untrusted repo,
but not receive-pack.

-Peff
