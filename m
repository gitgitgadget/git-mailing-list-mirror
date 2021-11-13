Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87CCC433F5
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 07:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998C560E08
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 07:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhKMHOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 02:14:45 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:2889 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhKMHOp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 02:14:45 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4Hrmpw0BS1z5tlB;
        Sat, 13 Nov 2021 08:11:51 +0100 (CET)
Subject: Re: Possible merge bug
To:     Michael Schiff <schiff.michael@gmail.com>
Cc:     Saksham Mittal <saksham.mittal000@gmail.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <CAJcz5TVsv20+FmHR67_UhL_7rhEGvfPHeP3RMiRtnSGAEKiwBg@mail.gmail.com>
 <5aa1fb67-6bd8-6de3-8271-369722b6ebef@gmail.com>
 <da873a08-c73a-cc30-6b7d-dd5cd3bacb22@gmail.com>
 <CAJcz5TXy37s=Ez-SwKHGS6ps_+oGSsyjXSVCC0=qnoPx2BE1QA@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5079b568-d86d-97a9-2561-25cafc6a490f@kdbg.org>
Date:   Sat, 13 Nov 2021 08:11:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAJcz5TXy37s=Ez-SwKHGS6ps_+oGSsyjXSVCC0=qnoPx2BE1QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.11.21 um 04:49 schrieb Michael Schiff:
> This script includes an extra new-line, turing the final change into a
> 2 line diff, which is caught correctly.  Modified to:
> --- 8< ---
> git --version --build-options
> 
> rm -rf sample
> mkdir sample
> cd sample
> git init
> echo -e "a\nb\nc" > test
> git add .
> git commit -m "abc"
> 
> git branch b1
> git switch b1
> 
> echo -e "b\na\nc" > test
> git add .
> git commit -m "bac"
> 
> git switch master
> git branch b2
> git switch b2
> 
> echo -e "b\nc\na" > test
> git add .
> git commit -m "bca"
> 
> git switch master
> echo "----- Merging b1 -----"
> git merge b1
> cat test
> echo "----- Merging b2 -----"
> git merge b2
> echo "----- Content of test -----"
> cat test
> --- 8< ---
> 
> The only meaningful difference being the removal of the trailing \n
> from the first echo.  Running it produces the output:
> 
> git version 2.34.0.rc0.377.g6d82a21a3b
> cpu: x86_64
> built from commit: 6d82a21a3b699caf378cb0f89b6b0e803fc58480
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> hint: Using 'master' as the name for the initial branch. This default
> branch name
> hint: is subject to change. To configure the initial branch name to use in all
> hint: of your new repositories, which will suppress this warning, call:
> hint:
> hint: git config --global init.defaultBranch <name>
> hint:
> hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
> hint: 'development'. The just-created branch can be renamed via this command:
> hint:
> hint: git branch -m <name>
> Initialized empty Git repository in /Users/michaelschiff/Desktop/sample/.git/
> [master (root-commit) 8d6bc12] abc
>  1 file changed, 3 insertions(+)
>  create mode 100644 test
> Switched to branch 'b1'
> [b1 b5328d8] bac
>  1 file changed, 1 insertion(+), 1 deletion(-)
> Switched to branch 'master'
> Switched to branch 'b2'
> [b2 98603f6] bca
>  1 file changed, 1 insertion(+), 1 deletion(-)
> Switched to branch 'master'
> ----- Merging b1 -----
> Updating 8d6bc12..b5328d8
> Fast-forward
>  test | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> b
> a
> c
> ----- Merging b2 -----
> Auto-merging test
> Merge made by the 'ort' strategy.
>  test | 1 +
>  1 file changed, 1 insertion(+)
> ----- Content of test -----
> b
> a
> c
> a

There is no bug.

Before the merge, the diff on our side is

@@ -1,3 +1,3 @@
-a
 b
+a
 c

and the diff on their side is

@@ -1,3 +1,3 @@
-a
 b
 c
+a

Notice how both sides remove the first line, '-a'. The diff algorithm
treats this identical change on both sides not as a conflict, but simply
as "both sides did the same thing, so let's take it". This leaves two
changes: our side added 'a' in the middle and their side added 'a' at
the end. Both changes are separated by a common context, 'c', which does
not produce a conflict as desired. Hence, no conflict in total.

There is one thing to notice, though. Our side turns 'abc' into 'bac',
i.e., swaps the first two lines. There is no unique "true" patch text
that represents a change that swaps two regions of code. It could be

@@ -1,3 +1,3 @@
-a
 b
+a
 c

or

@@ -1,3 +1,3 @@
+b
 a
-b
 c

Git's diff algrithm (and henceforth merge algorithm) happens to pick the
first one in this case. Had it picked the second option, there would
have been a conflict, I think ('-a' vs. '+b').

-- Hannes
