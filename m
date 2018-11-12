Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53BDF1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 16:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbeKMCPt (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 21:15:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:36042 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729373AbeKMCPt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 21:15:49 -0500
Received: (qmail 484 invoked by uid 109); 12 Nov 2018 16:21:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 16:21:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12800 invoked by uid 111); 12 Nov 2018 16:21:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 11:21:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 11:21:51 -0500
Date:   Mon, 12 Nov 2018 11:21:51 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick
 existence check
Message-ID: <20181112162150.GB7612@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145442.GH7400@sigill.intra.peff.net>
 <87ftw62sld.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftw62sld.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 05:01:02PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > There's some obvious hand-waving in the paragraphs above. I would love
> > it if somebody with an NFS system could do some before/after timings
> > with various numbers of loose objects, to get a sense of where the
> > breakeven point is.
> >
> > My gut is that we do not need the complexity of a cache-size limit, nor
> > of a config option to disable this. But it would be nice to have a real
> > number where "reasonable" ends and "pathological" begins. :)
> 
> I'm happy to test this on some of the NFS we have locally, and started
> out with a plan to write some for-loop using the low-level API (so it
> would look up all 256), fake populate .git/objects/?? with N number of
> objects etc, but ran out of time.
> 
> Do you have something ready that you think would be representative and I
> could just run? If not I'll try to pick this up again...

No, but they don't even really need to be actual objects. So I suspect
something like:

  git init
  for i in $(seq 256); do
    i=$(printf %02x $i)
    mkdir -p .git/objects/$i
    for j in $(seq --format=%038g 1000); do
      echo foo >.git/objects/$i/$j
    done
  done
  git index-pack -v --stdin </path/to/git.git/objects/pack/XYZ.pack

might work (for various values of 1000). The shell loop would probably
be faster as perl, too. :)

Make sure you clear the object directory between runs, though (otherwise
the subsequent index-pack's really do find collisions and spend time
accessing the objects).

If you want real objects, you could probably just dump a bunch of
sequential blobs to fast-import, and then pipe the result to
unpack-objects.

-Peff
