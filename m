Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75A4B20970
	for <e@80x24.org>; Wed, 12 Apr 2017 00:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbdDLAsX (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 20:48:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:60468 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbdDLAsV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 20:48:21 -0400
Received: (qmail 24563 invoked by uid 109); 12 Apr 2017 00:48:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Apr 2017 00:48:21 +0000
Received: (qmail 9516 invoked by uid 111); 12 Apr 2017 00:48:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 20:48:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 20:48:18 -0400
Date:   Tue, 11 Apr 2017 20:48:18 -0400
From:   Jeff King <peff@peff.net>
To:     Julian Goacher <julian.goacher@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Modifying a bare repo directly
Message-ID: <20170412004818.xcguj3ndyfixnthy@sigill.intra.peff.net>
References: <CAG_DJYk3D=sPm6rhGRD_wF4dnJqSU_M+c=NWP4Q5ExBap_-kPw@mail.gmail.com>
 <20170410182209.GA18358@dcvr>
 <CAG_DJY=3Q1hcGnD72hwhdHxVReD4g7JZou=cm32_WECoJf+5nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG_DJY=3Q1hcGnD72hwhdHxVReD4g7JZou=cm32_WECoJf+5nA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 10:35:17PM +0100, Julian Goacher wrote:

> Thanks for the replies; is there anything that needs to be known about
> concurrent updates on a repo when using plumbing commands?

Concurrent writes to the object database are always safe (so
hash-object, write-tree, commit-tree are fine). Updates to the index
will take a lock on the index; use a unique GIT_INDEX_FILE if you want
multiple independent updates to avoid conflicting with each other.

So all of that should be able to proceed independently. The place where
you might see conflicts is when you actually update the branch. The
locking there uses a "lease" system:

  1. At the start of the operation, you note that the branch is at some
     sha1 X.

  2. When you're ready to write, you feed update-ref the refname, the
     new sha1, and that original sha1.

  3. Update-ref takes a lock, checks that we are still at the old sha1,
     and then atomically writes the new sha1.

So if you have updates to multiple independent branches, they'll never
conflict. If you have multiple updates to the same branch, they may
race, but you'll never "lose" an update; each one will either succeed or
fail. Just make sure you pass the "old" sha1 to update-ref (the example
I posted did so).

-Peff
