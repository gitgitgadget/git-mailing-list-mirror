Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C67BC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 23:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiFHXxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 19:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiFHXxf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 19:53:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A839E487
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 16:55:26 -0700 (PDT)
Received: (qmail 6375 invoked by uid 109); 8 Jun 2022 23:55:25 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jun 2022 23:55:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Wed, 8 Jun 2022 19:55:25 -0400
From:   Jeff King <peff@peff.net>
To:     "R. Diez" <rdiez1999@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to watch files in a Git repository
Message-ID: <YqE27RU45kjNRwxf@coredump.intra.peff.net>
References: <68627d29-8ffd-2e22-46ca-c28c9e980177@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68627d29-8ffd-2e22-46ca-c28c9e980177@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 06, 2022 at 06:04:11PM +0200, R. Diez wrote:

> If there is nothing of the sort, I could write my own script in Bash
> or Perl. I can handle cron and sending e-mails, but I do not know much
> about Git's internals. Could someone provide a few pointers about how
> to code this? I would expect there is some command to list commits,
> and all files touched by a particular commit. And there would be some
> way to interface with Bash or Perl, which does not need parsing
> complicated text output from Git.

This sounds kind of like git-multimail:

  https://github.com/git-multimail/git-multimail

That's usually triggered from a hook, I think, but it would not be hard
to trigger it with arbitrary segments of history.

You'd probably want to keep a "seen" ref of processed commits, and move
from that, like:

  # assuming you just care about one branch on the remote, but this
  # concept can be extended to several
  branch=refs/remotes/origin/main
  seen=refs/heads/seen

  git fetch

  # I don't know what git-multimail expects, but this is similar to what
  # a server-side receive hook would show
  echo "$(git rev-parse $seen) $(git rev-parse $branch) $branch" |
  some-git-multimail-command

  # now move your pointer forward for next time
  git update-ref $seen $branch

If multimail doesn't do what you want, then you can probably just script
around:

  git rev-list $seen..$branch -- $paths_you_care_about |
  git diff-tree --stdin -r --name-only --format="Commit %h touched: " -- $paths_you_care_about

depending how you want to format things.

-Peff
