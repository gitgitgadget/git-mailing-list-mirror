Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311A61F461
	for <e@80x24.org>; Fri, 17 May 2019 22:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfEQWUe (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 18:20:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:32810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727843AbfEQWUd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 18:20:33 -0400
Received: (qmail 5210 invoked by uid 109); 17 May 2019 22:20:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 May 2019 22:20:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17889 invoked by uid 111); 17 May 2019 22:21:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 17 May 2019 18:21:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 May 2019 18:20:31 -0400
Date:   Fri, 17 May 2019 18:20:31 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git ransom campaign incident report - May 2019
Message-ID: <20190517222031.GA17966@sigill.intra.peff.net>
References: <CACPiFCJdXsrywra8qPU3ebiiGQP3YPC6g-_Eohbfwu_bQgfyVg@mail.gmail.com>
 <8736lfwnks.fsf@evledraar.gmail.com>
 <20190516042739.GH4596@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905172121130.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1905172121130.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 17, 2019 at 09:39:55PM +0200, Johannes Schindelin wrote:

> > Of course I suspect there are many cases where people _do_ need to store
> > the password in plaintext, because an automated system needs to fetch
> > with it. They can use the plaintext git-credential-store, but it's
> > slightly more hassle. And it doesn't really _solve_ the problem (though
> > perhaps it would be harder to accidentally expose it with your web
> > server!).
> 
> One thing that we actually *could* do here is to anonymize the URLs stored
> under remote.origin.url when cloning. In no other circumstance that I can
> think of do we take an URL from some command-line parameter that is not
> *explicitly* intended for storing in the config.

Good point. That's a plausible way that these end up in config even when
they're not needed and it wasn't intended by the user.

> Combined with that warning "You cloned via a URL that contains
> credentials; for security reasons, the credentials were scrubbed before
> storing this in your Git config. Please consider using a credential
> manager instead of storing secrets in your Git config." this should
> provide a reasonable compromise.

Yeah, we'd definitely want to warn the user. Some people might find it
irritating because a follow-up fetch would require an interactive
password. We might need to make sure the escape hatch is pretty turnkey.
The simplest thing is just a "--save-password" option to override this,
but it would be nice if there's an out-of-the-box solution with a
credential helper.

We can use credential-store as a general solution. That's still
sticking the password in the filesystem in plaintext, but the file is
0700 by default, and it's not in the repo directory).

Unfortunately converting:

  git clone https://user@pass:example.com/repo.git

into a safer use of credential-store is a little tricky, because seeding
the store is generally only done interactively. What if we did this:

  1. Do not ever write the password part of a URL into config.

  2. When we extract the user/pass out of a URL, put them into the
     credential struct, so that when we successfully authenticate, we
     trigger storage. This _might_ actually happen already, but we
     should definitely confirm it.

  3. If the user has no credential helper defined, then do one of:

     a. Warn them that the credential was not recorded, but that they
        can use "git clone -c credential.helper=store" as a fallback
	(but probably worded in a way to recommend using something
	stronger if possible).

	This is slightly annoying because following the advice requires
	re-cloning. Fixing it up from there is more like:

	  git config credential.helper store
	  git fetch
	  [interactively input password]

     b. Just use credential-store. Optionally notify them of what
         happened (and that they might want to choose a better helper).

I hate the magical-ness of 3b, because credential-store really _isn't_
the best choice. It's just better than the current behavior. At the same
time, by doing it automatically, the existing flow they were using just
works, and is moderately better.

> Judging from looking at my own automated jobs, it does not appear that you
> would *ever* need to store such credentials in the Git config, anyway. If
> you need to, say, push to a repository, you can always store the full URL
> (or the credentials) in a secret variable.

Yes, that's definitely the way you _should_ do it. I think the problem
is that handling secret storage is tricky and system-specific, and the
people who are affected here are ones who just didn't think about it. If
we can make even a moderate improvement without the user having to do
anything differently, it's worth considering.

-Peff
