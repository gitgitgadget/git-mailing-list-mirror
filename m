Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7A44202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 14:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbdGMOz5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 10:55:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:39074 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751200AbdGMOz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 10:55:56 -0400
Received: (qmail 23831 invoked by uid 109); 13 Jul 2017 14:55:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 14:55:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32004 invoked by uid 111); 13 Jul 2017 14:56:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 10:56:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 10:55:53 -0400
Date:   Thu, 13 Jul 2017 10:55:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/15] making user-format colors conditional on config/tty
Message-ID: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a cleanup of the patch I posted last October:

  https://public-inbox.org/git/20161010151517.6wszhuyp57yfncaj@sigill.intra.peff.net/

The general idea is that it's rather confusing that "%C(red)" in a
pretty-print format does not currently respect color.ui, --no-color, or
the usual isatty check on stdout. This series changes that. Note that
this is a backwards-incompatible change, but the general sentiment in
that earlier thread seemed to be that the existing behavior is arguably
buggy. See patch 14 for more discussion.

The patch stalled back then because I wanted to make sure that
ref-filter's color placeholders behaved the same. That required some
refactoring which conflicted badly with kn/ref-filter-branch-list. Now
that it has graduated, I was able to rebase on top.

This version also takes into account feedback from the original thread.
And as I added tests, it surfaced a few corner cases around color config
that I've dealt with here.  The last two patches are the most
interesting bits.

  [01/15]: check return value of verify_ref_format()
  [02/15]: docs/for-each-ref: update pointer to color syntax
  [03/15]: t: use test_decode_color rather than literal ANSI codes
  [04/15]: ref-filter: simplify automatic color reset
  [05/15]: ref-filter: abstract ref format into its own struct
  [06/15]: ref-filter: move need_color_reset_at_eol into ref_format
  [07/15]: ref-filter: provide a function for parsing sort options
  [08/15]: ref-filter: make parse_ref_filter_atom a private function
  [09/15]: ref-filter: factor out the parsing of sorting atoms
  [10/15]: ref-filter: pass ref_format struct to atom parsers
  [11/15]: color: check color.ui in git_default_config()
  [12/15]: for-each-ref: load config earlier
  [13/15]: rev-list: pass diffopt->use_colors through to pretty-print
  [14/15]: pretty: respect color settings for %C placeholders
  [15/15]: ref-filter: consult want_color() before emitting colors

 Documentation/git-for-each-ref.txt |   6 +-
 Documentation/pretty-formats.txt   |  18 ++++--
 builtin/branch.c                   |  21 +++---
 builtin/clean.c                    |   3 +-
 builtin/for-each-ref.c             |  27 ++++----
 builtin/grep.c                     |   2 +-
 builtin/rev-list.c                 |   1 +
 builtin/show-branch.c              |   2 +-
 builtin/tag.c                      |  61 ++++++------------
 builtin/verify-tag.c               |  14 ++--
 color.c                            |   8 ---
 config.c                           |   4 ++
 diff.c                             |   3 -
 pretty.c                           |  27 ++++++--
 ref-filter.c                       | 108 ++++++++++++++++++-------------
 ref-filter.h                       |  30 +++++++--
 t/t3203-branch-output.sh           |  31 +++++++++
 t/t4207-log-decoration-colors.sh   |  22 +++----
 t/t6006-rev-list-format.sh         | 129 ++++++++++++++++++++++++-------------
 t/t6300-for-each-ref.sh            |  39 +++++++----
 t/t7004-tag.sh                     |  25 +++++++
 t/test-lib-functions.sh            |   1 +
 22 files changed, 362 insertions(+), 220 deletions(-)

-Peff
