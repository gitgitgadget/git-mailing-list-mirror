Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5FA1F516
	for <e@80x24.org>; Sun, 24 Jun 2018 08:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeFXI4Z (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Jun 2018 04:56:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:53150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751536AbeFXI4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jun 2018 04:56:25 -0400
Received: (qmail 29564 invoked by uid 109); 24 Jun 2018 08:56:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 24 Jun 2018 08:56:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7509 invoked by uid 111); 24 Jun 2018 08:56:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 24 Jun 2018 04:56:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Jun 2018 04:56:23 -0400
Date:   Sun, 24 Jun 2018 04:56:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [BUG] url schemes should be case-insensitive
Message-ID: <20180624085622.GA28575@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We seem to match url schemes case-sensitively:

  $ git clone SSH://example.com/repo.git
  Cloning into 'repo'...
  fatal: Unable to find remote helper for 'SSH'

whereas rfc3986 is clear that the scheme portion is case-insensitive.
We probably ought to match at least our internal ones with strcasecmp.
Possibly we should also normalize external helpers (so "FOO://bar" would
always call git-remote-foo, never git-remote-FOO).

We could probably also give an advise() message in the above output,
suggesting that the problem is likely one of:

  1. They misspelled the scheme.

  2. They need to install the appropriate helper.

This may be a good topic for somebody looking for low-hanging fruit to
get involved in development (I'd maybe call it a #leftoverbits, but
since I didn't start on it, I'm not sure if it counts as "left over" ;)).

-Peff
