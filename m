Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29208C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 21:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0510320661
	for <git@archiver.kernel.org>; Thu,  7 May 2020 21:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgEGVCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 17:02:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:40998 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726218AbgEGVCL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 17:02:11 -0400
Received: (qmail 2797 invoked by uid 109); 7 May 2020 21:02:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 21:02:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22104 invoked by uid 111); 7 May 2020 21:02:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 17:02:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 17:02:10 -0400
From:   Jeff King <peff@peff.net>
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     public git mailing list <git@vger.kernel.org>
Subject: Re: "--quiet" for git-push does not suppress remote hook output
Message-ID: <20200507210210.GB38308@coredump.intra.peff.net>
References: <ba70b25b-906c-0117-2594-c606595c6816@redhat.com>
 <3cb011a9-ce3d-df38-01c6-062062f1c9c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3cb011a9-ce3d-df38-01c6-062062f1c9c2@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 02:16:36PM +0200, Laszlo Ersek wrote:

> On 05/07/20 14:05, Laszlo Ersek wrote:
> > Hi,
> > 
> > being a total novice in git internals, it seems like
> > "builtin/receive-pack.c" (on the server) forwards any receive hook
> > output with copy_to_sideband() back to git-push (on the client), even if
> > git-push was invoked with "--quiet".
> > 
> > And "case 2" in demultiplex_sideband() seems to print that "band" to
> > stderr (on the client), despite "--quiet".
> > 
> > Is this intentional? I'd prefer "git push --quiet" to suppress remote
> > hook output (unless the remote hook fails).

I think the client has to propagate sideband 2 from the server, since it
doesn't know whether the messages are informational or errors (and even
with --quiet, we'd want to show errors).

There is a "quiet" protocol capability; when you run "git push --quiet"
on the client, it tells the server to use "quiet", and then it passes
options to index-pack, etc, to suppress progress. But that never makes
it to hooks.

> Or else:
> 
> would it be the job of the particular receive hooks to observe and obey
> the "--quiet" option in the GIT_PUSH_OPTION_* environment variables?

That would work, but push options require the client to send them. We
should probably be passing knowledge of the "quiet" capability from
receive-pack down to the hooks, probably via an environment variable
(but not GIT_PUSH_OPTION_*, because that already has meaning).

-Peff
