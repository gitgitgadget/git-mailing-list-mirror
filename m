Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE9D20954
	for <e@80x24.org>; Wed, 22 Nov 2017 23:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbdKVXZA (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 18:25:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:38164 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751525AbdKVXY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 18:24:59 -0500
Received: (qmail 7274 invoked by uid 109); 22 Nov 2017 23:24:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Nov 2017 23:24:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5614 invoked by uid 111); 22 Nov 2017 23:25:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 22 Nov 2017 18:25:15 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Nov 2017 18:24:57 -0500
Date:   Wed, 22 Nov 2017 18:24:57 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 0/3] Introduce BUG_ON(cond, msg) MACRO
Message-ID: <20171122232457.GA8577@sigill>
References: <20171122223827.26773-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171122223827.26773-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 02:38:24PM -0800, Stefan Beller wrote:

> On reviewing [1] I wondered why there are so many asserts and wondered
> if these asserts could have been prevented by a better functionality around
> bug reporting in our code.
> 
> Introduce a BUG_ON macro, which is superior to assert() by
>  * being always there, even when compiled with NDEBUG and
>  * providind an additional human readable error message, like BUG()

I'm not sure I agree with the aim of the series.

If people want to compile with NDEBUG, that's their business, I guess.
I don't see much _point_ in it for Git, since most of our assertions do
not respect NDEBUG, and I don't think we tend to assert in expensive
ways anyway.

I do like human readable messages. But sometimes such a message just
makes the code harder to read (and to write). E.g., is there any real
value in:

  BUG_ON(!foo, "called bar() with a foo!");

over:

  assert(foo);

? The error message you'd get from the latter is rather sparse, but the
file and line number information it contains should be enough to find
the original source line. And after all, it's not _supposed_ to happen,
so if it does you're likely going to need to dig into the source anyway.

The human-readable BUG messages I find useful add some context or
summarize the situation. E.g. (pulled from random grepping):

  BUG: color parsing ran out of space

is way better than:

  assert failed: len < 2

Likewise, in this code:

  if (hashmap_put(map, alloc_ref_store_hash_entry(name, refs)))
	die("BUG: %s ref_store '%s' initialized twice", type, name);

we get a lot of extra information:

  - the type is mentioned
  - the name variable is dereferenced
  - the implication of "initialized twice" is made clear by the author,
    which would not be immediately obvious just from seeing the failed
    call

So I _like_ good messages, but I also think a lot of assertions don't
really lend themselves to good messages. And we should shoot for just
making them easy to read and write.

I also find (as your third patch switches):

  if (!foo)
	BUG("foo has not been setup");

more readable than the BUG_ON() version, if only because it uses
traditional control flow. But that may just be because I'm used to it.
I'm sure kernel folks are used to BUG_ON() at this point, and we'd grow
used to it, too.

-Peff
