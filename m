Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1EC91F453
	for <e@80x24.org>; Thu, 17 Jan 2019 16:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfAQQpJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 11:45:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:39952 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728618AbfAQQpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 11:45:09 -0500
Received: (qmail 30860 invoked by uid 109); 17 Jan 2019 16:45:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Jan 2019 16:45:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1890 invoked by uid 111); 17 Jan 2019 16:45:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 17 Jan 2019 11:45:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jan 2019 11:45:07 -0500
Date:   Thu, 17 Jan 2019 11:45:07 -0500
From:   Jeff King <peff@peff.net>
To:     Dmitriy Smirnov <dmitriy.smirnov@jetbrains.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org,
        Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
        Aleksey Pivovarov <aleksey.pivovarov@jetbrains.com>
Subject: Re: git add =?utf-8?B?4oCUaWdub3JlLWVycm9y?= =?utf-8?Q?s?= causes
 --renormalize
Message-ID: <20190117164507.GA27819@sigill.intra.peff.net>
References: <401130AF-056B-40BF-8001-8492223B8A6B@jetbrains.com>
 <20190117162711.GA7935@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117162711.GA7935@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 17, 2019 at 11:27:11AM -0500, Jeff King wrote:

> -- >8 --
> Subject: [PATCH] add: use separate ADD_CACHE_RENORMALIZE flag
> 
> Commit 9472935d81 (add: introduce "--renormalize", 2017-11-16) taught
> git-add to pass HASH_RENORMALIZE to add_to_index(), which then passes
> the flag along to index_path(). However, the flags taken by
> add_to_index() and the ones taken by index_path() are distinct
> namespaces. We cannot take HASH_* flags in add_to_index(), because they
> overlap with the ADD_CACHE_* flags we already take (in this case,
> HASH_RENORMALIZE conflicts with ADD_CACHE_IGNORE_ERRORS).
> 
> We can solve this by adding a new ADD_CACHE_RENORMALIZE flag, and using
> it to set HASH_RENORMALIZE within add_to_index(). In order to make it
> clear that these two flags come from distinct sets, let's also change
> the name "newflags" in the function to "hash_flags".

By the way, I wondered if there was a good way for the compiler to help
us find an error like this. There's no type-checking here, since all of
the flags are "int", with the values #define macros. Could enums give us
better safety?

My experiments suggest no, since the compiler is pretty loose about what
it will allow, even with -Wenum-compare. In particular, I think it's
happy to allow bitwise-AND even against tags from other enums. But if
somebody can figure out a way to make it work, I'm all ears. :)

A more drastic option is to replace the flag int with a struct
containing a bitfield. I.e., something like:

  struct add_cache_flags {
	unsigned ignore_errors : 1;
	unsigned renormalize : 1;
	... etc ...
  };

That gives us real type safety and eliminates the need to manually
assign numbers to each flag. But there are downsides:

  - it's syntactically more awkward to modify the flags. I.e.:

      foo(flags | BAR);

    becomes:

      struct flags new_flags = old_flags;
      new_flags.bar = 1;
      foo(&new_flags);

    There might be some C99-isms that can help us out (though I suspect
    not completely -- even if we can use anonymous structs, I don't
    think there's such a thing as "initialize this anonymous struct and
    then modify these fields").

  - there's no grouping, so you can't mask off certain values

So I dunno. Maybe that road is too painful, and we're stuck with what C
gives us.

-Peff
