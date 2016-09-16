Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9739C207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 12:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933468AbcIPMcG (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 08:32:06 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.94]:37158 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759155AbcIPMcE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 08:32:04 -0400
Received: from [84.137.191.132] (helo=book.hvoigt.net)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bksJD-0002ho-Jk; Fri, 16 Sep 2016 14:31:59 +0200
Date:   Fri, 16 Sep 2016 14:31:55 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH 3/2] batch check whether submodule needs pushing into one
 call
Message-ID: <20160916123155.GA40725@book.hvoigt.net>
References: <20160824173017.24782-1-sbeller@google.com>
 <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
 <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
 <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
 <20160914173124.GA7613@sandbox>
 <xmqqwpiep10i.fsf@gitster.mtv.corp.google.com>
 <20160915121044.GA96648@book.hvoigt.net>
 <xmqq1t0kna51.fsf@gitster.mtv.corp.google.com>
 <20160916094019.GB1488@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160916094019.GB1488@book.hvoigt.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 11:40:19AM +0200, Heiko Voigt wrote:
> > By the way, with the two new patches, 'pu' seems to start failing
> > some tests, e.g. 5533 5404 5405.
> 
> Ah ok I did only test on master, will look into those.

Ok I had a look into these and the reason t5533 fails is because on pu
--recurse-submodules is enabled by default and I missed the case when
overwriting a ref. In that case we get the sha1 from the remote side as
old. So we could catch that and fall back to all revisions there, but...

... tl;dr: The solution to use the old revisions from the remote side
was too simple and does not make matters better but actually worse for
some typical usecases. Its only in the last patch.

... that lead me to further thinking about the previous solution (using
the locally cached remote refs) which might actually be a good default
for the non-fastforward cases like creating new ref or overwriting a
ref.

My current patch would handle the --mirror case nicer, since it gets a
lot of old revs to reduce the revisions to check. For the typical one
branch push it would most likely be worse. Except when the user is
updating (fast-forwarding) the remote ref we would scan all revs of a
ref until the root because we do not get enough valid revs that already
exist on the remote.

The most exact solution would be to use all actual remote refs available
(not sure if we have them at this point in the process?) another
solution would be to still append the --remotes=<remotename> option as a
fallback to reduce the revisions.

What do others think? Will leave this for a little bit further thinking.
Its just the last patch ("use actual start hashes for submodule push
check instead of local refs") that needs to go back to the drawing
board.

Cheers Heiko
