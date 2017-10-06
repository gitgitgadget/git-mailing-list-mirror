Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 771C01FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 14:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbdJFOhs (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 10:37:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:35322 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752250AbdJFOhr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 10:37:47 -0400
Received: (qmail 7349 invoked by uid 109); 6 Oct 2017 14:37:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 14:37:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6693 invoked by uid 111); 6 Oct 2017 14:37:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 10:37:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 10:37:45 -0400
Date:   Fri, 6 Oct 2017 10:37:45 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Regression in 'git branch -m'?
Message-ID: <20171006143745.w6q2yfgy6nvd2m2a@sigill.intra.peff.net>
References: <20171005172552.GA11497@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171005172552.GA11497@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2017 at 07:25:52PM +0200, Andreas Krey wrote:

> I got something that looks like a regression somewhere since 2.11.
> This script
> 
>   set -xe
>   rm -rf repo
>   git init repo
>   cd repo
>   git commit -m nix --allow-empty
>   git branch -m master/master
>   git rev-parse HEAD
>   git branch
>   git status
> 
> causes .git/HEAD to still contain 'ref: refs/heads/master' and to fail
> in the rev-parse step with
> 
>   + git rev-parse HEAD
>   HEAD
>   fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
> 
> This is with 2.15.0.rc0; with 2.11.0 (and 2.11.0.356.gffac48d09) it still works.

So this turned out to be quite an interesting bug to explore. I think
the solution I ended up with in the second patch is the right thing. I'm
adding Michael to the cc for wisdom on the ref code, though I think the
bug I'm fixing actually goes back to the early days of Git.

Earlier I blamed Duy's 31824d180d. And that is the start of the
regression in v2.15, but only because it fixed another bug which was
papering over the one I'm fixing here. :)

  [v1 1/2]: t3308: create a real ref directory/file conflict
  [v1 2/2]: refs_resolve_ref_unsafe: handle d/f conflicts for writes

 refs.c                  | 15 ++++++++++++++-
 t/t1401-symbolic-ref.sh | 26 +++++++++++++++++++++++++-
 t/t3200-branch.sh       | 10 ++++++++++
 t/t3308-notes-merge.sh  |  2 +-
 4 files changed, 50 insertions(+), 3 deletions(-)

-Peff
