Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11F661F461
	for <e@80x24.org>; Fri,  6 Sep 2019 17:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395202AbfIFRap (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 13:30:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:42272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732789AbfIFRap (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 13:30:45 -0400
Received: (qmail 21241 invoked by uid 109); 6 Sep 2019 17:30:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 17:30:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5249 invoked by uid 111); 6 Sep 2019 17:32:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2019 13:32:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Sep 2019 13:30:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: Re: [PATCH 3/3] commit-graph.c: handle corrupt/missing trees
Message-ID: <20190906173043.GD23181@sigill.intra.peff.net>
References: <cover.1567720960.git.me@ttaylorr.com>
 <9fbd965e3892307bb5bb78952f017624fcc0b73a.1567720960.git.me@ttaylorr.com>
 <20190906061919.GA5122@sigill.intra.peff.net>
 <xmqqo8zxnz0m.fsf@gitster-ct.c.googlers.com>
 <xmqq5zm5nydu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zm5nydu.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 10:11:09AM -0700, Junio C Hamano wrote:

> > Is there even a single caller that is prepared to react to NULL?
> >
> >     Answer. There is a single hit inside fsck.c that wants to report
> >     an error without killing ourselves in fsck_commit_buffer().  I
> >     however doubt its use of get_commit_tree() is correct in the
> >     first place.  The function is about validating the commit object
> >     payload manually, without trusting the result of parse_commit(),
> >     and it does read the object name of the tree object; the call to
> >     get_commit_tree() used for reporting the error there should
> >     probably become has_object() on the tree_oid.
> 
> At least we need to ensure, not just has_object(), but the object
> indeed claims to be a tree object.  It is OK if it is a corrupt
> tree object---we'll catch its brokenness separately anyway.
> 
>     Hmm, the should we also tolerate the pointed object to be broken
>     in a way that it is not even able to claim to be a tree object?
>     That would mean that has_object() is sufficient to check here.
> 
> OK, so... 

We'd do that check later, during fsck_walk_commit(). Which ironically
calls get_commit_tree() without checking for NULL, and would likely
segfault. ;)

-Peff
