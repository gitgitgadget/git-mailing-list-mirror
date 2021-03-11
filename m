Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740D6C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 19:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A68264F10
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 19:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCKTZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 14:25:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:60848 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229938AbhCKTZh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 14:25:37 -0500
Received: (qmail 16921 invoked by uid 109); 11 Mar 2021 19:25:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Mar 2021 19:25:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13008 invoked by uid 111); 11 Mar 2021 19:25:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Mar 2021 14:25:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Mar 2021 14:25:36 -0500
From:   Jeff King <peff@peff.net>
To:     Tassilo Horn <tsdh@gnu.org>
Cc:     git@vger.kernel.org
Subject: Re: [Bug] Stashing during merge loses MERGING state
Message-ID: <YEpusE7ZIE5RgOws@coredump.intra.peff.net>
References: <875z1xwznd.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875z1xwznd.fsf@gnu.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 03:00:58PM +0100, Tassilo Horn wrote:

> Here is a simple recipe with a publicly available repo:
> 
> ```sh
> git clone https://github.com/magit/magit.git
> # Current master is 4735b9254105eb7dd538f979d8b4c6ab96b827b9
> cd magit
> git merge origin/km/reshelve-rewrite # currently 0073bff21c826a57a4b48076074bdbba092d4b67
> # Conflict in magit-extras.el
> git add lisp/magit-extras.el
> git stash
> # The MERGING state is gone
> git stash pop
> # And it won't come back, so when I commit now, my "merge" has just
> # one parent.
> ```
> 
> What did you expect to happen? (Expected behavior)
> 
> I expected that stashing during a merge will keep the MERGING state.

Thanks for providing a clear recipe and expectation. However, I think
Git is working here as intended. The MERGE_HEAD file (which is how "git
status", the prompt, etc figure out that we're in the middle of a merge)
is cleaned up when stash runs "git reset --hard" under the hood.

However, I don't think we would want to _not_ clear that file. The
conflicted merge placed some changes into the index and working tree
representing what happened on the branch you're merging in. Then making
the stash (and the reset of the working tree) removes those changes. If
we were to leave MERGE_HEAD in place and you ran "git commit", then it
would create a merge commit that claims to have incorporated everything
from the other branch, but has quietly dropped those changes as part of
the merge resolution.

> Or that popping the stash again would also restore the MERGING state.

This would make more sense: the stash records that part of the state,
and then we make it available again later when the stash is applied.
However, that feature doesn't exist yet.

I can't offhand think of a reason it couldn't be implemented. It's
possible that it would mess with somebody else's workflow (e.g., they
think it's useful to stash some changes independent of the merging
state, and then apply it later, perhaps while replaying the same or a
similar merge). So it might need to be tied to a command-line option or
similar.

-Peff
