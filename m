Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D7201F461
	for <e@80x24.org>; Tue, 27 Aug 2019 19:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbfH0TFL (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 15:05:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:58440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730668AbfH0TFL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 15:05:11 -0400
Received: (qmail 27256 invoked by uid 109); 27 Aug 2019 19:05:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Aug 2019 19:05:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4398 invoked by uid 111); 27 Aug 2019 19:06:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Aug 2019 15:06:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Aug 2019 15:05:10 -0400
From:   Jeff King <peff@peff.net>
To:     Vipul <finn02@disroot.org>
Cc:     git@vger.kernel.org
Subject: Re: Support for an interactive confirmation prompt when users can
 possibly lose their work like some UNIX commands
Message-ID: <20190827190509.GB3150@sigill.intra.peff.net>
References: <c1136131-0a9e-9dbb-3ad7-495ac96c1ef0@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1136131-0a9e-9dbb-3ad7-495ac96c1ef0@disroot.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 09:53:30AM +0000, Vipul wrote:

> Sometimes, I messed-up with git repository and lost works due
> carelessness. This includes reset a branch instead of other, drop the
> stash etc by mistake. I wonder, is there way to a get an interactive
> confirmation prompt (which ask for yes/no option) before executing those
> commands when users can possibly lose their work? Like, some UNIX
> commands have support for an interactive prompt (like 'rm -i', 'mv -i',
> 'cp -i', etc) for ex: before deleting and overwriting a file a
> confirmation is prompt and asking for users permission.
> 	If there would no such feature available in git, so how do other people
> avoid these kind of mistakes?

The usual philosophy in Git is not to bother the user with
confirmations, but to allow recovery after a mistake.

If you've moved a branch pointer around (e.g., via "git branch -f" or
"git reset"), you can recover it from the reflog.

In the case of a mistakenly dropped stash, there's no reflog (the stash
list itself is implemented as a reflog!), but you can use "git fsck" to
generate a list of "dangling" commits. These are commits which are
unreferenced, but they hang around until at least the next git-gc run.

Note that there _are_ some commands which are not reversible: mostly
things that drop content from the working tree. So "git reset --hard" is
one, and "git clean" is another. There have been discussions and even
some patches about storing the lost in an "undo log", but nothing has
been merged.

-Peff
