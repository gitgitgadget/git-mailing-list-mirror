Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A102620248
	for <e@80x24.org>; Fri,  1 Mar 2019 18:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbfCASht (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 13:37:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:34730 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728033AbfCASht (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 13:37:49 -0500
Received: (qmail 20343 invoked by uid 109); 1 Mar 2019 18:37:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Mar 2019 18:37:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32533 invoked by uid 111); 1 Mar 2019 18:38:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Mar 2019 13:38:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2019 13:37:47 -0500
Date:   Fri, 1 Mar 2019 13:37:47 -0500
From:   Jeff King <peff@peff.net>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] name-rev: check if a commit should be named
 before naming it
Message-ID: <20190301183747.GC30847@sigill.intra.peff.net>
References: <20190301175024.17337-1-alban.gruin@gmail.com>
 <20190301175024.17337-4-alban.gruin@gmail.com>
 <CAPig+cQmZOWUZuj2+z+qrrCO-YBMNiEnGic1_FwAcaaj5gA5-w@mail.gmail.com>
 <992c5d7e-524a-3c92-9f0f-bbefbe151de5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <992c5d7e-524a-3c92-9f0f-bbefbe151de5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 07:22:47PM +0100, Alban Gruin wrote:

> Le 01/03/2019 à 19:05, Eric Sunshine a écrit :
> > On Fri, Mar 1, 2019 at 12:50 PM Alban Gruin <alban.gruin@gmail.com> wrote:
> > -%<-
> > Minor: It would probably be more efficient to check if the count is 0
> > first, and only search the list if not.
> > 
> > By the way, how big is 'commits' likely to get? Will the linear scan
> > done by commit_list_contains() become an issue? Should it be using a
> > hash table instead?
> > 
> 
> It depends on the amount of commits mentionned in stdin that are
> reachable from the ref in name_ref().  If there is a lot of commit in
> the input, it may effectively become a problem.

Yeah, I think this is quadratic in the worst case.

> I thought of adding a field to the rev_name structure for this purpose.
>  I think commit slabs are hash maps under the hood?

They're not hash maps, but they're still O(1). Each commit struct is
allocated a unique integer id, and the slab just keeps a dynamic array
of one entry per commit.

So they're actually faster than a hashmap (it's a pure index, no oideq()
required).  The downside is that they can use more memory than a hashmap
if they're sparsely populated. However in your case, I think you'd load
a couple of "struct commit" objects at the start, mark them as "1" in
the slab, and then never mark any more as you traverse. So you'd only
allocate entries for those tightly-packed initial ones.

It seems like an ideal case for using a slab.

-Peff
