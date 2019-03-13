Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B5C20248
	for <e@80x24.org>; Wed, 13 Mar 2019 20:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfCMUsB (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 16:48:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:49560 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726646AbfCMUsB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 16:48:01 -0400
Received: (qmail 23495 invoked by uid 109); 13 Mar 2019 20:48:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Mar 2019 20:48:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15619 invoked by uid 111); 13 Mar 2019 20:47:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 16:47:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 16:46:44 -0400
Date:   Wed, 13 Mar 2019 16:46:44 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] difftool: allow running outside Git worktrees with
 --no-index
Message-ID: <20190313204644.GA5397@sigill.intra.peff.net>
References: <pull.163.git.gitgitgadget@gmail.com>
 <9f6eb60eeeccf920af83652899c5bc2d40e2092f.1552504812.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f6eb60eeeccf920af83652899c5bc2d40e2092f.1552504812.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 12:20:14PM -0700, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> As far as this developer can tell, the conversion from a Perl script to
> a built-in caused the regression in the difftool that it no longer runs
> outside of a Git worktree (with `--no-index`, of course).
> 
> It is a bit embarrassing that it took over two years after retiring the
> Perl version to discover this regression, but at least we now know, and
> can do something, about it.

If a bug falls in the forest, does it make a sound?

I get the impression that `--no-index` is not used all that much, given
how long bugs seem to hang around in it (and doubly so when intersected
with the difftool).

> -	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
> -	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
> +	for (i = 0; i < argc; i++)
> +		if (!strcmp(argv[i], "--"))
> +			break;
> +		else if (!strcmp(argv[i], "--no-index")) {
> +			no_index = 1;
> +			break;
> +		}

Instead of this ad-hoc parsing, can we just add an OPT_BOOL("no-index")
to the parse-options array? We'll have already run parse_options() at
this point.

We'd just have to remember to add it back to the argv of diff
sub-commands we run.

> +	if (!no_index && !startup_info->have_repository)
> +		die(_("difftool requires worktree or --no-index"));
> +
> +	if (!no_index){
> +		setup_work_tree();
> +		setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
> +		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
> +	}

This part makes sense.

There may be other subtle dependencies on having a repo from
sub-functions we run, but I didn't see any from a quick scan. And
anyway, if there is such a code path, it is no worse off than before
your patch (and in fact much better, because it would hopefully yield a
BUG() that would tell us what we need to fix).

> index 2014aab6b8..46365ed86a 100644
> --- a/git.c
> +++ b/git.c
> @@ -491,7 +491,7 @@ static struct cmd_struct commands[] = {
>  	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>  	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
>  	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
> -	{ "difftool", cmd_difftool, RUN_SETUP | NEED_WORK_TREE },
> +	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },

We necessarily lost NEED_WORK_TREE, but that's OK because you added in a
setup_work_tree() in the function. Good.

> +test_expect_success 'outside worktree' '
> +	mkdir outside &&
> +	echo 1 >outside/1 &&
> +	echo 2 >outside/2 &&
> +	test_expect_code 1 env GIT_CEILING_DIRECTORIES="$(pwd)" git \
> +		-c diff.tool=echo -c difftool.echo.cmd="echo \$LOCAL \$REMOTE" \
> +		-C outside difftool --no-prompt --no-index 1 2 >out &&

We have a helper for running outside a repo. Because you have to set up
the "outside" space, it unfortunately doesn't shorten things as much as
it does in some other spots:

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 4907627656..255a787614 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -706,12 +706,12 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 '
 
 test_expect_success 'outside worktree' '
-	mkdir outside &&
-	echo 1 >outside/1 &&
-	echo 2 >outside/2 &&
-	test_expect_code 1 env GIT_CEILING_DIRECTORIES="$(pwd)" git \
+	mkdir non-repo &&
+	echo 1 >non-repo/1 &&
+	echo 2 >non-repo/2 &&
+	test_expect_code 1 nongit git \
 		-c diff.tool=echo -c difftool.echo.cmd="echo \$LOCAL \$REMOTE" \
-		-C outside difftool --no-prompt --no-index 1 2 >out &&
+		difftool --no-prompt --no-index 1 2 >out &&
 	test "1 2" = "$(cat out)"
 '
 

but it might be worth using anyway, just for consistency.

> +	test "1 2" = "$(cat out)"

A minor nit, but I think:

  echo "1 2" >expect &&
  test_cmp expect actual

produces nicer output on failure, and costs the same number of
processes (it is an extra file write, but I think the main driver of
performance in the test suite is just processes).

-Peff
