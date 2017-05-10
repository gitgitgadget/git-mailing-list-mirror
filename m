Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E581B2018D
	for <e@80x24.org>; Wed, 10 May 2017 04:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbdEJEqv (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 00:46:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:48599 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751984AbdEJEqu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 00:46:50 -0400
Received: (qmail 15649 invoked by uid 109); 10 May 2017 04:46:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 May 2017 04:46:48 +0000
Received: (qmail 32112 invoked by uid 111); 10 May 2017 04:47:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 May 2017 00:47:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 May 2017 00:46:45 -0400
Date:   Wed, 10 May 2017 00:46:45 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Script to rebase branches
Message-ID: <20170510044645.hqxkzljajaifwwsl@sigill.intra.peff.net>
References: <8D018370-79F9-450F-97AF-31EF4C95BA44@gmail.com>
 <20170509040943.j3n5li7fapiuvgbj@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1705091244420.146734@virtualbox>
 <20170509110249.eluxns2zz5jqh42k@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1705091418540.146734@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1705091418540.146734@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2017 at 02:32:37PM +0200, Johannes Schindelin wrote:

> > I didn't really expect anybody to use it verbatim, though. I was
> > providing it more for inspiration.
> 
> I deem it part of Git's mission is to avoid forcing everybody to write
> scripts so specific to their own needs that they cannot be shared easily.

Sure. I'd be happy if somebody used it as inspiration to make a tool for
everybody, too.

The two main reasons I don't polish and try to share the bits in my
Meta/ more widely are:

  1. Most of them are as much policy as they are implementation logic.
     So either you buy in completely to the worldview that I've assumed
     in my tools, or you end up fighting the tool (and by the time you
     make the tool configurable enough to handle all world-views, you
     haven't really helped anybody).

     I think the best thing to do with those logic bits is to add them
     as much as possible to Git itself (e.g., as command-line options).
     That keeps any personal scripts as thin wrappers that specify the
     policy.

  2. Some of the features are really powerful but also really dangerous.
     For example, my "rebase" script (which rebases all my topics) and
     my "private" script (which builds my daily "private" version of Git
     to run) both write a shell snippet into $GIT_DIR/continue.

     And then I have a git-continue alias that looks like this:

        #!/bin/sh
        SUBDIRECTORY_OK=Yes
        . git-sh-setup
        cd_to_toplevel

        if test -f "$GIT_DIR/continue"; then
          eval "$(cat "$GIT_DIR/continue")"
        elif test -d "$GIT_DIR/rebase-merge"; then
          git rebase --continue
        elif test -d "$GIT_DIR/rebase-apply"; then
          if test -f "$GIT_DIR/rebase-apply/applying"; then
            git am --continue
          else
            git rebase --continue
          fi
        elif test -f "$GIT_DIR/CHERRY_PICK_HEAD"; then
          git cherry-pick --continue
        else
          echo >&2 "nothing to continue"
          exit 1
        fi

     So when I run "git continue" it magically tries to pick up the
     operation in progress keep going. When it works, it works
     beautifully. But when it doesn't...well, you can dig yourself into
     a pretty confusing situation. It's worth it for me, because I can
     dig myself out. But I'm not sure it's something I'd encourage other
     people to use.

-Peff
