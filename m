Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E683B1F42D
	for <e@80x24.org>; Sat, 12 May 2018 09:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbeELJSM (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 05:18:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:37090 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750791AbeELJSL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 05:18:11 -0400
Received: (qmail 24470 invoked by uid 109); 12 May 2018 09:18:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 12 May 2018 09:18:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13665 invoked by uid 111); 12 May 2018 09:18:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 12 May 2018 05:18:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 May 2018 05:18:09 -0400
Date:   Sat, 12 May 2018 05:18:09 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/12] shallow.c: use commit-slab for commit depth
 instead of commit->util
Message-ID: <20180512091809.GC28279@sigill.intra.peff.net>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180512080028.29611-4-pclouds@gmail.com>
 <20180512090748.GB28279@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180512090748.GB28279@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 05:07:48AM -0400, Jeff King wrote:

> So no, it wouldn't work to directly store depths with the code as
> written.  I'm not sure if the depth can ever be 0. If not, then it would
> be a suitable sentinel as:
> 
>   int *slot = commit_depth_at(&depths, p->item);
>   if (!*slot || cur_depth < *slot)
> 	*slot = cur_depth;
> 
> But somebody would have to dig into the possible values of cur_depth
> there (which would make sense to do as a separate patch anyway, since
> the point of this is to be a direct conversion).

By the way, one other approach if xcalloc() doesn't produce a good
sentinel is to use a data type that does. ;) E.g., something like this
should work:

  struct depth {
	unsigned valid:1;
	int value;
  };
  define_commit_slab(commit_depth, struct depth);

  ...

  struct depth *slot = commit_depth_at(&depths, p->item);
  if (!slot->valid || cur_depth < slot->value) {
	slot->value = cur_depth;
	slot->valid = 1;
  }

That wastes an extra 4 bytes per slot over storing an int directly, but
it's the same as storing an 8-byte pointer, plus you avoid the storage
and runtime overhead of malloc.

I actually wonder if we could wrap commit_slab with a variant that
stores the sentinel data itself, to make this pattern easier. I.e.,
something like:

  #define define_commit_slab_sentinel(name, type) \
	struct name##_value { \
		unsigned valid:1; \
		type value; \
	}; \
	define_commit_slab(name, struct name##_value)

and some matching "peek" and "at" functions to manipulate value
directly.

I think the end result would be nicer, but it's turning into a little
bit of a rabbit hole. So I don't mind going with your direct conversion
here for now.

-Peff
