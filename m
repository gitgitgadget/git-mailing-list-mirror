Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC900C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969E020719
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgDCTBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:01:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:60958 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727167AbgDCTBj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 15:01:39 -0400
Received: (qmail 29673 invoked by uid 109); 3 Apr 2020 19:01:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Apr 2020 19:01:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21955 invoked by uid 111); 3 Apr 2020 19:11:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Apr 2020 15:11:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Apr 2020 15:01:38 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: fast-import's hash table is slow
Message-ID: <20200403190138.GA660829@coredump.intra.peff.net>
References: <20200331094553.GB7274@coredump.intra.peff.net>
 <fcf422e4-08f6-634a-39ba-18d40d1c25ca@web.de>
 <20200401103522.GE60227@coredump.intra.peff.net>
 <20200401111621.GA1265072@coredump.intra.peff.net>
 <38be9140-546c-e3fa-fb71-c92937094a40@web.de>
 <20200403121212.GA65799@coredump.intra.peff.net>
 <0279dc99-871c-8fb4-f1b0-3ae4ae7d94d8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0279dc99-871c-8fb4-f1b0-3ae4ae7d94d8@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 03, 2020 at 08:53:23PM +0200, René Scharfe wrote:

> Am 03.04.20 um 14:12 schrieb Jeff King:
> > On Thu, Apr 02, 2020 at 08:40:35PM +0200, René Scharfe wrote:
> >
> >>>  struct object_entry {
> >>>  	struct pack_idx_entry idx;
> >>> -	struct object_entry *next;
> >>> +	struct hashmap_entry ent;
> >>
> >> That uses 16 bytes more memory per entry on x64 than khash would.
> >> That's 256MB for 2^24 objects -- not ideal, but bearable, I guess.
> >
> > Isn't it 8? We're dropping the old pointer and replacing it with the
> > "next" pointer in hashmap_entry, plus our 4-byte hash code (which likely
> > gets padded to 8).
> 
> That's right, so the difference to your khash version is 16, as the
> latter removes the pointer without any replacement.

Ah, OK. We are on the same page, then.

The khash version removes the pointer, but it presumably it would use a
larger number of buckets to keep the load factor down. I doubt it's
worth spending time running real-world heap-profiling experiments
(especially not on the silly synthetic test I showed).

-Peff
