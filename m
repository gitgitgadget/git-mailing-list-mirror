Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29E7D20D09
	for <e@80x24.org>; Sun, 16 Apr 2017 15:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756115AbdDPPvh (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 11:51:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:34424 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756020AbdDPPvg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 11:51:36 -0400
Received: (qmail 12057 invoked by uid 109); 16 Apr 2017 15:51:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 15:51:34 +0000
Received: (qmail 16955 invoked by uid 111); 16 Apr 2017 15:51:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 11:51:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Apr 2017 11:51:32 -0400
Date:   Sun, 16 Apr 2017 11:51:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        bert.wesarg@googlemail.com
Subject: Re: [PATCH 2/2] config: handle conditional include when $GIT_DIR is
 not set up
Message-ID: <20170416155131.ppp5iakohiiphzmk@sigill.intra.peff.net>
References: <20170416045004.2ghhiv7jzgroejgw@sigill.intra.peff.net>
 <20170416104125.15300-1-pclouds@gmail.com>
 <20170416104125.15300-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170416104125.15300-2-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 16, 2017 at 05:41:25PM +0700, Nguyễn Thái Ngọc Duy wrote:

> If setup_git_directory() and friends have not been called,
> get_git_dir() (because of includeIf.gitdir:XXX) would lead to
> 
>     die("BUG: setup_git_env called without repository");
> 
> There are two cases when a config file could be read before $GIT_DIR is
> located. The first one is check_repository_format(), where we read just
> the one file $GIT_DIR/config to check if we could understand this
> repository. This case should be safe. The concerned variables should
> never be hidden away behind includes anyway.

Right, we should not even have respect_includes turned on for that case.

> The second one is triggered in check_pager_config() when we're about to
> run an external git command. We might be able to find $GIT_DIR in this
> case, which is exactly what read_early_config() does (and also is the
> what check_pager_config() uses). Conditional includes and

s/the what/what/

> diff --git a/cache.h b/cache.h
> index e29a093839..27b7286f99 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1884,6 +1884,8 @@ enum config_origin_type {
>  
>  struct config_options {
>  	unsigned int respect_includes : 1;
> +	unsigned int early_config : 1;
> +	const char *git_dir; /* only valid when early_config is true */
>  };

Why do we need both the flag and the string? Later, you do:

> -static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
> +static int include_by_gitdir(const struct config_options *opts,
> +			     const char *cond, size_t cond_len, int icase)
>  {
>  	struct strbuf text = STRBUF_INIT;
>  	struct strbuf pattern = STRBUF_INIT;
>  	int ret = 0, prefix;
>  
> -	strbuf_add_absolute_path(&text, get_git_dir());
> +	if (!opts->early_config)
> +		strbuf_add_absolute_path(&text, get_git_dir());
> +	else if (opts->git_dir)
> +		strbuf_add_absolute_path(&text, opts->git_dir);
> +	else
> +		goto done;

So we call get_git_dir() always when we're not in early config. Even if
we don't have a git dir! Doesn't this mean that programs operating
outside of a repo will still hit the BUG? I.e.:

  git config --global includeif.gitdir:/whatever.path foo
  cd /not/a/git/dir
  git diff --no-index foo bar

?

I think instead the logic should be:

  if (opts->git_dir)
	strbuf_add_absolute_path(&text, opts->git_dir);
  else if (have_git_dir())
	strbuf_add_absolute_path(&text, get_git_dir());
  else
	goto done;

I'd also be tempted to call the option field "override_git_dir" or
something to indicate that it takes precedence over the normal one. With
the current code it doesn't matter, because we set it only to the result
of the discovered dir.

> @@ -1615,15 +1626,21 @@ void read_early_config(config_fn_t cb, void *data)
>  	 * notably, the current working directory is still the same after the
>  	 * call).
>  	 */
> -	if (!have_git_dir() && discover_git_directory(&buf)) {
> +	else if (discover_git_directory(&buf))
> +		opts.git_dir = to_free = strbuf_detach(&buf, NULL);

This to_free seemed redundant to me at first; why not just hold on to
the strbuf and release it later?

The answer is that we reuse the strbuf to generate the config-file path
later. However, by detaching, we clear the strbuf. So later when we
use it:


> +	if (opts.git_dir) {
>  		struct git_config_source repo_config;
>  
>  		memset(&repo_config, 0, sizeof(repo_config));
> -		strbuf_addstr(&buf, "/config");
> +		strbuf_addf(&buf, "%s/config", opts.git_dir);
>  		repo_config.file = buf.buf;
>  		git_config_with_options(cb, data, &repo_config, &opts);
>  	}

...we have to re-add the git_dir.

Might it be simpler to just xstrdup() to opts.git_dir, and then leave
this later code alone?


That said, I actually think in the long run that
git_config_with_options() should compute the repo_config itself from our
git_dir parameter. That lets us fix a very subtle bug in
read_early_config(). The problem is that the function works like this:

  1. Run git_config_with_options(), hitting the usual sources in order

  2. If we didn't have a git-dir, run it again just for our discovered
     repo-config

That has two implications:

  - the config callback will see keys from ~/.gitconfig twice, once for
    each run. This is usually OK because the only early config we care
    about uses last-one-wins semantics (so no list-appending).

  - the repo-level config is read last, so by last-one-wins it takes
    precedence over ~/.gitconfig. Good. But it should have _less_
    precedence than command-line config, and it doesn't.

You can see the second problem with:

  # random external
  cat >git-foo <<-\EOF
  #!/bin/sh
  echo foo
  EOF
  chmod +x git-foo
  PATH=$PWD:$PATH

  git init
  git config pager.foo 'sed s/^/repo:/'
  git -c pager.foo='sed s/^/cmdline:/' foo

That command should prefer the cmdline config, but it doesn't.

The fix is something like what's below, which is easy on top of your new
options struct. I can wrap it up with a config message and test on top
of your series.

diff --git a/config.c b/config.c
index f323b9628..5dda6e8ca 100644
--- a/config.c
+++ b/config.c
@@ -1502,12 +1502,20 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
-static int do_git_config_sequence(config_fn_t fn, void *data)
+static int do_git_config_sequence(config_fn_t fn, void *data,
+				  const char *override_repo_dir)
 {
 	int ret = 0;
 	char *xdg_config = xdg_config_home("config");
 	char *user_config = expand_user_path("~/.gitconfig");
-	char *repo_config = have_git_dir() ? git_pathdup("config") : NULL;
+	char *repo_config;
+
+	if (override_repo_dir)
+		repo_config = mkpathdup("%s/config", override_repo_dir);
+	else if (have_git_dir())
+		repo_config = git_pathdup("config");
+	else
+		repo_config = NULL;
 
 	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
@@ -1561,7 +1569,7 @@ int git_config_with_options(config_fn_t fn, void *data,
 	else if (config_source && config_source->blob)
 		return git_config_from_blob_ref(fn, config_source->blob, data);
 
-	return do_git_config_sequence(fn, data);
+	return do_git_config_sequence(fn, data, opts->git_dir);
 }
 
 static void git_config_raw(config_fn_t fn, void *data)
@@ -1631,14 +1639,6 @@ void read_early_config(config_fn_t cb, void *data)
 
 	git_config_with_options(cb, data, NULL, &opts);
 
-	if (opts.git_dir) {
-		struct git_config_source repo_config;
-
-		memset(&repo_config, 0, sizeof(repo_config));
-		strbuf_addf(&buf, "%s/config", opts.git_dir);
-		repo_config.file = buf.buf;
-		git_config_with_options(cb, data, &repo_config, &opts);
-	}
 	strbuf_release(&buf);
 	free(to_free);
 }

