Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BEE9211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 06:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeLEGvj (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 01:51:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:59460 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726037AbeLEGvi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 01:51:38 -0500
Received: (qmail 3585 invoked by uid 109); 5 Dec 2018 06:51:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 06:51:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28491 invoked by uid 111); 5 Dec 2018 06:51:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Dec 2018 01:51:06 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2018 01:51:36 -0500
Date:   Wed, 5 Dec 2018 01:51:36 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick
 existence check
Message-ID: <20181205065136.GA27263@sigill.intra.peff.net>
References: <87ftw62sld.fsf@evledraar.gmail.com>
 <20181112162150.GB7612@sigill.intra.peff.net>
 <87d0ra2b3z.fsf@evledraar.gmail.com>
 <87bm6u2akf.fsf@evledraar.gmail.com>
 <878t1x2t3e.fsf@evledraar.gmail.com>
 <221cb2e4-a024-e301-2b3f-e37dcd93795e@web.de>
 <20181203220424.GA11883@sigill.intra.peff.net>
 <fe388ba5-765e-ff83-e610-d40964a76a0c@web.de>
 <20181205044645.GA12284@sigill.intra.peff.net>
 <54e7a97d-501c-1aa7-55cd-83f070d05a8c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54e7a97d-501c-1aa7-55cd-83f070d05a8c@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 07:02:17AM +0100, René Scharfe wrote:

> > I actually wrote it that way initially, but doing the hashcpy() in the
> > caller is a bit more awkward. My thought was to punt on that until the
> > rest of the surrounding code starts handling oids.
> 
> The level of awkwardness is the same to me, but sha1_loose_object_info()
> is much longer already, so it might feel worse to add it there. 

Right, what I meant was that in sha1_loose_object_info():

  if (special_case)
	handle_special_case();

is easier to follow than a block setting up the special case and then
calling the function.

> This
> function is easily converted to struct object_id, though, as its single
> caller can pass one on -- this makes the copy unnecessary.

If you mean modifying sha1_loose_object_info() to take an oid, then
sure, I agree that is a good step forward (and that is exactly the "punt
until" moment I meant).

> > This patch looks sane. How do you want to handle it? I'd assumed your
> > earlier one would be for applying on top, but this one doesn't have a
> > commit message. Did you want me to squash down the individual hunks?
> 
> I'm waiting for the first one (object-store: use one oid_array per
> subdirectory for loose cache) to be accepted, as it aims to solve a
> user-visible performance regression, i.e. that's where the meat is.
> I'm particularly interested in performance numbers from Ævar for it.
> 
> I can send the last one properly later, and add patches for converting
> quick_has_loose() to struct object_id.  Those are just cosmetic..

Great, thanks. I just wanted to make sure these improvements weren't
going to slip through the cracks.

-Peff
