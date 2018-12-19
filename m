Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9E0B1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 23:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbeLSXRS (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 18:17:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:46270 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728996AbeLSXRS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 18:17:18 -0500
Received: (qmail 20452 invoked by uid 109); 19 Dec 2018 23:17:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Dec 2018 23:17:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26084 invoked by uid 111); 19 Dec 2018 23:16:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Dec 2018 18:16:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2018 18:17:16 -0500
Date:   Wed, 19 Dec 2018 18:17:16 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/3] setup: do not use invalid `repository_format`
Message-ID: <20181219231716.GA21283@sigill.intra.peff.net>
References: <20181218072528.3870492-1-martin.agren@gmail.com>
 <20181218072528.3870492-3-martin.agren@gmail.com>
 <20181219153841.GB14802@sigill.intra.peff.net>
 <CAN0heSpc_sap1cZktteRn3hyeuRx2w86Hd2kqxu4XFgHs75_Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpc_sap1cZktteRn3hyeuRx2w86Hd2kqxu4XFgHs75_Kw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 19, 2018 at 10:46:52PM +0100, Martin Ågren wrote:

> >   2. Arguably we should not even look at extensions.* unless we see a
> >      version >= 1. But we do process them as we parse the config file.
> >      This is mostly an oversight, I think. We have to handle them as we
> >      see them, because they may come out of order with respect to the
> >      repositoryformatversion field. But we could put them into a
> >      string_list, and then only process them after we've decided which
> >      version we have.
> 
> I hadn't thought too much about this. I guess that for some simpler
> extensions--versions dependencies it would be feasible to first parse
> everything, then, depending on the version we've identified, forget
> about any "irrelevant" extensions. Again, nothing I've thought much
> about, and seems to be safely out of scope for this patch.

The decision is actually pretty straight-forward: if version < 1, ignore
extensions, otherwise respect them (and complain about any we don't know
about).

So I think we could just do in verify_repository_format() something
like:

  if (version < 1) {
    /* "undo" any extensions we might have parsed */
    data->precious_objects = 0;
    FREE_AND_NULL(data->partial_clone);
    data->worktree_config = 0;
    data->hash_algo = GIT_HASH_SHA1;
  } else {
    /* complain about unknown extension; we already do this! */
  }

It's a little ugly to have to know about all the extensions here, but we
already initialize them in read_repository_format(). We could probably
factor that out into a shared function.

-Peff
