Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53111207BD
	for <e@80x24.org>; Wed, 19 Apr 2017 03:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759366AbdDSDSq (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 23:18:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:35760 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759312AbdDSDSo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 23:18:44 -0400
Received: (qmail 31125 invoked by uid 109); 19 Apr 2017 03:18:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Apr 2017 03:18:42 +0000
Received: (qmail 18549 invoked by uid 111); 19 Apr 2017 03:19:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 23:19:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Apr 2017 23:18:39 -0400
Date:   Tue, 18 Apr 2017 23:18:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1] diffcore-rename: speed up register_rename_src
Message-ID: <20170419031839.m2zgwywa2soejiqk@sigill.intra.peff.net>
References: <20170418194421.22453-1-git@jeffhostetler.com>
 <20170418194421.22453-2-git@jeffhostetler.com>
 <20170419013214.q35jarvmk5jhqdyi@sigill.intra.peff.net>
 <xmqqd1c9cdzi.fsf@gitster.mtv.corp.google.com>
 <20170419025608.xy5nvso6k6lb5z7g@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170419025608.xy5nvso6k6lb5z7g@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 10:56:08PM -0400, Jeff King wrote:

> > When adding many things, we often just append and then sort at the
> > end after we finished adding.  I wonder if recent "check the last
> > one and append" optimization beats that strategy.
> 
> The big question is whether we need to detect duplicates while we're
> appending to the list, which is hard on an unsorted list.  In this
> function, at least, we do detect when the path already exists and return
> the existing entry. I'm not sure under what circumstances we would see
> such a duplicate, though, as each filename should appear only once in
> the tree diff. I would think.
> 
> Doing:
> 
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index f7444c86b..56a493d97 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -86,7 +86,7 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
>  		struct diff_rename_src *src = &(rename_src[next]);
>  		int cmp = strcmp(one->path, src->p->one->path);
>  		if (!cmp)
> -			return src;
> +			die("BUG: duplicate rename src: %s", one->path);
>  		if (cmp < 0) {
>  			last = next;
>  			continue;
> 
> passes the test suite, at least. :)

Maybe relevant: 4d6be03b9 (diffcore-rename: avoid processing duplicate
destinations, 2015-02-26). That's on the dst side, but possibly we
should do something similar on the src side.

BTW, I think the return value from register_rename_src() is
questionable. It points to a "struct diff_rename_src" that may be
reallocated by further calls to the function. Fortunately nobody
actually looks at it, let alone saves it, so there's no bug.

We may want to convert that return value to a void (if not just return
an int for "hey, there's a duplicate", like we do for add_rename_dst()).

Also, presumably that function could learn the same "check the last one"
trick that the src side does. Which leads me back to "surely we can
generalize this". I don't think bsearch() is quite what we want, because
its interface doesn't tell us where to put the item when it isn't found.
But I think we could make a general bsearch-like function that has
similar semantics to index_name_pos(), with its negative-integer return.

And then that would be a general lookup function, and we could easily
build a general "look up and add" function around that. And the "check
the last one" optimization would go in the latter.

-Peff
