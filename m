Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F86F1FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 20:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754288AbcLOUkO (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 15:40:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:57277 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752333AbcLOUkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 15:40:09 -0500
Received: (qmail 20449 invoked by uid 109); 15 Dec 2016 20:40:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 20:40:03 +0000
Received: (qmail 6067 invoked by uid 111); 15 Dec 2016 20:40:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 15:40:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2016 15:40:00 -0500
Date:   Thu, 15 Dec 2016 15:40:00 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: index-pack outside of repository?
Message-ID: <20161215204000.avlcfaqjwstkptu2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running git on 'next', you can trigger a BUG:

  $ cd /some/repo
  $ git pack-objects --all --stdout </dev/null >/tmp/foo.pack
  $ cd /not-a-git-repo
  $ git index-pack --stdin </tmp/foo.pack
  fatal: BUG: setup_git_env called without repository

This obviously comes from my b1ef400eec (setup_git_env: avoid blind
fall-back to ".git", 2016-10-20). What's going on is that index-pack
uses RUN_SETUP_GENTLY, but never actually handles the out-of-repo case.
When we use the internal git_dir to make "objects/pack/pack-xxx.pack",
it barfs.

In older versions of git will just blindly write into
".git/objects/pack", even though there's no repository there.

So I think complaining to the user is the right thing to do here. I
started to write a patch to have index-pack notice when it needs a repo
and doesn't have one, but the logic is actually a bit unclear.  Do we
need to complain early _just_ when --stdin is specified, or does that
miss somes cases?  Likewise, are there cases where --stdin can operate
without a repo? I couldn't think of any.

I'm actually wondering if the way it calls die() in 'next' is a pretty
reasonable way for things to work in general. It happens when we lazily
try to ask for the repository directory. So we don't have to replicate
logic to say "are we going to need a repo"; at the moment we need it, we
notice we don't have it and die. The only problem is that it says "BUG"
and not "this operation must be run in a git repository".

That strategy _might_ be a problem for some programs, which would want
to notice the issue early before doing work. But it seems like a
reasonable outcome for index-pack. Thoughts?

-Peff
