Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31782047F
	for <e@80x24.org>; Tue, 19 Sep 2017 05:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751001AbdISFUU (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 01:20:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:42984 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750713AbdISFUT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 01:20:19 -0400
Received: (qmail 3491 invoked by uid 109); 19 Sep 2017 05:20:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 05:20:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32108 invoked by uid 111); 19 Sep 2017 05:20:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 01:20:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Sep 2017 01:20:17 -0400
Date:   Tue, 19 Sep 2017 01:20:17 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     phionah bugosi <bugosip@gmail.com>, git@vger.kernel.org
Subject: Re: [OUTREACHY] pack: make packed_git_mru global a value instead of
 a pointer
Message-ID: <20170919052017.mcspwuse3vlobpxf@sigill.intra.peff.net>
References: <1505755303-5583-1-git-send-email-bugosip@gmail.com>
 <20170918231724.GY27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170918231724.GY27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 18, 2017 at 04:17:24PM -0700, Jonathan Nieder wrote:

> phionah bugosi wrote:
> 
> > Just to reecho a previous change requested before in one of the mail
> > threads, we currently have two global variables declared:
> >
> > struct mru packed_git_mru_storage;
> > struct mru *packed_git_mru = &packed_git_mru_storage;
> >
> > We normally use pointers in C to point or refer to the same location
> > or space in memory from multiple places. That means in situations
> > where we will have the pointer be assigned to in many places in our
> > code. But in this case, we do not have any other logic refering or
> > assigning to the pointer packed_git_mru. In simple words we actually
> > dont need a pointer in this case.
> >
> > Therefore this patch makes packed_git_mru global a value instead of
> > a pointer and makes use of list.h
> >
> > Signed-off-by: phionah bugosi <bugosip@gmail.com>
> > ---
> >  builtin/pack-objects.c |  5 +++--
> >  cache.h                |  7 -------
> >  list.h                 |  6 ++++++
> >  packfile.c             | 12 ++++++------
> >  4 files changed, 15 insertions(+), 15 deletions(-)
> 
> *puzzled* This appears to already be in "pu", with a different author.
> Did you independently make the same change?  Or are you asking for a
> progress report on that change, and just phrasing it in a confusing
> way?

I pointed Phionah at your #leftoverbits comment in:

  https://public-inbox.org/git/20170912172839.GB144745@aiede.mtv.corp.google.com/

about moving packed_git_mru to list.h. But I'm afraid I wasn't very
clear in giving further guidance.

The goal is to build on _top_ of the patch in that message, and convert
the doubly-linked list implementation used in "struct mru" to use the
shared code in list.h. That should mostly involve touching mru.c and
mru.h, though I think we'd need to tweak the name of the "next" pointer
during the traversal, too.

-Peff
