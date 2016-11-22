Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87C01FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 21:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933238AbcKVVYU (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 16:24:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:46342 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932436AbcKVVYT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 16:24:19 -0500
Received: (qmail 19500 invoked by uid 109); 22 Nov 2016 21:24:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 21:24:19 +0000
Received: (qmail 32386 invoked by uid 111); 22 Nov 2016 21:24:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 16:24:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Nov 2016 16:24:16 -0500
Date:   Tue, 22 Nov 2016 16:24:16 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 2/3] stripspace: respect repository config
Message-ID: <20161122212416.kv5srurlnidqufqr@sigill.intra.peff.net>
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
 <5567548295222401fab10d3f2901c1787afbfd07.1479737858.git.johannes.schindelin@gmx.de>
 <CACsJy8D5oBR+vo2B+Ro2Q4SX0CG3jME4Gfs1_6AohccmpNvD0A@mail.gmail.com>
 <alpine.DEB.2.20.1611221712480.3746@virtualbox>
 <xmqqshqjqw3z.fsf@gitster.mtv.corp.google.com>
 <xmqqzikrpbz2.fsf@gitster.mtv.corp.google.com>
 <20161122195015.rztaixpz7zvdxb4u@sigill.intra.peff.net>
 <xmqqoa17p8k0.fsf@gitster.mtv.corp.google.com>
 <20161122211920.3qdohxdktykqhyga@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161122211920.3qdohxdktykqhyga@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2016 at 04:19:20PM -0500, Jeff King wrote:

> > > Do you want to do another round of -rc3? Ship with the
> > > minor regressions and fix them up in v2.11.1?
> > 
> > I am leaning towards the former (though we may also end up doing the
> > latter).
> 
> I think I'd lead towards -rc3, as well. Our schedule is somewhat

I meant s/lead/lean/, of course.

> Something like this, which does all but the last (and that should
> probably happen separately post-release).

As usual, I'm utterly confused by the $(pwd) versus $PWD thing. So let
me review what I did to see if it makes sense. :)

> +# run "$@" inside a non-git directory
> +nongit () {
> +	test -d non-repo ||
> +	mkdir non-repo ||
> +	return 1
> +
> +	(
> +		GIT_CEILING_DIRECTORIES=$(pwd) &&
> +		export GIT_CEILING_DIRECTORIES &&
> +		cd non-repo &&
> +		"$@"
> +	)
> +}

I copied this bit from t1515, which sets up a similar scenario. I think
it _probably_ works either way because of the environment-variable
conversion magic that Windows bash does.

> +test_expect_success 'git archive --remote outside of a git repo' '
> +	git archive HEAD >expect.tar &&
> +	nongit git archive --remote="$PWD" HEAD >actual.tar &&
> +	test_cmp_bin expect.tar actual.tar
> +'

I'm not sure if it matters here. I almost wrote $TRASH_DIRECTORY, but
that I think is in the same form as $PWD. Either would be fine.

-Peff
