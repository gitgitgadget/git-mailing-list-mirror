Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA3220401
	for <e@80x24.org>; Wed, 21 Jun 2017 19:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbdFUTo2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 15:44:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:47922 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751041AbdFUTo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 15:44:27 -0400
Received: (qmail 7189 invoked by uid 109); 21 Jun 2017 19:44:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Jun 2017 19:44:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26854 invoked by uid 111); 21 Jun 2017 19:44:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jun 2017 15:44:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jun 2017 15:44:25 -0400
Date:   Wed, 21 Jun 2017 15:44:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Tim Hutt <tdhutt@gmail.com>, git@vger.kernel.org
Subject: Re: Monitoring a repository for changes
Message-ID: <20170621194425.vcu6qdmoddwpi3ht@sigill.intra.peff.net>
References: <CAKuVd4Bdhreu6wrwDp1Bia56Db=TXYMQcitsznaRM+QcYVzJnQ@mail.gmail.com>
 <87efud8jrn.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87efud8jrn.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 05:04:12PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > In terms of implementation, the HTTP transport could use Server-Sent
> > Events, and the SSH transport can pretty much do whatever so that
> > should be easy.
> 
> In case you didn't know, any of the non-trivially sized git hosting
> providers (e.g. github, gitlab) provide you access over ssh, but you
> can't just run any arbitrary command, it's a tiny set of whitelisted
> commands. See the "git-shell" manual page (github doesn't use that exact
> software, but something similar).

These days you don't even hit the actual fileservers with ssh at all.
We terminate all of the protocols (http, git://, and ssh) at a proxy
layer that kicks off git commands in the actual repositories using a
separate protocol. The ssh handshakes were a huge performance
bottleneck, so by doing it that way we can scale out the front-end tier
independently of the repository storage (and of course it also provides
a convenient layer for mapping user visible repository names into
sharded paths).

Not to take away from your point. Just a little bit of trivia.

> But overall, it would be nice to have some rationale for this approach
> other than that you think polling is ugly. There's a lot of advantages
> to polling for something you don't need near-instantly, e.g. imagine how
> many active connections a site like GitHub would need to handle if
> something like this became widely used, that's in a lot of ways harder
> to scale and load balance than just having clients that poll something
> that's trivially cached as static content.

Yeah. The naive way to implement this would be to have the client
connect and receive the ref advertisement. And then when it's a noop
(nothing to fetch), instead of saying "I want these objects", say
"Please pause until one or more refs change". But I don't think we'd
want to leave actual upload-pack processes sitting paused on the server.
Their memory usage is too high.

For this kind of "long polling" we have a separate front-end tier with a
daemon that keeps the per-client cost very low. We could possibly wedge
that into our proxy layer, but the system would be a lot simpler and
more flexible if this were done separately from the actual git protocol.
E.g., if an HTTP endpoint were defined that paused and returned data
only when a particular repository's refs were updated.

Another option is to keep polling, but just make noop fetches a lot
cheaper. The ref advertisement on some repositories can get into the
megabytes. I'd love to see protocol extensions for:

  1. The client asking only for bits of the ref namespace they care
     about. I have some preliminary patches for this, but I really need
     to polish them.

  2. Something ETag-ish where the client can say "I already saw state X,
     do you have updates?" Even just handling "no, no updates" (like an
     ETag) would be a big benefit. Bonus points if it can say "since
     state X, these are the changes; you are now at state Y".

The sticking point on both is that the client needs to speak before the
ref advertisement begins, which is why we have to deal with the protocol
v2 headache.

-Peff
