Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388A9C33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 10:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF86206D5
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 10:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgA3K3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:29:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:48362 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726873AbgA3K3e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 05:29:34 -0500
Received: (qmail 30974 invoked by uid 109); 30 Jan 2020 10:29:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Jan 2020 10:29:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22811 invoked by uid 111); 30 Jan 2020 10:37:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 05:37:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 05:29:33 -0500
From:   Jeff King <peff@peff.net>
To:     "Crabtree, Andrew" <andrew.crabtree@hpe.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Inconsistent results from git rev-parse --show-toplevel
Message-ID: <20200130102933.GE840531@coredump.intra.peff.net>
References: <TU4PR8401MB111758B9513DD7D8B96CBFAAF90E0@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
 <xmqqftg4zkvo.fsf@gitster-ct.c.googlers.com>
 <TU4PR8401MB1117B81EB9240905AA36B1E9F9090@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
 <20200125195319.GA5519@coredump.intra.peff.net>
 <TU4PR8401MB1117E8EEB853728B0392D83CF9090@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TU4PR8401MB1117E8EEB853728B0392D83CF9090@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 25, 2020 at 10:22:45PM +0000, Crabtree, Andrew wrote:

> > But the bigger thing, I think, is: who is setting GIT_DIR but not setting GIT_WORK_TREE to match? Because IMHO that's the situation that is causing the confusion.
> Pre-commit hook when worktrees are used? 
> 
> pre-commit
> #!/bin/bash
> env | grep GIT
> 
> /tmp/pre_commit_test_worktree  (new_branch)$ git add frob
> /tmp/pre_commit_test_worktree  (new_branch)$ git commit -m "frob"
> GIT_DIR=/tmp/pre_commit_test/.git/worktrees/pre_commit_test_worktree
> GIT_EDITOR=:
> GIT_INDEX_FILE=/tmp/pre_commit_test/.git/worktrees/pre_commit_test_worktree/index
> GIT_PREFIX=
> GIT_AUTHOR_DATE=@1579990789 -0800
> GIT_AUTHOR_NAME=Andrew Crabtree
> GIT_EXEC_PATH=/usr/local/libexec/git-core
> GIT_AUTHOR_EMAIL=andrew.crabtree@hpe.com
> [new_branch 7b1b747] frob
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 frob

I dug into this a little bit. I think the culprit is actually that our
internal set_git_dir() puts GIT_DIR into the environment, but the
matching setup_work_tree() doesn't touch GIT_WORK_TREE unless it's
already set.

This is mostly fine because we chdir() to the top-level of the working
tree, meaning that any sub-processes would see the correct environment.
But if we execute some arbitrary script (like a hook) that does a chdir,
the results are surprising.

Something like this seems like it would be an improvement:

diff --git a/setup.c b/setup.c
index e2a479a64f..75e2d1393c 100644
--- a/setup.c
+++ b/setup.c
@@ -394,12 +394,7 @@ void setup_work_tree(void)
 	if (!work_tree || chdir_notify(work_tree))
 		die(_("this operation must be run in a work tree"));
 
-	/*
-	 * Make sure subsequent git processes find correct worktree
-	 * if $GIT_WORK_TREE is set relative
-	 */
-	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
-		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
+	setenv(GIT_WORK_TREE_ENVIRONMENT, work_tree, 1);
 
 	initialized = 1;
 }

but it fails a test in t5601 around git-clone. So there may be some
weird subtle interaction here (or possibly just a bug in git-clone, if
it isn't careful enough to clean its environment when moving into the
newly created repo).

-Peff
