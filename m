Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F11C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E69C20776
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbgDALor (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:44:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:58154 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726804AbgDALor (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 07:44:47 -0400
Received: (qmail 1562 invoked by uid 109); 1 Apr 2020 11:44:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Apr 2020 11:44:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7517 invoked by uid 111); 1 Apr 2020 11:54:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Apr 2020 07:54:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Apr 2020 07:44:46 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Inefficiency of partial shallow clone vs shallow clone +
 "old-style" sparse checkout
Message-ID: <20200401114446.GA1589184@coredump.intra.peff.net>
References: <2814631585342072@sas8-da6d7485e0c7.qloud-c.yandex.net>
 <20200328144023.GB1198080@coredump.intra.peff.net>
 <decf87bb-dffc-e44e-912e-fe51bc2514c3@gmail.com>
 <8919571585692069@vla5-e043431e7e8d.qloud-c.yandex.net>
 <4872731585693023@vla5-c5051da8689e.qloud-c.yandex.net>
 <0bf763ad-5f1d-65e2-bf3a-a4b7d5a7b3e3@gmail.com>
 <8268671585700012@iva3-58091f505f14.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8268671585700012@iva3-58091f505f14.qloud-c.yandex.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 01, 2020 at 04:49:20AM +0300, Konstantin Tokarev wrote:

> > Less efficient use of network bandwidth is one thing, but shallow clones are
> > also more CPU-intensive with the "counting objects" phase on the server. Your
> > link shares the following end-to-end timings:
> >
> > * Shallow-clone: 234s
> > * Partial clone: 286s
> > * Both(???): 1023s
> >
> > The data implies that by asking for both you actually got a full clone (4.1 GB).
> 
> No, this is still a partial clone, full clone takes more than 6 GB

I think that 4GB number is just because of the bug, though. With the fix
I showed earlier, doing clones of linux.git from a local repo yields:

  type       objects (in passes)      bytes  time
  ----       -----------------------  -----  ----
  shallow      71447 (  71447+  n/a)  188MB   23s
  blob:none  5260567 (5193557+67010)  870MB   99s
  both         71447 (   4437+67010)  188MB   37s

The object counts and sizes make sense. blob:none is still going to get
the whole history of commits and trees, which are substantial. The sizes
for "shallow" and "both" are the same, because the checkout is going to
grab all of the blobs from the tip commit, which were included in the
original "shallow" anyway. It does take longer, because they come in a
second followup fetch (though I'm surprised it's so _much_ slower).

So to me that implies that shallow is strictly better than partial if
you're just going to check out the full tip commit. But doing both
together opens up the possibility of narrowing the sparse checkout.
Doing:

  $ git clone --no-local --no-checkout --filter=blob:none --depth=1 \
      /path/to/linux sparse
  $ cd sparse
  $ git sparse-checkout set arch

fetches 20795 objects (4437+16357+1), consuming only 27MB.

-Peff
