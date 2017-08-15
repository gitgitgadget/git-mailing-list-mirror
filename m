Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38CE51F667
	for <e@80x24.org>; Tue, 15 Aug 2017 10:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753673AbdHOKW6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 06:22:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:39240 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753667AbdHOKW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 06:22:57 -0400
Received: (qmail 31408 invoked by uid 109); 15 Aug 2017 10:22:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 10:22:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9714 invoked by uid 111); 15 Aug 2017 10:23:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 06:23:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Aug 2017 06:22:54 -0400
Date:   Tue, 15 Aug 2017 06:22:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 0/8] trailer parsing via interpret-trailers and %(trailers)
Message-ID: <20170815102254.knccmhgralfijwli@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
 <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net>
 <20170810180326.4kkmawywvdbuzwnp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170810180326.4kkmawywvdbuzwnp@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a fourth version of my series to make the output of
interpret-trailers useful for callers who just want to parse existing
trailers.

The big change here is that I added similar features to pretty.c's
"%(trailers)", meaning you can now efficiently get the same output for
multiple commits with a single invocation. Like:

  $ git rev-list --no-walk --format='%(trailers:only:unfold)' \
    3ac53e0d13fa7483cce90eb6a1cfcdcbda5b8e35
  commit 3ac53e0d13fa7483cce90eb6a1cfcdcbda5b8e35
  Signed-off-by: H. Peter Anvin <hpa@zytor.com>
  Signed-off-by: Junio C Hamano <junkio@cox.net>

That doesn't look very exciting, but with just "%(trailers)" you would
see that the block also contains a "cherry-picked from" line. There
aren't good examples of unfolding in git.git because we don't tend to
fold. Nor does linux.git (though they do have a lot of non-trailer lines
in square brackets). The tests show off some samples of both.

I left %(trailers) exactly as it is: it shows the trailer block
verbatim, including funny syntax, etc. As soon as you use one of :only
or :unfold, we have to parse further, and as a side effect we normalize
a few bits (like whitespace around separators), because we round-trip
through the parser. I think that's fine and what callers would want. But
it did make me wonder if I should just have a single "parse" option that
does all that normalizing. Or alternatively, have %(trailers) always do
that round-trip normalizing. That's how interpret-trailers behaves,
after all(since it always parses and reconstructs the trailer block). I
felt better taking the conservative route, though, and leaving
%(trailers) alone.

There are a few other changes from v3:

  - the --normalize option is now --unfold (and I matched it with
    ":unfold" for the placeholder)

  - the process_input_file function now takes the
    process_trailer_options to check "only_trailers" instead of taking a
    hint from a NULL outfile. This is hopefully a bit more obvious.

  - when only_trailers is set, I don't even bother adding non-trailers
    from the middle of the trailer-block to the list (we know we'd never
    output them, and they can't affect the trailer rules). This is just
    a micro-optimization I noticed while writing the %(trailers) helper.

  - Similarly, we no longer unfold non-trailers. So if you have:

      key: value
        more value
      this is not a trailer
        this is also not a trailer

    we would unfold "key: value more value", but not the other two
    lines. Because without a separator, that's not really folding. I'm
    not sure it actually matters. It's hard to have non-trailers in the
    block in the first place. But I think the new behavior is the right
    thing if it ever does come up.

  [1/8]: trailer: put process_trailers() options into a struct
  [2/8]: interpret-trailers: add an option to show only the trailers
  [3/8]: interpret-trailers: add an option to show only existing trailers
  [4/8]: interpret-trailers: add an option to unfold values
  [5/8]: interpret-trailers: add --parse convenience option
  [6/8]: pretty: move trailer formatting to trailer.c
  [7/8]: t4205: refactor %(trailer) tests
  [8/8]: pretty: support normalization options for %(trailers)

 Documentation/git-interpret-trailers.txt |  33 +++++++--
 Documentation/pretty-formats.txt         |   5 +-
 builtin/interpret-trailers.c             |  34 +++++++--
 pretty.c                                 |  26 +++----
 t/t4205-log-pretty-formats.sh            |  51 ++++++++++++--
 t/t7513-interpret-trailers.sh            |  76 ++++++++++++++++++++
 trailer.c                                | 115 ++++++++++++++++++++++++++-----
 trailer.h                                |  27 +++++++-
 8 files changed, 315 insertions(+), 52 deletions(-)

-Peff
