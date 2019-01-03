Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1E01F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 05:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfACFWW (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 00:22:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:53462 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726997AbfACFWV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 00:22:21 -0500
Received: (qmail 19667 invoked by uid 109); 3 Jan 2019 05:22:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Jan 2019 05:22:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7600 invoked by uid 111); 3 Jan 2019 05:21:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 03 Jan 2019 00:21:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2019 00:22:19 -0500
Date:   Thu, 3 Jan 2019 00:22:19 -0500
From:   Jeff King <peff@peff.net>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v4 0/3]
Message-ID: <20190103052219.GF20047@sigill.intra.peff.net>
References: <20181220145931.GB27361@sigill.intra.peff.net>
 <20181224084756.49952-1-nbelakovski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181224084756.49952-1-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 24, 2018 at 12:47:53AM -0800, nbelakovski@gmail.com wrote:

> From: Nickolai Belakovski <nbelakovski@gmail.com>
> 
> > I don't think that works. The default function is always_equal(), which
> > will treat two entries equal if they have the same hash value. I.e., any
> > collisions would be considered a match.
> 
> You're absolutely right. I've added a compare function, but I left out the
> functionality for it to work with an entry passed in as a key. Doing so would
> mean the user would have to allocate a worktree struct, which just seems silly
> when the ref is all that's needed (and also defeats the purpose of avoiding
> extra allocations).

Unfortunately, that doesn't quite work. :)

Your compare function has to handle _both_ cases: two keys, or one key
and a keydata.

The former may be called when the hashmap has to compare two entries
internally (e.g., when it has to re-bucket all of the entries after a
resize). Your tests likely wouldn't run into this case in practice,
since you'd only have a handful of worktrees. But if you added, say,
thousands of worktrees and we had to grow the hash midway through the
process, it would segfault.  So you do need to handle the case when your
keydata is NULL.

In theory it would also be used for comparisons if we used a more clever
data structure to hold entries within a bucket. But since we just use a
linked list and linear search for now, we don't.

> And while most of the hashmap API seems OK, yea, this is definitely awful. It
> feels like it should just be able to take a key and return either an entry or
> NULL, and do away with entry_or_key and equals_function_data.

In your case, yeah, equals_function_data is not used at all (but there
are a few call-sites which need it to avoid relying on global data).

But the entry_or_key (coupled with keydata) is the magic that lets the
same function be used for both lookups as well as internal entry
comparisons.

I think having two separate comparison functions would make this a lot
more clear, though likely at the cost of having more boilerplate.

-Peff
