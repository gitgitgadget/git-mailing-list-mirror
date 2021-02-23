Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5E4C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 00:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76ED564DE9
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 00:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhBWAjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 19:39:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:40920 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhBWAjL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 19:39:11 -0500
Received: (qmail 22452 invoked by uid 109); 23 Feb 2021 00:38:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Feb 2021 00:38:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20056 invoked by uid 111); 23 Feb 2021 00:38:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Feb 2021 19:38:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Feb 2021 19:38:30 -0500
From:   Jeff King <peff@peff.net>
To:     Yaron Wittenstein <yaron.wittenstein@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [QUESTION] Tracking HEAD changes?
Message-ID: <YDROhhrM5qJti1ir@coredump.intra.peff.net>
References: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 11:12:11AM +0200, Yaron Wittenstein wrote:

> Is there any possible way to track changes to HEAD using hooks?
> 
> Being able to listen using hooks to events such as pre-head-checkout
> and post-head-checkout would be the best option (from my perspective).
> 
> To my knowledge, the only possible way to do that today is by adding a
> file watch over the refs directory.

No, I don't think there is currently a better way.

If you do go the file watch route, make sure you put one on HEAD, too
(to catch the case of checking out a different branch, as opposed to
updating it with a new commit). I use:

  gitdir=$(git rev-parse --git-dir)
  # We need delete_self to pick up changes to HEAD (since it gets renamed
  # over), and "move" to pick up changes in the refs directories.
  inotifywait -qq -t 60 -e delete_self -e move -r "$gitdir/HEAD" "$gitdir/refs"

in a script that I use for automatically running tests against the
current commit. (if you are doing something similar, I also recommend
https://github.com/mhagger/git-test for avoiding re-running against the
same commits repeatedly).

-Peff
