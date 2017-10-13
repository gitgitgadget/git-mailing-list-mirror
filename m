Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D9C20437
	for <e@80x24.org>; Fri, 13 Oct 2017 12:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756659AbdJMMo7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 08:44:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:51980 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753276AbdJMMo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 08:44:58 -0400
Received: (qmail 18889 invoked by uid 109); 13 Oct 2017 12:44:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 12:44:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24896 invoked by uid 111); 13 Oct 2017 12:45:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 08:45:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 08:44:56 -0400
Date:   Fri, 13 Oct 2017 08:44:56 -0400
From:   Jeff King <peff@peff.net>
To:     Constantine <hi-angel@yandex.ru>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Mike Hommey <mh@glandium.org>, git <git@vger.kernel.org>
Subject: Re: git-clone causes out of memory
Message-ID: <20171013124456.qsbaol7txdgdb6wq@sigill.intra.peff.net>
References: <515b1400-4053-70b0-18e2-1f61ebc3b2d7@yandex.ru>
 <20171013100603.5eed26sjjigph2il@glandium.org>
 <CAP8UFD1KuBdUCo=x_q4__s1kW15CWMH1jJkKzXqmf3=T3jcrng@mail.gmail.com>
 <20171013103722.rvr7536mu2hoo4wb@glandium.org>
 <CAP8UFD3vniWZQ9Wb1oMo-bbj8n7CTjTHUNhBRwg6jN9x0+ApAQ@mail.gmail.com>
 <xmqqr2u7uuc8.fsf@gitster.mtv.corp.google.com>
 <2f9b8856-dacc-768d-32c2-985f5f145ba7@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f9b8856-dacc-768d-32c2-985f5f145ba7@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 03:12:43PM +0300, Constantine wrote:

> On 13.10.2017 15:04, Junio C Hamano wrote:
> > Christian Couder <christian.couder@gmail.com> writes:
> > 
> > > Yeah, but perhaps Git could be smarter when rev-listing too and avoid
> > > processing files or directories it has already seen?
> > 
> > Aren't you suggesting to optimize for a wrong case?
> > 
> 
> Anything that is possible with a software should be considered as a possible
> usecase. It's in fact a DoS attack. Imagine there's a server that using git
> to process something, and now there's a way to knock down this server. It's
> also bad from a promotional stand point.

But the point is that you'd have the same problem with any repository
that had 10^7 files in it. Yes, it's convenient for the attacker that
there are only 9 objects, but fundamentally it's pretty easy for an
attacker to construct repositories that have large trees (or very deep
trees -- that's what causes stack exhaustion in some cases).

Note too that this attack almost always comes down to the diff code
(which is why it kicks in for pathspec limiting) which has to actually
expand the tree. Most "normal" server-side operations (like accepting
pushes or serving fetches) operate only on the object graph and _do_
avoid processing already-seen objects.

As soon as servers start trying to checkout or diff, though, the attack
surface gets quite large. And you really need to start thinking about
having resource limits and quotas for CPU and memory use of each process
(and group by requesting user, IP, repo, etc).

I think the main thing Git could be doing here is to limit the size of
the tree (both width and depth). But arbitrary limits like that have a
way of being annoying, and I think it just pushes resource-exhaustion
attacks off a little (e.g., can you construct a blob that behaves badly
with the "--patch"?).

-Peff
