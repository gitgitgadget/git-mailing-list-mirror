Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0742E1F859
	for <e@80x24.org>; Sat, 10 Sep 2016 14:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754524AbcIJO73 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 10:59:29 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:47620 "EHLO
        mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754237AbcIJO73 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 10:59:29 -0400
Received: from teco.navytux.spb.ru (unknown [178.70.98.236])
        by mail2.tiolive.com (Postfix) with ESMTPSA id 97C4EBF0319;
        Sat, 10 Sep 2016 16:59:26 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
        (envelope-from <kirr@teco.navytux.spb.ru>)
        id 1bijkb-0004sQ-TA; Sat, 10 Sep 2016 17:59:25 +0300
Date:   Sat, 10 Sep 2016 17:59:25 +0300
From:   Kirill Smelkov <kirr@nexedi.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vicent Marti <tanoku@gmail.com>,
        =?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
        Isabelle Vallet <isabelle.vallet@nexedi.com>,
        Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
        Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2 v7] pack-objects: use reachability bitmap index when
 generating non-stdout pack
Message-ID: <20160910145925.xbbus7eck5ineika@teco.navytux.spb.ru>
References: <20160809192858.GA25822@teco.navytux.spb.ru>
 <20160809193217.32389-1-kirr@nexedi.com>
 <20160818180615.q25p57v35m2xxtww@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160818180615.q25p57v35m2xxtww@sigill.intra.peff.net>
User-Agent: NeoMutt/ (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 02:06:15PM -0400, Jeff King wrote:
> On Tue, Aug 09, 2016 at 10:32:17PM +0300, Kirill Smelkov wrote:
> 
> > Subject: Re: [PATCH 2/2 v7] pack-objects: use reachability bitmap index when
> >    generating non-stdout pack
> 
> This is v7, but as I understand your numbering, it goes with v5 of patch
> 1/2 that I just reviewed (usually we just increment the version number
> on the whole series and treat it as a unit, even if some patches didn't
> change from version to version).

The reason those patches are having their own numbers is that they are
orthogonal to each other and can be applied / rejected independently.
Since I though Junio might want to pick them up as separate topics they
were versioned separately.

But ok, since now we have them considered both together, their next
versions posted will be uniform v8.


> > So we can teach pack-objects to use bitmap index for initial object
> > counting phase when generating resultant pack file too:
> > 
> > - if we care it is not activated under git-repack:
> 
> Do you mean "if we take care that it is not..." here?
> 
> (I think you might just be getting tripped up in the English idioms;
> "care" means that we have a preference; "to take care" means that we are
> being careful).

Ok, I've might have been tripped and thanks for the catch up. I've changed to

	"if we take care to not let it be activated under git-repack"

> 
> > - if we know bitmap index generation is not enabled for resultant pack:
> > 
> >   Current code has singleton bitmap_git so cannot work simultaneously
> >   with two bitmap indices.
> 
> Minor English fixes:
> 
>   The current code has a singleton bitmap_git, so it cannot work
>   simultaneously with two bitmap indices.

ok.

> > - if we keep pack reuse enabled still only for "send-to-stdout" case:
> > 
> >   Because on pack reuse raw entries are directly written out to destination
> >   pack by write_reused_pack() bypassing needed for pack index generation
> >   bookkeeping done by regular codepath in write_one() and friends.
> 
> Ditto on English:
> 
>   On pack reuse raw entries are directly written out to the destination
>   pack by write_reused_pack(), bypassing the need for pack index
>   generation bookkeeping done by the regular code path in write_one()
>   and friends.
> 
> I think this is missing the implication. Why wouldn't we want to reuse
> in this case? Certainly we don't when doing a "careful" on-disk repack.
> I suspect the answer is that we cannot write a ".idx" off of the result
> of write_reused_pack(), and write-to-disk always includes the .idx.

Yes, mentioning pack-to-file needs to generate .idx makes it more clear
and thanks for pointing this out. I've changed this item to the
following (picking some of your English corrections):

    - if we keep pack reuse enabled still only for "send-to-stdout" case:

      Because pack-to-file needs to generate index for destination pack, and
      currently on pack reuse raw entries are directly written out to the
      destination pack by write_reused_pack(), bypassing needed for pack index
      generation bookkeeping done by regular codepath in write_one() and
      friends.

      ( In the future we might teach pack-reuse code about cases when index
        also needs to be generated for resultant pack and remove
        pack-reuse-only-for-stdout limitation )

Hope it is ok.

> > More context:
> > 
> >     http://marc.info/?t=146792101400001&r=1&w=2
> 
> Can we turn this into a link to public-inbox? We have just been bit by
> all of our old links to gmane dying, and they cannot easily be replaced
> because they use a gmane-specific article number. public-inbox URLs use
> message-ids, which should be usable for other archives if public-inbox
> goes away.

Yes, makes sense to put msgid here. I've added

	http://public-inbox.org/git/20160707190917.20011-1-kirr@nexedi.com/T/#t


> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index b1007f2..c92d7fc 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> 
> The code here looks fine.

Thanks.

> > diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> > index a278d30..9602e9a 100755
> > --- a/t/t5310-pack-bitmaps.sh
> > +++ b/t/t5310-pack-bitmaps.sh
> > @@ -196,6 +196,18 @@ test_expect_success 'pack-objects respects --local (non-local bitmapped pack)' '
> >  	! has_any packbitmap.objects 3b.objects
> >  '
> >  
> > +test_expect_success 'pack-objects to file can use bitmap' '
> > +	# make sure we still have 1 bitmap index from previous tests
> > +	ls .git/objects/pack/ | grep bitmap >output &&
> > +	test_line_count = 1 output &&
> > +	# verify equivalent packs are generated with/without using bitmap index
> > +	packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
> > +	packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
> > +	list_packed_objects <packa-$packasha1.idx >packa.objects &&
> > +	list_packed_objects <packb-$packbsha1.idx >packb.objects &&
> > +	test_cmp packa.objects packb.objects
> > +'
> 
> Of course we can't know if bitmaps were actually used, or if they were
> turned off under the hood. But at least this exercises the code a bit.

Yes, I was thinking how to know the bitmap codepath was actually active,
and without adding debugging points there is no way (at least I could
not find it).

> You could possibly add a perf test which shows off the improvement, but
> I don't think it's strictly necessary.

Good idea. I've added this

---- 8< ----
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index de2a224..bb91dbb 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -32,6 +32,14 @@ test_perf 'simulated fetch' '
        } | git pack-objects --revs --stdout >/dev/null
 '
 
+test_perf 'pack to file' '
+       git pack-objects --all pack1 </dev/null >/dev/null
+'
+
+test_perf 'pack to file (bitmap)' '
+       git pack-objects --use-bitmap-index --all pack1b </dev/null >/dev/null
+'
+
 test_expect_success 'create partial bitmap state' '
        # pick a commit to represent the repo tip in the past
        cutoff=$(git rev-list HEAD~100 -1) &&
@@ -53,8 +61,12 @@ test_expect_success 'create partial bitmap state' '
        git update-ref HEAD $orig_tip
 '
 
-test_perf 'partial bitmap' '
+test_perf 'clone (partial bitmap)' '
        git pack-objects --stdout --all </dev/null >/dev/null
 '
 
+test_perf 'pack to file (partial bitmap)' '
+       git pack-objects --use-bitmap-index --all pack2b </dev/null >/dev/null
+'
+
 test_done
---- 8< ----

    Test                                    56dfeb62          this tree
    --------------------------------------------------------------------------------
    5310.2: repack to disk                  8.98(8.05+0.29)   9.05(8.08+0.33) +0.8%
    5310.3: simulated clone                 2.02(2.27+0.09)   2.01(2.25+0.08) -0.5%
    5310.4: simulated fetch                 0.81(1.07+0.02)   0.81(1.05+0.04) +0.0%
    5310.5: pack to file                    7.58(7.04+0.28)   7.60(7.04+0.30) +0.3%
    5310.6: pack to file (bitmap)           7.55(7.02+0.28)   3.25(2.82+0.18) -57.0%
    5310.8: clone (partial bitmap)          1.83(2.26+0.12)   1.82(2.22+0.14) -0.5%
    5310.9: pack to file (partial bitmap)   6.86(6.58+0.30)   2.87(2.74+0.20) -58.2%
    

Kirill
