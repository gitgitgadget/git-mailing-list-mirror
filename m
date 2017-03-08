Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C35202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 12:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbdCHM5V (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 07:57:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:40409 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752266AbdCHM5U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 07:57:20 -0500
Received: (qmail 28786 invoked by uid 109); 8 Mar 2017 07:30:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 07:30:37 +0000
Received: (qmail 11498 invoked by uid 111); 8 Mar 2017 07:30:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 02:30:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Mar 2017 02:30:35 -0500
Date:   Wed, 8 Mar 2017 02:30:35 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/9] Fix the early config
Message-ID: <20170308073035.pt5ysp6bzpozoqps@sigill.intra.peff.net>
References: <cover.1488506615.git.johannes.schindelin@gmx.de>
 <cover.1488562287.git.johannes.schindelin@gmx.de>
 <20170304073952.drfgy7jacnlm6tum@sigill.intra.peff.net>
 <alpine.DEB.2.20.1703071314180.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703071314180.3767@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 07, 2017 at 03:31:43PM +0100, Johannes Schindelin wrote:

> >   /*
> >    * Find GIT_DIR of the repository that contains the current working
> >    * directory, without changing the working directory or other global
> >    * state. The result is appended to gitdir. The return value is NULL
> >    * if no repository was found, or gitdir->buf otherwise.
> >    */
> 
> I changed it a little bit more. In particular, I changed the
> discover_git_directory() function to return the pointer to the path
> itself: it provides additional value, and if that is not what the caller
> wants, they can use git_dir->buf just as well.

Yes, that makes much more sense.

> There is one more thing I included in v4: when I (re-)implemented that
> pre-command/post-command hook I was hinting at earlier, the test suite
> identified a problem where an invalid .git file would prevent even `git
> init` from working (it was actually much more complicated than that, but
> the gist is that `git -p init` would fail, no matter how much sense it
> may make to you to paginate an `init` run, it should still not fail,
> right?). So I added a patch on top to fix that.

Good catch. Another "non-gentle" thing I noticed here while looking at
another thread: the repository-format version check uses the config
parser, which will die() in certain circumstances. So for instance:

  $ git init
  $ git rev-parse && echo ok
  ok

  $ echo '[core]repositoryformatversion = 10' >.git/config
  $ git rev-parse && echo ok
  fatal: Expected git repo version <= 1, found 10

  $ echo '[core]repositoryformatversion = foobar' >.git/config
  $ git rev-parse && echo ok
  fatal: bad numeric config value 'foobar' for 'core.repositoryformatversion' in file .git/config: invalid unit

  $ echo '[co' >.git/config
  $ git rev-parse && echo ok
  fatal: bad config line 1 in file .git/config

Your series correctly avoids the first failure by calling the
read/verify_repository_format functions correctly. But I think it would
get tripped up by the other two.

Fixing the first one is probably not too hard; check_repo_format()
should use a more forgiving parser than git_config_int().

The second one I thought would be tricky, but it looks like we added a
die_on_error flag in b2dc09455. That does what we want, but it needs to
be plumbed through to git_config_from_file().

> And another change: the GIT_DIR_NONE value was handled incorrectly in
> discover_git_directory().

This is the "if (setup_git_directory_1() <= 0)" change from the
interdiff? That's subtle. The compiler could have noticed if we used a
switch statement here. But then any new error conditions would have to
be added to that switch statement.

> I am slightly disappointed that the these additional problems were not
> spotted in any review but my own. And I had not even included a Duck.

Get used to being disappointed, I guess. A non-zero number of bugs will
slip through when writing code _and_ when reviewing it.

> [ceil_offset]
> Hopefully that clears up the picture?

Yes, it does. Thanks.

-Peff
