Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D855A202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 16:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753745AbdCHQSX (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 11:18:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:40513 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753831AbdCHQRq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 11:17:46 -0500
Received: (qmail 31496 invoked by uid 109); 8 Mar 2017 16:17:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 16:17:44 +0000
Received: (qmail 18675 invoked by uid 111); 8 Mar 2017 16:17:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 11:17:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Mar 2017 11:17:42 -0500
Date:   Wed, 8 Mar 2017 11:17:42 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/2] Fix crashes due to real_pathdup() potentially
 returning NULL
Message-ID: <20170308161742.lpbf6gn6qhoex7et@sigill.intra.peff.net>
References: <cover.1488987786.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1488987786.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2017 at 04:43:27PM +0100, Johannes Schindelin wrote:

> We may want to consider fast-tracking this into v2.12.1, and to that
> end, I would appreciate code reviews that focus on the correctness of
> this patch and that try to consider undesired side effects.

I don't see how it could be not-correct, in the sense that every caller
now passes the die_on_error flag (restoring the original behavior)
except for the one which clearly checks for a NULL return immediately
afterward.

The only exception would be if there were new calls to real_pathdup()
that did not originally use real_path(). But:

  # 7241764076 introduced real_pathdup
  git log -Sreal_pathdup 7241764076..

shows only one other introduction, and it's just duplicating an existing
call.

It's possible that some of these _could_ handle the error case more
gracefully (I already fixed one such case in 3a1345af2). But even if
we wanted to do so, that should come separately on top of this patch.
This can go to 'maint' as a regression fix, and then that gives a stable
base for making potential improvements.

-Peff
