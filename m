Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF81F20C11
	for <e@80x24.org>; Thu, 30 Nov 2017 21:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbdK3VbI (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 16:31:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:44864 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750747AbdK3VbH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 16:31:07 -0500
Received: (qmail 24393 invoked by uid 109); 30 Nov 2017 21:31:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Nov 2017 21:31:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32537 invoked by uid 111); 30 Nov 2017 21:31:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 30 Nov 2017 16:31:26 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Nov 2017 16:31:05 -0500
Date:   Thu, 30 Nov 2017 16:31:05 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>
Subject: Re: [PATCH] Makefile: replace perl/Makefile.PL with simple make rules
Message-ID: <20171130213105.GA8861@sigill.intra.peff.net>
References: <20171129153436.24471-1-avarab@gmail.com>
 <20171129195430.10069-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171129195430.10069-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 29, 2017 at 07:54:30PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Replace the perl/Makefile.PL and the fallback perl/Makefile used under
> NO_PERL_MAKEMAKER=NoThanks with a much simpler implementation heavily
> inspired by how the i18n infrastructure's build process works[1].

I'm very happy to see the recursive make invocation go away. The perl
makefile generation was one of the few places where parallel make could
racily get confused (though I haven't seen that for a while, so maybe it
was fixed alongside some of the other .stamp work you did).

> The reason for having the Makefile.PL in the first place is that it
> was initially[2] building a perl C binding to interface with libgit,
> this functionality, that was removed[3] before Git.pm ever made it to
> the master branch.

Thanks for doing all this history digging. I agree that it doesn't seem
like there's really any reason to carry the complexity. Of your
functional changes, the only one that gives me pause is:

>  * This will not always install into perl's idea of its global
>    "installsitelib". This only potentially matters for packagers that
>    need to expose Git.pm for non-git use, and as explained in the
>    INSTALL file there's a trivial workaround.

This could be a minor hiccup for people using Git.pm from other scripts.
But maybe only in funny setups? It seems like $prefix/share/perl5 would
be in most people's @INC unless they are doing something exotic.

>  * We don't build the Git(3) Git::I18N(3) etc. man pages from the
>    embedded perldoc. I suspect nobody really cares, these are mostly
>    internal APIs, and if someone's developing against them they likely
>    know enough to issue a "perldoc" against the installed file to get
>    the same result.

I don't have a real opinion on this, but it sounds from the rest of the
thread like we should maybe build these to be on the safe side.

> @@ -2291,6 +2273,17 @@ endif
>  po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
>  	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
>  
> +PMFILES := $(wildcard perl/*.pm perl/*/*.pm perl/*/*/*.pm perl/*/*/*/*.pm)

Yuck. :) I don't think there's a better wildcard solution within make,
though. And I'd rather see this than doing a $(shell) to "find" or
similar.

The other option is to actually list the files, as we do for .o files.
That's a minor pain to update, but it would allow things like
differentiating which ones get their documentation built.

> +PMCFILES := $(patsubst perl/%.pm,perl/build/%.pmc,$(PMFILES))

TIL about pmc files. It sounds like they've had a storied history, but
should be supported everywhere.

> [...]

The rest of the patch all looked good to me. Thanks for working on this.

-Peff
