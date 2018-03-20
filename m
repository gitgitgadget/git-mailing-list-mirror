Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95ADF1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 02:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeCTCe3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 22:34:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:35300 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751343AbeCTCe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 22:34:27 -0400
Received: (qmail 23812 invoked by uid 109); 20 Mar 2018 02:34:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Mar 2018 02:34:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27910 invoked by uid 111); 20 Mar 2018 02:35:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Mar 2018 22:35:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Mar 2018 22:34:24 -0400
Date:   Mon, 19 Mar 2018 22:34:24 -0400
From:   Jeff King <peff@peff.net>
To:     Dakota Hawkins <dakota@dakotahawkins.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: .gitattributes override behavior (possible bug, or documentation
 bug)
Message-ID: <20180320023423.GA10143@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 09:49:28PM -0400, Dakota Hawkins wrote:

> Summary: Trying to apply attributes to file extensions everywhere
> except in one directory.
> 
> .gitattributes:
> 
>     *.[Pp][Nn][Gg] filter=lfs diff=lfs merge=lfs -text
>     /.readme-docs/ -filter=lfs -diff=lfs -merge=lfs
> 
> Make some data:
> 
>     echo "asldkjfa;sldkjf;alsdjf" > ./.readme-docs/test.png
>     git add -A

As you noted below, that second line does not match your path, because
attributes on a directory aren't applied recursively. And it has nothing
to do with overriding. If you remove the png line entirely, you can see
that we still do not match it. You need to use "*" to match the paths.

You may also find that "-diff=lfs" does not do quite what you want.
There is no way to say "cancel any previous attribute", which I think is
what you're trying for here. You can only override it with a new value.
So:

  /.readme-docs/* -diff

says "do not diff this". And:

  /.readme-docs/* diff

says "diff this as text, even if it looks binary".

The best you can probably do is:

  /.readme-docs/* diff=foo

Since you have no diff.foo.* config, that will behave in the default way
(including respecting the usual "is it binary" checks). So a bit hacky,
but I think it would work as "ignore prior diff".

And I think filter and merge drivers should work the same.

> Is this me misunderstanding something in the documentation? I would
> expect "./.readme-docs/" to match "./.readme-docs/test.png" and
> override the earlier "*.[Pp][Nn][Gg]" attributes.
>
> I have found the following overrides to work in lieu of the directory match:
> 
>     /.readme-docs/* -filter=lfs -diff=lfs -merge=lfs
>     /.readme-docs/**/* -filter=lfs -diff=lfs -merge=lfs
> 
> ...but I don't see a justification in the documentation for this
> working and the original directory filter not working.

I could not find anything useful in gitattributes(5). There's some old
discussion here:

  https://public-inbox.org/git/slrnkldd3g.1l4.jan@majutsushi.net/

which makes it clear that attributes aren't recursive, but it's probably
worth calling out in the documentation. In fact, I think the current
documentation is a bit misleading in that it says "patterns are matched
as in .gitignore", which is clearly not the case here.

I think just "/.readme-docs/**" should be sufficient for your case. You
could also probably write "*" inside ".readme-docs/.gitattributes",
which may be simpler (you don't need "**" there because patterns without
a slash are just matched directly against the basename).

-Peff
