Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEAB520D0C
	for <e@80x24.org>; Tue,  6 Jun 2017 03:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbdFFD4w (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 23:56:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:35219 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751292AbdFFD4w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 23:56:52 -0400
Received: (qmail 31730 invoked by uid 109); 6 Jun 2017 03:56:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jun 2017 03:56:52 +0000
Received: (qmail 21997 invoked by uid 111); 6 Jun 2017 03:57:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jun 2017 23:57:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jun 2017 23:56:50 -0400
Date:   Mon, 5 Jun 2017 23:56:50 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: [BUG?] gitlink without .gitmodules no longer fails recursive clone
Message-ID: <20170606035650.oykbz2uc4xkr3cr2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While running some regression tests with v2.13, I noticed an odd
behavior. If I create a repository where there's a gitlink with no
matching .gitmodules entry:

  git init repo
  cd repo
  n10=1234abcdef
  n40=$n10$n10$n10$n10
  git update-index --add --cacheinfo 160000 $n40 foo
  git commit -m "gitlink without .gitmodule entry"

and then I clone it recursively with v2.12, it fails:

  $ git.v2.12.3 clone --recurse-submodules . dst; echo exit=$?
  Cloning into 'dst'...
  done.
  fatal: No url found for submodule path 'foo' in .gitmodules
  exit=128

But with v2.13, it silently ignores the submodule:

  $ git.v2.13.1 clone --recurse-submodules . dst; echo exit=$?
  Cloning into 'dst'...
  done.
  exit=0

This bisects to your bb62e0a99 (clone: teach --recurse-submodules to
optionally take a pathspec, 2017-03-17). That patch just sets
submodule.active by default, so I think the real issue is probably in
a086f921a (submodule: decouple url and submodule interest, 2017-03-17).

I also wasn't sure if this might be intentional. I.e., that we'd just
consider gitlink entries which aren't even configured as not-submodules
and ignore them. I couldn't certainly see an argument for moving in that
direction, but it is different than what we used to do. But I couldn't
find anything in any of the commit messages that mentioned this either
way, so I figured I'd punt and ask. :)

-Peff
