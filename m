Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BCCD1F428
	for <e@80x24.org>; Sat,  1 Sep 2018 07:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeIALwu (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 07:52:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:36096 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726163AbeIALwu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 07:52:50 -0400
Received: (qmail 24066 invoked by uid 109); 1 Sep 2018 07:41:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Sep 2018 07:41:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11531 invoked by uid 111); 1 Sep 2018 07:41:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 01 Sep 2018 03:41:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Sep 2018 03:41:45 -0400
Date:   Sat, 1 Sep 2018 03:41:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] un-breaking pack-objects with bitmaps
Message-ID: <20180901074145.GA24023@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
 <20180821190701.GE30764@sigill.intra.peff.net>
 <8736uud0gq.fsf@evledraar.gmail.com>
 <20180831225558.GA22917@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180831225558.GA22917@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 06:55:58PM -0400, Jeff King wrote:

> On Fri, Aug 31, 2018 at 05:23:17PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > On Tue, Aug 21 2018, Jeff King wrote:
> > 
> > > +int bitmap_has_sha1_in_uninteresting(struct bitmap_index *bitmap_git,
> > > +				     const unsigned char *sha1)
> > > +{
> > > +	int pos;
> > > +
> > > +	if (!bitmap_git)
> > > +		return 0; /* no bitmap loaded */
> > > +	if (!bitmap_git->result)
> > > +		BUG("failed to perform bitmap walk before querying");
> > 
> > Some part of what calls this completely breaks pushing from the "next"
> > branch when you have local bitmaps (we *really* should have some tests
> > for this...).
> 
> Yikes, thanks for reporting. I agree we need better tests here.

OK, here is the fix. Since the problem is in 'next', this is done as a
patch on top of jk/pack-delta-reuse-with-bitmap. But since we're set to
rewind 'next' post-release anyway, we could squash it directly into
30cdc33fba from the original series. That would help later bisections
from running into it, which may be worth it as it's a pretty severe
breakage.  Or maybe not:

  1. The test suite doesn't actually fail, because it's toy repos are
     too small.

  2. It only triggers in the real-world if you have bitmaps turned on,
     which are not the default.

So it may not be that likely in practice to bother a hypothetical future
bisecting developer.

> [1] Actually, there is also prepare_bitmap_git(), but it is not really
>     for general use by callers. It should be made static, or better yet,
>     I suspect it can be folded into its callers.

This actually turned out not to work. There's a caller over in
pack-bitmap-write.c, and it makes things worse to try to expand the
logic there. So it technically _is_ possible to have a bitmap_index
without a "have" field, but it also doesn't make sense to ask about
"uninteresting" objects there. You haven't done (and cannot do) a
traversal on such an object.

Which I think goes back to Stefan's original question: is this just a
crappy API? And the answer is "yes, to some degree". There are really
two uses of bitmaps:

  - you want to do a traverse_commit_list() walk, but faster

  - you want to selectively query the on-disk bitmaps (e.g., you are
    walking for --contains and want to ask "do we have a bitmap for this
    object?"

Those currently use the same struct bitmap_index, but with two different
constructors (prepare_bitmap_git and prepare_bitmap_walk). It probably
ought to be two different ones (with the "walk" variant using the
"query" variant under the hood). I've punted on that full conversion for
now, but did clean up a few confusing bits.

  [1/4]: bitmap_has_sha1_in_uninteresting(): drop BUG check

    The actual fix. This should get merged to next ASAP (or the original
    topic just reverted).

  [2/4]: t5310: test delta reuse with bitmaps

    I did this separately to give us flexibility to squash or merge
    quickly. But it does find Ævar's bug on a git without patch 1.

  [3/4]: traverse_bitmap_commit_list(): don't free result

    The original assert should have simply been useless, but it was the
    surprising behavior of this function that turned it into a bug.

  [4/4]: pack-bitmap: drop "loaded" flag

    And this is just an annoyance I ran into, which is a fallout from
    our conversion to using an allocated bitmap_index struct.

 pack-bitmap.c           | 14 ++-----
 pack-bitmap.h           |  2 +-
 t/t5310-pack-bitmaps.sh | 93 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 12 deletions(-)

-Peff
