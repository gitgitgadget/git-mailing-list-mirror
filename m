Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64462C433DF
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 13:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D1A2076E
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 13:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgHTNsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:48:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:36278 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730592AbgHTNkf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 09:40:35 -0400
Received: (qmail 7094 invoked by uid 109); 20 Aug 2020 13:40:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Aug 2020 13:40:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15457 invoked by uid 111); 20 Aug 2020 13:40:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Aug 2020 09:40:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 Aug 2020 09:40:13 -0400
From:   Jeff King <peff@peff.net>
To:     Sergii Shkarnikov <sergii.shkarnikov@globallogic.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Possible bug with git restore
Message-ID: <20200820134013.GA2526241@coredump.intra.peff.net>
References: <CAFvH=vsWyX79j-9pyC5gpxGu8rRxYyrXwywHjh-_T2opHjT8Xg@mail.gmail.com>
 <CAPig+cSCd_8YB90sypTe1bHMQhPgo+Tr2PHNucdqfCpEe+Dosg@mail.gmail.com>
 <CAFvH=vuFg+kM2GkBaE7jRqHWWcTcZMrs36KLS+-VTy8tgNZXJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFvH=vuFg+kM2GkBaE7jRqHWWcTcZMrs36KLS+-VTy8tgNZXJw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 20, 2020 at 03:59:00PM +0300, Sergii Shkarnikov wrote:

> Here is a script to reproduce the issue that works for me in Git Bash:
> 
> =============================================
> #!/bin/bash
> 
> #create repo with corresponding structure
> mkdir restore_bug_test
> cd restore_bug_test
> mkdir incl
> mkdir src
> touch incl/test_file.hpp
> touch src/test_file.cpp
> git init
> git add .
> git commit -m"initial"
> 
> #add a couple of commits
> echo "1" >> incl/test_file.hpp
> echo "1" >> src/test_file.cpp
> git commit -am"1"
> echo "2" >> incl/test_file.hpp
> echo "2" >> src/test_file.cpp
> git commit -am"2"
> 
> #reproduce bug
> git restore -s HEAD~ -- *test_file.*
> git status
> ===============================================

That reproduces for me here on Linux, as well (for those just joining,
the interesting thing is that the final "git status" reports the files
as deleted, rather than modified back to "1").

Interestingly, if I do:

  git restore -s HEAD~ --overlay -- *test_file.*

then I get:

  error: pathspec '*test_file.*' did not match any file(s) known to git

So there are two oddities here:

  - shouldn't that wildcard pathspec match those files? I've confirmed
    that the glob characters make it into Git's pathspec machinery, and
    since it doesn't have slashes, I think we'd match a basename (and
    certainly "git ls-files *test_file.*" does what I expect).

  - even if it doesn't match, it seems weird that overlay mode would
    remove files that don't match. I'd expect it to remove files in
    trees that _did_ match the pathspec, but leave anything outside of
    the pathspec untouched.

    It's almost like we matched the pathspec in the pass over the
    working tree files, but failed to do so when reading in the tree.

-Peff
