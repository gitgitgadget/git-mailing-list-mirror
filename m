Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A67F01F404
	for <e@80x24.org>; Fri,  5 Jan 2018 00:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbeAEAWJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 19:22:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:53818 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751108AbeAEAWI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 19:22:08 -0500
Received: (qmail 26808 invoked by uid 109); 5 Jan 2018 00:22:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Jan 2018 00:22:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11673 invoked by uid 111); 5 Jan 2018 00:22:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Jan 2018 19:22:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Jan 2018 19:22:06 -0500
Date:   Thu, 4 Jan 2018 19:22:06 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Stephan Janssen <sjanssen@you-get.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] clone: factor out dir_exists() helper
Message-ID: <20180105002206.GB3474@sigill.intra.peff.net>
References: <20180102210753.GA10430@sigill.intra.peff.net>
 <20180102211014.GC22556@sigill.intra.peff.net>
 <xmqqbmi9dw55.fsf@gitster.mtv.corp.google.com>
 <20180104235412.GA3474@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180104235412.GA3474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 04, 2018 at 06:54:12PM -0500, Jeff King wrote:

> > If we really want to be anal, perhaps a new helper path_exists()
> > that cares only about existence of paths (i.e. the implementation of
> > these two helpers they currently have), together with update to
> > check the st.st_mode for file_exists() and dir_exists(), may help
> > making the API set more rational, but I do not think it is worth it.
> 
> Yep, I also considered that file_exists() probably wants to be
> path_exists() with its current implementation. We'd probably want to
> review all of the callers.
> 
> Anyway, I tried to do the minimal refactoring here, with no change in
> behavior. I'm not opposed to calling this dir_exists() as path_exists()
> and making it globally available (as you note, I don't think we'd want
> to use a true dir_exists() here).

So I actually started down this road just now, but I'm not sure if it's
worth it.  If we were to transition to an endgame with path_exists(),
dir_exists(), and file_exists(), we'd probably want to do something
like:

  1. introduce path_exists(), but leave existing file_exists() callers
     in place

  2. introduce file_exists_as_file(), which checks S_IFREG

  3. audit each file_exists() call to see if it ought to be
     path_exists() or file_exists_as_file() and convert as needed

  4. When there are no more file_exists() calls left, all
     file_exists_as_file() instances can be renamed to file_exists().

But as with any "audit each..." plan, that leaves topics in flight out
of luck. If we want to be kind to those, we'd have to wait a long while
to shake out any file_exists() callers.

At which point is there much value in having path_exists() as a wrapper?
It's a better name, perhaps, but I think my future-proofing against
"file_exists() may become file-specific" was probably overly paranoid. I
don't think we could sanely do that conversion without risking breakage.

Maybe we should just document its behavior and use it here, rather than
introducing this new dir_exists().

-Peff
