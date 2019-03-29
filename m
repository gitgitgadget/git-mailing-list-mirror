Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B1CC20248
	for <e@80x24.org>; Fri, 29 Mar 2019 13:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfC2Ndv (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 09:33:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:40374 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729626AbfC2Ndv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 09:33:51 -0400
Received: (qmail 22370 invoked by uid 109); 29 Mar 2019 13:33:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 29 Mar 2019 13:33:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19404 invoked by uid 111); 29 Mar 2019 13:34:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 29 Mar 2019 09:34:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Mar 2019 09:33:49 -0400
Date:   Fri, 29 Mar 2019 09:33:49 -0400
From:   Jeff King <peff@peff.net>
To:     Kurt Ablinger <kurt.ablinger@bs-ag.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Problem with filename containing '?'
Message-ID: <20190329133349.GA21802@sigill.intra.peff.net>
References: <1c1c5d858d8b431fb96b1d48044c00b7@bs-ag.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c1c5d858d8b431fb96b1d48044c00b7@bs-ag.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 01:10:19PM +0000, Kurt Ablinger wrote:

> in Linux the git-client accepts (add, commit, push) files with '?' (questionmark)  in its name.
> 
> When cloning such a repository into Eclipse (eGit/jGit) the
> repository-clone is rejected with an 'Invalid Path'-message with the
> ?-filename.
> 
> Under Linux it is possible to create a clone (the same git-binary used
> to checkin the ?-file) without any message.
> But the directory containing the ?-file is silently discarded whatever
> you checkout (master/HEAD, first or any other commit containing this
> file).

It seems to work fine for me with a few simple exercises:

  git init repo
  cd repo
  mkdir subdir
  echo foo >'subdir/bar?'
  git add .
  git commit -m 'file with question mark in name'

  git clone --no-local . child
  cd child
  ls -l
  echo changes >'subdir/bar?'
  git commit -am 'changes'
  git show

It also seems to clone fine with jgit:

  jgit clone $PWD/repo jgit-clone

Can you show us more exactly what you're running, and what doesn't work?

Also, one other question: are you sure it's actually a question mark in
the name? If there are non-ascii garbage characters, "ls" will typically
show a question mark when output is going to the terminal. E.g.:

  $ echo foo >"$(printf 'funny\1char')"
  $ ls
  funny?char
  $ ls | cat -A
  funny^Achar$
  $ ls | xxd
  00000000: 6675 6e6e 7901 6368 6172 0a              funny.char.

If it's some more exotic character, then that may be why jgit rejects
it.

-Peff
