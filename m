Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 359361F405
	for <e@80x24.org>; Sun, 16 Dec 2018 10:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbeLPKkT (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 05:40:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:43234 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726164AbeLPKkT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 05:40:19 -0500
Received: (qmail 23956 invoked by uid 109); 16 Dec 2018 10:40:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Dec 2018 10:40:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22301 invoked by uid 111); 16 Dec 2018 10:39:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 16 Dec 2018 05:39:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Dec 2018 05:40:17 -0500
Date:   Sun, 16 Dec 2018 05:40:17 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        bwilliamseng@gmail.com
Subject: Re: [PATCH 0/3] protocol v2 and hidden refs
Message-ID: <20181216104017.GB13704@sigill.intra.peff.net>
References: <20181211104236.GA6899@sigill.intra.peff.net>
 <20181213195305.249059-1-jonathantanmy@google.com>
 <20181214083507.GB11777@sigill.intra.peff.net>
 <87d0q21s8w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0q21s8w.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 15, 2018 at 08:53:35PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > So I'm a bit worried that the unified endpoint model is going to be a
> > dead end, at which point carrying around git-serve just makes things
> > more complicated.
> 
> This is from wetware memory of something discussed at a previous Git
> Merge, so I may have (inadvertently) made it up, but wasn't part of the
> idea of "git-serve" to have an extensible next-gen protocol where we
> could add new actions & verbs unrelated to sending or receiving packs?

Yes, I think that's a goal (and we already have upload-archive, which is
a similar thing).

> Of course that's not in itself an argument for having a general "serve"
> command, actually the opposite for the reasons you mention with locking
> down things. E.g. maybe I want to support server-side git-grep on my
> server, but not git-log, and if it's one command it becomes a hassle to
> do that via SSH config or HTTPD config for the reasons you mention.

Right, exactly. It pushes more of the information down into Git's own
protocol. Of course we _can_ build mechanisms at that level for
configuring which verbs are allowed. But if some context is available at
the higher protocol level, then we can use the mechanisms at that higher
level.

I think of it as a tradeoff. By including the endpoint in the transport
protocol (e.g., in ssh the command name, in HTTP the URL), we get to use
the mechanisms in those transports to make policy decisions on the
server. But it also means we _have_ to implement those policies twice,
once per transport.

IMHO having to deal with both transports is not that big a loss,
considering that there are only two, and really not likely to be more.
git:// is already unauthenticated, and IMHO is mostly a dead-end for
future protocol work since it provides no advantage over HTTP, and the
future is mostly HTTP, with ssh for people who really prefer its
authentication mode.

> The upside would be that once a host understands "git serve" I'm more
> likely to be able to get past whatever middle layer there is between my
> client and the "git" binary on the other side. E.g. if I have a newly
> compiled "git" client/server binary, but something like GitLab's
> "gitaly" sitting between the two of us.

But I think that's what makes it dangerous, too. :)

Gitaly (and we have our own equivalent at GitHub) is responsible for
making those policy decisions about who can run what. Opening a pipe
between the client and the backend that can issue arbitrary verbs is
exactly what they _don't_ want to do.

So they have to intercept the conversation at least at the verb level.
It _is_ nice if conversation for each verb is standardized (so once a
verb is issued, they can just step out of the way and proxy bytes[1]),
and v2 helps with that.

That's not too hard for a Git-aware endpoint to implement.  But when
that verb interception can be done at the HTTP/ssh level, then it's easy
for tools that _aren't_ Git-aware to do handle it (again, like the
Apache config we recommend in git-http-backend(1)).

-Peff

[1] Actually, we do much more intimate interception than that at GitHub
    already. The upload-pack conversation is mostly vanilla, but for
    receive-pack we handle replication at that layer. So your pack is
    streamed to 3-6 backend receive-packs simultaneously, and that
    endpoint layer handles quorum for updating refs, etc.
