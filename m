Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8000620248
	for <e@80x24.org>; Thu, 11 Apr 2019 04:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfDKEGr (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 00:06:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:54502 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725782AbfDKEGq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 00:06:46 -0400
Received: (qmail 2029 invoked by uid 109); 11 Apr 2019 04:06:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Apr 2019 04:06:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23983 invoked by uid 111); 11 Apr 2019 04:07:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Apr 2019 00:07:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2019 00:06:42 -0400
Date:   Thu, 11 Apr 2019 00:06:42 -0400
From:   Jeff King <peff@peff.net>
To:     Josh Steadmon <steadmon@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3] rev-list: exclude promisor objects at walk time
Message-ID: <20190411040642.GA8418@sigill.intra.peff.net>
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
 <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com>
 <20190409180418.GH8796@szeder.dev>
 <20190409234255.GM60888@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190409234255.GM60888@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 09, 2019 at 04:42:55PM -0700, Josh Steadmon wrote:

> >   warning: reflog of 'HEAD' references pruned commits
> >   warning: reflog of 'refs/heads/master' references pruned commits
> >   fatal: unable to read 71905dfcd543b7cbb0b4b66fbd20379e67220557
> >   error: last command exited with $?=128
> >   not ok 23 - repack -d does not irreversibly delete promisor objects
> > 
> 
> Thank you for catching this. I haven't yet figured out the cause. I will
> look into this more tomorrow and then send a V4 once I've fixed it.

I'm concerned that this is a sign that the approach I suggested does not
actually work everywhere. I.e., could this be a case where we have some
non-promisor object that points to a sub-object that is reachable from
the promisor pack, but not a direct tip? Before your patch we'd consider
that sub-object a promisor (because we enumerate all of the graph that
we do have and mark each such object), but afterwards we would not.

And I wonder if that confuses pack-objects. Though I think it would
confuse it in the _opposite_ direction. I.e., using
--exclude-promisor-objects would count such an object as not-a-promisor
and would be more inclined to include it in the new pack.

It is curious that this only turns up with GIT_TEST_COMMIT_GRAPH=1, too.
It seems like any such problem ought to be independent of that.

Puzzling...

-Peff
