Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9B2C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 20:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiLNUxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 15:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLNUxw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 15:53:52 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E562C123
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 12:53:51 -0800 (PST)
Received: (qmail 28310 invoked by uid 109); 14 Dec 2022 20:53:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Dec 2022 20:53:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22740 invoked by uid 111); 14 Dec 2022 20:53:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Dec 2022 15:53:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Dec 2022 15:53:50 -0500
From:   Jeff King <peff@peff.net>
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] git: remove duplicate includes
Message-ID: <Y5o33g7sEljanQjv@coredump.intra.peff.net>
References: <pull.1394.git.git.1671036743272.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1394.git.git.1671036743272.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2022 at 04:52:23PM +0000, Rose via GitGitGadget wrote:

> These files are already included; we do not need to include them again

These all look good to me. I'm guessing you found them with something
like:

  git grep '^#include' '*.h' '*.c' | sort | uniq -d

and then looking over the output (it has many false positives because
sometimes includes are found in multiple conditionals).

There's one more in compat/regex/regex.h, where we include stddef.h
unconditionally, but also if HAVE_STDDEF_H is defined (which I think
we'd never set ourselves). The conditional bit comes from upstream, I
think, via d18f76dccf (compat/regex: use the regex engine from gawk for
compat, 2010-08-17). The unconditional one is from just after that, in
a997bf423d (compat/regex: get the gawk regex engine to compile within
git, 2010-08-17).

It's probably best to leave it as-is, since the "clean" fix would be to
remove the unused conditional, but that takes us further from upstream,
which would be a pain if we ever want to re-import a new version.

So I think your patch covers all of the cases we'd want to fix.

-Peff
