Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E543C0015E
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 02:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241411AbjHPC51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 22:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241472AbjHPC5S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 22:57:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570AB213E
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 19:57:17 -0700 (PDT)
Received: (qmail 5021 invoked by uid 109); 16 Aug 2023 02:57:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Aug 2023 02:57:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14346 invoked by uid 111); 16 Aug 2023 02:57:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Aug 2023 22:57:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Aug 2023 22:57:15 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick <patrickf3139@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Force usage of pager for diff, show, etc when piping to non-TTY
Message-ID: <20230816025715.GB2248431@coredump.intra.peff.net>
References: <CAMRL+qYYGJ-LYG8qZpJOq+_=YO_C7JSTH4TPDpbEA4fRdANP7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMRL+qYYGJ-LYG8qZpJOq+_=YO_C7JSTH4TPDpbEA4fRdANP7w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2023 at 05:09:13PM -0700, Patrick wrote:

> I noticed there is no option I can pass to git to use the pager set in
> my gitconfig even when piping to non-TTY. Is there a workaround? If
> not, may I request this as a new feature?

I don't think there is a workaround. We have "git --paginate", but it
really means "paginate this command using the default rules, even if it
is not a command that is usually paginated".

Looking at the code in setup_pager(), I think the check for "is stdout a
tty" is fed directly into the decision of whether to use a pager.
There's no way to override it within Git. You'd have to trick Git by
opening a pty in the calling program and pumping the data through it
(which is what our test suite does; see t/test-terminal.perl).

So I think it would need a new option. But...

> Use case: integrate tools like Delta or diff-so-fancy when building
> wrappers around git commands. See
> https://github.com/dandavison/delta/discussions/840 and
> https://github.com/PatrickF1/fzf.fish/discussions/202 for examples.

I'm not quite sure that's what you want. When a user configures a custom
pager using a prettifier tool like that, they usually further pipe the
output to a pager like "less". E.g., I have:

  [pager]
  log = diff-highlight | less

in my config. If you are trying to save output that looks like what the
user would see on their tty, you want the first half of that pipeline
(the diff-highlight here), but not the second (less). Of course it
mostly works because less is smart enough to behave like a noop "cat"
when stdout isn't a tty. So it might be OK in practice.

I think your script might be better off doing the piping itself. In
theory you could ask Git what the configured pager is and the run it
yourself, but:

  1. You can use "git var GIT_PAGER" to get the default pager, but not
     command-specific ones. So you'd have to check "git config
     pager.log", etc, yourself, which means reimplementing some of Git's
     logic.

  2. You'd get a string like "diff-highlight | less", and then you'd
     have to decide whether to parse off the "| less" part yourself,
     which is obviously error-prone since the string can be an
     arbitrarily complex shell expression.

When we were faced with a similar situation within Git, we ended up
adding a new config option: interactive.diffFilter. This is used by "add
-p", etc, to filter diffs that are shown to the user. It does mean the
user has to repeat themselves (I have to set it to "diff-highlight"
separately from my settings for pager.log, pager.diff, etc). But it's
unambiguous, and it gives the user the flexibility of configuring
various outputs differently if they choose.

So depending on what your script does, you could use a similar config
option. Or even just use interactive.diffFilter if your use case is
conceptually the same.

-Peff
