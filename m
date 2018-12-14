Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C998520A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 10:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbeLNKMe (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 05:12:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:41880 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726494AbeLNKMe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 05:12:34 -0500
Received: (qmail 25942 invoked by uid 109); 14 Dec 2018 10:12:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Dec 2018 10:12:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2384 invoked by uid 111); 14 Dec 2018 10:12:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 14 Dec 2018 05:12:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2018 05:12:32 -0500
Date:   Fri, 14 Dec 2018 05:12:32 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under
 GIT_TEST_PROTOCOL_VERSION=2
Message-ID: <20181214101232.GC13465@sigill.intra.peff.net>
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
 <20181213155817.27666-9-avarab@gmail.com>
 <87pnu51kac.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnu51kac.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 05:08:43PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Now that we have this maybe we should discuss why these tests show
> different things:
> 
> > diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> > index 086f2c40f6..8b1217ea26 100755
> > --- a/t/t5500-fetch-pack.sh
> > +++ b/t/t5500-fetch-pack.sh
> > @@ -628,7 +628,10 @@ test_expect_success 'fetch-pack cannot fetch a raw sha1 that is not advertised a
> >  	test_commit -C server 6 &&
> >
> >  	git init client &&
> > -	test_must_fail git -C client fetch-pack ../server \
> > +
> > +	# Other protocol versions (e.g. 2) allow fetching an unadvertised
> > +	# object, so run this test with the default protocol version (0).
> > +	test_must_fail env GIT_TEST_PROTOCOL_VERSION= git -C client fetch-pack ../server \
> >  		$(git -C server rev-parse refs/heads/master^) 2>err &&
> 
> What? So the equivalent of uploadpack.allowAnySHA1InWant=true is on for
> v2 all the time?

Yeah, I actually didn't realize it until working on the earlier series,
but this is the documented behavior:

  $ git grep -hC3 'want <oid>' Documentation/technical/protocol-v2.txt
  
  A `fetch` request can take the following arguments:
  
      want <oid>
  	Indicates to the server an object which the client wants to
  	retrieve.  Wants can be anything and are not limited to
  	advertised objects.

An interesting implication of this at GitHub (and possibly other
hosters) is that it exposes objects from shared storage via unexpected
repos. If I fork torvalds/linux to peff/linux and push up object X, a v0
fetch will (by default) refuse to serve it to me. But v2 will happily
hand it over, which may confuse people into thinking that the object is
(or at least at some point was) in Linus's repository.

-Peff
