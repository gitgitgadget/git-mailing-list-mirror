Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612F420958
	for <e@80x24.org>; Wed, 29 Mar 2017 18:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932323AbdC2SMj (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 14:12:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:53702 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932180AbdC2SMe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 14:12:34 -0400
Received: (qmail 28148 invoked by uid 109); 29 Mar 2017 18:12:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Mar 2017 18:12:31 +0000
Received: (qmail 24439 invoked by uid 111); 29 Mar 2017 18:12:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Mar 2017 14:12:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Mar 2017 14:12:29 -0400
Date:   Wed, 29 Mar 2017 14:12:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        stefan.naewe@atlas-elektronik.com
Subject: Re: [PATCH v3] perl: regenerate perl.mak if perl -V changes
Message-ID: <20170329181228.n4t77pashdnirl3a@sigill.intra.peff.net>
References: <39b203e9-c3a9-80c3-ec24-649e04ef5620@atlas-elektronik.com>
 <20170329135703.18860-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170329135703.18860-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2017 at 01:57:03PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Change the perl/perl.mak build process so that the file is regenerated
> if the output of "perl -V" changes.
> 
> Before this change updating e.g. /usr/bin/perl to a new major version
> would cause the next "make" command to fail, since perl.mak has
> hardcoded paths to perl library paths retrieved from its first run.

This is one of those things that has been bugging me for years, but it
comes up so rarely that I have never dug into it.

> Now the logic added in commit ee9be06770 ("perl: detect new files in
> MakeMaker builds", 2012-07-27) is extended to regenerate
> perl/perl.mak if there's any change to "perl -V".

Nice. This fix is way simpler than I feared.

> This will in some cases redundantly trigger perl/perl.mak to be
> re-made, e.g. if @INC is modified in ways the build process doesn't
> care about through sitecustomize.pl, but the common case is that we
> just do the right thing and re-generate perl/perl.mak when needed.

I think that's fine. There's a related bug that the generation of
perl/perl.mak via recursive-make is sometimes racy. So that _might_
trigger more often as a result of this, but I think the solution is to
fix that race, not try to pretend it won't happen. :)

-Peff
