Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D044D1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 12:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbfBUMoK (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 07:44:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:52400 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725814AbfBUMoK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 07:44:10 -0500
Received: (qmail 19755 invoked by uid 109); 21 Feb 2019 12:44:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Feb 2019 12:44:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11679 invoked by uid 111); 21 Feb 2019 12:44:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Feb 2019 07:44:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2019 07:44:08 -0500
Date:   Thu, 21 Feb 2019 07:44:08 -0500
From:   Jeff King <peff@peff.net>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v8 2/3] branch: update output to include worktree info
Message-ID: <20190221124408.GA13403@sigill.intra.peff.net>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190219083123.27686-3-nbelakovski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219083123.27686-3-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 05:31:22PM +0900, nbelakovski@gmail.com wrote:

> From: Nickolai Belakovski <nbelakovski@gmail.com>
> 
> The output of git branch is modified to mark branches checkout out in a

s/checkout out/checked out/ ?

> linked worktree with a "+" and color them in cyan (in contrast to the
> current branch, which will still be denoted with a "*" and colored in green)
> 
> This is meant to communicate to the user that the branches that are
> marked or colored will behave differently from other branches if the user
> attempts to check them out or delete them, since branches checked out in
> another worktree cannot be checked out or deleted.

I think this makes sense to have. You cannot "git checkout" such a
marked branch (since it would conflict with the other worktree), and
that alone seems to make it worth marking in the output.

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 3bd83a7cbd..f2e5a07d64 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -26,8 +26,10 @@ DESCRIPTION
>  -----------
>  
>  If `--list` is given, or if there are no non-option arguments, existing
> -branches are listed; the current branch will be highlighted with an
> -asterisk.  Option `-r` causes the remote-tracking branches to be listed,
> +branches are listed; the current branch will be highlighted in green and
> +marked with an asterisk.  Any branches checked out in linked worktrees will
> +be highlighted in cyan and marked with a plus sign. Option `-r` causes the
> +remote-tracking branches to be listed,

This makes sense to me.

> -	strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %s%%(end)",
> -		    branch_get_color(BRANCH_COLOR_CURRENT),
> -		    branch_get_color(BRANCH_COLOR_LOCAL));
> +	strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)%%(if)%%(worktreepath)%%(then)+ %s%%(else)  %s%%(end)%%(end)",
> +			branch_get_color(BRANCH_COLOR_CURRENT),
> +			branch_get_color(BRANCH_COLOR_WORKTREE),
> +			branch_get_color(BRANCH_COLOR_LOCAL));

Makes sense. The long line is ugly. Our format does not support breaking
long lines, though we could break the C string, I think, like:

  strbuf_add(&local,
	     "%%(if)%%(HEAD)"
	       "%%(then)* %s"
	     "%%(else)%(if)%%(worktreepath)"
	       "%%(then)+ %s"
	     "%%(else)"
	       "%%(then)  %s"
	     "%%(end)%%(end)");

That's pretty ugly, too, but it at least shows the conditional
structure.

> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index ee6787614c..94ab05ad59 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -240,6 +240,27 @@ test_expect_success 'git branch --format option' '
>  	test_i18ncmp expect actual
>  '
>  
> +test_expect_success '"add" a worktree' '
> +	mkdir worktree_dir &&
> +	git worktree add -b master_worktree worktree_dir master
> +'

This mkdir gets deleted in the next patch. It should just not be added
here.

> +cat >expect <<'EOF'
> +* <GREEN>(HEAD detached from fromtag)<RESET>
> +  ambiguous<RESET>
> +  branch-one<RESET>
> +  branch-two<RESET>
> +  master<RESET>
> ++ <CYAN>master_worktree<RESET>
> +  ref-to-branch<RESET> -> branch-one
> +  ref-to-remote<RESET> -> origin/branch-one
> +EOF
> +test_expect_success TTY 'worktree colors correct' '
> +	test_terminal git branch >actual.raw &&
> +	test_decode_color <actual.raw >actual &&
> +	test_cmp expect actual
> +'

We are not testing the auto-color behavior here, so I think you could
just use "git branch --color >actual.raw" and drop the TTY prerequisite.
That's shorter and simpler, and will let your test run on more
platforms.

-Peff
