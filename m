Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34FF320C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 21:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbdFLVXx (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 17:23:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:38486 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbdFLVXw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 17:23:52 -0400
Received: (qmail 1910 invoked by uid 109); 12 Jun 2017 21:23:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 21:23:52 +0000
Received: (qmail 16328 invoked by uid 111); 12 Jun 2017 21:23:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 17:23:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jun 2017 17:23:50 -0400
Date:   Mon, 12 Jun 2017 17:23:50 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 00/32] repository object
Message-ID: <20170612212350.demwgog22liqae2p@sigill.intra.peff.net>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
 <20170609174034.61889ae8@twelve2.svl.corp.google.com>
 <20170610060712.foqre5fscaxu3tnx@sigill.intra.peff.net>
 <CAGZ79kbtZJd3O1vZBEkqU5_VRs5LmJhxUKtWu4RWTyk5M1r__Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbtZJd3O1vZBEkqU5_VRs5LmJhxUKtWu4RWTyk5M1r__Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 11, 2017 at 10:24:12PM -0700, Stefan Beller wrote:

> On Fri, Jun 9, 2017 at 11:07 PM, Jeff King <peff@peff.net> wrote:
> > On Fri, Jun 09, 2017 at 05:40:34PM -0700, Jonathan Tan wrote:
> >
> >> Before I get into the details, I have some questions:
> >>
> >> 1. I am concerned that "struct repository" will end up growing without
> >> bounds as we store more and more repo-specific concerns in it. Could it
> >> be restricted to just the fields populated by repo_init()?
> >> repo_read_index() will then return the index itself, instead of using
> >> "struct repository" as a cache. This means that code using
> >> repo_read_index() will need to maintain its own variable holding the
> >> returned index, but that is likely a positive - it's better for code to
> >> just pass around the specific thing needed between functions anyway, as
> >> opposed to passing a giant "struct repository" (which partially defeats
> >> the purpose of eliminating the usage of globals).
> >
> > I think the repository object has to become a kitchen sink of sorts,
> > because we have tons of global variables representing repo-wide config.
> 
> AFAICT we want to operate on struct 'the_repo' and struct 'the_cmd_options'
> eventually. In our use case of submodules the submodules would ignore the
> settings of the main repo, but still accept guidance of the_cmd_config or
> 'the_config.
> 
> > So I have a feeling that we're always going to need some
> > big object to hold all that context when doing multi-repo operations in
> > a single process.
> 
> Well not just one big struct, but two. (or more?)

Right, I think you could have a separate kitchen-sink struct that isn't
the "repo" one. But now you have to pass both of those around, which is
going to get cumbersome. Almost every function is going to end up
passing around the context struct.

I almost think it would be easier to shove them all of the context into
a big global struct and "push" and "pop" contexts from a stack of
structs. That gets you the in-process benefits, though of course it's
absolutely horrible if you ever want to multi-thread across two contexts.

-Peff
