Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E7D1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 00:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932637AbeAYA3p (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 19:29:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:56516 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932250AbeAYA3o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 19:29:44 -0500
Received: (qmail 17672 invoked by uid 109); 25 Jan 2018 00:29:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Jan 2018 00:29:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31353 invoked by uid 111); 25 Jan 2018 00:30:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 19:30:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 19:29:43 -0500
Date:   Wed, 24 Jan 2018 19:29:42 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Git packs friendly to block-level deduplication
Message-ID: <20180125002942.GA21184@sigill.intra.peff.net>
References: <87bmhiykvw.fsf@evledraar.gmail.com>
 <20180124232214.GA11348@sigill.intra.peff.net>
 <87607qyfci.fsf@evledraar.gmail.com>
 <20180125001015.GA17856@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180125001015.GA17856@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 07:10:15PM -0500, Jeff King wrote:

> On Thu, Jan 25, 2018 at 01:03:25AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> > > You may also want to use "--threads=1" to avoid non-determinism in the
> > > generated packs. In theory, both repos would then produce identical base
> > > packs, though it does not seem to do so in practice (I didn't dig in to
> > > what the different may be).
> > 
> > ..and north of 20% with --threads=1.
> >
> > [...]
> >
> > Thanks. I'll look into that, although the above results (sans hacking on
> > the core pack-objects logic) suggest that even once I create an island
> > I'm getting at most 20%.
> 
> I think it may be worth figuring out where the two differ. With
> --no-reuse-object and --no-reuse-delta, I'd think that the pack
> generated for a particular apex commit would be totally deterministic,
> regardless of other objects available in the repo. But it's not for some
> reason.

I think I see it. If I compare the objects in pack-order of the two
packs:

  diff -u <(git show-index <$one | sort -n) <(git show-index <$two | sort -n)

I get:

  6281 fac64e011f1b1ecabcccf7ad2511efcac3e26bdc (9381a4f9)
  6585 59c276cf4da0705064c32c9dba54baefa282ea55 (1b02a1c0)
  6869 8279ed033f703d4115bee620dccd32a9ec94d9aa (ca7acf33)
 -7042 298d861208d71089dd308761ae96738e81ad3e68 (135aefd7)
 -7222 ea7b5de1c1187294d3d4dca93b129e049ca7ca76 (3708bbfc)
 -7512 b6947af2294ea0c814f5b4cb8737c782895519b2 (719fad14)
 -8004 e26f7f19b6c7485f04234946a59ab8f4fd21d6d1 (59127876)
 -8826 2512f15446149235156528dafbe75930c712b29e (fc72468e)
  [...]
 +7042 2512f15446149235156528dafbe75930c712b29e (fc72468e)
 +7215 c6c75c93aaeb97bab6fd25b672a641c84dd85d59 (68fe0b8d)
 +7391 36438dc19dd2a305dddebd44bf7a65f1a220075b (c424e726)
 +7565 1eaabe34fc6f486367a176207420378f587d3b48 (4a27450b)

So the write order differs; one pack stuck 2512f15446 much earlier.

That's probably due to this line from compute_write_order():

     /*
      * Mark objects that are at the tip of tags.
      */
     for_each_tag_ref(mark_tagged, NULL);

If I remove that line, then your manual pack (with --threads=1) gives me
identical packs for each repo.

And if I then mark each with a .keep, then "git repack -ad" to remove
duplicates, your block-dedup check yields:

   17742 2
    1939 1

which is 90%, and about what I'd expect between those two repos. So I
think the idea of computing a "base" pack (either as a separate pack, or
as a layer in the pack) is a viable strategy.

-Peff
