Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789661F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389373AbfAOTr2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:47:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:37418 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728745AbfAOTr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:47:28 -0500
Received: (qmail 26410 invoked by uid 109); 15 Jan 2019 19:47:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Jan 2019 19:47:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13063 invoked by uid 111); 15 Jan 2019 19:47:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 15 Jan 2019 14:47:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2019 14:47:26 -0500
Date:   Tue, 15 Jan 2019 14:47:26 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] getenv() timing fixes
Message-ID: <20190115194726.GA5818@sigill.intra.peff.net>
References: <20190111221414.GA31335@sigill.intra.peff.net>
 <87va2u3yeu.fsf@evledraar.gmail.com>
 <CAGZ79kZrcC=SBrBR_4JDWu4Odgz-Uf7LrusiKNe6tgs02JeAMA@mail.gmail.com>
 <20190115191359.GC4886@sigill.intra.peff.net>
 <xmqqy37lra1j.fsf@gitster-ct.c.googlers.com>
 <20190115194142.GG4886@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115194142.GG4886@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 15, 2019 at 02:41:42PM -0500, Jeff King wrote:

> The more involved one (that doesn't pass along memory ownership) is
> something like:
> 
>   static struct hashmap env_cache;
> 
>   const char *getenv_safe(const char *name)
>   {
> 
> 	if (e = hashmap_get(&env_cache, name))
> 		return e->value;
> 
>         /* need some trickery to make sure xstrdup does not call getenv */
> 	e->value = xstrdup_or_null(getenv(name));
> 	e->name = xstrdup(name);
> 	hashmap_put(&env_cache, e);
> 
> 	return e->value;
>   }
> 
> with a matching setenv_safe() to drop the hashmap entry. Come to think
> of it, this is really pretty equivalent to string-interning, which we
> already have a hashmap for. I think one could argue that string
> interning is basically just a controlled form of memory leaking, but
> it's probably a reasonable compromise in this instance (i.e., we expect
> to ask about a finite number of variables anyway; the important thing is
> just that we don't leak memory for the same variable over and over).

So actually, that's pretty easy to do without writing much code at all.
Something like:

  #define xgetenv(name) strintern(getenv(name))

It means we're effectively storing the environment twice in the worst
case, but that's probably not a big deal. Unless we have a loop which
does repeated setenv()/getenv() calls, the strintern hashmap can't grow
without bound.

-Peff
