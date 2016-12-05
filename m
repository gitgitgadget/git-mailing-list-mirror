Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24A31FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 06:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750939AbcLEGCP (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 01:02:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:51547 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbcLEGCO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 01:02:14 -0500
Received: (qmail 27280 invoked by uid 109); 5 Dec 2016 06:01:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 06:01:19 +0000
Received: (qmail 1971 invoked by uid 111); 5 Dec 2016 06:01:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 01:01:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2016 01:01:16 -0500
Date:   Mon, 5 Dec 2016 01:01:16 -0500
From:   Jeff King <peff@peff.net>
To:     Jack Bates <bk874k@nottheoilrig.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jack Bates <jack@nottheoilrig.com>
Subject: Re: [PATCH v2] diff: handle --no-abbrev outside of repository
Message-ID: <20161205060116.szy5ojetg3znu4w7@sigill.intra.peff.net>
References: <20161129070637.eult6o3m34r2mima@sigill.intra.peff.net>
 <20161202184840.2158-1-jack@nottheoilrig.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161202184840.2158-1-jack@nottheoilrig.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2016 at 11:48:40AM -0700, Jack Bates wrote:

> The "git diff --no-index" codepath didn't handle the --no-abbrev option.
> Also it didn't behave the same as find_unique_abbrev()
> in the case where abbrev == 0.
> find_unique_abbrev() returns the full, unabbreviated string in that
> case, but the "git diff --no-index" codepath returned an empty string.

If you've dug into what's wrong, I think it's often good to add some
notes in the commit message in case somebody has to revisit this later.

For example, I'd have written something like:

  The "git diff --no-index" codepath doesn't handle the --no-abbrev
  option, because it relies on diff_opt_parse(). Normally that function
  is called as part of handle_revision_opt(), which handles the abbrev
  options itself. Adding the option directly to diff_opt_parse() fixes
  this. We don't need to do the same for --abbrev, because it's already
  handled there.

  Note that setting abbrev to "0" outside of a repository was broken
  recently by 4f03666ac (diff: handle sha1 abbreviations outside of
  repository, 2016-10-20). It adds a special out-of-repo code path for
  handling abbreviations which behaves differently than find_unique_abbrev()
  by truly giving a zero-length sha1, rather than taking "0" to mean "do
  not abbreviate".

  That bug was not triggerable until now, because there was no way to
  set the value to zero (using --abbrev=0 silently bumps it to the
  MINIMUM_ABBREV).

>  t/t4013-diff-various.sh                                 | 7 +++++++
>  t/t4013/diff.diff_--no-index_--raw_--abbrev=4_dir2_dir  | 3 +++
>  t/t4013/diff.diff_--no-index_--raw_--no-abbrev_dir2_dir | 3 +++
>  t/t4013/diff.diff_--no-index_--raw_dir2_dir             | 3 +++
>  t/t4013/diff.diff_--raw_--abbrev=4_initial              | 6 ++++++
>  t/t4013/diff.diff_--raw_--no-abbrev_initial             | 6 ++++++
>  t/t4013/diff.diff_--raw_initial                         | 6 ++++++

I wondered if the tests without --no-index were redundant with earlier
ones, but I don't think so. --abbrev=4 is tested with diff-tree, but
--no-abbrev is not covered at all, AFAICT.

>  diff.c                                                  | 6 +++++-

The actual code changes look good to me.

Thanks.

-Peff
