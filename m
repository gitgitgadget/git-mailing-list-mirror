Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA38E1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 03:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKSDdM (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 22:33:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:50640 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727112AbfKSDdM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 22:33:12 -0500
Received: (qmail 4748 invoked by uid 109); 19 Nov 2019 03:33:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Nov 2019 03:33:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19782 invoked by uid 111); 19 Nov 2019 03:36:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Nov 2019 22:36:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Nov 2019 22:33:11 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git rev-parse --show-toplevel inside `.git` returns 0 and prints
 nothing
Message-ID: <20191119033311.GA18613@sigill.intra.peff.net>
References: <CA+dzEBmrMavFJeyPSQr2wA9kFZwz_Kfr6PFBLRfLJ-EuCVXJnA@mail.gmail.com>
 <xmqqk17wziex.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk17wziex.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 19, 2019 at 11:52:54AM +0900, Junio C Hamano wrote:

> If I were designing the feature today, with today's rest-of-git in
> mind, I would say
> 
>  - In a bare repository, exit with non-zero status after giving an
>    error message "no working tree".
> 
>  - In a repository that has a single associated working tree, show
>    the path to the top-level of that working tree and exit with zero
>    status.

Do you mean to do this even in when the cwd is inside .git?

I think that's confusing, because you don't actually have a working tree
at all. E.g.:

  $ git rev-parse --show-toplevel
  /home/peff/tmp
  $ git status -b --short
  ## No commits yet on master

  $ cd .git
  $ git rev-parse --show-toplevel
  $ git status -b --short
  fatal: this operation must be run in a work tree

So internal commands like status accept that we have no working tree in
this situation. But "--show-toplevel" just prints nothing. I'd amend
your second point to be "If we are in the working tree of a repository,
show the path to the top-level of that working tree and exit with zero
status".

And then that leaves another case: we are not in the working tree of the
repository. In which case I think it should be the same as the bare
repository.

And from that, your multi-working-tree case falls out naturally:

> In a repository that has more than one working trees (which is one
> of the things "todasy's rest-of-git" has that did not exist back
> when --show-prefix/--show-toplevel etc. were invented), then what?
> Would it make sense to show the primary working tree?  What if the
> worktree(s) were made off of a bare repository, in which case nobody
> is the primary?

There may be multiple working trees, but we can only be in one of them
at a time. So that's the one that we show.

And the only real change here is that "--show-toplevel" prints an error
and exits non-zero when we won't have a working tree. Something like:

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 3857fd1b8a..81161f2dfb 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -805,6 +805,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				const char *work_tree = get_git_work_tree();
 				if (work_tree)
 					puts(work_tree);
+				else
+					die("this operation must be run in a work tree");
 				continue;
 			}
 			if (!strcmp(arg, "--show-superproject-working-tree")) {


I think the reason this hasn't come up until now is callers are expected
to use require_work_tree() or "rev-parse --is-inside-work-tree" first.

It would probably make sense for the rev-parse documentation to also
clarify what "the top-level directory" is.

-Peff
