Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53EF61FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 19:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbcFUT10 (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 15:27:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:58069 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751002AbcFUT1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 15:27:25 -0400
Received: (qmail 1905 invoked by uid 102); 21 Jun 2016 19:25:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 15:25:59 -0400
Received: (qmail 27619 invoked by uid 107); 21 Jun 2016 19:26:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 15:26:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2016 15:25:57 -0400
Date:	Tue, 21 Jun 2016 15:25:57 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/3] perf: make the tests work in worktrees
Message-ID: <20160621192557.GA2311@sigill.intra.peff.net>
References: <cover.1462955446.git.johannes.schindelin@gmx.de>
 <cover.1463145936.git.johannes.schindelin@gmx.de>
 <0f0bc7ac7b6eebed22b05c277cf7352122d164d2.1463145936.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f0bc7ac7b6eebed22b05c277cf7352122d164d2.1463145936.git.johannes.schindelin@gmx.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, May 13, 2016 at 03:25:58PM +0200, Johannes Schindelin wrote:

> This patch makes perf-lib.sh more robust so that it can run correctly
> even inside a worktree. For example, it assumed that $GIT_DIR/objects is
> the objects directory (which is not the case for worktrees) and it used
> the commondir file verbatim, even if it contained a relative path.
> 
> Furthermore, the setup code expected `git rev-parse --git-dir` to spit
> out a relative path, which is also not true for worktrees. Let's just
> change the code to accept both relative and absolute paths, by avoiding
> the `cd` into the copied working directory.

I was trying to run the perf scripts today and got bit by this patch.
The problem is this line:

> +	objects_dir="$(git -C "$source" rev-parse --git-path objects)"

When the perf script is running, the "git" in its PATH is the version of
git being perf-tested, not the most recent one. And --git-path wasn't
introduced until v2.5.0. So if you try to compare results against an
older git, it fails:

  $ cd t/perf
  $ ./run v2.4.0 v2.9.0 -- p0000-perf-lib-sanity.sh
  [...]

  === Running 1 tests in build/67308bd628c6235dbc1bad60c9ad1f2d27d576cc/bin-wrappers ===
  fatal: ambiguous argument 'objects': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'
  cp: unrecognized option '--git-path
  objects'
  Try 'cp --help' for more information.
  error: failed to copy repository '/home/peff/compile/git/t/..' to '/var/ram/git-tests/trash directory.p0000-perf-lib-sanity'

  [...]
  Test                                                       v2.4.0      v2.9.0         
  --------------------------------------------------------------------------------------
  0000.1: test_perf_default_repo works                       <missing>   0.00(0.00+0.00)
  0000.2: test_checkout_worktree works                       <missing>   0.01(0.00+0.00)
  0000.4: export a weird var                                 <missing>   0.00(0.00+0.00)
  0000.6: important variables available in subshells         <missing>   0.00(0.00+0.00)
  0000.7: test-lib-functions correctly loaded in subshells   <missing>   0.00(0.00+0.00)

I know that running modern perf tests against older versions isn't
guaranteed to work (the tests might rely on newer options, for example),
but it at least generally worked up until this point.

IMHO the problem is in the design of t/perf, though. It should always
use your modern git for the harness setup, and only use the git-to-test
inside test_expect and test_perf blocks.

-Peff
