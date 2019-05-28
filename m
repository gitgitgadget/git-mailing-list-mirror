Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EF841F462
	for <e@80x24.org>; Tue, 28 May 2019 20:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfE1Uyo (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 16:54:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:40394 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726523AbfE1Uyn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 16:54:43 -0400
Received: (qmail 4433 invoked by uid 109); 28 May 2019 20:54:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 20:54:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17948 invoked by uid 111); 28 May 2019 20:55:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 16:55:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 16:54:41 -0400
Date:   Tue, 28 May 2019 16:54:41 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] sha1-file: split OBJECT_INFO_FOR_PREFETCH
Message-ID: <20190528205441.GB24650@sigill.intra.peff.net>
References: <pull.228.git.gitgitgadget@gmail.com>
 <2737e62966cae2f00d75a93446bad76e5816d07e.1559056745.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2737e62966cae2f00d75a93446bad76e5816d07e.1559056745.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 28, 2019 at 08:19:07AM -0700, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The OBJECT_INFO_FOR_PREFETCH bitflag was added to sha1-file.c in 0f4a4fb1
> (sha1-file: support OBJECT_INFO_FOR_PREFETCH, 2019-03-29) and is used to
> prevent the fetch_objects() method when enabled.
> 
> However, there is a problem with the current use. The definition of
> OBJECT_INFO_FOR_PREFETCH is given by adding 32 to OBJECT_INFO_QUICK. This is
> clearly stated above the definition (in a comment) that this is so
> OBJECT_INFO_FOR_PREFETCH implies OBJECT_INFO_QUICK. The problem is that using
> "flag & OBJECT_INFO_FOR_PREFETCH" means that OBJECT_INFO_QUICK also implies
> OBJECT_INFO_FOR_PREFETCH.
> 
> Split out the single bit from OBJECT_INFO_FOR_PREFETCH into a new
> OBJECT_INFO_SKIP_FETCH_OBJECT as the single bit and keep
> OBJECT_INFO_FOR_PREFETCH as the union of two flags. This allows a clearer use
> of flag checking while also keeping the implication of OBJECT_INFO_QUICK.

Oof. I actually suggested splitting these up for review, but thought it
was only a clarity/flexibility issue, and completely missed the
correctness aspect of checking when the bit is set.

I agree with Junio's other response that using "==" would be the right
way for a multi-bit check, in general. But I like the split here,
because I think the result is more clear to read and harder to get
wrong for future checks.

I'd even go so far as to say...

> + * This is meant for bulk prefetching of missing blobs in a partial
> + * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
> + */
> +#define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)

we could dump this, and callers should just say what they mean (i.e.,
specify both flags).

There are only two of them, and I think both would be more readable with
a helper more like:

  int should_prefetch_object(struct repository *r,
                             const struct object_id *oid) {
	return !oid_object_info_extended(r, oid, NULL,
	                                 OBJECT_INFO_SKIP_FETCH_OBJECT |
					 OBJECT_INFO_QUICK);
  }

but unless everybody is immediately on-board with "yes, that is much
nicer", I don't want bikeshedding to hold up your important and
obviously-correct fix.

-Peff
