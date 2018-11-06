Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9DA1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 21:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388539AbeKGGqE (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 01:46:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:42814 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388314AbeKGGqE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 01:46:04 -0500
Received: (qmail 15893 invoked by uid 109); 6 Nov 2018 21:18:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Nov 2018 21:18:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4469 invoked by uid 111); 6 Nov 2018 21:18:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Nov 2018 16:18:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2018 16:18:52 -0500
Date:   Tue, 6 Nov 2018 16:18:52 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Halstrick <christian.halstrick@gmail.com>
Cc:     Git <git@vger.kernel.org>, rene.scheibe@gmail.com
Subject: Re: What exactly is a "initial checkout"
Message-ID: <20181106211852.GA8513@sigill.intra.peff.net>
References: <CAENte7hoHxQCiQwSaAGPyaeFK8rb2Q23DcbePd01fcvgxtodZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAENte7hoHxQCiQwSaAGPyaeFK8rb2Q23DcbePd01fcvgxtodZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 06, 2018 at 01:38:45PM +0100, Christian Halstrick wrote:

> I am trying to teach JGit [1] to behave like native git regarding some
> corner cases during "git checkout". I am reading the "git read-tree"
> documentation and I am not sure about the case [2]. Git should behave
> differently during a normal checkout than when you are doing a
> "initial checkout". I can imagine that the first checkout you do after
> you have cloned a repo is a initial checkout but: What exactly defines
> a "initial checkout"? It can't be an empty or non-existing index
> because native git behaves like in a non-initial-checkout even if the
> index is empty (see example below).
> 
> Here are some commands explaining my case. Git is facing an empty
> index, HEAD and MERGE (the commit you checkout) have the some content
> for path 'p'  and still git is neither updating index nor workingtree
> file during checkout.

Without looking at the code, I'd assume that an empty HEAD is different
than "there is no HEAD at all". I.e., what we call an "unborn branch"
elsewhere.

So perhaps try:

  git init
  git fetch ../some/other/repo HEAD:tmp
  git checkout tmp

where you'd truly have no HEAD.

Though peeking at the code, it looks like we set the unpack_trees
initial_checkout flag based on is_cache_unborn(), which looks for a
totally missing index file (not just an empty one). That would trigger
in the above case, too, though, because of course we have no index there
either.

-Peff
