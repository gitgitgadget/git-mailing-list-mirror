Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3EE207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 03:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbcIMDWr (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:22:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:42259 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750747AbcIMDWq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:22:46 -0400
Received: (qmail 20197 invoked by uid 109); 13 Sep 2016 03:22:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:22:46 +0000
Received: (qmail 18380 invoked by uid 111); 13 Sep 2016 03:22:55 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:22:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 23:22:42 -0400
Date:   Mon, 12 Sep 2016 23:22:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 0/16] fix config-reading in non-repos
Message-ID: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The motivation for this series is to fix the regression in v2.9 where
core.logallrefupdates is sometimes not set properly in a newly
initialized repository, as described in this thread:

  http://public-inbox.org/git/c46d36ef-3c2e-374f-0f2e-ffe31104e023@gmx.de/T/#u

The root of the problem is that we are overly eager to read and use
config from ".git/config", even when we have not established that it is
part of a repository. This is especially bad for git-init, which would
not want to read anything until we've created the new repo.

So the two interesting parts of the fix are:

  1. We stop blindly reading ".git/config" when we don't know there's an
     actual git directory. This is in patch 14, and is actually enough
     to fix the v2.9 regression.

  2. We are more thorough about dropping any cached config values when
     we move into the new repository in git-init (patch 16).

     I didn't dig into when this was broken, but it was probably when we
     switched git_config() to use cached values in the v2.2.0
     time-frame.

Doing (1) required fixing up some builtins that depended on the blind
.git/config thing, as the tests demonstrated. But I think this is a sign
that we are moving in the right direction, because each one of those
programs could easily be demonstrated to be broken in scenarios only
slightly more exotic than the test scripts (e.g., see patch 3 for one of
the simplest cases).

So I think notwithstanding their use as prep for patch 14, patches 1-13
fix useful bugs.

I won't be surprised if there are other fallouts that were not caught by
the test suite (i.e., programs that expect to read config, don't do
RUN_SETUP, but aren't covered well by tests). I poked around the list of
builtins in git.c that do not use RUN_SETUP, and they seem to correctly
end up in setup_git_directory_gently() before reading config. But it's
possible I missed a case.

So this is definitely a bit larger than I'd hope for a regression-fix to
maint. But anything that doesn't address this issue at the config layer
is going to end up as a bit of a hack, and I'd rather not pile up hacks
if we can avoid it.

I have a few patches on top that go even further and disallow the
auto-fallback of looking in ".git" at all for non-repositories. I think
that's the right thing to do, and after years of chipping away at the
setup code, I think we're finally at a point to make that change (with a
few fixes of course). But that's an even riskier change and not fixing
an immediate regression. So I'll hold that back for now, and hopefully
it would become "master" material once this is sorted out.

I've cc'd Dennis, who helped investigate solutions in the thread
mentioned above, and Duy, because historically he has been the one most
willing and able to battle the dragon of our setup code. :)

  [01/16]: t1007: factor out repeated setup
  [02/16]: hash-object: always try to set up the git repository
  [03/16]: patch-id: use RUN_SETUP_GENTLY
  [04/16]: diff: skip implicit no-index check when given --no-index
  [05/16]: diff: handle --no-index prefixes consistently
  [06/16]: diff: always try to set up the repository
  [07/16]: pager: remove obsolete comment
  [08/16]: pager: stop loading git_default_config()
  [09/16]: pager: make pager_program a file-local static
  [10/16]: pager: use callbacks instead of configset
  [11/16]: pager: handle early config
  [12/16]: t1302: use "git -C"
  [13/16]: test-config: setup git directory
  [14/16]: config: only read .git/config from configured repos
  [15/16]: init: expand comments explaining config trickery
  [16/16]: init: reset cached config when entering new repo

-Peff
