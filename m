Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 954761F405
	for <e@80x24.org>; Wed,  8 Aug 2018 23:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbeHIBrM (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 21:47:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:47784 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729661AbeHIBrM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 21:47:12 -0400
Received: (qmail 18828 invoked by uid 109); 8 Aug 2018 23:25:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Aug 2018 23:25:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4472 invoked by uid 111); 8 Aug 2018 23:25:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 Aug 2018 19:25:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2018 19:25:16 -0400
Date:   Wed, 8 Aug 2018 19:25:16 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] packfile: iterate packed objects in pack order
Message-ID: <20180808232515.GC21882@sigill.intra.peff.net>
References: <20180808231210.242120-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180808231210.242120-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 08, 2018 at 04:12:10PM -0700, Jonathan Tan wrote:

> Many invocations of for_each_object_in_pack() and
> for_each_packed_object() (which invokes the former) subsequently check
> at least the type of the packed object, necessitating accessing the
> packfile itself. For locality reasons, it is thus better to iterate in
> pack order, instead of index order. Teach for_each_object_in_pack() to
> iterate in pack order by first creating a reverse index.
> 
> This is based off work by Jeff King.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> After writing this patch and looking at it further, I'm not sure if this
> is a clear benefit, but here's the patch anyway. In particular,
> builtin/fsck.c and builtin/cat-file.c just deal with the OID directly
> and does not access the packfile at all (at least at the time of
> invoking for_each_packed_object). And revision.c, if we are excluding
> promisor objects, parses each packed promisor object, but it seems
> possible to avoid doing that (replacing the parse_object() by
> lookup_unknown_object() still passes tests).

Even if you just use the oid to do a separate lookup in the object
database, there's still a benefit in accessing the objects in pack
order. The case in cat-file needs more than this, though, since it
separately sorts the output (it has to, because it has to merge and
de-dup the output from several packs plus loose objects).

With the patch below on top of yours, I get:

  $ time git.v2.18.0 cat-file --batch-all-objects --buffer --batch | wc -c
  6938365964

  real	0m44.686s
  user	0m42.932s
  sys	0m5.283s

  $ time git.compile cat-file --batch-all-objects --buffer --batch | wc -c
  8289859070

  real	0m7.007s
  user	0m5.542s
  sys	0m4.005s

But:

  - it needs to de-duplicate using a hashmap (which is why the output is
    so much bigger in the second case)

  - it probably needs to be enabled explicitly by the user, since
    cat-file is plumbing and callers may be relying on the existing sort
    order

I can try to pick this up and carry the cat-file bits to completion if
you want, but probably not until tomorrow or Friday.

-Peff
