Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B901F424
	for <e@80x24.org>; Wed, 28 Mar 2018 09:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeC1Jrh (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 05:47:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:45744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751212AbeC1Jrg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 05:47:36 -0400
Received: (qmail 15368 invoked by uid 109); 28 Mar 2018 09:47:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Mar 2018 09:47:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6652 invoked by uid 111); 28 Mar 2018 09:48:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Mar 2018 05:48:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2018 05:47:34 -0400
Date:   Wed, 28 Mar 2018 05:47:34 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git complains packed-refs is not a directory when used with
 GIT_DIR and GIT_WORK_TREE envvars.
Message-ID: <20180328094733.GA1523@sigill.intra.peff.net>
References: <CACUQV5_3Pw+vnyyNUL4oE4tMLG_wKVdqdVk01rg4V92ufUYHHA@mail.gmail.com>
 <20180327063137.GA24044@sigill.intra.peff.net>
 <CACsJy8DP53Og1crS1bLoJf6w8cJhjGKy=ggfbsqzJ6AU4eNhPA@mail.gmail.com>
 <20180327164757.GB24747@sigill.intra.peff.net>
 <CACsJy8Bog6U7X-jvzDhq14heQWx0HA_21HsSYR0nykU9aDsCYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Bog6U7X-jvzDhq14heQWx0HA_21HsSYR0nykU9aDsCYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 07:09:36PM +0200, Duy Nguyen wrote:

> > I don't quite get why f57f37e2 doesn't want to call git_path(). Is it to
> > avoid the way the path is munged? Or is it to avoid some lazy-setup that
> > is triggered by calling get_git_dir() at all (which doesn't make much
> > sense to me, because we'd already have called get_git_dir() much
> > earlier). Or is it just because we may sometimes fill in refs->git_dir
> > with something besides get_git_dir() (for a submodule or worktree or
> > something)?
> 
> None of those, I think. git_path() does some magic to translate paths
> so that refs/... ends up with $GIT_COMMON_DIR/refs/... while "index"
> ends up with $GIT_DIR/index. Michael wanted to avoid that magic and
> keep the control within refs code (i.e. this code knows refs/ and
> packed-refs are shared, and pseudo refs are not, what git_path()
> decides does not matter).

Ah, OK (that is my first one, "avoid the way the path is munged", but
obviously I didn't spell it out very clearly).

> > Hmm. Typing that out, it seems like (3) is probably the right path.
> > Something like the patch below seems to fix it and passes the tests.
> 
> Honestly I think this is just another way to work around the problem
> (with even more changes than your abspath approach). The problem is
> with setup_work_tree(). We create a ref store at a specific location
> and it should stay working without lazily calling get_git_dir(), which
> has nothing to do (anymore) with the path we have given a ref store.
> If somebody changes a global setting like $CWD, it should be well
> communicated to everybody involved.

Yeah, I agree that the root of the problem is not the caching of
get_git_dir(), but that chdir() may invalidate assumptions made by other
parts of the program.

> I would rather have something like ref_store_reinit() in the same
> spirit as the second call of set_git_dir() in setup_work_tree. It is
> hacky, but it works and keeps changes to minimal (so that it could be
> easily replaced later).

So the non-hacky solution is to inform all callers that we've changed
directories, and they may need to recompute any relative paths.

It does seem backwards for setup_work_tree() to need to know about the
refs code. Should we have a system by which interested code can register
to learn about changes to global state? E.g., something like:

  typedef void (*chdir_notify_cb)(const char *old_cwd,
                                  const char *new_cwd,
                                  void *data);

  /* Register interest in hearing about chdir */
  void chdir_notify_register(chdir_notify_cb cb, void *data);

  /* Do a chdir and then tell everybody about it */
  void chdir_notify(const char *path);

Then the ref code (or anybody else) should be able to write a function
to normalize a relative path from the old_cwd into a relative one from
the new_cwd.

-Peff
