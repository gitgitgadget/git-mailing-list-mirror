Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270D2207F8
	for <e@80x24.org>; Wed,  3 May 2017 20:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757495AbdECUWe (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 16:22:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:44878 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756493AbdECUWc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 16:22:32 -0400
Received: (qmail 14469 invoked by uid 109); 3 May 2017 20:22:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 May 2017 20:22:27 +0000
Received: (qmail 27916 invoked by uid 111); 3 May 2017 20:22:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 May 2017 16:22:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 May 2017 16:22:24 -0400
Date:   Wed, 3 May 2017 16:22:24 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: git-clone --config order & fetching extra refs during initial
 clone
Message-ID: <20170503202224.arjszzbruxjgpkt5@sigill.intra.peff.net>
References: <robbat2-20170225T185056-448272755Z@orbis-terrarum.net>
 <20170225205052.j3p7obbf4onf6cbf@sigill.intra.peff.net>
 <xmqqd1e3xx4c.fsf@gitster.mtv.corp.google.com>
 <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
 <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>
 <20170315170829.7gp44typsyrlw6kg@sigill.intra.peff.net>
 <CAM0VKjnjMEThuMvLEQByxWvxVvdzMSVsFKKstKLMweEx5UwTcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjnjMEThuMvLEQByxWvxVvdzMSVsFKKstKLMweEx5UwTcg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 03, 2017 at 04:42:58PM +0200, SZEDER Gábor wrote:

> write_refspec_config() nicely encapsulates writing the proper fetch
> refspec configuration according to the given command line options.  Of
> course these options are already known right at the start, so solely
> in this regard we could call this function earlier.  However, in some
> cases, e.g. '--single-branch', the refspec to be written to the config
> depends not only on the given options but on the refs in the remote
> repository, too, so it can only be written after we got the remote's
> refs.

Good point. We can't really consider clone to be a blind "init + config
+ fetch + checkout" because those middle two steps sometimes overlap
each other.  It really does need to be its own beast.

> The root issue is that 'git clone' calls directly into the fetch
> machinery instead of running 'git fetch' (either via run_command() or
> cmd_fetch()), and some of these "higher-level" config variables are
> only handled in 'builtin/fetch.c' but not in 'git clone'.  By
> "handle" I mean "parse and act accordingly": as it happens, these
> config values are parsed alright when 'git clone' calls remote_get(),
> but it never looks at the relevant fields in the resulting 'struct
> remote'.
> 
> Luckily, many "lower-level" config variables are working properly even
> during 'git clone', because they are handled in the transport layer,
> e.g. 'git clone -c url.https://github.com/.insteadof=gh: gh:git/git'
> does the right thing.

Yeah, and I think that insteadOf is working as intended there (clone
sets it early enough that all of the rest of the code sees it). And the
bug is just that there's special handling in builtin/fetch.c that clone
needs to replicate.

The right solution there is probably pushing that logic down into the
transport layer. Or at the very least abstracting it into a function so
that both clone and fetch can call it without replicating the logic.

> My patch deals with 'remote.<name>.refspec', i.e. 'remote->fetch'.
> Apparently some extra care is necessary for 'remote.<name>.tagOpt' and
> 'remote->fetch_tags', too.  Perhaps there are more, I haven't checked
> again, and maybe we'll add similar config variables in the future.  So
> I don't think that dealing with such config variables one by one in
> 'git clone', too, is the right long-term solution...  but perhaps it's
> sufficient for the time being?

I think your patch is a strict improvement and we don't need to hold up
waiting for a perfect fix (and because of the --single-branch thing you
mentioned, this may be the best we can do anyway).

> Running a fully-fledged 'git fetch' seems to be simpler and safer
> conceptually, as it would naturally handle all fetch-related config
> variables, present and future.  However, it's not without drawbacks:
> 'git clone' must set the proper config before running 'git fetch' (or
> at least set equivalent cmdline options), which in some cases requires
> the refs in the remote repository, making an additional "list remote
> refs" step necessary (i.e. both 'clone' and 'fetch' would have to
> retrieve the refs from the remote, resulting in more network I/O).

I don't think we ever want to request two ref advertisements; they're
too expensive. If clone needs to do work between the advertisement and
the actual fetch (and it sounds like it does), then it should be using
the transport layer directly. Which is what it's already doing.

-Peff
