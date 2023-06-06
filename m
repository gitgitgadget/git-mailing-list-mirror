Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30ABC7EE23
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 02:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjFFCOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 22:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjFFCN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 22:13:57 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8A0F7
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 19:13:51 -0700 (PDT)
Received: (qmail 24110 invoked by uid 109); 6 Jun 2023 02:13:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Jun 2023 02:13:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2094 invoked by uid 111); 6 Jun 2023 02:13:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Jun 2023 22:13:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Jun 2023 22:13:49 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] add: check color.ui for interactive add
Message-ID: <20230606021349.GC89456@coredump.intra.peff.net>
References: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 05, 2023 at 07:42:43PM +0000, Derrick Stolee via GitGitGadget wrote:

> The fix is simple, to use git_color_default_config() as the fallback for
> git_add_config(). A more robust change would instead encapsulate the
> git_use_color_default global in methods that would check the config
> setting if it has not been initialized yet. Some ideas are being
> discussed on this front [1], but nothing has been finalized.

I think it should be OK to load the color config here, but note...

>     This is also a reoccurrence of the "config not loaded" bug from [3].

...that this case is a little different than the core.replaceRefs one.
One of the reasons we don't just load all config by default is that it
was an intentional scheme that not all programs would respect all
config, and color in particular was one of the things that wasn't meant
to be supported everywhere.

In other words, the idea was that porcelain like "git diff" would use
git_diff_ui_config(), which would load all the bells and whistles (like
color). But plumbing like git-diff-tree uses git_diff_basic_config(),
which skips those. And that way we can freely introduce new config
options without worrying that they will unexpectedly change the behavior
of plumbing commands (because each command has to manually opt into the
new config).

Now I won't claim that this approach hasn't created all sorts of
headaches over the years, and we might not be better off with something
more explicit (e.g., we parse all the config, but plumbing sets a flag
to say "I am plumbing; do not respect color.ui"). But it is roughly the
approach we've taken, so I'm mostly warning you that there may be
dragons here. :)

I say "roughly" because I actually think the rules have been bent a bit
over the years. In particular, I think that git_use_color_default is
initialized to COLOR_AUTO, so something like:

  git diff-tree -p HEAD

ends up colorizing, even though it's plumbing. Which is maybe not so
bad, but it's doubly silly that:

  git -c color.diff=false diff-tree -p HEAD

still colorizes, even though "git diff" in an equivalent situation would
not! That seems like a bug, but it's one that I suspect has been there
since we flipped color on by default many years ago, and nobody has
really complained.

So all of this is a big digression from your patch. I think for "git
add" it is probably OK to enable color by default. But I mostly want to
point out that trying to roll this into a more elaborate fix may run
afoul of all kinds of rabbit holes.

-Peff
