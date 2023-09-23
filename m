Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF63CE7A88
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 06:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjIWGVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 02:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIWGVp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 02:21:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E72199
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 23:21:38 -0700 (PDT)
Received: (qmail 9392 invoked by uid 109); 23 Sep 2023 06:21:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Sep 2023 06:21:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24724 invoked by uid 111); 23 Sep 2023 06:21:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 Sep 2023 02:21:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 23 Sep 2023 02:21:37 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] .github/workflows: add coverity action
Message-ID: <20230923062137.GB1469962@coredump.intra.peff.net>
References: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com>
 <b23951c569660e1891a7fb3ad2c2ea1952897bd7.1695332105.git.me@ttaylorr.com>
 <d29b5fd3-3b44-89ca-62b4-cf93b23031fd@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d29b5fd3-3b44-89ca-62b4-cf93b23031fd@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 01:09:26PM +0200, Johannes Schindelin wrote:

> While it is true that that Action caches the Coverity Tool, this GitHub
> Action comes with a few non-niceties, too, one of them being that it
> actually fails to do its job. Looking at
> https://github.com/vapier/coverity-scan-action/blob/main/action.yml it can
> be very easily verified that `cov-configure` is not called. But as
> https://github.com/git-for-windows/git/actions/runs/6267593979/job/17020975444#step:9:12
> demonstrates, this command now _needs_ to be called:

Hmm. I have been running Coverity for years without running
cov-configure (using my own workflow), and I just tested Taylor's patch,
which worked fine. I wonder what is different about our setups; maybe it
is only an issue on the Windows version of Coverity?

Or maybe it has to do with the project setup on Coverity's server side,
since we have to provide the project name as part of the tool download
(though I don't know if that is purely for logging/auditing on their
side or if the delivered download is customized in any way).

> Another issue I ran into: That Action defaults to using the URL-encoded
> name of the repository (in our case, `git%2Fgit`) as Coverity project
> name. That project does not exist, though, and the GitHub Action therefore
> silently assumes an empty MD5 and attempts to extract a tar file that is
> actually a text file instead, with the contents "Not found".

It took me a minute to understand what you meant here, since the main
use of the project name is for uploading our tarball. But we also must
provide it (along with the token) just to download their scan software,
so that step failed.

And yes, I agree that the error checking in the Action could be better
(I also mentioned elsewhere in the thread that it did not detect or
report a failed upload). I'm not sure if it is easier to submit a patch
there, or if we are better off just doing it all inline (it is not that
much code either way).

> Further, when I tried to specify `win64` as this GitHub Action's
> `platform` input variable (whose existence suggests that platforms other
> than `linux64` are allowed), it totally fell over, trying to untar a
> `.zip` file.

Hmm, yes, I hadn't really considered running Coverity with different
build configurations. But I guess it needs to run code through the
compiler to do its magic, so you'd want to be able to run it on a
Windows build to hit any platform-specific code.

For general git/git use, I'm not sure if we'd want to run it on multiple
platforms, but I guess your plan would be to share the workflow code
between git/ and git-for-windows/, and use a repo variable to select the
platform for the latter. And for that case we can't rely on an Action
which doesn't support Windows.

I'll take a look at the patches you posted.

-Peff
