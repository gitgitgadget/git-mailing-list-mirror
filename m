Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B9EE1F406
	for <e@80x24.org>; Thu, 10 May 2018 16:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966462AbeEJQDd (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 12:03:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:35014 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966422AbeEJQDY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 12:03:24 -0400
Received: (qmail 9028 invoked by uid 109); 10 May 2018 16:03:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 May 2018 16:03:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25923 invoked by uid 111); 10 May 2018 16:03:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 May 2018 12:03:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2018 12:03:22 -0400
Date:   Thu, 10 May 2018 12:03:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 6/6] get_short_oid: document & warn if we ignore the
 type selector
Message-ID: <20180510160322.GC6462@sigill.intra.peff.net>
References: <20180501184016.15061-10-avarab@gmail.com>
 <20180510124303.6020-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180510124303.6020-7-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 12:43:03PM +0000, Ævar Arnfjörð Bjarmason wrote:

> The SHA1 prefix 06fa currently matches no blobs in git.git. When
> disambiguating short SHA1s we've been quietly ignoring the user's type
> selector as a fallback mechanism, this was intentionally added in
> 1ffa26c461 ("get_short_sha1: list ambiguous objects on error",
> 2016-09-26).
> 
> I think that behavior makes sense, it's not very useful to just show
> nothing because a preference has been expressed via core.disambiguate,
> but it's bad that we're quietly doing this. The user might thing that
> we just didn't understand what e.g 06fa^{blob} meant.

I had to read this through a few times to figure out what problem you
were solving. Possibly because you lead with 06fa, which is really just
an example (and also, I have an 06fa blob in my clone ;) ).

Maybe:

  If the short-sha1 disambiguation code is told to use a particular hint
  (e.g., treeish or blob) but no objects with that short-sha1 match that
  hint, we end up ignoring the hint. This can result in either:

    1. We choose the non-matching object if there is only one. This will
       typically result in an error later up the stack (since whatever
       gave us the hint is expecting a particular type).

    2. We list all objects with that short-sha1, including those with
       non-matching types.

  This second case can be confusing to the user, who might think that we
  didn't apply the hint properly (especially if the hint came from
  them). For example, in git.git there is no blob with the prefix 06fa.
  So the user may see:

    $ git rev-parse 06fa^{blob}
    hint: The candidates are:
    hint:   06fa2b7c2b tag v2.1.4
    hint:   06faf6ba64 tree
    06fa^{blob}
    fatal: ambiguous argument '06fa^{blob}': unknown revision or path not in the working tree.

  Let's help them out by issuing a warning whenever the hint is ignored.

So that at least explains it in a way that makes sense to me. But now
that I've propped up my strawman, let me take a few swings...

Your patch just covers case 2, I think. And for the error case, that's
probably OK:

  $ git rev-parse 06faf^{blob}
  error: 06faf^{blob}: expected blob type, but the object dereferences to tree type
  06faf^{blob}
  error: 06faf^{blob}: expected blob type, but the object dereferences to tree type
  fatal: ambiguous argument '06faf^{blob}': unknown revision or path not in the working tree.

(though there is a separate bug in showing the error twice).

But some cases _don't_ issue an error. For example, try this:

  $ git log ..06faf

which returns an empty output! We return the single matching tree, even
though the ".." triggers the commit hint. The revision machinery just
queues the tree, and then later when we see we're not doing an --objects
traversal, it just gets ignored. (That's a separate issue, but it shows
that the hints are just that: hints. The code that runs after does not
necessarily require a matching type).

And that example shows another issue, which is that the user does not
necessarily feed us the hint explicitly. We're using a committish hint
there, but I'm not sure if mentioning that would confuse the user or
not. Certainly this warning:

>     warning: Your hint (via core.disambiguate or peel syntax) was ignored, we fell
>     back to showing all object types since no object of the requested type
>     matched the provide short SHA1 06fa

is not accurate, because the hint came from neither of those places. ;)

So all that said together, I kind of wonder if we should consider
issuing the warning earlier, doing so for all cases, and being a bit
less chatty. Like:

  $ git rev-parse 06fa^{blob}
  warning: short object id 06fa did not match any objects of type 'blob'

If that were followed by any of:

  1. error: short SHA1 06fa is ambiguous, then a bunch of non-blobs

  2. error: expected blob but I got a tree

  3. the command proceeds and silently ignores the matched object

I think it would be helpful. We'd need to add in an extra mapping of
GET_OID_* back to a human-readable string, but I think that should be
pretty easy.

And finally, your 06fa example for me shows behavior that's either
buggy, or I'm just confused. I get:

  $ git rev-parse 06fa^{blob}
  error: short SHA1 06fa is ambiguous
  hint: The candidates are:
  hint:   06fa2b7c2b tag v2.1.4
  hint:   06faa52353 commit 2005-10-18 - 2005-10-18 midnight
  hint:   06fac427af blob
  hint:   06faf6ba64 tree

(That 06fac blob comes Junio's refs/notes/amlog). Shouldn't the blob
disambiguator show me just that object?

-Peff
