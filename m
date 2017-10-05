Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D31E20281
	for <e@80x24.org>; Thu,  5 Oct 2017 18:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbdJESdL (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 14:33:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:33918 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751286AbdJESdL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 14:33:11 -0400
Received: (qmail 12376 invoked by uid 109); 5 Oct 2017 18:33:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 18:33:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30305 invoked by uid 111); 5 Oct 2017 18:33:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 14:33:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Oct 2017 14:33:03 -0400
Date:   Thu, 5 Oct 2017 14:33:03 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     Git Users <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Regression in 'git branch -m'?
Message-ID: <20171005183303.f77dpkhs5ztxlmyv@sigill.intra.peff.net>
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
> 
> I'm going to do a bisect on this as battery permits.

Looks like 31824d180d (branch: fix branch renaming not updating HEADs
correctly, 2017-08-24). This is in v2.15.0-rc0, so we should figure it
out before the upcoming release.

I didn't dig very far, but it looks like the branch name is important
"foo" doesn't trigger the problem but "master/master" does. "master/foo"
also does, but "foo/master" does not. So I suspect it's something about
how resolve_ref handles the failure when it would not be able to create
the ref because of the d/f conflict. So it's probably related to losing
the RESOLVE_REF_READING in the final hunk of that patch. That's just a
guess for now, though.

-Peff
