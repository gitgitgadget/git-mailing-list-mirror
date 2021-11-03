Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F245C433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 11:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289A261073
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 11:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhKCMAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 08:00:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:52134 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231343AbhKCMAA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 08:00:00 -0400
Received: (qmail 5068 invoked by uid 109); 3 Nov 2021 11:57:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Nov 2021 11:57:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18674 invoked by uid 111); 3 Nov 2021 11:57:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Nov 2021 07:57:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Nov 2021 07:57:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alejandro Sanchez <asanchez1987@gmail.com>
Subject: Re: [PATCH 2/2] prompt.c: add and use a GIT_TEST_TERMINAL_PROMPT=true
Message-ID: <YYJ5IpvGRoDvp8V6@coredump.intra.peff.net>
References: <20190524062724.GC25694@sigill.intra.peff.net>
 <cover-0.2-00000000000-20211102T155046Z-avarab@gmail.com>
 <patch-2.2-964e7f4531f-20211102T155046Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.2-964e7f4531f-20211102T155046Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 02, 2021 at 05:48:10PM +0100, Ævar Arnfjörð Bjarmason wrote:

> In 97387c8bdd9 (am: read interactive input from stdin, 2019-05-20) we
> we fixed a behavior change in the conversion of git-am from a
> shellscript to a C program by changing it from using git_prompt() to
> using fgets(..., stdin). This ensured that we could run:
> 
>     echo y | git am --interactive [...]
> 
> But along with that in the subsequent 6e7baf246a2 (am: drop tty
> requirement for --interactive, 2019-05-20) we had to remove support
> for:
> 
>     git am --interactive </dev/null
> 
> This change builds on the refactoring of git_prompt() into "normal
> prompt" and "wants password" functions in the preceding commit, and
> moves "git am --interactive" back to using the prompt function.

Why do we want to do that? The only reason I mentioned that "/dev/null"
thing in the earlier commit is that it's pointless.

IMHO nothing should be using git_prompt() outside of the credential
code. They should just be reading from stdin, which is much more
flexible. If a caller knows that stdin is coming from elsewhere, they
can redirect from /dev/tty.

> It seems to me that using /dev/tty is desirable over using stdin,
> these prompts are meant to be interactive, and our acceptance of stdin
> was an artifact of how these commands were originally implemented in
> shellscript.

Basically, I think I just disagree with this paragraph entirely. Moving
to stdin in the commits you referenced was done to help testing, but I
also think it's just a more flexible direction overall.

-Peff
