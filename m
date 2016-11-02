Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACE6220193
	for <e@80x24.org>; Wed,  2 Nov 2016 13:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754123AbcKBNE4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 09:04:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:37447 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752971AbcKBNEf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 09:04:35 -0400
Received: (qmail 22499 invoked by uid 109); 2 Nov 2016 13:04:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 13:04:34 +0000
Received: (qmail 2629 invoked by uid 111); 2 Nov 2016 13:05:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 09:05:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 09:04:32 -0400
Date:   Wed, 2 Nov 2016 09:04:32 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/5] disallow symlinks for .gitignore and .gitattributes
Message-ID: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed in a nearby discussion that we will follow in-filesystem
symlinks for in-tree .gitignore and .gitattributes files, but not when
those files are read out of the index (e.g., when switching branches).

This series teaches git to open those files with O_NOFOLLOW (when it is
available) to get more consistent behavior. Note that this only applies
to the in-tree versions; you can still symlink $GIT_DIR/info/attributes,
etc.

I stopped short of warning about symlinked entries in git-fsck, but
perhaps we would want to do that as well (doing it completely is tricky
because of all of the case-folding issues around matching pathnames).

  [1/5]: add open_nofollow() helper
  [2/5]: attr: convert "macro_ok" into a flags field
  [3/5]: exclude: convert "check_index" into a flags field
  [4/5]: attr: do not respect symlinks for in-tree .gitattributes
  [5/5]: exclude: do not respect symlinks for in-tree .gitignore

 attr.c                | 58 ++++++++++++++++++++++++++++++++-------------------
 dir.c                 | 20 +++++++++++++-----
 dir.h                 |  2 +-
 git-compat-util.h     |  3 +++
 t/t0003-attributes.sh | 31 +++++++++++++++++++++++++++
 t/t0008-ignores.sh    | 29 ++++++++++++++++++++++++++
 wrapper.c             |  8 +++++++
 7 files changed, 123 insertions(+), 28 deletions(-)

-Peff
