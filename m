Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0E7620A40
	for <e@80x24.org>; Mon, 27 Nov 2017 04:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751105AbdK0EfF (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 23:35:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:40964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750841AbdK0EfE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 23:35:04 -0500
Received: (qmail 25060 invoked by uid 109); 27 Nov 2017 04:35:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Nov 2017 04:35:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32242 invoked by uid 111); 27 Nov 2017 04:35:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 26 Nov 2017 23:35:21 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Nov 2017 23:35:02 -0500
Date:   Sun, 26 Nov 2017 23:35:02 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>, Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
Message-ID: <20171127043502.GA5946@sigill>
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
 <20171120191931.okxejqyqayjvxpbc@aiede.mtv.corp.google.com>
 <CAP8UFD0d9zM9F3tLrTMiLdfoJQsOPELtmudVB6e83DiLPN5DEA@mail.gmail.com>
 <20171126191510.GA1501@sigill>
 <xmqqy3msfrr1.fsf@gitster.mtv.corp.google.com>
 <xmqqshd0e41a.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshd0e41a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 01:31:13PM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Perhaps the "else" part of the above should become a bit more
> > careful, something along the lines of...
> >
> >     else
> >             MSGFMT ?= msgfmt
> > -           ifneq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null; echo $$?),0)
> > -                   MSGFMT := $(TCL_PATH) po/po2msg.sh
> > -           endif
> > +           MSGFMT_DRYRUN = --tcl -l C -d . /dev/null 2>/dev/null
> > +            ifneq ($(shell $(MSGFMT) $(MSGFMT_DRYRUN); echo $$?),0)
> > +               ifneq ($(shell $(TCL_PATH) po/po2msg.sh $(MSGFMT_DRYRUN); echo $$?),0)
> > +                    MSGFMT := $(TCL_PATH) po/po2msg.sh
> > +               else
> > +                   $(error "no usable msgfmt to build gitk; set NO_TCLTK perhaps?")
> > +               endif
> >             endif
> >     endif
> 
> Actually, at this point, I think the suggestion should primarily be
> to install either msgfmt or tclsh; offering another choice to set
> NO_TCLTK is OK, but it should be secondary, as the fact that the
> make utility is running this recipe is a sign that the builder wants
> to build gitk/git-gui.

I think that's the rub, though. We hit this code path by default, so
it's _not_ a sign that the builder cares about gitk.

I do agree that outlining "install one of these or disable tcl" as the
options is a good idea, though.

> Whether the builder wants to run the result on the same box is a
> separate and irrelevant matter.  Once built and installed, a box
> without "wish" may not be able to run the result, but installing it
> after the fact will fix it without need to rebuild anything.

Yeah, this side-steps the "other half" of the issue that Christian's
patch addresses, which seems like the more controversial part (I don't
have a strong opinion myself, though).

-Peff
