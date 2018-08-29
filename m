Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22C8B1F428
	for <e@80x24.org>; Wed, 29 Aug 2018 23:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeH3Dop (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 23:44:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:33242 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727271AbeH3Doo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 23:44:44 -0400
Received: (qmail 26437 invoked by uid 109); 29 Aug 2018 23:45:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Aug 2018 23:45:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20646 invoked by uid 111); 29 Aug 2018 23:45:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 19:45:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 19:45:24 -0400
Date:   Wed, 29 Aug 2018 19:45:24 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: How is the ^{sha256} peel syntax supposed to work?
Message-ID: <20180829234524.GA15802@sigill.intra.peff.net>
References: <878t4xfaes.fsf@evledraar.gmail.com>
 <20180824014703.GE99542@aiede.svl.corp.google.com>
 <877ek9edsa.fsf@evledraar.gmail.com>
 <CAGZ79kaGb_TL7SiR4CFGFzrfy2Lotioy76o6sUK4=vZK5qwqNA@mail.gmail.com>
 <20180829175950.GB7547@aiede.svl.corp.google.com>
 <87zhx5c8wo.fsf@evledraar.gmail.com>
 <20180829191232.GC7547@aiede.svl.corp.google.com>
 <87y3cpc6bt.fsf@evledraar.gmail.com>
 <20180829204623.GD7547@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180829204623.GD7547@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 01:46:23PM -0700, Jonathan Nieder wrote:

> > Can you elaborate on that?
> 
> What I'm saying is, regardless of the syntax used, as a user I *need*
> a way to look up $some_hash as a sha256-name, with zero risk of Git
> trying to outsmart me and treating $some_hash as a sha1-name instead.
> 
> Any design without that capability is a non-starter.

Right, this is IMHO the only thing that makes sense for ^{hash} to do:
it disambiguates the sha1 that you just gave it. Nothing more, nothing
less.

> > I.e. if I'm using this in a script I'd need:
> >
> >     if x = git rev-parse $some_hash^{sha256}^{commit}
> >         hash = x
> >     elsif x = git rev-parse $some_hash^{sha1}^{commit}
> >         hash = x
> >     endif
> 
> Why wouldn't you use "git rev-parse $some_hash^{commit}" instead?

Yes, the sane rules seem to me to be:

  # try any available hash for $some_hash
  git rev-parse $some_hash

  # look _only_ for $some_hash as a sha1
  git rev-parse $some_hash^{sha1}

  # ditto for sha256
  git rev-parse $some_hash^{sha256}

  # ditto, but then peel the result to a commit
  git rev-parse $some_hash^{sha256}^{commit}

  # this is nonsense, and should produce an error
  git rev-parse $some_hash^{commit}^{sha256}

For convenience of scripts, we may also want:

  git rev-parse --input-hash=sha256 $some_hash

to pretend as if "^{sha256}" was appended to each command-line hash we
try to resolve (e.g., consider a case where a script is feeding 0 or
more hashes).

-Peff
