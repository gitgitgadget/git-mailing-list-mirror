Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B60C4346E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 07:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D431623787
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 07:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgIXHb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 03:31:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:39078 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbgIXHb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 03:31:26 -0400
Received: (qmail 1784 invoked by uid 109); 24 Sep 2020 07:31:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Sep 2020 07:31:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24156 invoked by uid 111); 24 Sep 2020 07:31:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Sep 2020 03:31:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Sep 2020 03:31:25 -0400
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 06/13] reftable: (de)serialization for the polymorphic
 record type.
Message-ID: <20200924073125.GD1851751@coredump.intra.peff.net>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <791f69c000556e93bf5fcfc0ec9304833b12565b.1600283416.git.gitgitgadget@gmail.com>
 <xmqqlfh5i7nk.fsf@gitster.c.googlers.com>
 <CAFQ2z_M9uBc+VArOVXg-hwTY8bu-gQQSL9JC6TJ5MuTCtxx=EQ@mail.gmail.com>
 <20200924072151.GC1851751@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200924072151.GC1851751@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 24, 2020 at 03:21:51AM -0400, Jeff King wrote:

> > I originally had
> > 
> > +void put_be64(uint8_t *out, uint64_t v)
> > +{
> > +       int i = sizeof(uint64_t);
> > +        while (i--) {
> > +               out[i] = (uint8_t)(v & 0xff);
> > +               v >>= 8;
> > +       }
> > +}
> > 
> > in my reftable library, which is portable. Is there a reason for the
> > magic with htonll and friends?
> 
> Presumably it was thought to be faster. This comes originally from the
> block-sha1 code in 660231aa97 (block-sha1: support for architectures
> with memory alignment restrictions, 2009-08-12). I don't know how it
> compares in practice, and especially these days.
> 
> Our fallback routines are similar to an unrolled version of what you
> wrote above.

We should be able to measure it pretty easily, since block-sha1 uses a
lot of get_be32/put_be32. I generated a 4GB random file, built with
BLK_SHA1=Yes and -O2, and timed:

  t/helper/test-tool sha1 <foo.rand

Then I did the same, but building with -DNO_UNALIGNED_LOADS. The latter
actually ran faster, by a small margin. Here are the hyperfine results:

  [stock]
  Time (mean ± σ):      6.638 s ±  0.081 s    [User: 6.269 s, System: 0.368 s]
  Range (min … max):    6.550 s …  6.841 s    10 runs

  [-DNO_UNALIGNED_LOADS]
  Time (mean ± σ):      6.418 s ±  0.015 s    [User: 6.058 s, System: 0.360 s]
  Range (min … max):    6.394 s …  6.447 s    10 runs

For casual use as in reftables I doubt the difference is even
measurable. But this result implies that perhaps we ought to just be
using the fallback version all the time.

-Peff
