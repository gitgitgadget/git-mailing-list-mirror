Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E161F453
	for <e@80x24.org>; Thu, 21 Feb 2019 12:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfBUM7z (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 07:59:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:52436 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725845AbfBUM7z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 07:59:55 -0500
Received: (qmail 19905 invoked by uid 109); 21 Feb 2019 12:59:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Feb 2019 12:59:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11884 invoked by uid 111); 21 Feb 2019 13:00:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Feb 2019 08:00:07 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2019 07:59:52 -0500
Date:   Thu, 21 Feb 2019 07:59:52 -0500
From:   Jeff King <peff@peff.net>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v8 3/3] branch: add worktree info on verbose output
Message-ID: <20190221125952.GB13403@sigill.intra.peff.net>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190219083123.27686-4-nbelakovski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219083123.27686-4-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 05:31:23PM +0900, nbelakovski@gmail.com wrote:

> From: Nickolai Belakovski <nbelakovski@gmail.com>
> 
> To display worktree path for refs checked out in a linked worktree

This would be a good place to describe why this is useful. :)

I do not have an opinion myself. Patch 2 makes a lot of sense to me, but
I don't know if people would like this one or not. I don't use "-v"
myself, though, so what do I know. :)

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index f2e5a07d64..326a45f648 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -168,8 +168,10 @@ This option is only applicable in non-verbose mode.
>  	When in list mode,
>  	show sha1 and commit subject line for each head, along with
>  	relationship to upstream branch (if any). If given twice, print
> -	the name of the upstream branch, as well (see also `git remote
> -	show <remote>`).
> +	the path of the linked worktree, if applicable (not applicable
> +	for current worktree since user's path will already be in current
> +	worktree) and the name of the upstream branch, as well (see also
> +	`git remote show <remote>`).

That parenthetical feels a bit awkward. Maybe:

  ...print the path of the linked worktree (if any) and the name of the
  upstream branch, as well (see also `git remote show <remote>`). Note
  that the current worktree's HEAD will not have its path printed (it
  will always be your current directory).

> diff --git a/builtin/branch.c b/builtin/branch.c
> index c2a86362bb..0b8ba9e4c5 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -367,9 +367,13 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
>  		strbuf_addf(&local, " %s ", obname.buf);
>  
>  		if (filter->verbose > 1)
> +		{
> +			strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)",
> +				    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
>  			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
>  				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
>  				    branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
> +		}

Another unreadable long line (both the one you're adding, and the existing
one!). I don't know if it's worth trying to clean these up, but if we
do, it might be worth hitting the existing ones, too.

I'm OK if that comes as a patch on top later on, though.

> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index 94ab05ad59..012ddde7f2 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -241,7 +241,6 @@ test_expect_success 'git branch --format option' '
>  '
>  
>  test_expect_success '"add" a worktree' '
> -	mkdir worktree_dir &&
>  	git worktree add -b master_worktree worktree_dir master
>  '

Here's that mysterious mkdir going away. :)

> @@ -285,4 +284,24 @@ test_expect_success '--color overrides auto-color' '
>  	test_cmp expect.color actual
>  '
>  
> +# This test case has some special code to strip the first 30 characters or so
> +# of the output so that we do not have to put commit hashes into the expect
> +test_expect_success 'verbose output lists worktree path' '
> +	cat >expect <<-EOF &&
> +	one
> +	one
> +	two
> +	one
> +	two
> +	($(pwd)/worktree_dir) two
> +	two
> +	two
> +	EOF
> +	git branch -vv >tmp &&
> +	SUBSTRLENGTH=$(head -1 tmp | awk "{print index(\$0, \"one\")}") &&
> +	awk -v substrlength="$SUBSTRLENGTH" "{print substr(\$0,substrlength,length(\$0))}" <tmp >actual &&
> +	test_cmp expect actual
> +'

It's hard to tell if this awk is doing the right thing. I guess it works
because git-branch tries to line up all of the hashes. I think the
result might be easier to verify if we simply blanked the hashes.
Unfortunately the output is actually pretty hard to parse. Since there
are only two tip commits, perhaps it would not be so bad to just do
something like this:

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 012ddde7f2..8065279be6 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -284,22 +284,20 @@ test_expect_success '--color overrides auto-color' '
 	test_cmp expect.color actual
 '
 
-# This test case has some special code to strip the first 30 characters or so
-# of the output so that we do not have to put commit hashes into the expect
 test_expect_success 'verbose output lists worktree path' '
+	one=$(git rev-parse --short HEAD) &&
+	two=$(git rev-parse --short master) &&
 	cat >expect <<-EOF &&
-	one
-	one
-	two
-	one
-	two
-	($(pwd)/worktree_dir) two
-	two
-	two
+	* (HEAD detached from fromtag) $one one
+	  ambiguous                    $one one
+	  branch-one                   $two two
+	  branch-two                   $one one
+	  master                       $two two
+	+ master_worktree              $two ($(pwd)/worktree_dir) two
+	  ref-to-branch                $two two
+	  ref-to-remote                $two two
 	EOF
-	git branch -vv >tmp &&
-	SUBSTRLENGTH=$(head -1 tmp | awk "{print index(\$0, \"one\")}") &&
-	awk -v substrlength="$SUBSTRLENGTH" "{print substr(\$0,substrlength,length(\$0))}" <tmp >actual &&
+	git branch -vv >actual &&
 	test_cmp expect actual
 '
 

I don't like how it depends on the space alignment of the branches, but
I do like that you can clearly see which branch is being annotated.

-Peff
