Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E125EC6FA8E
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 22:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiITW22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 18:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiITW20 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 18:28:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89315AC61
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 15:28:25 -0700 (PDT)
Received: (qmail 31775 invoked by uid 109); 20 Sep 2022 22:28:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Sep 2022 22:28:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15696 invoked by uid 111); 20 Sep 2022 22:28:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Sep 2022 18:28:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Sep 2022 18:28:24 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Stopak <jacob@initialcommit.io>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Newbie contribution idea for 'git log --children': input
 requested
Message-ID: <Yyo+iBNF1bydcQt+@coredump.intra.peff.net>
References: <Yx5qjPhZ5AHkPHr7@MacBook-Pro-3.local>
 <xmqqillth1am.fsf@gitster.g>
 <YyKzOk5AQBz1pmAh@coredump.intra.peff.net>
 <YyaOJa1FNyWK+M4U.jacob@initialcommit.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YyaOJa1FNyWK+M4U.jacob@initialcommit.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 17, 2022 at 08:19:01PM -0700, Jacob Stopak wrote:

> On Thu, Sep 15, 2022 at 12:08:10AM -0500, Jeff King wrote:
> > 
> > I usually solve this by doing a single traversal, and asking the pager
> > to jump straight to the commit of interest, at which point I can scroll
> > up and down to see the context. Like:
> > 
> >   git log --color | less +/$some_old_commit
> > 
> > I'm not 100% sure I understand the original use case. But if I do, and
> > that solves it, I wonder if we could make it more ergonomic somehow.
> 
> Great points thanks for the details. I do think your method addresses the use
> case I was trying to describe, which is being able to quickly see context in
> both directions when you jump to a commit far from any branch/tag.

One thing my suggestion doesn't help with is when $some_old_commit is
the current HEAD. Something like:

  git checkout HEAD~50
  git log --magically-start-at=HEAD

wouldn't work, because to get context you need to start traversing from
somewhere else. So really you want to start with "--branches --tags", or
maybe even "--all" as traversal points, and then show whatever commit
(be it HEAD or something else) in context.

> But like you implied, it would be nice to be able to do it with a real command
> line option to git log instead of repiping into less, something like:
> 
>     git log --scroll-to=commit_id
> 
> I peeked into builtin/log.c and saw how it calls setup_pager(); at the end of
> cmd_log_init_finish(...). I have a basic understanding now of how the default
> pager and pager environment are roped in.
> 
> One obvious issue is that different pagers might have different ways (or no way
> at all) to auto-scroll to a pattern. But this might be solved by allowing the
> user to add their pager option such as +/ to the pager environment, which would
> only be applied when the user adds the --scroll-to=commit_id option to git log.

Yes, exactly. It's awkward to assume too much about the pager, because
it could be literally anything. I think the worst thing we can do is
stick extra bits on the command-line like this, because it may actually
break other pagers. As you noted, we do have a default LESS variable,
which is OK, because at worst it is simply ignored.

I think we _could_ append "+/whatever" into $LESS, and that would work.
It feels kind of dirty somehow, though.

> Anyway, then the commit_id would be dynamically added after, probably in a format like
> "commit <commit_id>" so that the same pattern in commit messages doesn't match.

Right, and you can anchor it with "+/^commit ...". But of course that
depends on the output format. Something like "--oneline" would have a
partial commit. If done inside Git, it would know the format it will
use. But if you don't mind being a little sloppy, you can probably write
a regex which works well enough.

Taking it all together, a script like this works:

-- >8 --
#!/bin/sh

focus=$1; shift

# use --short rather than --verify so we match --oneline
short=$(git rev-parse --short "$focus") || exit 1

# this regex tries to match a variety of formats:
#
#   - anchor to the left to avoid false positives
#   - make "commit" optional to catch both regular and oneline
#   - skip --graph markers
#   - we can ignore colors; less skips ANSI codes when matching
regex='^[*|\\ ]*(commit )?'

# yuck, there's no way to ask "which pager would you use for git-log".
# Stuffing the value inside $LESS works, but if we override Git's
# internal value, then we have to recreate it.
LESS="${LESS-FRX} +/$regex$short"
export LESS

exec git log --branches --tags "$@"
-- >8 --

Saving that as git-focus and setting the execute bit lets you do stuff
like:

  git checkout HEAD~50
  git focus HEAD

I think this could be done inside Git, though it would be a little
awkward. Maybe it's worth living with that script for a while and seeing
if you like it.

-Peff
