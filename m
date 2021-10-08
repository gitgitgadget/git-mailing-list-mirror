Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C440DC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 03:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9078C60F9E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 03:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhJHDJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 23:09:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:35538 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhJHDJi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 23:09:38 -0400
Received: (qmail 31634 invoked by uid 109); 8 Oct 2021 03:07:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Oct 2021 03:07:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30075 invoked by uid 111); 8 Oct 2021 03:07:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Oct 2021 23:07:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Oct 2021 23:07:43 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de
Subject: Re: [PATCH] t/perf: do not run tests in user's $SHELL
Message-ID: <YV+1/0b5bN3o6qRG@coredump.intra.peff.net>
References: <20211002112640.hrn2ojndhoa2dd4c@gmail.com>
 <20211007184716.1187677-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211007184716.1187677-1-aclopte@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 07, 2021 at 08:47:16PM +0200, Johannes Altmanninger wrote:

> The environment variable $SHELL is usually set to the user's
> interactive shell. We never use that shell for build and test scripts
> because it might not be a POSIX shell.
> 
> Perf tests are run inside $SHELL via a wrapper defined in
> t/perf/perf-lib.sh. Use $TEST_SHELL_PATH like elsewhere.

Yes, I think this is the right thing to do. We didn't have
$TEST_SHELL_PATH back when this code was added, but I think it should
have been $SHELL_PATH from the start.

I wondered if we would always have TEST_SHELL_PATH set, but we should:
it is put unconditionally into GIT-BUILD-OPTIONS, and we will always
load that via test-lib.sh, even if the test is run outside of "make".

> ---
> 
> Regarding the inconsistency around $(SHELL) in Makefiles: we could do
> something like
> 
> 	-SHELL_PATH ?= $(SHELL)
> 	+SHELL_PATH ?= /bin/sh
> 	+SHELL = $(SHELL_PATH)
> 
> in some Makefiles. Though the upside (consistency & slightly easier to build
> with broken /bin/sh) seems fairly low, so I'd leave it be.

In general assuming that $SHELL is a valid /bin/sh replacement is
questionable (e.g., if your login shell is zsh or god forbid tcsh). But
I think GNU make will set SHELL=/bin/sh, rather than pick it up from the
environment (probably for this exact reason).

-Peff
