Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FEDC33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 18:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6C120715
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 18:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgAFSBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:01:20 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:35313 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFSBU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 13:01:20 -0500
X-Originating-IP: 157.49.189.75
Received: from localhost (unknown [157.49.189.75])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 7347040008;
        Mon,  6 Jan 2020 18:01:16 +0000 (UTC)
Date:   Mon, 6 Jan 2020 23:31:01 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] worktree: delete branches auto-created by 'worktree
 add'
Message-ID: <20200106180101.wwznvthla35x3qd2@yadavpratyush.com>
References: <20191214161438.16157-1-me@yadavpratyush.com>
 <20191214161438.16157-2-me@yadavpratyush.com>
 <CAPig+cRL5w7azdALeBKKisTZwjgU6QhBqJRzQqDENjYiaTT0oA@mail.gmail.com>
 <CAPig+cQmqKiYWDWFH5eK2S6XPOi2t2+8Oas8yZa8R=bKLym3wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQmqKiYWDWFH5eK2S6XPOi2t2+8Oas8yZa8R=bKLym3wQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01/20 11:20PM, Eric Sunshine wrote:
> On Fri, Dec 27, 2019 at 6:05 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Sat, Dec 14, 2019 at 11:16 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > > When no branch name is supplied to 'worktree add', it creates a new
> > > branch based on the name of the directory the new worktree is located
> > > in. But when the worktree is later removed, that created branch is left
> > > over.
> >
> > This is describing the existing (intentional) behavior but doesn't
> > explain why this might be annoying or problematic. To help sell the
> > patch, it might make sense to say something about how the behavior can
> > trip up newcomers to git-worktree, leaving them to wonder why they are
> > accumulating so many branches that they weren't aware they created. A
> > comment about why you think "git worktree add -d foo" is not a viable
> > way to side-step the creation of unwanted branches might also be
> > worthwhile.
> 
> As an alternative to this patch, would the simpler approach of
> improving git-worktree documentation to do a better job of pointing
> people at -d/--detach as a way to side-step unwanted branch creation
> make sense? That is, at minimum, enhance the "Description" section to
> prominently talk about throwaway worktrees (created with -d/--detach),
> and add an example to the "Examples" section (perhaps as the first
> example) showing creation/use/deletion of a throwaway worktree.
> 
> Some points in favor of just updating the documentation to address
> this issue (rather than implementing the new behavior suggested by
> this patch) include:
> 
> * far simpler; no code to implement or debug
> 
> * no (surprising) behavior changes
> 
> * "git worktree add -d foo" is about as easy to type and remember as
>   "git worktree add foo"

FYI, I'm running Git v2.24.1 and 'git worktree add' doesn't accept the 
option '-d'. It only accepts '--detach'. And looking at the current 
'next', I don't see the option mentioned in git-worktree.txt. So at the 
very least, we should start by actually adding the option.
 
> Of lesser importance, it might make sense, as a followup, to add a
> configuration which changes the default behavior to detach instead of
> auto-creating a branch. I wonder if this could be piggybacked on the
> existing "worktree.guessremote" configuration. Or rather,
> retire/deprecate that configuration and add a new one which affects
> DWIM'ing behavior such that it becomes multi-state. Some possible
> values for the new configuration: "auto" (or "dwim" or whatever),
> "guessremote", "detach". (I haven't thought this through thoroughly,
> so there might be holes in my suggestion.)

Honestly, coupled with a configuration variable this alternative fits my 
use-case really well.

I think 'guessremote' does not describe very well what the config 
variable would actually do. So I think deprecating it would be a better 
idea.

Does 'worktree.newBranch' sound like a good name? (Disclaimer: I am 
terrible at naming things).
 
> There's at least one point not in favor of merely updating the
> documentation to promote -d/--detach more heavily, and that is that
> (presumably) the concept of detached HEAD is perceived as an advanced
> topic, so it may not be suitable for the newcomer or casual user.

I'm basing this off no data so take it with a grain of salt, but I think 
people who know Git enough to understand the concept of multiple 
worktrees should also understand what a detached HEAD is. And even if 
they already don't know what it is, they should have no trouble quickly 
reading one of the many great explanations available with a simple 
Google search.

My argument in favor of auto-deletion is that we should still try to 
have sane defaults. Leaving behind a branch the user didn't explicitly 
create and didn't use doesn't sound like a sane default to me.

The configuration variable path is easier and suits my needs really 
well, so I am inclined to just go with it. But making the whole user 
experience better for everyone is still something worthwhile. But then 
again, introducing a backwards-incompatible change might not be the best 
idea. So, I dunno.

-- 
Regards,
Pratyush Yadav
