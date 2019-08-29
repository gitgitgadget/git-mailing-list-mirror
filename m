Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D40C11F461
	for <e@80x24.org>; Thu, 29 Aug 2019 13:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfH2Nok (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 09:44:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:32860 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727066AbfH2Nok (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 09:44:40 -0400
Received: (qmail 23620 invoked by uid 109); 29 Aug 2019 13:44:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Aug 2019 13:44:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23009 invoked by uid 111); 29 Aug 2019 13:46:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2019 09:46:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Aug 2019 09:44:39 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jon Simons <jon@jonsimons.org>, git@vger.kernel.org,
        me@ttaylorr.com
Subject: Re: [PATCH 2/2] list-objects-filter: handle unresolved sparse filter
 OID
Message-ID: <20190829134439.GA1797@sigill.intra.peff.net>
References: <20190828201824.1255-1-jon@jonsimons.org>
 <20190828201824.1255-3-jon@jonsimons.org>
 <164fa8bc-bcf1-4cce-1b49-94b64535d332@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <164fa8bc-bcf1-4cce-1b49-94b64535d332@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 09:12:38AM -0400, Derrick Stolee wrote:

> > +test_expect_success 'partial clone with unresolvable sparse filter fails cleanly' '
> > +	test_must_fail git clone --no-local --no-checkout --filter=sparse:oid=master:sparse-filter "file://$(pwd)/sparse-src" sc1 2>err &&
> > +	test_i18ngrep "unable to read sparse filter specification from sparse:oid=master:sparse-filter" err &&
> > +	test_must_fail git clone --no-local --no-checkout --filter=sparse:oid=master "file://$(pwd)/sparse-src" sc2 2>err &&
> > +	test_i18ngrep "unable to parse sparse filter data in $(git -C sparse-src rev-parse master)" err
> 
> Just as a sanity check: when we use test_i18ngrep, how does it know how to
> separate the part that is translated and which part is not?
> 
> 	translated: "unable to read sparse filter specification from"
> 	not translated: "sparse:oid=master"

It doesn't know. By default we run the suite in LOCALE=C and it checks
the whole string. Under a GETTEXT_POISON build, it checks nothing at
all.

The poison stuff is really about helping people not accidentally mark a
plumbing string (that we expect to get parsed by a machine) as
translatable. So the idea is you'd build with GETTEXT_POISON and then
run the test suite to see if anything breaks. But that means we also
have to annotate the test suite with "yes, I know this will be gibberish
in a poison build, but that's OK because it's meant for humans". And
that's what test_i18ngrep is.

test_i18ngrep could be more clever about matching the gibberish, but
there's not much point. The LOCALE=C run already covered the correctness
of checking the message.

-Peff
