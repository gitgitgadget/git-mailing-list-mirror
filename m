Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A971F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 10:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760159AbcHaKsc (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 06:48:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:35916 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1759929AbcHaKsb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 06:48:31 -0400
Received: (qmail 26862 invoked by uid 109); 31 Aug 2016 10:48:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 10:48:29 +0000
Received: (qmail 6022 invoked by uid 111); 31 Aug 2016 10:48:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 06:48:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Aug 2016 06:48:26 -0400
Date:   Wed, 31 Aug 2016 06:48:26 -0400
From:   Jeff King <peff@peff.net>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     doak <doak@gmx.de>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug: 'core.logallrefupdates' is not set by default in non-bare
 repository
Message-ID: <20160831104825.quyqb54bo5k7fdxs@sigill.intra.peff.net>
References: <c46d36ef-3c2e-374f-0f2e-ffe31104e023@gmx.de>
 <1472634746.4265.47.camel@kaarsemaker.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1472634746.4265.47.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2016 at 11:12:26AM +0200, Dennis Kaarsemaker wrote:

> That is indeed a bug. git reads the config of t1 and then thinks a
> template config has set that value, so it won't override it.

This is a regression in v2.9.0 due to my ae5f677 (lazily load
core.sharedrepository, 2016-03-11).

> This is caused by git init reading the config via
> get_shared_repository. The comment above it indicates that this may not
> be needed, and indeed not doing it makes this bug go away.

Hrm. I'm not sure if that will work, though, because we may call
get_shared_repository() from other code-paths (e.g., anything that calls
adjust_shared_perm(), like safe_create_leading_directories).

We may need to do something like turn off the
need_shared_repository_from_config in init-db, since I think it would
not want to ever read from the default config sources in most of its
code-paths (OTOH, it should in theory respect core.sharedRepository in
~/.gitconfig, so maybe there is another more elegant way of handling
this).

I'm out of time for the day, so it will be a while before I can dig
further. Please feel free to figure it out while I am sleeping. :)

-Peff
