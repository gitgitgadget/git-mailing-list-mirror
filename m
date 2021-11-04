Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FBEC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 09:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105F06113B
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 09:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhKDJ4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 05:56:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:52964 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhKDJ4h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 05:56:37 -0400
Received: (qmail 8249 invoked by uid 109); 4 Nov 2021 09:53:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Nov 2021 09:53:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32241 invoked by uid 111); 4 Nov 2021 09:54:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Nov 2021 05:54:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 4 Nov 2021 05:53:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alejandro Sanchez <asanchez1987@gmail.com>
Subject: Re: [PATCH 2/2] prompt.c: add and use a GIT_TEST_TERMINAL_PROMPT=true
Message-ID: <YYOttuoQT2X6HC/C@coredump.intra.peff.net>
References: <20190524062724.GC25694@sigill.intra.peff.net>
 <cover-0.2-00000000000-20211102T155046Z-avarab@gmail.com>
 <patch-2.2-964e7f4531f-20211102T155046Z-avarab@gmail.com>
 <YYJ5IpvGRoDvp8V6@coredump.intra.peff.net>
 <xmqqo8716sqx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8716sqx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 03, 2021 at 10:42:14AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Basically, I think I just disagree with this paragraph entirely. Moving
> > to stdin in the commits you referenced was done to help testing, but I
> > also think it's just a more flexible direction overall.
> 
> It is OK, and it is more convenient for writing test scripts, to
> take interactive input from the standard input stream, if the
> command does not use the standard input for other purposes.
> 
> "git am -i <mbox" cannot take prompted input via the standard input,
> but "git am -i mbox" is an easy workaround, for example.
> 
> Commands that are designed to be used in the downstream of a pipe
> (e.g. "git rev-list ... | git pack-objects") cannot easily use such
> a workaround, so they may still need to open and interact with
> /dev/tty if they want to do an interactive input, though [*].

True. The most Unix-y thing there would be to provide an option for
reading interactive input from an arbitrary descriptor. That gives the
most flexibility, though it's probably a bit arcane for most folks to
do:

  git foo | git bar --interactive-from=3 3</dev/tty

We could directly allow:

  git foo | git bar --interactive-from=/dev/tty

which is a bit less arcane. Or alternatively this could come from the
environment, like:

  export GIT_INTERACTIVE_FROM=/dev/tty
  git foo | git bar --interactive

Which is equivalent-ish to having a boolean env variable to say "read
from the terminal", except that it retains some more of the flexibility
(especially if we treat a numeric value as a descriptor).

Of course yet another option is to teach commands like pack-objects that
read input only from stdin to accept a command-line option to read that
input from a file. Then stdin is free for interactive use. ;)

But I would not do any of that until we had a command that was a good
candidate. In the case of git-am and git-bisect, I think it's fine to
assume that "-i" will use stdin.

-Peff
