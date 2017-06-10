Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961331FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 09:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbdFJJo1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 05:44:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:37603 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbdFJJo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 05:44:26 -0400
Received: (qmail 8275 invoked by uid 109); 10 Jun 2017 09:44:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 09:44:25 +0000
Received: (qmail 30183 invoked by uid 111); 10 Jun 2017 09:44:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 05:44:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 05:44:24 -0400
Date:   Sat, 10 Jun 2017 05:44:24 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/8] read_early_config(): optionally return the
 worktree's top-level directory
Message-ID: <20170610094423.kscoqrljxjki3np4@sigill.intra.peff.net>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
 <0cef47383c0dd2287ffda2a6eaf1f430ed3ee726.1496951503.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0cef47383c0dd2287ffda2a6eaf1f430ed3ee726.1496951503.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 08, 2017 at 09:53:41PM +0200, Johannes Schindelin wrote:

> So far, when we invoked the early config code path, we implicitly
> determined the top-level directory of the worktree while discovering the
> .git/ directory.
> 
> And then we simply forgot that information.
> 
> However, when we expand aliases, we very much need that information, as
> aliases expanding to shell commands, i.e. whose value starts with an
> exclamation point, have to be executed in the top-level directory of the
> worktree. There are exceptions abound, not only with non-shell aliases
> (which are supposed to be executed in the original working directory
> instead), but also when being started inside the .git/ directory or in a
> worktree created via `git worktree add`.

I understand why you wrote it this way, but it really feels backwards.
We're calling a function that's about config, and oh by the way
sometimes it tells us about which git directory we're in (and sometimes
not because it didn't actually run discover_git_directory anyway).

It would make a lot more sense to me if we told read_early_config() "oh
by the way, I discovered the git directory already, here it is".

The same applies to the later patch to pass the information through
alias_lookup().

Taking a step back, this is really just an optimization, right? The
cleanest thing would be for the alias code, right before launching a
shell alias, to discover_git_directory(). But you don't want to do that
because it's too expensive?

If so, my questions would be:

  1. Is it actually that expensive, or is this premature optimization?
     We are, after all, about to fork and execute a shell. Have we
     measured?

  2. Can we cache the results of discovery_git_directory() between
     calls? That would not only fix your issue here, but it would
     optimize the calls we make when we call read_early_config() for
     multiple items (e.g., both pager and alias config).

     The only trick is making sure our previous value is still valid.
     I suspect it would work to just ignore this, as we only chdir when
     doing setup_git_directory(), and that should generally take
     precedence over discover_git_directory() being called at all. But
     for extra safety, we should be able to key it to the cwd, like:

       strbuf_getcwd(&now_cwd);
       if (!strbuf_cmp(&cached_cwd, &now_cwd) {
               strbuf_addbuf(cdup_dir, &cached_cdup_dir));
               return xstrdup(cached_gitdir);
       }
       strbuf_swap(&cached_cwd, &now_cwd);
       strbuf_release(&now_cwd);
       ... rest of function, but store result in cached_gitdir ...

-Peff
