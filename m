Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4493C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 19:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8731720738
	for <git@archiver.kernel.org>; Thu, 21 May 2020 19:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgEUTQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 15:16:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:53884 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbgEUTQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 15:16:27 -0400
Received: (qmail 15184 invoked by uid 109); 21 May 2020 19:16:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 May 2020 19:16:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 843 invoked by uid 111); 21 May 2020 19:16:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 May 2020 15:16:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 May 2020 15:16:26 -0400
From:   Jeff King <peff@peff.net>
To:     Dana Dahlstrom <dahlstrom@google.com>
Cc:     git@vger.kernel.org
Subject: Re: 'HEAD' is not a commit (according to git-checkout)
Message-ID: <20200521191626.GC1308489@coredump.intra.peff.net>
References: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 12:00:00PM -0700, Dana Dahlstrom wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> 
>   $ git clone https://github.com/githubtraining/hellogitworld.git
>   $ cd hellogitworld
>   $ git checkout -b work -t master HEAD
>   fatal: 'HEAD' is not a commit and a branch 'work' cannot be created from it
>   $ git show -s --oneline
>   ef7bebf (HEAD -> master, origin/master, origin/HEAD) Fix groupId […]
>   $ git checkout -b work -t master ef7bebf
>   fatal: 'ef7bebf' is not a commit and a branch 'work' cannot be created from it

Thanks for a complete reproduction. There are a few things going on
here.

The "-t" option doesn't take an argument; it's a boolean that says
"track the branch we started from". So "master" is taken as the
start-point, and "HEAD" is tacked onto the end. I.e., equivalent to:

  git checkout -b work master HEAD

That error message is wrong and misleading. It looks like what happens
is that we parse "master" as the start-point. And then we try to treat
remaining options (i.e., "HEAD") as a pathspec. That fails, because
there's no such path. But then instead of saying "hey, HEAD isn't a
pathspec" we try to be clever:

                  /*
                   * Try to give more helpful suggestion.
                   * new_branch && argc > 1 will be caught later.
                   */
                  if (opts->new_branch && argc == 1)
                          die(_("'%s' is not a commit and a branch '%s' cannot be created from it"),
                                  argv[0], opts->new_branch);

We know we're making a new branch and there's one argument, so we assume
that it didn't get parsed earlier as a start-point. But that misses the
fact that if we _did_ parse a start-point, it would have been removed
from argv, and our "single argument" is actually the former
second-argument.

Something like this works:

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e9d111bb83..6559ac666b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1553,6 +1553,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 {
 	struct branch_info new_branch_info;
 	int parseopt_flags = 0;
+	int got_start_point = 0;
 
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
 	opts->overwrite_ignore = 1;
@@ -1661,6 +1662,8 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			!opts->new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
 					     &new_branch_info, opts, &rev);
+		if (n)
+			got_start_point = 1;
 		argv += n;
 		argc -= n;
 	} else if (!opts->accept_ref && opts->from_treeish) {
@@ -1689,7 +1692,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		 * Try to give more helpful suggestion.
 		 * new_branch && argc > 1 will be caught later.
 		 */
-		if (opts->new_branch && argc == 1)
+		if (opts->new_branch && !got_start_point && argc == 1)
 			die(_("'%s' is not a commit and a branch '%s' cannot be created from it"),
 				argv[0], opts->new_branch);
 

to produce:

  $ git checkout -b work -t master HEAD
  fatal: '--track' cannot be used with updating paths

  $ git checkout -b work master HEAD
  fatal: Cannot update paths and switch to branch 'work' at the same time.

which are both correct. I wonder if there's a more elegant way to do it,
though (probably not, as there's definitely some heuristic parsing going
on to determine which checkout mode we're in; the new switch/restore
alternatives don't suffer as much from this).

> What did you expect to happen? (Expected behavior)
> 
>   I expected a new branch named 'work' to be created and checked out,
>   pointing to commit ef7bebf and with upstream branch set to 'master'.

So getting back to your actual goal: you can't do what you want with a
single checkout command. I think:

  git checkout -b work HEAD
  git branch --set-upstream-to=master

-Peff
