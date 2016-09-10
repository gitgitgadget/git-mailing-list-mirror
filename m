Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB04F1F859
	for <e@80x24.org>; Sat, 10 Sep 2016 14:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755239AbcIJO5r (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 10:57:47 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:47613 "EHLO
        mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755216AbcIJO5q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 10:57:46 -0400
Received: from teco.navytux.spb.ru (unknown [178.70.98.236])
        by mail2.tiolive.com (Postfix) with ESMTPSA id 8F5B4BF0327;
        Sat, 10 Sep 2016 16:57:42 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
        (envelope-from <kirr@teco.navytux.spb.ru>)
        id 1bijit-0004s1-2m; Sat, 10 Sep 2016 17:57:39 +0300
Date:   Sat, 10 Sep 2016 17:57:39 +0300
From:   Kirill Smelkov <kirr@nexedi.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vicent Marti <tanoku@gmail.com>,
        =?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
        Isabelle Vallet <isabelle.vallet@nexedi.com>,
        Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
        Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2 v5] pack-objects: respect
 --local/--honor-pack-keep/--incremental when bitmap is in use
Message-ID: <20160910145738.x6ihp2gqzpk7dbi3@teco.navytux.spb.ru>
References: <20160809192858.GA25822@teco.navytux.spb.ru>
 <20160809193143.32213-1-kirr@nexedi.com>
 <20160818175222.bmm3ivjheokf2qzl@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160818175222.bmm3ivjheokf2qzl@sigill.intra.peff.net>
User-Agent: NeoMutt/ (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 01:52:22PM -0400, Jeff King wrote:
> On Tue, Aug 09, 2016 at 10:31:43PM +0300, Kirill Smelkov wrote:
> 
> > Since 6b8fda2d (pack-objects: use bitmaps when packing objects) there
> > are two codepaths in pack-objects: with & without using bitmap
> > reachability index.
> 
> Sorry, I got distracted from reviewing these patches. I'll give them a
> detailed look now and hopefully we can finalize the topic.

Jeff, thanks for feedback. On my side I'm sorry for the delay because I
was travelling and only recently got back to work.

> > In want_object_in_pack() we care to start the checks from already found
> > pack, if we have one, this way determining the answer right away
> > in case neither --local nor --honour-pack-keep are active. In
> > particular, as p5310-pack-bitmaps.sh shows, we do not do harm to
> > served-with-bitmap clones performance-wise:
> > 
> >     Test                      56dfeb62          this tree
> >     -----------------------------------------------------------------
> >     5310.2: repack to disk    9.63(8.67+0.33)   9.47(8.55+0.28) -1.7%
> >     5310.3: simulated clone   2.07(2.17+0.12)   2.03(2.14+0.12) -1.9%
> >     5310.4: simulated fetch   0.78(1.03+0.02)   0.76(1.00+0.03) -2.6%
> >     5310.6: partial bitmap    1.97(2.43+0.15)   1.92(2.36+0.14) -2.5%
> > 
> > with all differences strangely showing we are a bit faster now, but
> > probably all being within noise.
> 
> Good to know there is no regression. It is curious that there is a
> slight _improvement_ across the board. Do we have an explanation for
> that? It seems odd that noise would be so consistent.

Yes, I too thought it and it turned out to be t/perf/run does not copy
config.mak.autogen & friends to build/ and I'm using autoconf with
CFLAGS="-march=native -O3 ..."

Junio, I could not resist to the following:

---- 8< ----
From: Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH] t/perf/run: Don't forget to copy config.mak.autogen & friends
 to build area

Otherwise for people who use autotools-based configure in main worktree,
the performance testing results will be inconsistent as work and build
trees could be using e.g. different optimization levels.

See e.g.

	http://public-inbox.org/git/20160818175222.bmm3ivjheokf2qzl@sigill.intra.peff.net/

for example.

NOTE config.status has to be copied because otherwise without it the build
would want to run reconfigure this way loosing just copied config.mak.autogen.

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 t/perf/run | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/run b/t/perf/run
index cfd7012..aa383c2 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -30,7 +30,7 @@ unpack_git_rev () {
 }
 build_git_rev () {
 	rev=$1
-	cp ../../config.mak build/$rev/config.mak
+	cp -t build/$rev ../../{config.mak,config.mak.autogen,config.status}
 	(cd build/$rev && make $GIT_PERF_MAKE_OPTS) ||
 	die "failed to build revision '$mydir'"
 }
-- 
2.9.2.701.gf965a18.dirty
---- 8< ----

With corrected t/perf/run the timings are more realistic - e.g. 3
consecutive runs of `./run 56dfeb62 . ./p5310-pack-bitmaps.sh`:

Test                      56dfeb62          this tree
-----------------------------------------------------------------
5310.2: repack to disk    9.08(8.20+0.25)   9.09(8.14+0.32) +0.1%
5310.3: simulated clone   1.92(2.12+0.08)   1.93(2.12+0.09) +0.5%
5310.4: simulated fetch   0.82(1.07+0.04)   0.82(1.06+0.04) +0.0%
5310.6: partial bitmap    1.96(2.42+0.13)   1.95(2.40+0.15) -0.5%

Test                      56dfeb62          this tree
-----------------------------------------------------------------
5310.2: repack to disk    9.11(8.16+0.32)   9.11(8.19+0.28) +0.0%
5310.3: simulated clone   1.93(2.14+0.07)   1.92(2.11+0.10) -0.5%
5310.4: simulated fetch   0.82(1.06+0.04)   0.82(1.04+0.05) +0.0%
5310.6: partial bitmap    1.95(2.38+0.16)   1.94(2.39+0.14) -0.5%

Test                      56dfeb62          this tree
-----------------------------------------------------------------
5310.2: repack to disk    9.13(8.17+0.31)   9.07(8.13+0.28) -0.7%
5310.3: simulated clone   1.92(2.13+0.07)   1.91(2.12+0.06) -0.5%
5310.4: simulated fetch   0.82(1.08+0.03)   0.82(1.08+0.03) +0.0%
5310.6: partial bitmap    1.96(2.43+0.14)   1.96(2.42+0.14) +0.0%



> > And in the general case we care not to have duplicate
> > find_pack_entry_one(*found_pack) calls. Worst what can happen is we can
> > call want_found_object(*found_pack) -- newly introduced helper for
> > checking whether we want object -- twice, but since want_found_object()
> > is very lightweight it does not make any difference.
> 
> I had trouble parsing this. I think maybe:
> 
>   In the general case we do not want to call find_pack_entry_one() more
>   than once, because it is expensive. This patch splits the loop in
>   want_object_in_pack() into two parts: finding the object and seeing if
>   it impacts our choice to include it in the pack. We may call the
>   inexpensive want_found_object() twice, but we will never call
>   find_pack_entry_one() if we do not need to.

Ok, thanks for the advice.

> 
> > +static int want_found_object(int exclude, struct packed_git *p)
> > +{
> > +	if (exclude)
> > +		return 1;
> > +	if (incremental)
> > +		return 0;
> > +
> > +	/*
> > +	 * When asked to do --local (do not include an object that appears in a
> > +	 * pack we borrow from elsewhere) or --honor-pack-keep (do not include
> > +	 * an object that appears in a pack marked with .keep), finding a pack
> > +	 * that matches the criteria is sufficient for us to decide to omit it.
> > +	 * However, even if this pack does not satisfy the criteria, we need to
> > +	 * make sure no copy of this object appears in _any_ pack that makes us
> > +	 * to omit the object, so we need to check all the packs. Signal that by
> > +	 * returning -1 to the caller.
> > +	 */
> > +	if (!ignore_packed_keep &&
> > +	    (!local || !have_non_local_packs))
> > +		return 1;
> 
> Hmm. The comment says "-1", but the return says "1". That is because the
> comment is describing the return that happens at the end. :)
> 
> I wonder if the last sentence should be:
> 
>   We can check here whether these options can possibly matter; if not,
>   we can return early from the function here. Otherwise, we signal "-1"
>   at the end to tell the caller that we do not know either way, and it
>   needs to check more packs.

Thanks for the catch and hint. I've changed it to the following:

	We can however first check whether these options can possible matter;
	if they do not matter we know we want the object in generated pack.
	Otherwise, we signal "-1" at the end to tell the caller that we do
	not know either way, and it needs to check more packs.

full version:

        /*
         * When asked to do --local (do not include an object that appears in a
         * pack we borrow from elsewhere) or --honor-pack-keep (do not include
         * an object that appears in a pack marked with .keep), finding a pack
         * that matches the criteria is sufficient for us to decide to omit it.
         * However, even if this pack does not satisfy the criteria, we need to
         * make sure no copy of this object appears in _any_ pack that makes us
         * to omit the object, so we need to check all the packs.
         *
         * We can however first check whether these options can possible matter;
         * if they do not matter we know we want the object in generated pack.
         * Otherwise, we signal "-1" at the end to tell the caller that we do
         * not know either way, and it needs to check more packs.
         */

Hope it is ok.

> > -	*found_pack = NULL;
> > -	*found_offset = 0;
> > +	/*
> > +	 * If we already know the pack object lives in, start checks from that
> > +	 * pack - in the usual case when neither --local was given nor .keep files
> > +	 * are present we will determine the answer right now.
> > +	 */
> > +	if (*found_pack) {
> > +		want = want_found_object(exclude, *found_pack);
> > +		if (want != -1)
> > +			return want;
> > +	}
> 
> Looks correct. Though it is not really "start checks from..." anymore,
> but rather "do a quick check to see if we can quit early, and otherwise
> start the loop". That might be nitpicking, though.

I see. Your version is ok, but to me 'start checks from ...' is a bit
more natural and explaining (yes, all subjective and depending on
taste), so if possible I'd prefer to leave it as is.

> 
> >  	for (p = packed_git; p; p = p->next) {
> > -		off_t offset = find_pack_entry_one(sha1, p);
> > +		off_t offset;
> > +
> > +		if (p == *found_pack)
> > +			offset = *found_offset;
> > +		else
> > +			offset = find_pack_entry_one(sha1, p);
> > +
> 
> This hunk will conflict with the MRU optimizations in 'next', but I
> think the resolution should be pretty trivial.

Yes.

> >  static int add_object_entry(const unsigned char *sha1, enum object_type type,
> >  			    const char *name, int exclude)
> >  {
> > -	struct packed_git *found_pack;
> > -	off_t found_offset;
> > +	struct packed_git *found_pack = NULL;
> > +	off_t found_offset = 0;
> 
> I think technically we don't need to initialize found_offset here (it is
> considered only if *found_pack is not NULL), but it doesn't hurt to make
> our starting assumptions clear.

Yes, found_pack != NULL is indicator whether we have found_pack /
found_offset info, but it makes it much clear and defending from
mistakes to set both found_{pack,offset} into known initial state.

> > @@ -1073,6 +1097,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
> >  	if (have_duplicate_entry(sha1, 0, &index_pos))
> >  		return 0;
> >  
> > +	if (!want_object_in_pack(sha1, 0, &pack, &offset))
> > +		return 0;
> > +
> 
> And this caller doesn't need to worry about initialization, because of
> course it knows it has a pack/offset already. Good.

Yes, we have this info from bitmap walker calling us.


> > diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> > index 3893afd..a278d30 100755
> > --- a/t/t5310-pack-bitmaps.sh
> > +++ b/t/t5310-pack-bitmaps.sh
> 
> Tests look OK. I saw a few style nitpicks, but I think they are not even
> against our style guide but more "I would have written it like this" and
> are not even worth quibbling over.
> 
> So I think the code here is fine, and I just had a few minor complaints
> on comment and commit message clarity.

Thanks for feedback. Yes tastes can differ but your comments regarding
commit message and want_found_object() were objectively (imho) worth it
and there I've made the adjustments.

Please expect updated patch to be send as reply to this mail.

Thanks again for feedback,
Kirill
