Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3EB920248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfBVQHY (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:07:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:54662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726352AbfBVQHY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 11:07:24 -0500
Received: (qmail 2157 invoked by uid 109); 22 Feb 2019 16:07:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Feb 2019 16:07:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29584 invoked by uid 111); 22 Feb 2019 16:07:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Feb 2019 11:07:37 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2019 11:07:22 -0500
Date:   Fri, 22 Feb 2019 11:07:22 -0500
From:   Jeff King <peff@peff.net>
To:     Dominik Salvet <dominik.salvet@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fetching master branch with tags associated with it
Message-ID: <20190222160722.GA22531@sigill.intra.peff.net>
References: <CAEXP2g92_pnbh4_V8VOgzzdUv6w5eDhCsXf=+NOdsRwyjQUb5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEXP2g92_pnbh4_V8VOgzzdUv6w5eDhCsXf=+NOdsRwyjQUb5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 06:02:54PM +0100, Dominik Salvet wrote:

> Now, I want to refresh the repository the same way - fetching only
> commits from the master branch and tags that are pointing to the
> master branch and also refresh those tags as well in case of their
> target commit change at the remote (you can expect that it always
> points to a master commit). Nevertheless, I don't really know how to
> do it. The closest I got, are the following commands:
> 
> ```sh
> git fetch --tags origin master &&
> git merge FETCH_HEAD
> ```
> 
> However, there obviously are some problems with this solution. The
> `--tags` flag will cause to fetch tags from all branches. Furthermore,
> it will fetch also their commits, which is absolutely what I don't
> want to.
> 
> I have Git 2.17.1 (on Ubuntu 18.04.2) and in its `git fetch --help` is
> stated, if I understood it correctly, that without passing neither
> `--tags` nor `--no-tags`, it will do exactly what I want.
> Nevertheless, without using any of the mentioned flags, it behaves
> more like using `--no-tags`.

Generally yes, that's how it's supposed to work. However, I think
tag-following does not kick in when you've given a specific refspec.

So take this toy setup for example:

-- >8 --
git init repo
cd repo

# one tags accessible from master
git commit --allow-empty -m one
git tag one

# one tag accessible only from "other"
git checkout -b other
git commit --allow-empty -m two
git tag two

# now fetch into another repository
git init child
cd child
git remote add origin ..
git fetch origin master
-- 8< --

That won't pick up the "one" tag in that final fetch. But if you use the
normal configured refspec (but tell it only to grab "master"):

  git config remote.origin.fetch refs/heads/master:refs/remotes/origin/master
  git fetch origin

then it works. I don't know if there's a less-awkward way to get what
you want, though. It really seems like there should be a "--tags=follow"
or similar.

-Peff
