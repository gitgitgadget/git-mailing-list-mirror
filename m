Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9FF1F859
	for <e@80x24.org>; Fri,  2 Sep 2016 08:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbcIBIrg (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 04:47:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:37027 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751756AbcIBIrf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 04:47:35 -0400
Received: (qmail 9964 invoked by uid 109); 2 Sep 2016 08:47:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 08:47:34 +0000
Received: (qmail 23709 invoked by uid 111); 2 Sep 2016 08:47:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 04:47:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2016 04:47:32 -0400
Date:   Fri, 2 Sep 2016 04:47:32 -0400
From:   Jeff King <peff@peff.net>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     doak <doak@gmx.de>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug: 'core.logallrefupdates' is not set by default in non-bare
 repository
Message-ID: <20160902084732.6yfbzipkqwwgk4yt@sigill.intra.peff.net>
References: <c46d36ef-3c2e-374f-0f2e-ffe31104e023@gmx.de>
 <1472634746.4265.47.camel@kaarsemaker.net>
 <20160831104825.quyqb54bo5k7fdxs@sigill.intra.peff.net>
 <1472657553.4265.63.camel@kaarsemaker.net>
 <20160902080416.jmrctu3onfmylmeq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160902080416.jmrctu3onfmylmeq@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 02, 2016 at 04:04:16AM -0400, Jeff King wrote:

> So here's the minimal fix that seems to work for me:
> 
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 3a45f0b..56e7b9a 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c

I also wonder if "clone" should be doing something similar. Or, for that
matter, things like git-daemon that operate outside of a repo. They work
now because they do not happen to trigger any library calls which look
at config under the hood.

Traditionally these were supposed to just use git_config_early(), but
that's really not possible when the config calls are happening behind
the scenes (e.g., when lazy-loading the config cache). And so we
eventually got rid of git_config_early() entirely.

But I wonder if we could enforce that concept automatically for config.

The simple patch below does fix this case:

diff --git a/config.c b/config.c
index 0dfed68..b62bb40 100644
--- a/config.c
+++ b/config.c
@@ -1289,7 +1289,7 @@ static int do_git_config_sequence(config_fn_t fn, void *data)
 	int ret = 0;
 	char *xdg_config = xdg_config_home("config");
 	char *user_config = expand_user_path("~/.gitconfig");
-	char *repo_config = git_pathdup("config");
+	char *repo_config = startup_info->have_repository ? git_pathdup("config") : NULL;
 
 	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))

but it causes a few test failures. Some of those are arguably
reasonable, though. E.g., several of the diff tests use "git diff
--no-index" and expect to read local config. But "--no-index" explicitly
_avoids_ setting up the git repository, so the current code just falls
back to reading ".git/config". Which means it works when you are at the
top-level of a repository, but not in a subdir!

So I think this patch is an improvement; if we have not set up the
repository, then we should not be reading its config! (It's another
question of whether --no-index should try setup_git_directory_gently(),
but then this patch would just do the right thing).

I think "hash-object" without "-w" is in the same boat. It does not even
bother looking for a git dir, but we assume that it can see config like
core.autocrlf. It works in the top-level, but not elsewhere:

  $ git init
  $ git config core.autocrlf true
  $ printf 'foo\r\n' >file
  $ git hash-object file
  257cc5642cb1a054f08cc83f2d943e56fd3ebe99
  $ mkdir subdir
  $ cd subdir
  $ git hash-object ../file
  e48b03ece74f47d1ae20075200c64aeaa01a9cdb

So there is definitely some cleanup work, but it seems like it would be
fixing a bunch of bugs.

Some of the other failures are not so obvious. In particular, t7006
tests the core.pager settings that are looked up before we set up the
git directory, and those are now broken. OTOH, I suspect that doing it
_correctly_ would fix all of the known breakages like:

  not ok 46 - git -p true - core.pager overrides PAGER from subdirectory

They are hitting that same subdirectory problem mentioned above.

-Peff
