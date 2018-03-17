Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 948031F404
	for <e@80x24.org>; Sat, 17 Mar 2018 16:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbeCQQSW (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 12:18:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:60882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752013AbeCQQSV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 12:18:21 -0400
Received: (qmail 23710 invoked by uid 109); 17 Mar 2018 16:18:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 17 Mar 2018 16:18:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6573 invoked by uid 111); 17 Mar 2018 16:19:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 17 Mar 2018 12:19:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Mar 2018 12:18:19 -0400
Date:   Sat, 17 Mar 2018 12:18:19 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     Michal Novotny <clime@redhat.com>, git@vger.kernel.org
Subject: Re: get commit ID from a tree object ID
Message-ID: <20180317161819.GB25113@sigill.intra.peff.net>
References: <CANT8FXR3pMgbwVWmwssDYhgv6eMFw4+Uz5xARGwFVVU1cMVmWw@mail.gmail.com>
 <20180317130128.mr2sfsrncykkubwo@tigra>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180317130128.mr2sfsrncykkubwo@tigra>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 04:01:28PM +0300, Konstantin Khomoutov wrote:

> So actually a generic approach to what you need is a full scan of all
> the commits in the repository with recursive traversing of the hierarchy
> of trees of each of them (via `git ls-tree`) and looking for the SHA-1
> name of the reference tree object.  As you can see, this is not going to
> be fast on repos of realistic size.

If you assume that the tree is a root tree (which is by no means
certain, but a good guess), it's not _too_ bad to do:

  git rev-list --all --format='%T %H' | grep ^$desired_tree

That's linear in the number of commits, but still takes only about 7
seconds on linux.git.

If you want to dig further, you can use the diff machinery to show which
commit introduced a particular tree, like:

  git rev-list --all |
  git diff-tree --stdin --pretty=raw --raw -t -r |
  less +/$desired_tree

That "less" will find the mentioned tree, and then you'll have to
manually read the commit. It would be possible to do it mechanically
with a short perl script, but I'll leave that as an exercise for the
reader.

-Peff
