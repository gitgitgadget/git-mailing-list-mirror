Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4411C6FA8F
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbjH2XdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239342AbjH2XdC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:33:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00791AD
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:32:59 -0700 (PDT)
Received: (qmail 14718 invoked by uid 109); 29 Aug 2023 23:32:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 23:32:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19620 invoked by uid 111); 29 Aug 2023 23:32:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 19:32:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 19:32:52 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 02/22] sequencer: mark repository argument as unused
Message-ID: <20230829233252.GA225495@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
 <20230828214717.GB3831137@coredump.intra.peff.net>
 <e65c93ec-0221-492b-b538-450b60cf1e59@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e65c93ec-0221-492b-b538-450b60cf1e59@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2023 at 04:55:30PM +0100, Phillip Wood wrote:

> > We could change the path helper to use REPO_GIT_PATH_FUNC(), but doing
> > so piecemeal is not great. There are 41 uses of GIT_PATH_FUNC() in
> > sequencer.c,
> 
> Wow, I knew there were quite a few but I hadn't realized there were that
> many. Changing them all to take a struct repository will be a big change and
> will make struct repo_cache_path a lot larger.

Yeah. One of the things that gave me pause is that some of them may need
to be renamed, as well. Most of the existing ones are static local
within sequencer.c, so names like git_path_head_file() are OK. But
REPO_GIT_PATH_FUNC() requires a pointer in the global repo_cache_path,
so the names need to be appropriate for a global view.

> > Note that we could also drop this parameter entirely, as the function is
> > always called directly, and not as a callback that has to conform to
> > some external interface. But since we'd eventually want to use the
> > repository parameter, let's leave it in place to avoid disrupting the
> > callers twice.
> 
> I think that makes sense as we're going to need that argument eventually. I
> was curious as to why this function takes a repository argument. When the
> function was added in 4a72486de97 (fix cherry-pick/revert status after
> commit, 2019-04-16) it called parse_insn_line() which takes a repository
> argument. It was refactored in ed5b1ca10b (status: do not report errors in
> sequencer/todo, 2019-06-27) and I failed to notice that the repository was
> unused afterwards.

Thanks for digging there. I usually do something similar for these
patches (to help verify that there's no extra bug lurking), but with
"struct repository" ones, the answer was usually uninteresting ("it
should be used, but the underlying functions don't support it" kind of
thing).

Since I'm re-rolling anyway, I'll throw your research into the commit
message.

-Peff
