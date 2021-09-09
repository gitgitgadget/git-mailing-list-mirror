Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E74C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 20:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748AC610F8
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 20:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbhIIUU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 16:20:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:43320 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233471AbhIIUUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 16:20:25 -0400
Received: (qmail 800 invoked by uid 109); 9 Sep 2021 20:19:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Sep 2021 20:19:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16453 invoked by uid 111); 9 Sep 2021 20:19:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Sep 2021 16:19:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Sep 2021 16:19:14 -0400
From:   Jeff King <peff@peff.net>
To:     Yuri <yuri@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG REPORT] Intermittent errors: Unable to create
 '/usr/ports/.git/index.lock': File exists.
Message-ID: <YTpsQtJa2rX691c0@coredump.intra.peff.net>
References: <1fcdeb8f-5869-cfe4-6063-8d4fb5da709c@rawbw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fcdeb8f-5869-cfe4-6063-8d4fb5da709c@rawbw.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 12:29:32PM -0700, Yuri wrote:

> Once every ~20 times I call 'git commit' it fails like this:
> 
> $ git commit .
> fatal: Unable to create '/usr/ports/.git/index.lock': File exists.
> 
> Another git process seems to be running in this repository, e.g.
> an editor opened by 'git commit'. Please make sure all processes
> are terminated then try again. If it still fails, a git process
> may have crashed in this repository earlier:
> remove the file manually to continue.
> 
> 
> There's no other instance.

In previous cases of this we've seen, there usually _is_ another
instance, just not one directly triggered by the user. E.g., some GUI
clients will trigger "git status" in the background, which tries to
refresh the index.

If you're running any other Git-related tools (or anything via cron),
those might be worth investigating. Otherwise you might try using OS
tools to see which processes might be opening such a file (on Linux I'd
use inotifywait, but I'm not sure what's available on FreeBSD).

If you do find the culprit, one solution is to get it to use the
"--no-optional-locks" option. See the discussion of that option and
GIT_OPTIONAL_LOCKS in git(1), as well as the "BACKGROUND REFRESH"
section of git-status(1).

-Peff
