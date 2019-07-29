Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA9B1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 19:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfG2TUm (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 15:20:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:54448 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729331AbfG2TUm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 15:20:42 -0400
Received: (qmail 27525 invoked by uid 109); 29 Jul 2019 19:20:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Jul 2019 19:20:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31969 invoked by uid 111); 29 Jul 2019 19:22:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jul 2019 15:22:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Jul 2019 15:20:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christopher Head <bugs@chead.ca>, git@vger.kernel.org
Subject: Re: Push force-with-lease with multi-URL remote
Message-ID: <20190729192040.GD14943@sigill.intra.peff.net>
References: <20190727095440.1aac3b3c@amdahl.home.chead.ca>
 <20190729102009.GC2755@sigill.intra.peff.net>
 <xmqq7e81vuc3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7e81vuc3.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 29, 2019 at 06:33:32AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > My general feeling is that having multiple push URLs for a remote is a
> > poorly designed feature in Git (and I think the discussion elsewhere in
> > this thread went there, as well).
> 
> That's being generous.  I do not think it was even designed---at
> least, the interaction with remote-tracking is ill thought out,
> but I think the updating of remote-tracking by pretending to have
> turned around and fetched immediately after it has done its thing
> came much later than multiple URLs for push.  A remote with multiple
> URLs without any remote-tracking (i.e. "push only remote") behaves
> semi-sensibly.

Yeah, the auto-update of the tracking refs came later (so I think you
could argue the bad interaction is my fault!).

> > But since we do have it, and if we are not going to deprecate it[1], it
> > seems like this case should pick the X value of myremote/mybranch ahead
> > of time, and then use it consistently for each push.
> 
> I agree but only if the listed ones are separate ones.  If the URLs
> are separate paths to reach the same remote (e.g. https:// and ssh://
> going to the same place), the current definition would make more sense.

Hmm, true. I'd almost argue that --force-with-lease, at least in its
default mode with no explicit lease source specified, should allow an
update from X to Y to be a successful noop if the remote "somehow"
already moved to Y.

This multi-URL push is one such "somehow", but I could imagine a case
where two other independent processes are racing. And we do not care at
all how we get to "Y", only that we get there.

But I haven't thought it through carefully, and I wonder if some users
would be unhappy not to find out that somebody had moved to "Y" already.

-Peff
