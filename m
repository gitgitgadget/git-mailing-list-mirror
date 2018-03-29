Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B52F1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 17:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeC2RuK (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 13:50:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:47612 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750866AbeC2RuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 13:50:09 -0400
Received: (qmail 18061 invoked by uid 109); 29 Mar 2018 17:50:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 17:50:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20718 invoked by uid 111); 29 Mar 2018 17:51:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 13:51:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 13:50:07 -0400
Date:   Thu, 29 Mar 2018 13:50:07 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] set_work_tree: use chdir_notify
Message-ID: <20180329175007.GC31833@sigill.intra.peff.net>
References: <20180328173656.GA29094@sigill.intra.peff.net>
 <20180328174215.GC16274@sigill.intra.peff.net>
 <CACsJy8CAjb4zdAgD5H9OZOAoHdrRFzGm9gaL8Wbna+GXJJCW4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CAjb4zdAgD5H9OZOAoHdrRFzGm9gaL8Wbna+GXJJCW4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 07:02:21PM +0200, Duy Nguyen wrote:

> On Wed, Mar 28, 2018 at 7:42 PM, Jeff King <peff@peff.net> wrote:
> > When we change to the top of the working tree, we manually
> > re-adjust $GIT_DIR and call set_git_dir() again, in order to
> > update any relative git-dir we'd compute earlier.
> 
> Another way to approach this problem is not delaying chdir() at all.
> We have to delay calling setup_work_tree() and not do it in
> setup_git_directory() because it can die() when chdir() fails. But in
> many cases, the command does not actually need the worktree and does
> not deserve to die. But what if we make setup_work_tree be gentle?
> 
> If it successfully chdir() at the end of setup_git_directory() (and
> perhaps before the first set_git_dir call), great! The problem we're
> dealing here vanishes. If it fails, don't die, just set a flag. Later
> on when a command requests a worktree, we can check this flag and now
> can die().
> 
> It's less code this way, but it uses up more of your (or my) time
> because even though the first set_git_dir() call actually happens at 8
> places. Is it worth trying ?

I do kind of like that. I'm reasonably happy with the chdir_notify()
interface, but it would be nicer still if we could get rid of it in the
first place. It's true that we _could_ chdir from other places, but
realistically speaking, we do our one big chdir as part of the setup
process.

-Peff
