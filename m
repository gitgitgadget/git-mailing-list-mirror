Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156B81F859
	for <e@80x24.org>; Fri,  9 Sep 2016 11:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbcIILWW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 07:22:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:40653 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754068AbcIILWW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 07:22:22 -0400
Received: (qmail 4584 invoked by uid 109); 9 Sep 2016 11:22:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 11:22:20 +0000
Received: (qmail 23538 invoked by uid 111); 9 Sep 2016 11:22:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 07:22:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2016 07:22:18 -0400
Date:   Fri, 9 Sep 2016 07:22:18 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Max Nordlund <max.nordlund@sqore.com>
Subject: Re: [PATCH 2/3] t0001: work around the bug that reads config file
 before repo setup
Message-ID: <20160909112217.gfalcbtiy2tzzhm5@sigill.intra.peff.net>
References: <CACsJy8CZf0O+uyQaeJ4gcx4XN8ivfFyni+3586WX_R2QM4XgVw@mail.gmail.com>
 <20160908134719.27955-1-pclouds@gmail.com>
 <20160908134719.27955-3-pclouds@gmail.com>
 <20160908200202.gmvpqrwwjavxmojb@sigill.intra.peff.net>
 <CACsJy8DmbdGODY+qT38OSkaegSpdO7yAt6e67sHB=_BT8Y7=_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8DmbdGODY+qT38OSkaegSpdO7yAt6e67sHB=_BT8Y7=_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 09, 2016 at 05:32:21PM +0700, Duy Nguyen wrote:

> On Fri, Sep 9, 2016 at 3:02 AM, Jeff King <peff@peff.net> wrote:
> > On Thu, Sep 08, 2016 at 08:47:18PM +0700, Nguyễn Thái Ngọc Duy wrote:
> >
> >> git-init somehow reads '.git/config' at current directory and sets
> >> log_all_ref_updates based on this file. Because log_all_ref_updates is
> >> not unspecified (-1) any more. It will not be written to the new repo's
> >> config file (see create_default_files() function).
> >>
> >> This will affect our tests in the next patch as we will compare the
> >> config file and expect that core.logallrefupdates is already set to true
> >> by "git init main-worktree".
> >
> > This is a bug for more than worktrees, and is something I'm working on
> > fixing
> 
> Great! test_expect_failure it is. But I'll make a separate patch,
> independent from this series though.

If you're curious what the fix looks like, it's in:

  https://github.com/peff/git jk/config-repo-setup

The actual fix is in the final patch, but it needed a lot of preparatory
work to avoid breaking various programs that made bad assumptions (and
in the process, I uncovered a ton of other minor bugs).

This is just a preview in case you're interested, for two reasons:

  1. I literally _just_ put the finishing touches on it, and it's
     extensive and tricky enough that I really should give it one more
     proofread.

  2. There may be other related fallouts from the bug related to running
     "git init /path/to/foo" when "/path/to/foo" already exists (and in
     that case we _do_ want to read its config, but not the config from
     an existing repository). This may all just work fine, but I need to
     think about some tests.

-Peff
