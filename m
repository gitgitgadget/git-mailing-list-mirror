From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: git subtree bug produces divergent descendants
Date: Sun, 6 Dec 2015 23:53:07 -0500
Message-ID: <20151207045307.GA624@flurp.local>
References: <CAET=KiVXh2UZwRSpM_+wX_QpfjBsyfdPPUVDSDoCRVe_0wbhCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Ware <davidw@realtimegenomics.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 05:53:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5nnc-0000xl-7x
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 05:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482AbbLGExQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 23:53:16 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37222 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755379AbbLGExP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 23:53:15 -0500
Received: by igcto18 with SMTP id to18so73269128igc.0
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 20:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ELiN+c3EdvFrqYqg95PgkXyG5P9YWRhXekVAa+ahNQQ=;
        b=oEWZqO1mEhsFtfkMGx2f4f1crOgA7Nwo6LIS4amJzLFQa4HuY+x1y/QAL6H9YGZPbV
         VLrtmKlm4PtZApBSvhNLIVoi2gS/mGNGJjdRRmfHQFUN2+i4rOA42EnwkkAfWeellrKI
         pviQhsD7EVD9Hiv2wrNKf2hgPwfXgtfzPv7u+fsmO9axO4JDx7uls2NL8iqL0S0/xHjw
         r0jVJ46XxzdTXV0/Bm9K22i5v5T/j7T9vjePrlqoBeAcE1JsSfhHXmUklXaINLhbT32Y
         sfeJVZgecULdHaiPXpJCOGWC/4IeBCUVkMfxnwJYkf2d6mSwgnVmoypolap9MQuRgbge
         Mxdg==
X-Received: by 10.50.79.202 with SMTP id l10mr15521241igx.46.1449463994280;
        Sun, 06 Dec 2015 20:53:14 -0800 (PST)
Received: from flurp.local (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id cl9sm5757264igb.16.2015.12.06.20.53.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Dec 2015 20:53:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAET=KiVXh2UZwRSpM_+wX_QpfjBsyfdPPUVDSDoCRVe_0wbhCg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282077>

On Mon, Dec 07, 2015 at 11:09:48AM +1300, David Ware wrote:
> My group has run into a bug with "git-subtree split". Under some
> circumstances a split created from a descendant of another earlier
> split is not a descendant of that earlier split (thus blocking
> pushes). [...]

I'm not a git-subtree user, so this review will be superficial.

> The attached patch (against v2.6.3) includes a test that reproduces
> the problem. [...]

Please include patches inline rather than as attachments since
reviewers will want to comment on portions of the patch as part of
their response to your email. Patches as attachments make this
process more painful.

> From: Dave Ware <davidw@netvalue.net.nz>
> Date: Fri, 4 Dec 2015 16:30:03 +1300
> Subject: [PATCH] Fix bug in git-subtree split.

For the subject, mention the area you're working on, followed by a
colon, followed by a concise description of the problem. If possible,
try to say something more specific than "fix bug". You might, for
instance, say something like:

    contrib/subtree: fix "subtree split" skipped-merge bug

> A bug occurs in 'git-subtree split' where a merge is skipped even when
> both parents act on the subtree, provided the merge results in a tree
> identical to one of the parents. Fixed by copying the merge if at least

Imperative mood: s/Fixed/Fix/

> one parent is non-identical, and the non-identical parent is not an
> ancestor of the identical parent.
> 
> Also adding a test case, this checks that a descendant can be pushed to
> it's ancestor in this case.

Your Signed-off-by: is missing. See Documentation/SubmittingPatches.

> ---
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 9f06571..b837531 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -479,8 +479,16 @@ copy_or_skip()
>  			p="$p -p $parent"
>  		fi
>  	done
> -	
> -	if [ -n "$identical" ]; then
> +
> +	copycommit=
> +	if [ -n "$identical" ] && [ -n "$nonidentical" ]; then
> +		extras=$(git rev-list --boundary $identical..$nonidentical)
> +		if [ -n "$extras" ]; then
> +			# we need to preserve history along the other branch
> +			copycommit=1
> +		fi
> +	fi
> +	if [ -n "$identical" ] && [ -z "$copycommit" ]; then

Typically, I'd say something about how this project uses 'test'
rather than '[' and that 'then' is placed on its own line (with no
semicolon), however, in this case, you're sticking to existing style
(in this script), so I won't mention it.

>  		echo $identical
>  	else
>  		copy_commit $rev $tree "$p" || exit $?
> diff --git a/contrib/subtree/t/t7901-subtree-split.sh b/contrib/subtree/t/t7901-subtree-split.sh
> new file mode 100755
> index 0000000..0a1ea56
> --- /dev/null
> +++ b/contrib/subtree/t/t7901-subtree-split.sh

Is there a strong reason why this demands a new test script rather
than being incorporated into the existing t7900-subtree.sh?

> @@ -0,0 +1,62 @@
> +#!/bin/bash
> +
> +test_description='Test for bug in subtree commit filtering'

A somewhat strange description. Typically, scripts want to verify
correct behavior, rather than buggy behavior.

> +TEST_DIRECTORY=$(pwd)/../../../t
> +export TEST_DIRECTORY
> +
> +. ../../../t/test-lib.sh
> +
> +
> +test_expect_success 'subtree descendent check' '
> +  mkdir git_subtree_split_check &&
> +  cd git_subtree_split_check &&

Tests don't automatically return to the directory prior to the 'cd',
so when this test ends, the current directory will still be
'git_subtree_split_check'. If someone later adds a test following
this one, that test will execute within 'git_subtree_split_check',
which might not be expected by the test writer.

To ensure that the prior working directory is restored at the end of
the test (regardless of success or failure), tests typically employ a
subshell using this idiom:

    mkdir foo &&
    (
        cd foo &&
        ... &&
        ...
    )

In this case, though, I'm wondering what is the purpose of having the
'git_subtree_split_check' subdirectory at all? Is there a reason you
can't just perform the test in the existing directory created
automatically specifically for the test script (which is already the
script's current working directory)? If, on the other hand, you
incorporate this test into t7900-subtree.sh, then the separate
'git_subtree_split_check' directory may make sense if it needs to be
isolated from the other gunk in that script's test directory.

> +  git init &&
> +
> +  mkdir folder &&
> +
> +  echo a > folder/a &&

Typical style is to drop the space after the redirection operator,
however, since you're following existing style in t7900-subtree.sh, I
won't mention it.

> +  git add . &&
> +  git commit -m "first commit" &&
> +
> +  git branch branch &&
> +
> +  echo 0 > folder/0 &&
> +  git add . &&
> +  git commit -m "adding 0 to folder" &&
> +
> +  echo b > folder/b &&
> +  git add . &&
> +  git commit -m "adding b to folder" &&
> +  git rev-list HEAD -1 > cherry.rev &&

Can this value instead just be assigned to a shell variable rather
than being dumped to a file?

    cherryrev=$(git rev-list HEAD -1) &&
    ... &&
    git cherry-pick $cherryrev &&

> +  git checkout branch &&
> +  echo text > textBranch.txt &&
> +  git add . &&
> +  git commit -m "commit to fiddle with branch: branch" &&
> +
> +  git cherry-pick $(cat cherry.rev) &&

See above: git cherry-pick $cherryrev &&

> +  git checkout master &&
> +  git merge -m "merge" branch &&
> +
> +  git branch noop_branch &&
> +
> +  echo d > folder/d &&
> +  git add . &&
> +  git commit -m "adding d to folder" &&
> +
> +  git checkout noop_branch &&
> +  echo moreText > anotherText.txt &&
> +  git add . &&
> +  git commit -m "irrelevant" &&
> +
> +  git checkout master &&
> +  git merge -m "second merge" noop_branch &&
> +
> +  git subtree split --prefix folder/ --branch subtree_tip master &&
> +  git subtree split --prefix folder/ --branch subtree_branch branch &&
> +  git push . subtree_tip:subtree_branch
> +  '
> +
> +test_done
> -- 
> 1.9.1
