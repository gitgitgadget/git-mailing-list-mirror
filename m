Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 939542021E
	for <e@80x24.org>; Thu,  3 Nov 2016 15:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756414AbcKCPO0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 11:14:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:38033 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751693AbcKCPOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 11:14:25 -0400
Received: (qmail 27304 invoked by uid 109); 3 Nov 2016 15:14:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 15:14:24 +0000
Received: (qmail 13084 invoked by uid 111); 3 Nov 2016 15:14:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 11:14:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2016 11:14:22 -0400
Date:   Thu, 3 Nov 2016 11:14:22 -0400
From:   Jeff King <peff@peff.net>
To:     Chris Purcell <chris.purcell.39@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug in git rev-parse @{push}?
Message-ID: <20161103151422.nhrgzivapy5tisr4@sigill.intra.peff.net>
References: <CAJUoZVYF=ZCBUX6jztwhJX3BZdq4JEfrSRbi4cFPwn+7yA=VjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJUoZVYF=ZCBUX6jztwhJX3BZdq4JEfrSRbi4cFPwn+7yA=VjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2016 at 02:53:44PM +0000, Chris Purcell wrote:

> I think I have discovered a bug in rev-parse's handling of @{push}:
> 
> $ git push
> Everything up-to-date
> $ git rev-parse @{push}
> fatal: cannot resolve 'simple' push to a single destination
> 
> The documentation for rev-parse says that "the suffix @{push} reports
> the branch 'where we would push to' if git push were run while
> branchname was checked out", so I would not expect this to error
> unless git push does.

I'm not too surprised if there's a bug there. IIRC, the way the code is
structured, some of the logic had to be reimplemented for @{push} rather
than re-used, so there may be corner cases where they do not agree.

> The relevant parts of my configuration are:
> 
> [push]
>     default = simple
> [remote]
>     pushdefault = origin
> [branch "foo"]
>     remote = origin
>     merge = refs/heads/develop
> 
> The code in branch_get_push_1 (remote.c) in the PUSH_DEFAULT_SIMPLE
> case is calling both branch_get_upstream and tracking_for_push_dest
> and erroring if they don't return the same result, which I assume is
> incorrect for a triangular workflow?

I assume you have branch "foo" checked out?

With this config I don't see how "git push" would work. Because you're
using "simple", it should complain that "develop" and "foo" are not the
same name.

Can you give a more full reproduction recipe? If I try:

  git init tmp && cd tmp
  git config push.default simple
  git commit -m foo --allow-empty ;# just to have some commit to push

  git init --bare dst.git
  git remote add origin dst.git
  git push origin master:refs/heads/develop

  git checkout -b foo origin/develop

  # pushdefault of "origin" is already the default. checkout will have
  # set up branch.foo.* as you specified. So let's try our push.
  git push

Then I get:

  fatal: The upstream branch of your current branch does not match
  the name of your current branch.  To push to the upstream branch
  on the remote, use

      git push origin HEAD:develop

  To push to the branch of the same name on the remote, use

      git push origin foo

which makes sense.

If you _don't_ get that same message with "git push", then my next
question is: might you have any aliases or other systems like "hub" that
are munging the arguments to "git push"? Running with "GIT_TRACE=1" in
the environment might be enlightening there.

> Please let me know if I've missed out important information by
> mistake. I'm happy to work on a patch if given guidance, but this is
> definitely outside my comfort zone for an unfamiliar codebase
> otherwise! e.g. I can't find the test suite.

The tests are in the "t" directory; see t/README for details. You can
run them all with "make test" from the top-level directory.

-Peff
