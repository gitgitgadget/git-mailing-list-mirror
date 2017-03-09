Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD9C1FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 08:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbdCIH7B (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 02:59:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:41113 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751525AbdCIH67 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 02:58:59 -0500
Received: (qmail 28954 invoked by uid 109); 9 Mar 2017 07:31:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 07:31:19 +0000
Received: (qmail 6399 invoked by uid 111); 9 Mar 2017 07:31:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 02:31:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 02:31:18 -0500
Date:   Thu, 9 Mar 2017 02:31:18 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <jeffhost@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, markbt@efaref.net,
        benpeart@microsoft.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH 02/10] pack-objects: add --partial-by-size=n
 --partial-special
Message-ID: <20170309073117.g3br5btsfwntcdpe@sigill.intra.peff.net>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
 <1488994685-37403-3-git-send-email-jeffhost@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1488994685-37403-3-git-send-email-jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2017 at 05:37:57PM +0000, Jeff Hostetler wrote:

> From: Jeff Hostetler <git@jeffhostetler.com>
> 
> Teach pack-objects to omit blobs from the generated packfile.
> 
> When the --partial-by-size=n[kmg] argument is used, only blobs
> smaller than the requested size are included.  When n is zero,
> no blobs are included.
> 
> When the --partial-special argument is used, git special files,
> such as ".gitattributes" and ".gitignores" are included.
> 
> When both are given, the union of two are included.

I understand why one would want to do:

  --partial-by-size=100 --partial-special

and get the union. The first one restricts, and the second one adds back
in. But I don't understand why "--partial-special" by itself makes any
sense. Wouldn't we already be including all blobs, and it would be a
noop?


Also, I was thinking a bit on Junio's comment elsewhere on whether
read_object_list_from_stdin() should do the same limiting. I think the
answer is "probably not", because whoever is generating that object list
can cull the set. You could do it today with something like:

  git rev-list --objects HEAD |
  git cat-file --batch-check='%(objectsize) %(objecttype) %(objectname) %(rest)' |
  perl -lne 's/^(\d+) (\S+) //; print if $2 ne "blob" || $1 < 100' |
  git pack-objects

But if we are going to add this --partial-by-size for the pack-objects
traversal, shouldn't we just add it to rev-list? Then:

  git rev-list --objects --partial-by-size=100 --partial-special |
  git pack-objects

works, and you should get it in the pack-objects basically for free (I
think you'd have to allow through the "--partial" arguments on stdin,
and make sure the rev-list implementation is done via
traverse_commit_list).

As a bonus, I suspect it would make the --partial-special path-handling
easier, because you'd see each tree entry rather than the fully
constructed path (so no more monkeying around with "/").

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 7e052bb..2df2f49 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -77,6 +77,10 @@ static unsigned long cache_max_small_delta_size = 1000;
>  
>  static unsigned long window_memory_limit = 0;
>  
> +static signed long partial_by_size = -1;

I would have expected this to be an off_t, though I think
OPT_MAGNITUDE() forces you into "unsigned long". I guess it is nothing
new for Git; we use "unsigned long" for single object sizes elsewhere,
so systems with a 32-bit long are out of luck anyway until we fix that.

The signed "long" here is unfortunate, as it limits us to 2G on such
systems. Maybe it is not worth worrying too much about. The "big object"
threshold is usually around 500MB. I think the failure behavior is not
great, though (asking for "3G" would go negative and effectively be
ignored).

I think handling all cases would involve swapping out OPT_MAGNITUDE()
for a special callback that writes the "yes, the user set this" bit in a
separate variable.

-Peff
