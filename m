Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D02AC433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 20:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8ED122BE8
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 20:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbhAOUAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 15:00:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:57650 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbhAOUAE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 15:00:04 -0500
Received: (qmail 3953 invoked by uid 109); 15 Jan 2021 19:59:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Jan 2021 19:59:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 516 invoked by uid 111); 15 Jan 2021 19:59:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Jan 2021 14:59:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Jan 2021 14:59:23 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ci/install-depends: attempt to fix "brew cask" stuff
Message-ID: <YAH0G+Y4fIxoTeZa@coredump.intra.peff.net>
References: <xmqqk0sevqlh.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0sevqlh.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 14, 2021 at 07:14:34PM -0800, Junio C Hamano wrote:

> It seems that homebrew suddenly started giving us trouble, like this:
> 
> https://github.com/git/git/runs/1705953982?check_suite_focus=true#step:3:70
> 
> Here is my attempt to work it around by blindly following the
> suggested course of action in the error message, without knowing
> what I am doing X-<.  I am not a Mac person.
> 
> What is frustrating is that every time we hit a minor snag like this
> to break one of the jobs, all other unrelated jobs are also taken
> down.

I think that has to do with the grouping in the workflow file (the
Windows builds, for example, will cancel the _other_ Windows tests if
they fail, but not the Linux ones).

So we could split the macos test out. It would probably involve
duplicating a little bit of the content, but we do something similar for
the dockerized builds. It might be that there is an option we can set to
say "keep building the others even if one of these fails", which would
give us the best of both.

>  	brew install $BREW_INSTALL_PACKAGES
>  	brew link --force gettext
> -	brew cask install --no-quarantine perforce || {
> +	brew install --cask --no-quarantine perforce || {

On a related note, it feels like perforce is a frequent offender for
triggering spurious failures (both for homebrew setup, but I have
definitely seen racy/flaky failures from it as well). I am tempted to
say it is not worth the trouble, but then I do not care at all about
git-p4 myself in the first place, so I may be biased.

-Peff
