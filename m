Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372BD1F991
	for <e@80x24.org>; Wed,  9 Aug 2017 12:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbdHIMVu (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 08:21:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:33190 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752439AbdHIMVu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 08:21:50 -0400
Received: (qmail 2915 invoked by uid 109); 9 Aug 2017 12:21:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 12:21:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26654 invoked by uid 111); 9 Aug 2017 12:22:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 08:22:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 08:21:47 -0400
Date:   Wed, 9 Aug 2017 08:21:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/5] make interpret-trailers useful for parsing
Message-ID: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Parsing trailers out of a commit message is _mostly_ easy, but there
area a lot of funny corner cases (e.g., heuristics for how many
non-trailers must be present before a final paragraph isn't a trailer
block anymore).  The code in trailer.c already knows about these corner
cases, but there's no way to access it from the command line.

This series teaches interpret-trailers to parse and output just the
trailers. So now you can do:

  $ git log --format=%B -1 8d44797cc91231cd44955279040dc4a1ee0a797f |
    git interpret-trailers --parse
  Signed-off-by: Hartmut Henkel <henkel@vh-s.de>
  Helped-by: Stefan Beller <sbeller@google.com>
  Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
  Acked-by: Matthias Rüster <matthias.ruester@gmail.com>

I considered a few different approaches before deciding on
what's here:

  1. The output format is actually the normal "key: value" trailers. I
     considered something more structured like JSON. But the "key:
     value" format is quite easy to parse, once it has been normalized
     (finding the trailers, unfolding whitespace continuation, etc).

  2. This series introduces several orthogonal options which can be used
     together to achieve my goal, when there could just be a "parse"
     mode. Since interpret-trailers is plumbing, I reasoned that the
     individual options might still be useful apart from each other (for
     instance, you could re-normalize existing trailers while writing
     your new ones from a commit hook). I did add a "--parse" for
     convenience and to help point users in the right direction.

     For the same reason (and so we could build on other orthogonal
     features like --in-place and --trim-empty), I decided against
     having a separate command like "git parse-trailers".

  [1/5]: trailer: put process_trailers() options into a struct
  [2/5]: interpret-trailers: add an option to show only the trailers
  [3/5]: interpret-trailers: add an option to show only existing trailers
  [4/5]: interpret-trailers: add an option to normalize output
  [5/5]: interpret-trailers: add --parse convenience option

 Documentation/git-interpret-trailers.txt | 17 ++++++++
 builtin/interpret-trailers.c             | 34 ++++++++++++---
 t/t7513-interpret-trailers.sh            | 73 ++++++++++++++++++++++++++++++++
 trailer.c                                | 65 ++++++++++++++++++++++------
 trailer.h                                | 12 +++++-
 5 files changed, 180 insertions(+), 21 deletions(-)

-Peff
