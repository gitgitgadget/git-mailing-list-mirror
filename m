Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63EDC2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 20:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90646206C0
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 20:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgDHUOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:14:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:37440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728853AbgDHUOz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 16:14:55 -0400
Received: (qmail 13225 invoked by uid 109); 8 Apr 2020 20:14:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Apr 2020 20:14:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11687 invoked by uid 111); 8 Apr 2020 20:25:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2020 16:25:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Apr 2020 16:14:54 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>
Subject: Re: [PATCH] clean: explicitly `fflush` stdout
Message-ID: <20200408201454.GB2270445@coredump.intra.peff.net>
References: <pull.755.git.git.1586374380709.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.755.git.git.1586374380709.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 08, 2020 at 07:33:00PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: =?UTF-8?q?=EB=A7=88=EB=88=84=EC=97=98?= <nalla@hamal.uberspace.de>
> 
> For performance reasons `stdout` is buffered by default. That leads to
> problems if after printing to `stdout` a read on `stdin` is performed.

This first paragraph left me scratching my head. It's only a problem for
interactive uses, right? Would:

  This can lead to problems for interactive commands which write a
  prompt to `stdout` and then read user input on `stdin`. If the prompt
  is left in the buffer, the user will not realize the program is
  waiting for their input.

make sense?

> For that reason interactive commands like `git clean -i` do not function
> properly anymore if the `stdout` is not flushed by `fflush(stdout)` before
> trying to read from `stdin`.

I'm not sure I understand this "anymore". Did the buffering change at
some point, introducing a regression?

> So let's precede all reads on `stdin` in `git clean -i` by flushing
> `stdout`.

This (and the patch) make sense to me. It might be worth factoring out a
"read input from user" function and putting the flush there, but with
only three affected call sites, I'm OK with it either way.

>     This is yet another patch that was funneled through a Git for Windows
>     PR. It has served us well for almost five years now, and it is beyond
>     time that it find its final home in core Git.

Agreed. I guess it didn't affect people on other platforms much because
stdout to a terminal is generally line-buffered on POSIX systems. But
it's better not to rely on that, plus it could create confusion if
somebody tried to manipulate the interactive operation through a pipe
(e.g., driving it from a GUI or something).

-Peff
