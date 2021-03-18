Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F09C43381
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 04:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B5A64F10
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 04:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhCREIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 00:08:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:40774 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhCREIb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 00:08:31 -0400
Received: (qmail 28891 invoked by uid 109); 18 Mar 2021 04:08:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Mar 2021 04:08:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17465 invoked by uid 111); 18 Mar 2021 04:08:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Mar 2021 00:08:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Mar 2021 00:08:29 -0400
From:   Jeff King <peff@peff.net>
To:     Waleed Khan <me@waleedkhan.name>
Cc:     Phil Hord <hordp@cisco.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org
Subject: Re: Bug: reference-transaction hook for branch deletions broken
 between Git v2.30 and Git v2.31
Message-ID: <YFLSPVr8k66c4CXs@coredump.intra.peff.net>
References: <CAKjfCeDdSRk5QwyYduvbQvz0zC9FCZ3+5bseeOmZBOULxZ0D7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKjfCeDdSRk5QwyYduvbQvz0zC9FCZ3+5bseeOmZBOULxZ0D7w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 08:42:10PM -0700, Waleed Khan wrote:

> The `reference-transaction` hook seems to have broken between Git
> v2.30 and v2.31, or at least violated my expectations as a user.
> 
> I didn't see any mention of the `reference-transaction` hook in the
> release notes, so I assume that this is a bug. Given that there's
> documentation at `man githooks` for the `reference-transaction` hook,
> I assume that the feature is no longer in a preliminary stage, and so
> a bug report is warranted. I couldn't find any mention of a
> `reference-transaction` hook bug already having been reported in the
> mailing list search online.

Thanks for a clear explanation and reproduction recipe. I can see the
bug easily here. It bisects to 8198907795 (use delete_refs when deleting
tags or branches, 2021-01-20). I've cc'd the author of that commit, as
well as the author of the ref-transaction hook (I've also retained the
reproduction info for them at the end of the message).

I _think_ this is probably another variant of what we were discussing
in:

  https://lore.kernel.org/git/d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im/

and that ended up with the documentation from:

  https://lore.kernel.org/git/55905b8693dd49637d0516ee123405cbfb58b6c6.1614591751.git.ps@pks.im/

Namely that the hook is not seeing the "old" ref value as it was on
disk, but rather they see the value that the caller asked us to verify
existed (or all zeroes if the caller didn't specify). So I think what
happened is that git-branch went from calling "delete the ref X with
value 1234abcd" to "delete the ref X, no matter what it's value is".

-Peff

-- >8 --
> To reproduce, run this script:
> 
> ```
> #!/bin/sh
> set -eu
> 
> # Change between Git v2.30.0 and v2.31.0 here.
> GIT=${GIT:-$(which git)}
> echo "Running version $("$GIT" version)"
> 
> # For determinism.
> export GIT_COMMITTER_DATE="Wed Mar 17 16:53:32 PDT 2021"
> export GIT_AUTHOR_DATE="Wed Mar 17 16:53:32 PDT 2021"
> 
> rm -rf repo
> mkdir repo
> cd repo
> "$GIT" init
> "$GIT" commit --allow-empty -m 'Initial commit'
> 
> mkdir .git/hooks
> cat >.git/hooks/reference-transaction <<'EOF'
> #!/bin/sh
> echo "reference-transaction ($1):"
> cat
> EOF
> chmod +x .git/hooks/reference-transaction
> 
> "$GIT" branch -v 'test-branch'
> echo "Created test-branch"
> "$GIT" branch -v -d 'test-branch'
> ```
> 
> ## Expected behavior (git v2.30) ##
> 
> This is the output:
> 
> ```
> [master (root-commit) 3b61ecc] Initial commit
> reference-transaction (prepared):
> 0000000000000000000000000000000000000000
> 3b61ecc56006fcc283d42b302191e1385f19b551 refs/heads/test-branch
> reference-transaction (committed):
> 0000000000000000000000000000000000000000
> 3b61ecc56006fcc283d42b302191e1385f19b551 refs/heads/test-branch
> Created test-branch
> reference-transaction (aborted):
> 0000000000000000000000000000000000000000
> 0000000000000000000000000000000000000000 refs/heads/test-branch
> reference-transaction (prepared):
> 3b61ecc56006fcc283d42b302191e1385f19b551
> 0000000000000000000000000000000000000000 refs/heads/test-branch
> reference-transaction (committed):
> 3b61ecc56006fcc283d42b302191e1385f19b551
> 0000000000000000000000000000000000000000 refs/heads/test-branch
> Deleted branch test-branch (was 3b61ecc).
> ```
> 
> It's pretty strange that there was an "aborted" reference-transaction
> from 0 to 0, especially with no previous "prepared"
> reference-transaction, but that's not the bug in question, and I can
> work around it by ignoring such transactions on my end.
> 
> Notice that as part of the branch deletion, there is a
> reference-transaction from a non-zero commit hash to a zero commit
> hash.
> 
> ## Actual behavior (git v2.31) ##
> 
> ```
> [master (root-commit) 3b61ecc] Initial commit
> reference-transaction (prepared):
> 0000000000000000000000000000000000000000
> 3b61ecc56006fcc283d42b302191e1385f19b551 refs/heads/test-branch
> reference-transaction (committed):
> 0000000000000000000000000000000000000000
> 3b61ecc56006fcc283d42b302191e1385f19b551 refs/heads/test-branch
> Created test-branch
> reference-transaction (prepared):
> 0000000000000000000000000000000000000000
> 0000000000000000000000000000000000000000 refs/heads/test-branch
> reference-transaction (committed):
> 0000000000000000000000000000000000000000
> 0000000000000000000000000000000000000000 refs/heads/test-branch
> reference-transaction (aborted):
> 0000000000000000000000000000000000000000
> 0000000000000000000000000000000000000000 refs/heads/test-branch
> reference-transaction (prepared):
> 0000000000000000000000000000000000000000
> 0000000000000000000000000000000000000000 refs/heads/test-branch
> reference-transaction (committed):
> 0000000000000000000000000000000000000000
> 0000000000000000000000000000000000000000 refs/heads/test-branch
> Deleted branch test-branch (was 3b61ecc).
> ```
> 
> My issues are 1) the reference-transaction deleting the branch goes
> from a zero commit hash, instead of from the non-zero commit hash
> 3b61ec, and 2) there's two such "committed" transactions for some
> reason. Like the other example, there's also a mysterious unpaired
> aborted transaction, but I assume that's not new behavior in this
> release.
