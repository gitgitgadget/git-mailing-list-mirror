Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6D21F404
	for <e@80x24.org>; Mon, 27 Aug 2018 23:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeH1DZ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 23:25:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:58128 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727021AbeH1DZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 23:25:58 -0400
Received: (qmail 10246 invoked by uid 109); 27 Aug 2018 23:37:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Aug 2018 23:37:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27213 invoked by uid 111); 27 Aug 2018 23:37:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 27 Aug 2018 19:37:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2018 19:37:06 -0400
Date:   Mon, 27 Aug 2018 19:37:06 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Gregory Oschwald <oschwald@gmail.com>, git@vger.kernel.org
Subject: Re: $GIT_DIR is no longer set when pre-commit hooks are called
Message-ID: <20180827233706.GA11663@sigill.intra.peff.net>
References: <CAFKzd1qaMU=K6uc62xL0DUyZOWxY79Qakaog2dzBjiNrmq0ydg@mail.gmail.com>
 <20180826004150.GA31168@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1808271824270.73@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808271824270.73@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 06:25:26PM +0200, Johannes Schindelin wrote:

> On Sat, 25 Aug 2018, Jeff King wrote:
> 
> > On Wed, Aug 22, 2018 at 04:16:00PM -0700, Gregory Oschwald wrote:
> > 
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 3bfeabc463..3670024a25 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -1440,6 +1440,7 @@ int run_commit_hook(int editor_is_used, const char *index_file, const char *name
> >  	int ret;
> >  
> >  	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
> > +	argv_array_pushf(&hook_env, "GIT_DIR=%s", get_git_dir());
> 
> We did something similar in sequencer.c, and it required setting
> `GIT_WORK_TREE`, too, to avoid problems in worktrees. Do you need the same
> here, too?

Hmm, good point. Maybe. If we're just trying to restore the original
behavior (i.e., fix a regression), then this would behave as the
original.

I'm not at all opposed to going beyond that and actually fixing more
cases. But I am a little nervous of introducing a new regression, given
the subtlety around some of our startup code.

My current understanding is:

  - If we're setting GIT_DIR, it's probably always save to set
    GIT_WORK_TREE (or GIT_IMPLICIT_WORK_TREE=0 if there isn't a
    worktree). I.e., there is no case I know that would be broken by
    this.

  - Passing GIT_DIR to any sub-process operating in the context of our
    repo (i.e., excluding cases where we're clearing local_repo_env) can
    break a script that expects to do:

      cd /another/repo
      git ...

    and operate in /another/repo. But such a script is already broken at
    least in some cases, because running the initial command as:

      git --git-dir=/some/repo

    will mean that GIT_DIR is set. So a hook depending on that is
    already broken, though it may be small consolation to somebody whose
    hook happened to work most of the time, because they do not pass in
    GIT_DIR.

  - Any command that uses setup_work_tree() (which includes things with
    NEED_WORK_TREE in git.c) would have always been setting GIT_DIR up
    through v2.17.x. So any hooks they run would have seen it
    consistently, and therefore are exempt from being regressed in the
    case above.

So I _think_ it would be safe to:

  1. Set GIT_DIR again anytime we call setup_work_tree(), because that's
     what has always happened.

  2. Start setting GIT_WORK_TREE at the same time. This didn't happen
     before, but it can't break anybody, and might help.

That makes the rules for when GIT_DIR is set confusing, but at least it
shouldn't regress. A more consistent rule of "hooks always see GIT_DIR"
(or even "any sub-process always sees...") is easier to explain, but
might break people in practice.

I notice also that sequencer.c sets an absolute path, since 09d7b6c6fa
(sequencer: pass absolute GIT_DIR to exec commands, 2017-10-31). That
does seem friendlier, though I wonder if could break any scripts. I
cannot think of a case, unless the intermediate paths were no accessible
to the uid running the process (but then, how would Git have generated
the absolute path in the first place?).

-Peff
