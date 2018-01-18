Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5B71FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 14:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756215AbeAROTR (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 09:19:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:47932 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756342AbeAROTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 09:19:16 -0500
Received: (qmail 31671 invoked by uid 109); 18 Jan 2018 14:19:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Jan 2018 14:19:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11253 invoked by uid 111); 18 Jan 2018 14:19:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Jan 2018 09:19:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jan 2018 09:19:14 -0500
Date:   Thu, 18 Jan 2018 09:19:14 -0500
From:   Jeff King <peff@peff.net>
To:     Mathias Rav <m@git.strova.dk>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] files_initial_transaction_commit(): only unlock if locked
Message-ID: <20180118141914.GA32718@sigill.intra.peff.net>
References: <20180118143841.1a4c674d@novascotia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180118143841.1a4c674d@novascotia>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 02:38:41PM +0100, Mathias Rav wrote:

> Running git clone --single-branch --mirror -b TAGNAME previously
> triggered the following error message:
> 
> 	fatal: multiple updates for ref 'refs/tags/TAGNAME' not allowed.
> 
> This error condition is handled in files_initial_transaction_commit().
> 
> 42c7f7ff9 ("commit_packed_refs(): remove call to `packed_refs_unlock()`", 2017-06-23)
> introduced incorrect unlocking in the error path of this function,
> which changes the error message to
> 
> 	fatal: BUG: packed_refs_unlock() called when not locked
> 
> Move the call to packed_refs_unlock() above the "cleanup:" label
> since the unlocking should only be done in the last error path.

Thanks, this solution looks correct to me. It's pretty low-impact since
the locking is the second-to-last thing in the function, so we don't
have to re-add the unlock to a bunch of error code paths. But one
alternative would be to just do:

  if (packed_refs_is_locked(refs))
	packed_refs_unlock(refs->packed_ref_store);

in the cleanup section.

-Peff
