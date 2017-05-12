Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4466201A7
	for <e@80x24.org>; Fri, 12 May 2017 20:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757162AbdELUen (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 16:34:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:50489 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755947AbdELUem (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 16:34:42 -0400
Received: (qmail 13983 invoked by uid 109); 12 May 2017 20:34:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 20:34:38 +0000
Received: (qmail 27226 invoked by uid 111); 12 May 2017 20:35:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 16:35:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 16:34:36 -0400
Date:   Fri, 12 May 2017 16:34:36 -0400
From:   Jeff King <peff@peff.net>
To:     Josh Hagins <hagins.josh@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] config: complain about --local outside of a git repo
Message-ID: <20170512203436.fcoqauphzvox2sgv@sigill.intra.peff.net>
References: <CANuW5x0pBwfQeha50mxN8pVQKm67u_b3UKTCQ8ZbJA6FUGvYbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANuW5x0pBwfQeha50mxN8pVQKm67u_b3UKTCQ8ZbJA6FUGvYbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 10:19:59AM -0400, Josh Hagins wrote:

> Since upgrading to Git 2.13.0 I'm seeing this error message whenever
> `git config --local <whatever>` is called outside a Git repository.
> For example, note the difference in behavior between Git 2.13 and
> Apple Git:
> 
>     $ pwd
>     /Users/jhagins
>     $ /usr/bin/git --version
>     git version 2.11.0 (Apple Git-81)
>     $ /usr/bin/git config --local --get user.name
>     $ /usr/local/bin/git --version
>     git version 2.13.0
>     $ /usr/local/bin/git config --local --get user.name
>     fatal: BUG: setup_git_env called without repository
> 
> Apple Git outputs nothing, as expected. The summarized release notes
> published by GitHub specifically mentioned that instances of this
> error message should be reported, so here you go!

Thanks for reporting. All the developers have been running with this
change for months, but I knew as soon as it was released into the wild
that somebody would find a new corner case. :)

I think dying is the right thing here; you are asking for "--local" but
there is no local repository. But we should never hit a BUG assertion.
Patch is below.

I'm not sure exactly what you wanted to accomplish with --local. If you
just want to know if user.name is set anywhere (and you may or may not
be in a git repo), then just "git config --get user.name" would work. If
you want to know if you're in a local repo and if so whether the
variable is set, you'd need to use two commands, like:

  git rev-parse --git-dir >/dev/null 2>&1 &&
  git config --local --get user.name

-- >8 --
Subject: [PATCH] config: complain about --local outside of a git repo

The "--local" option instructs git-config to read or modify
the repository-level config. This doesn't make any sense if
you're not actually in a repository.

Older versions of Git would blindly try to read or write
".git/config". For reading, this would result in a quiet
failure, since there was no config to read (and thus no
matching config value). Writing would generally fail
noisily, since ".git" was unlikely to exist. But since
b1ef400ee (setup_git_env: avoid blind fall-back to ".git",
2016-10-20), we catch this in the call to git_pathdup() and
die("BUG").

Dying is the right thing to do, but we should catch the
problem early and give a more human-friendly error message.

Note that even without --local, git-config will sometimes
default to using local repository config. These cases are
already protected by a similar check.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/config.c b/builtin/config.c
index 3a554ad50..ad7c6a19c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -496,6 +496,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
+	if (use_local_config && nongit)
+		die(_("--local only be used inside a git repository"));
+
 	if (given_config_source.file &&
 			!strcmp(given_config_source.file, "-")) {
 		given_config_source.file = NULL;
-- 
2.13.0.452.g0afc8e12b

