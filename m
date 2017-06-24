Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8BFE2082E
	for <e@80x24.org>; Sat, 24 Jun 2017 11:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbdFXL5H (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 07:57:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:51670 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751272AbdFXL5H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 07:57:07 -0400
Received: (qmail 32476 invoked by uid 109); 24 Jun 2017 11:57:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 11:57:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22998 invoked by uid 111); 24 Jun 2017 11:57:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Jun 2017 07:57:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jun 2017 07:57:04 -0400
Date:   Sat, 24 Jun 2017 07:57:04 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 22/29] commit_packed_refs(): use a staging file
 separate from the lockfile
Message-ID: <20170624115704.cb6nujno3elgqvdv@sigill.intra.peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <d8fa8dec13eb095c0c39ef0de2ee8987d6bf9d77.1498200513.git.mhagger@alum.mit.edu>
 <20170623194610.o2eyte4xmlsscrlz@sigill.intra.peff.net>
 <8156514c-f255-5bda-2011-db8f512d6fb9@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8156514c-f255-5bda-2011-db8f512d6fb9@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 24, 2017 at 01:43:09PM +0200, Michael Haggerty wrote:

> >>  out:
> >> +	rollback_lock_file(&refs->lock);
> > 
> > We always rollback the lockfile regardless, because committing it would
> > overwrite our new content with an empty file. There's no real safety
> > against somebody calling commit_lock_file() on it, but it also seems
> > like an uncommon error to make.
> 
> If this seems too dangerous, we could add a `LOCK_NO_COMMIT` flag for
> `hold_lock_file_for_update()` and `hold_lock_file_for_update_timeout()`,
> which would die() if somebody tries to commit the associated lockfile. I
> think we can live without it. I hope that any such bugs would be caught
> immediately by CI. But I admit that the prospect of renaming an empty
> file on top of a `packed-refs` file is quite sobering, so if anybody is
> worried about this, let me know and I'll implement it.

Yeah, that was the protection I was thinking of. Reflecting on it more,
though, it's not really any different than somebody calling
commit_lock_file() when we haven't correctly written out the whole
content. It's probably not worth adding code to protect against this
special case.

-Peff
