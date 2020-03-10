Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6ACC10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 17:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB6020675
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 17:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgCJRkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:40:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:35504 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726380AbgCJRkS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 13:40:18 -0400
Received: (qmail 24934 invoked by uid 109); 10 Mar 2020 17:40:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Mar 2020 17:40:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13296 invoked by uid 111); 10 Mar 2020 17:49:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Mar 2020 13:49:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Mar 2020 13:40:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.26.0-rc1
Message-ID: <20200310174017.GA549010@coredump.intra.peff.net>
References: <xmqqo8t4z29k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8t4z29k.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 10, 2020 at 07:57:11AM -0700, Junio C Hamano wrote:

>  * "git rebase" has learned to use the merge backend (i.e. the
>    machinery that drives "rebase -i") by default, while allowing
>    "--apply" option to use the "apply" backend (e.g. the moral
>    equivalent of "format-patch piped to am").  The rebase.backend
>    configuration variable can be set to customize.

I noticed a few behavior changes that I think are related to this
switch. I'm not sure to what degree we'd consider these a problem
(though the second I think may be an existing bug in the merge backend
that's just getting more attention), but it seems like the time to raise
the issue is now, before the release. :)

The first change is that we'll now open an editor when continuing a
conflicted rebase. You can see it by running this:

  for backend in apply merge; do
    echo "==> Running with rebase.backend=$backend"
  
    # new repo
    rm -rf repo
    git init -q repo
    cd repo
  
    # create two conflicting branches
    echo base >base && git add base && git commit -qm base
    echo master >file && git add file && git commit -qm master
    git checkout -q -b side HEAD^
    echo side >file && git add file && git commit -qm side
  
    # rebase on master, hit the conflict, then resolve it
    git -c rebase.backend=$backend rebase master
    echo resolved >file
    git add file
  
    # continue the rebase, noting whether we used the editor
    GIT_EDITOR='echo >&2 running editor on:' git rebase --continue
  done

We won't run the editor the "apply" backend, but do for "merge".  I'm
not sure how big a deal this is. It bit me because I have a script which
runs rebase in a "while read" shell loop, with stdin coming from a pipe
feeding the loop. It auto-continues when rerere is able to fix up the
conflicts, but the editor complains about stdin not being a tty and
dies.

I'd imagine that's a pretty rare situation, and it was easy enough to
fix up. But I wonder if we should be more careful about making sure the
behavior is more identical. On the other hand, I imagine this is the way
the merge backend has always behaved, so it would be a change in
behavior for people who had been using it already. I guess the _most_
compatible thing would be a merge-that-behaves-more-like-apply backend,
but I'm not sure if we want to support that forever.

The second thing I noticed is more clearly a bug, I think. If we have a
patch that is skipped because it was already applied, we get stuck in
"cherry-picking" mode. Try:

  for backend in apply merge; do
    echo "==> Running with rebase.backend=$backend"
  
    # new repo
    rm -rf repo
    git init -q repo
    cd repo
  
    echo base >file && git add file && git commit -qm base
    # do this in two steps so we don't match patch-id
    echo one >file && git commit -qam master-1
    echo two >file && git commit -qam master-2
  
    git checkout -q -b side HEAD~2
    echo two >file && git commit -qam side
  
    # start a rebase, which should realize that the patch is a noop
    git -c rebase.backend=$backend rebase master
  
    # see what state "status" reports us in
    git status
  done

For the "apply" case, I get:

  ==> Running with rebase.backend=apply
  First, rewinding head to replay your work on top of it...
  Applying: side
  Using index info to reconstruct a base tree...
  M	file
  Falling back to patching base and 3-way merge...
  No changes -- Patch already applied.
  On branch side
  nothing to commit, working tree clean

So we complete the rebase, and git-status shows nothing. But for the
merge backend:

  ==> Running with rebase.backend=merge
  dropping f8b25a2cd2a3a0e64d820efe2fcbae81dec98616 side -- patch contents already upstream
  Successfully rebased and updated refs/heads/side.
  On branch side
  You are currently cherry-picking commit f8b25a2.
  
  nothing to commit, working tree clean

Oops. If I "git rebase --continue" from there, I get "No rebase in
progress?". Doing "git cherry-pick --skip" clears it. I guess the issue
is the continued presence of .git/CHERRY_PICK_HEAD.

As you can see from the output above (and the earlier snippet, if you
run it), there are also a bunch of minor stderr output changes. I think
these probably aren't worth caring about.

-Peff
