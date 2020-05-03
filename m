Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01ACC28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 07:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF998207DD
	for <git@archiver.kernel.org>; Sun,  3 May 2020 07:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgECHby (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 03:31:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:34972 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727067AbgECHby (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 03:31:54 -0400
Received: (qmail 19788 invoked by uid 109); 3 May 2020 07:31:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 May 2020 07:31:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4520 invoked by uid 111); 3 May 2020 07:31:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 03 May 2020 03:31:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 3 May 2020 03:31:53 -0400
From:   Jeff King <peff@peff.net>
To:     Paul Ganssle <paul@ganssle.io>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Segfault when rebasing with --autosquash
Message-ID: <20200503073153.GA1834438@coredump.intra.peff.net>
References: <017dbc40-8d21-00fb-7b0e-6708d2dcb366@ganssle.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <017dbc40-8d21-00fb-7b0e-6708d2dcb366@ganssle.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 02, 2020 at 09:22:09PM -0400, Paul Ganssle wrote:

> Unfortunately, I have been unable to /deliberately/ create a repository
> that exhibits this behavior using `git absorb`, but last time it
> happened I created a fork of my repo and trimmed out as many commits as
> I could while still exhibiting the behavior, you can find it here, along
> with instructions on how to trigger the bug:
> https://github.com/pganssle-bug-mwes/git_autosquash_bug_mwe

Thanks, this is a good reproduction recipe.

The todo list looks like this:

  pick f4af993 Add sphinx configuration
  pick 1203b9a Add tox environment for building docs
  pick bc28c93 Add minimal documentation for the ZoneInfo module
  pick a5f6347 fixup! Add minimal documentation for the ZoneInfo module
  pick ba18026 fixup! Add sphinx configuration
  pick 04bac75 fixup! Add sphinx configuration
  pick d25a6ae fixup! Add sphinx configuration
  pick 3747813 fixup! Add minimal documentation for the ZoneInfo module
  pick 64ebca8 fixup! Add minimal documentation for the ZoneInfo module
  pick 6c6a5a2 fixup! 3747813a8df9675a7c8b33c4fc665adc52d86b5b

The interesting one is the last one, which is a fixup of another fixup.

Building with ASan, I get this:

  ==1857141==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x60400000084c at pc 0x555555c3a37b bp 0x7fffffffbfb0 sp 0x7fffffffbfa8
  WRITE of size 4 at 0x60400000084c thread T0
      #0 0x555555c3a37a in todo_list_rearrange_squash /home/peff/compile/git/sequencer.c:5391
      #1 0x555555c386af in complete_action /home/peff/compile/git/sequencer.c:5196
      #2 0x555555842c2f in do_interactive_rebase builtin/rebase.c:366
      #3 0x55555584320a in run_sequencer_rebase builtin/rebase.c:401
      #4 0x555555849fc5 in run_specific_rebase builtin/rebase.c:949
      #5 0x555555855b29 in cmd_rebase builtin/rebase.c:2071
      #6 0x5555556f23b4 in run_builtin /home/peff/compile/git/git.c:447
      #7 0x5555556f2b06 in handle_builtin /home/peff/compile/git/git.c:672
      #8 0x5555556f3d2d in cmd_main /home/peff/compile/git/git.c:840
      #9 0x555555900565 in main /home/peff/compile/git/common-main.c:52
      #10 0x7ffff7322e0a in __libc_start_main ../csu/libc-start.c:308
      #11 0x5555556ee0d9 in _start (/home/peff/compile/git/git-rebase+0x19a0d9)

The code in question looks like this:

                  if (i2 >= 0) {
                          rearranged = 1;
                          todo_list->items[i].command =
                                  starts_with(subject, "fixup!") ?
                                  TODO_FIXUP : TODO_SQUASH;
                          if (next[i2] < 0)
                                  next[i2] = i;
                          else
                                  next[tail[i2]] = i;
                          tail[i2] = i;

where "i" is the index of the fixup commit and "i2" is the index of the
thing we're fixing up. When we hit that final fixup, our next[i2] will
not be negative. The commit we're fixing is already part of a fixup
chain. But it's not _itself_ being fixed up already, so its tail[i2] is
negative. And thus we'll try to write to next[-1].

I'm not sure if there's a simple logic error here, or a more fundamental
issue with the "next" array having an overloaded meaning. This all comes
from c44a4c650c (rebase -i: rearrange fixup/squash lines using the
rebase--helper, 2017-07-14), so I've added Dscho to the cc.

-Peff
