Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A00C05027
	for <git@archiver.kernel.org>; Sun, 29 Jan 2023 06:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjA2Gff (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Jan 2023 01:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2Gfe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2023 01:35:34 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DBC166EB
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 22:35:32 -0800 (PST)
Received: (qmail 24803 invoked by uid 109); 29 Jan 2023 06:35:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 29 Jan 2023 06:35:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18256 invoked by uid 111); 29 Jan 2023 06:35:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Jan 2023 01:35:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 29 Jan 2023 01:35:28 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: t5559 breaks with apache 2.4.55
Message-ID: <Y9YTsF4a8lL7uHm+@coredump.intra.peff.net>
References: <Y8ztIqYgVCPILJlO@coredump.intra.peff.net>
 <Y81lQwG85+Skujja@pobox.com>
 <Y9Jmfg/jlSszVep4@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9Jmfg/jlSszVep4@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2023 at 06:39:42AM -0500, Jeff King wrote:

> Yeah, after seeing that, I'm quite sure this is a mod_http2 issue. It
> would be nice to bisect within the mod_http2 history to find the
> culprit, but I'd first have to figure out how to build standalone apache
> modules. ;)

This turned out to be quite painless, so I bisected using the source at:

  https://github.com/icing/mod_h2

Unfortunately, it's not super helpful for identifying the problem.  The
culprit turns out to be 16ffed9692b, which has a 450-line diff. The
commit message is:

  * refactored stream response handling to reflect the different phases
    (response/data/trailers) more clearly and help resolving cpu busy loops.

But that does at least give me more confidence that the bug is in
mod_http2, and isn't, say, some intentional behavior change there that
happens to trigger a bug in curl.

I opened an issue here: https://github.com/icing/mod_h2/issues/243

So we'll see if that helps.

I re-read your earlier thread, and the version problems you have don't
quite line up. I think you were having issues with mod_http2 2.0.9, but
the older version (1.5.19) worked. I was OK with 2.0.9, but upgrading to
2.0.10 broke things. I'd hate to have to disable t5559 by default; it
does catch some cases that would trigger in the real-world (since real
sites like GitHub are using http2). But if it's too unreliable in
practice, that might be the path of least resistance.

-Peff
