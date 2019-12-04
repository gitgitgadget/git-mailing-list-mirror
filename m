Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBC1C432C0
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 04:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509B22053B
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 04:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLDEFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 23:05:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:38034 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726834AbfLDEFp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 23:05:45 -0500
Received: (qmail 20186 invoked by uid 109); 4 Dec 2019 04:05:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Dec 2019 04:05:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3320 invoked by uid 111); 4 Dec 2019 04:09:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Dec 2019 23:09:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Dec 2019 23:05:44 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "Patrick Marlier (pamarlie)" <pamarlie@cisco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] send-pack: use OBJECT_INFO_QUICK to check negative
 objects
Message-ID: <20191204040544.GA11502@sigill.intra.peff.net>
References: <CH2PR11MB429411CA1288526D21C7AF26CF4C0@CH2PR11MB4294.namprd11.prod.outlook.com>
 <20191127123211.GG22221@sigill.intra.peff.net>
 <20191204035522.GC214771@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191204035522.GC214771@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 03, 2019 at 07:55:22PM -0800, Jonathan Nieder wrote:

> > We can fix this by using OBJECT_INFO_QUICK, which tells the lookup
> > code that we expect objects to be missing. Notably, it will not re-scan
> > the packs, and it will use the loose cache from 61c7711cfe (sha1-file:
> > use loose object cache for quick existence check, 2018-11-12).
> 
> On first reading, I wondered how this would interact with alternates,
> since you had mentioned that checking alternates can be expensive.  Does
> this go too far in that direction by treating an object as missing
> whenever it's not in the local object store, even if it's available from
> an alternate?
> 
> But I believe that was a misreading.  With this patch, we still do pay
> the cost of checking alternates for the missing object.  The savings
> is instead about having to *double* check.
> 
> Am I understanding correctly?

Yes, we'd still look in alternates for each object before giving up. The
reason alternates are relevant is that normally if you have (say) 5
alternates, then you have to do 5 syscalls to find out whether each
alternate has an object. And alternates are more likely to be on
high-latency filesystems like NFS, which exacerbates the cost. But with
OBJECT_INFO_QUICK, we'll build an in-memory cache for each alternate
directory (as well as the main object store, of course), rather than
making one request per object.

> > Interestingly, upload-pack does not use OBJECT_INFO_QUICK when it's
> > getting oids from the other side. But I think it could possibly benefit
> > in the same way. Nobody seems to have noticed. Perhaps it simply comes
> > up less, as servers would tend to have more objects than their clients?
> 
> I like to imagine that servers are also more likely to keep a tidy set
> of packs and to avoid alternates.  But using INFO_QUICK when checking
> the fetcher's "have"s does sound like a sensible change to me.

At GitHub we do use alternates (but only one, and on the same local
disk). And our packing situation does sometimes get unwieldy. I think it
might be worth looking into, but it would be nice to have real numbers
before proceeding (likewise we've known about this spot in send-pack,
but it hadn't been expensive enough for anybody to notice; I'll be
curious to see real-world numbers from Patrick's case).

-Peff
