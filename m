Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D56C32023D
	for <e@80x24.org>; Fri,  3 Mar 2017 07:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbdCCHKy (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 02:10:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:37735 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751518AbdCCHKw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 02:10:52 -0500
Received: (qmail 2716 invoked by uid 109); 3 Mar 2017 05:06:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 05:06:33 +0000
Received: (qmail 24781 invoked by uid 111); 3 Mar 2017 05:06:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 00:06:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 00:06:30 -0500
Date:   Fri, 3 Mar 2017 00:06:30 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 8/9] read_early_config(): really discover .git/
Message-ID: <20170303050630.mw6asla65prku3vq@sigill.intra.peff.net>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
 <cover.1488506615.git.johannes.schindelin@gmx.de>
 <921faef822901715fa877d6969255ce00d80b925.1488506615.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <921faef822901715fa877d6969255ce00d80b925.1488506615.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 03:04:32AM +0100, Johannes Schindelin wrote:

> Earlier, we punted and simply assumed that we are in the top-level
> directory of the project, and that there is no .git file but a .git/
> directory so that we can read directly from .git/config.
> 
> However, that is not necessarily true. We may be in a subdirectory. Or
> .git may be a gitfile. Or the environment variable GIT_DIR may be set.
> 
> To remedy this situation, we just refactored the way
> setup_git_directory() discovers the .git/ directory, to make it
> reusable, and more importantly, to leave all global variables and the
> current working directory alone.
> 
> Let's discover the .git/ directory correctly in read_early_config() by
> using that new function.
> 
> This fixes 4 known breakages in t7006.

Yay, this is much nicer.

I think the "dirty hack..." comment in read_early_config() can be
condensed (or go away) now.

I think we _could_ do away with read_early_config() entirely, and just
have the regular config code do this lookup when we're not already in a
repo. But then we'd really need to depend on the "creating_repository"
flag being managed correctly.

I think I prefer the idea that a few "early" spots like pager and alias
config need to use this special function to access the config. That's
less likely to cause surprises when some config option is picked up
before we have run setup_git_directory().

There is one surprising case that I think we need to deal with even now,
though. If I do:

  git init repo
  git -C repo config pager.upload-pack 'echo whoops'
  git upload-pack repo
  cd repo && git upload-pack .

the first one is OK, but the second reads and executes the pager config
from the repo, even though we usually consider upload-pack to be OK to
run in an untrusted repo. This _isn't_ a new thing in your patch, but
just something I noticed while we are here.

And maybe it is a non-issue. The early-config bits all happen via the
git wrapper, and normally we use the direct dashed "git-upload-pack" to
access the other repositories. Certainly I have been known to use "git
-c ... upload-pack" while debugging various things.

So I dunno. You really have to jump through some hoops for it to matter,
but I just wonder if the git wrapper should be special-casing
upload-pack, too.

-Peff
