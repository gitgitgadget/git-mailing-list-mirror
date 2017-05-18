Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90814201A7
	for <e@80x24.org>; Thu, 18 May 2017 01:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754626AbdERBL7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 21:11:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:53964 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754080AbdERBL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 21:11:59 -0400
Received: (qmail 19770 invoked by uid 109); 18 May 2017 01:11:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 May 2017 01:11:56 +0000
Received: (qmail 13506 invoked by uid 111); 18 May 2017 01:12:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 21:12:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 May 2017 21:11:53 -0400
Date:   Wed, 17 May 2017 21:11:53 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 10/23] files_ref_store: put the packed files lock
 directly in this struct
Message-ID: <20170518011153.luuacy5jay6vinzv@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <dd7637060bac1a27e03563edc82649812dcf897c.1495014840.git.mhagger@alum.mit.edu>
 <20170517131753.rditx62clmkrdmeq@sigill.intra.peff.net>
 <20170518001717.GF185461@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170518001717.GF185461@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 05:17:17PM -0700, Brandon Williams wrote:

> > This made me wonder how we handle the locking for ref_stores besides the
> > main one (e.g., for submodules). The lockfile structs have to remain
> > valid for the length of the program. Previously those stores could have
> > xcalloc()'d a lockfile and just leaked it. Now they'll need to xcalloc()
> > and leak their whole structs.
> 
> Wait, why would this be the case?  I would assume that you would
> allocate a ref_store (including a lockfile for it) and then once you are
> done with the ref_store, you free it (and unlock and free the lockfile).
> I'm definitely not versed in ref handling code though so I may be
> missing something.

One used, you are not allowed to free a lockfile struct (actually these
days it's just the "tempfile" part of it), because it lives on the
cleanup-handler's tempfile_list forever.

This is a holdover from the early days of the lockfile code, but I think
we could loosen it (and that's the right solution in the long run).

> > I suspect the answer is "we don't ever lock anything except the main ref
> > store because that is the only one we write to", so it doesn't matter
> > anyway.
> 
> Really? I can envision a case in the future where we'd want to update
> a ref, or create a ref inside a submodule.

Oh, I agree it's a probable thing for the future. I was mostly wondering
about the immediate change. I think this patch makes things slightly
worse for that future, but the right fix is to remove the weird tempfile
lifetime requirement in the first place.

-Peff
