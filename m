Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549C5200B9
	for <e@80x24.org>; Tue,  8 May 2018 18:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeEHSZw (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 14:25:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:60756 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932133AbeEHSZv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 14:25:51 -0400
Received: (qmail 16663 invoked by uid 109); 8 May 2018 18:25:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 May 2018 18:25:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7509 invoked by uid 111); 8 May 2018 18:25:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 May 2018 14:25:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2018 14:25:48 -0400
Date:   Tue, 8 May 2018 14:25:48 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] getting rid of most "static struct lock_file"s
Message-ID: <20180508182548.GD7210@sigill.intra.peff.net>
References: <20180506141031.30204-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180506141031.30204-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 06, 2018 at 04:10:26PM +0200, Martin Ågren wrote:

> This series addresses two classes of "static struct lock_file", removing
> the staticness: Those locks that already live inside a function, and
> those that can simply be moved into the function they are used from.
> 
> The first three patches are some cleanups I noticed along the way, where
> we first take a lock using LOCK_DIE_ON_ERROR, then check whether we got
> it.
> 
> After this series, we have a small number of "static struct lock_file"
> left, namely those locks that are used from within more than one
> function. Thus, after this series, when one stumbles upon a static
> lock_file, it should be a clear warning that the lock is being
> used by more than one function.

These all look fine to me. The commit messages all made perfect sense to
me, but it sounds like some people weren't aware of the new
post-076aa2cbda rules. So maybe it makes sense to reference that even in
the earlier commits, and to explicitly say that it's safe to convert
even in the case where the lock_file goes out of scope while still
active.

The only dangerous thing left to check for is anybody holding onto a
pointer-to-lockfile. The only such pointer declared outside of a
parameter list is in create_reflock(), and there it's just to
temporarily coerce a void pointer. So unless somebody is doing something
really tricky (putting a pointer-to-lock in a "void *"), I think these
conversions all have to be trivially correct (famous last words...).

-Peff
