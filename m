Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DF592018E
	for <e@80x24.org>; Mon,  8 Aug 2016 18:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbcHHSTq (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 14:19:46 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:53678 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbcHHSTp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 14:19:45 -0400
Received: from teco.navytux.spb.ru (pppoe.178-66-29-27.dynamic.avangarddsl.ru [178.66.29.27])
	by mail2.tiolive.com (Postfix) with ESMTPSA id CA6D5BF034A;
	Mon,  8 Aug 2016 20:19:42 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bWp9K-0000nk-AH; Mon, 08 Aug 2016 21:19:42 +0300
Date:	Mon, 8 Aug 2016 21:19:42 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:	Vicent Marti <tanoku@gmail.com>,
	=?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: Teach --use-bitmap-index codepath to
 respect --local, --honor-pack-keep and --incremental
Message-ID: <20160808181942.GD3995@teco.navytux.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160808135020.yggthtfekdiwq3lz@sigill.intra.peff.net>
 <xmqqk2frgs4s.fsf@gitster.mtv.corp.google.com>
 <xmqqfuqfgrzq.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


( updated patch is in the end of this mail )

Jeff, first of all thanks for commenting,

On Mon, Aug 08, 2016 at 09:50:20AM -0400, Jeff King wrote:
> On Mon, Aug 08, 2016 at 03:37:35PM +0300, Kirill Smelkov wrote:
> 
> > @@ -958,15 +958,30 @@ static int want_object_in_pack(const unsigned char *sha1,
> >  			       off_t *found_offset)
> >  {
> >  	struct packed_git *p;
> > +	struct packed_git *pack1 = *found_pack;
> > +	int pack1_seen = !pack1;
> >  
> >  	if (!exclude && local && has_loose_object_nonlocal(sha1))
> >  		return 0;
> >  
> > -	*found_pack = NULL;
> > -	*found_offset = 0;
> > +	/*
> > +	 * If we already know the pack object lives in, start checks from that
> > +	 * pack - in the usual case when neither --local was given nor .keep files
> > +	 * are present the loop will degenerate to have only 1 iteration.
> > +	 */
> > +	for (p = (pack1 ? pack1 : packed_git); p;
> > +	     p = (pack1_seen ? p->next : packed_git), pack1_seen = 1) {
> > +		off_t offset;
> 
> Hmm. So this is basically sticking the found-pack at the front of the
> loop.
> 
> We either need to look at zero packs here (we already know where the
> object is, and we don't need to bother with --local or .keep lookups),
> or we need to look at all of them (to check for local/keep).
> 
> I guess you structured it this way to try to reuse the "can we break out
> early" logic from the middle of the loop. So we go through the loop one
> time, and then break out. And then this:
> 
> > +		if (p == pack1) {
> > +			if (pack1_seen)
> > +				continue;
> > +			offset = *found_offset;
> > +		}
> > +		else {
> > +			offset = find_pack_entry_one(sha1, p);
> > +		}
> 
> is meant to make that one-time through the loop cheaper. So I don't
> think it's wrong, but it's very confusing to me.
> 
> Would it be simpler to stick that logic in a function like:
> 
>   static int want_found_object(int exclude, struct packed_git *pack)
>   {
> 	if (exclude)
> 		return 1;
> 	if (incremental)
> 		return 0;
> 
> 	/* if we can break early, then do so */
> 	if (!ignore_packed_keep &&
> 	    (!local || !have_non_local_packs))
> 		return 1;
> 
> 	if (local && !p->pack_local)
> 		return 0;
> 	if (ignore_packed_keep && p->pack_local && p->pack_keep)
> 		return 0;
> 
> 	/* indeterminate; keep looking for more packs */
> 	return -1;
>   }
> 
>   static int want_object_in_pack(...)
>   {
> 	...
> 	if (!exclude && local && has_loose_object_nonlocal(sha1))
> 		return 0;
> 
> 	if (*found_pack) {
> 		int ret = want_found_object(exclude, *found_pack);
> 		if (ret != -1)
> 			return ret;
> 	}
> 
> 	for (p = packed_git; p; p = p->next) {
> 		off_t offset;
> 
> 		if (p == *found_pack)
> 			offset = *found_offset;
> 		else
> 			offset = find_pack_entry(sha1, p);
> 		if (offset) {
> 			... fill in *found_pack ...
> 			int ret = want_found_object(exclude, p);
> 			if (ret != -1)
> 				return ret;
> 		}
> 	}
> 	return 1;
>   }
> 
> That's a little more verbose, but IMHO the flow is a lot easier to
> follow (especially as the later re-rolls of that series actually muck
> with the loop order more, but with this approach there's no conflict).

On Mon, Aug 08, 2016 at 09:08:51AM -0700, Junio C Hamano wrote:
> I agree; Kirill's version was so confusing that I couldn't see what
> it was trying to do with "pack1_seen" flag that is reset every time
> loop repeats (at least, before got my coffee ;-).  A helper function
> like the above makes the logic a lot easier to grasp.

Ok, at least I put today's record for the most confusing code. I agree
with your comments - it is better to simplify control-flow logic. Somehow
my head was refusing doing that and insisted on keeping the loop inside
intact. Maybe I should have a bit of rest... Scratch all that in favour
of want_found_object() and thanks for heads-up.



> >  static int add_object_entry(const unsigned char *sha1, enum object_type type,
> >  			    const char *name, int exclude)
> >  {
> > -	struct packed_git *found_pack;
> > -	off_t found_offset;
> > +	struct packed_git *found_pack = NULL;
> > +	off_t found_offset = 0;
> >  	uint32_t index_pos;
> >  
> >  	if (have_duplicate_entry(sha1, exclude, &index_pos))
> > @@ -1073,6 +1088,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
> >  	if (have_duplicate_entry(sha1, 0, &index_pos))
> >  		return 0;
> >  
> > +	if (!want_object_in_pack(sha1, 0, &pack, &offset))
> > +		return 0;
> > +
> 
> This part looks correct and easy to understand.

thanks.


> > diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> > index 3893afd..1a61de4 100755
> > --- a/t/t5310-pack-bitmaps.sh
> > +++ b/t/t5310-pack-bitmaps.sh
> > @@ -16,6 +16,7 @@ test_expect_success 'setup repo with moderate-sized history' '
> >  		test_commit side-$i
> >  	done &&
> >  	git checkout master &&
> > +	bitmaptip=$(git show-ref -s master) &&
> 
> Our usual method for getting a sha1 is "git rev-parse". I don't think
> there's anything wrong with your method, but it might be better to stick
> to the canonical one (I had to actually look up "show-ref -s").

ok.


> > @@ -118,6 +119,90 @@ test_expect_success 'incremental repack can disable bitmaps' '
> >  	git repack -d --no-write-bitmap-index
> >  '
> >  
> > +test_expect_success 'pack-objects respects --local (non-local loose)' '
> > +	mkdir -p alt_objects/pack &&
> > +	echo $(pwd)/alt_objects > .git/objects/info/alternates &&
> > +	echo content1 > file1 &&
> 
> Style: we don't put a space between ">" and the filename.

ok, corrected.


> > +	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file1) &&
> > +	git cat-file blob $blob | GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w --stdin &&
> 
> I'm not sure why we need two objects in the fake alt_objects repository.
> Shouldn't one be enough to do the test?

Those two objects are different: one is not present in main bitmapped
pack and another is present in main bitmapped pack. So the second one
tests for case Junio caught - when bitmapped pack overlaps with
non-local loose object and with --local we want to avoid that object in
resultant pack. I've adjusted the patch as

+       # non-local loose object which is not present in bitmapped pack
        objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file1) &&
+       # non-local loose object which is also present in bitmapped pack
        git cat-file blob $blob | GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w --stdin &&

> > +	git add file1 &&
> 
> I think this will actually skip the writing of the loose object, because
> it's already available in the alternate object store. You probably want
> to do this before adding it there.

It does not want to add the object to local objects - it just wants to
make a commit with reference to that object, so that $objsha1 we added
above becomes referenced from HEAD and thus should be put in pack
without --local (and with --local we test it is not put there).

> > +	test_tick &&
> > +	git commit -m commit_file1 &&
> > +	echo HEAD | \
> 
> No need for "\" after a "|"; the shell knows it has to keep looking.

Ok, thanks for the info. I've actually now folded those two lines into
one as it is not long.

> 
> > +	git pack-objects --local --stdout --revs >1.pack &&
> > +	git index-pack 1.pack &&
> 
> I'd have expected you to use the non-stdout version here. Is this meant
> to be independent of your other patch (I think that's OK).

On Mon, Aug 08, 2016 at 09:50:20AM -0400, Jeff King wrote:
> Oh, nevermind, I forgot this was meant to be a preparatory patch. So it
> makes sense to use --stdout in the tests.

Actually now these two patches:

    - to teach bitmapped pack-objects  about --local & friends, and
    - to teach `pack-objects file` to use bitmaps

are completely separated and orthogonal.

I mean they work independently and can be reviewed / applied
independently, each solving its own task. Initially I was keeping them
together because in the first version of `pack-objects file` the default was
to always use bitmap index, and since repack was using it and there were
tests for repack v.s. non-local objects those tests were failing.

Now, since we figured we should have use_bitmap_index=0 by default when
packing to file, the `bitmap + --local` part is not needed for the first
patch. ( it is still good to have the `bitmap + --local` applied because
it restores correctness and consistency and allows future paths for
brave soles to do repacking with bitmap index being on maybe )

For the current patch I think using --stdout in tests is ok as we know
--stdout uses bitmap indices by default.

> > +	git verify-pack -v 1.pack >1.objects &&
> 
> It's cheaper to use "git show-index <1.pack", and the output is saner,
> too.

I've copied those verify-packs from t7700-repack.sh, but it ok to switch
to show-index. Thanks for pointing this out.

> > +	echo -e "$objsha1\n$blob" >nonlocal-loose &&
> 
> "echo -e" isn't portable. You can use "printf", or two echos like:
> 
>   {
>     echo one &&
>     echo two
>   } >file

ok, switching to printf. Thanks for portability hint.

> (though I'm still not sure what we gain by checking both).

Please see above about those two objects serves for testing two
different scenarios: 1) non-local object which is not in bitmapped pack,
and 2) non-local object which is also present in bitmapped pack.


> > +	if grep -qFf nonlocal-loose 1.objects; then
> > +		echo "Non-local object present in pack generated with --local"
> > +		return 1
> > +	fi
> > +'
> 
> grep -f isn't portable. However, I think:
> 
>   echo $objsha1 >expect &&
>   git show-index <1.pack | cut -d' ' -f2 >actual
>   test_cmp expect actual
> 
> would work (if you do stick with two entries, you might need to sort
> your "expect").

Thanks for pointing out grep -f is not portable (I did not knew nor
cared about portability). However here and in similar places we are
checking that entries in nonlocal-loose are not present in 1.objects
and that is not what test_cmp does as it would test nonlocal-loose and
1.objects to be completely same or not.

For this reason I'm changing `grep -f ...` to `git grep --no-index -f ...`
which we carry with us.

> 
> I think similar comments apply to the other tests.

I went through all tests in the patch and made similar adjustments
everywhere.

> I would have expected
> "respects --local (non-local pack)" to come next (i.e., to keep all of
> the --local tests together). But you seem to interleave them with
> --honor-pack-keep.

There is a reason: "respects --local (non-local pack)" needs non-local
pack setup in alt_objects/ for its tests to run. And we setup such pack
as byproduct of running "pack-objects respects --honor-pack-keep (local
non-bitmapped pack)". Similarly "pack-objects respects --local
(non-local bitmapped pack)" for its testing needs (and moves to
alt_objects/) main bitmapped pack, which was just analyzed in
"pack-objects respects --honor-pack-keep (local bitmapped pack)"

Initially I tried to cluster tests (i.e. all --local together and then
all --honor-pack-keep together) but having tests interleaved turned out
to be handy because one step checks something and prepares setup for its
next one.

On Mon, Aug 08, 2016 at 09:11:53AM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@nexedi.com> writes:
> 
> >> > ...
> >> > Suggested-by: Junio C Hamano <gitster@pobox.com>
> >> > Discussed-with: Jeff King <peff@peff.net>
> >> > ---
> >> 
> >> I do not think I suggested much of this to deserve credit like this,
> >> though, as I certainly haven't thought about the pros-and-cons
> >> between adding the same "some object in pack may not want to be in
> >> the output" logic to the bitmap side, or punting the bitmap codepath
> >> when local/keep are involved.
> >
> > I understand. Still for me it was you who convinced me to add proper
> > support for e.g. --local vs bitmap instead of special-casing it.
> 
> OK, in such a case, it probably is more sensible to do it like:
> 
>     ...
>     with all differences strangely showing we are a bit faster now, but
>     probably all being within noise.
> 
>     Credit for inspiring this solution and discussing the design of
>     the change goes to Junio and Jeff King.

Ok, thanks for advice.

> Don't forget your own sign-off ;-)

Oops, thanks for catching :) Obviously I forgot it and now corrected.

Thanks,
Kirill

---- 8< ----
From: Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH v3] pack-objects: Teach --use-bitmap-index codepath to respect
 --local, --honor-pack-keep and --incremental

Since 6b8fda2d (pack-objects: use bitmaps when packing objects) there
are two codepaths in pack-objects: with & without using bitmap
reachability index.

However add_object_entry_from_bitmap(), despite its non-bitmapped
counterpart add_object_entry(), in no way does check for whether --local
or --honor-pack-keep or --incremental should be respected. In
non-bitmapped codepath this is handled in want_object_in_pack(), but
bitmapped codepath has simply no such checking at all.

The bitmapped codepath however was allowing to pass in all those options
and with bitmap indices still being used under such conditions -
potentially giving wrong output (e.g. including objects from non-local or
.keep'ed pack).

We can easily fix this by noting the following: when an object comes to
add_object_entry_from_bitmap() it can come for two reasons:

    1. entries coming from main pack covered by bitmap index, and
    2. object coming from, possibly alternate, loose or other packs.

"2" can be already handled by want_object_in_pack() and to cover
"1" we can teach want_object_in_pack() to expect that *found_pack can be
non-NULL, meaning calling client already found object's pack entry.

In want_object_in_pack() we care to start the checks from already found
pack, if we have one, this way determining the answer right away
in case neither --local nor --honour-pack-keep are active. In
particular, as p5310-pack-bitmaps.sh shows, we do not do harm to
served-with-bitmap clones performance-wise:

    Test                      56dfeb62          this tree
    -----------------------------------------------------------------
    5310.2: repack to disk    9.63(8.67+0.33)   9.47(8.55+0.28) -1.7%
    5310.3: simulated clone   2.07(2.17+0.12)   2.03(2.14+0.12) -1.9%
    5310.4: simulated fetch   0.78(1.03+0.02)   0.76(1.00+0.03) -2.6%
    5310.6: partial bitmap    1.97(2.43+0.15)   1.92(2.36+0.14) -2.5%

with all differences strangely showing we are a bit faster now, but
probably all being within noise.

And in the general case we care not to have duplicate
find_pack_entry_one(*found_pack) calls. Worst what can happen is we can
call want_found_object(*found_pack) -- newly introduced helper for
checking whether we want object -- twice, but since want_found_object()
is very lightweight it does not make any difference.

I appreciate help and discussing this change with Junio C Hamano and
Jeff King.

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 builtin/pack-objects.c  |  94 ++++++++++++++++++++++++++--------------
 t/t5310-pack-bitmaps.sh | 111 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 172 insertions(+), 33 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c4c2a3c..e06c1bf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -944,13 +944,45 @@ static int have_duplicate_entry(const unsigned char *sha1,
 	return 1;
 }
 
+static int want_found_object(int exclude, struct packed_git *p)
+{
+	if (exclude)
+		return 1;
+	if (incremental)
+		return 0;
+
+	/*
+	 * When asked to do --local (do not include an
+	 * object that appears in a pack we borrow
+	 * from elsewhere) or --honor-pack-keep (do not
+	 * include an object that appears in a pack marked
+	 * with .keep), we need to make sure no copy of this
+	 * object come from in _any_ pack that causes us to
+	 * omit it, and need to complete this loop.  When
+	 * neither option is in effect, we know the object
+	 * we just found is going to be packed, so break
+	 * out of the search loop now.
+	 */
+	if (!ignore_packed_keep &&
+	    (!local || !have_non_local_packs))
+		return 1;
+
+	if (local && !p->pack_local)
+		return 0;
+	if (ignore_packed_keep && p->pack_local && p->pack_keep)
+		return 0;
+
+	/* we don't know yet; keep looking for more packs */
+	return -1;
+}
+
 /*
  * Check whether we want the object in the pack (e.g., we do not want
  * objects found in non-local stores if the "--local" option was used).
  *
- * As a side effect of this check, we will find the packed version of this
- * object, if any. We therefore pass out the pack information to avoid having
- * to look it up again later.
+ * As a side effect of this check, if object's pack entry was not already found,
+ * we will find the packed version of this object, if any. We therefore pass
+ * out the pack information to avoid having to look it up again later.
  */
 static int want_object_in_pack(const unsigned char *sha1,
 			       int exclude,
@@ -958,15 +990,30 @@ static int want_object_in_pack(const unsigned char *sha1,
 			       off_t *found_offset)
 {
 	struct packed_git *p;
+	int want;
 
 	if (!exclude && local && has_loose_object_nonlocal(sha1))
 		return 0;
 
-	*found_pack = NULL;
-	*found_offset = 0;
+	/*
+	 * If we already know the pack object lives in, start checks from that
+	 * pack - in the usual case when neither --local was given nor .keep files
+	 * are present we will determine the answer right now.
+	 */
+	if (*found_pack) {
+		want = want_found_object(exclude, *found_pack);
+		if (want != -1)
+			return want;
+	}
 
 	for (p = packed_git; p; p = p->next) {
-		off_t offset = find_pack_entry_one(sha1, p);
+		off_t offset;
+
+		if (p == *found_pack)
+			offset = *found_offset;
+		else
+			offset = find_pack_entry_one(sha1, p);
+
 		if (offset) {
 			if (!*found_pack) {
 				if (!is_pack_valid(p))
@@ -974,31 +1021,9 @@ static int want_object_in_pack(const unsigned char *sha1,
 				*found_offset = offset;
 				*found_pack = p;
 			}
-			if (exclude)
-				return 1;
-			if (incremental)
-				return 0;
-
-			/*
-			 * When asked to do --local (do not include an
-			 * object that appears in a pack we borrow
-			 * from elsewhere) or --honor-pack-keep (do not
-			 * include an object that appears in a pack marked
-			 * with .keep), we need to make sure no copy of this
-			 * object come from in _any_ pack that causes us to
-			 * omit it, and need to complete this loop.  When
-			 * neither option is in effect, we know the object
-			 * we just found is going to be packed, so break
-			 * out of the loop to return 1 now.
-			 */
-			if (!ignore_packed_keep &&
-			    (!local || !have_non_local_packs))
-				break;
-
-			if (local && !p->pack_local)
-				return 0;
-			if (ignore_packed_keep && p->pack_local && p->pack_keep)
-				return 0;
+			want = want_found_object(exclude, p);
+			if (want != -1)
+				return want;
 		}
 	}
 
@@ -1039,8 +1064,8 @@ static const char no_closure_warning[] = N_(
 static int add_object_entry(const unsigned char *sha1, enum object_type type,
 			    const char *name, int exclude)
 {
-	struct packed_git *found_pack;
-	off_t found_offset;
+	struct packed_git *found_pack = NULL;
+	off_t found_offset = 0;
 	uint32_t index_pos;
 
 	if (have_duplicate_entry(sha1, exclude, &index_pos))
@@ -1073,6 +1098,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
 	if (have_duplicate_entry(sha1, 0, &index_pos))
 		return 0;
 
+	if (!want_object_in_pack(sha1, 0, &pack, &offset))
+		return 0;
+
 	create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);
 
 	display_progress(progress_state, nr_result);
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 3893afd..e71caa4 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -7,6 +7,19 @@ objpath () {
 	echo ".git/objects/$(echo "$1" | sed -e 's|\(..\)|\1/|')"
 }
 
+# show objects present in pack ($1 should be associated *.idx)
+packobjects () {
+	git show-index <$1 | cut -d' ' -f2
+}
+
+# hasany pattern-file content-file
+# tests whether content-file has any entry from pattern-file with entries being
+# whole lines.
+hasany () {
+	# NOTE `grep -f` is not portable
+	git grep --no-index -qFf $1 $2
+}
+
 test_expect_success 'setup repo with moderate-sized history' '
 	for i in $(test_seq 1 10); do
 		test_commit $i
@@ -16,6 +29,7 @@ test_expect_success 'setup repo with moderate-sized history' '
 		test_commit side-$i
 	done &&
 	git checkout master &&
+	bitmaptip=$(git rev-parse master) &&
 	blob=$(echo tagged-blob | git hash-object -w --stdin) &&
 	git tag tagged-blob $blob &&
 	git config repack.writebitmaps true &&
@@ -118,6 +132,86 @@ test_expect_success 'incremental repack can disable bitmaps' '
 	git repack -d --no-write-bitmap-index
 '
 
+test_expect_success 'pack-objects respects --local (non-local loose)' '
+	mkdir -p alt_objects/pack &&
+	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
+	echo content1 >file1 &&
+	# non-local loose object which is not present in bitmapped pack
+	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file1) &&
+	# non-local loose object which is also present in bitmapped pack
+	git cat-file blob $blob | GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w --stdin &&
+	git add file1 &&
+	test_tick &&
+	git commit -m commit_file1 &&
+	echo HEAD | git pack-objects --local --stdout --revs >1.pack &&
+	git index-pack 1.pack &&
+	packobjects 1.idx >1.objects &&
+	printf "$objsha1\n$blob\n" >nonlocal-loose &&
+	if hasany nonlocal-loose 1.objects; then
+		echo "Non-local object present in pack generated with --local"
+		return 1
+	fi
+'
+
+test_expect_success 'pack-objects respects --honor-pack-keep (local non-bitmapped pack)' '
+	echo content2 >file2 &&
+	objsha2=$(git hash-object -w file2) &&
+	git add file2 &&
+	test_tick &&
+	git commit -m commit_file2 &&
+	printf "$objsha2\n$bitmaptip\n" >keepobjects &&
+	pack2=$(git pack-objects pack2 <keepobjects) &&
+	mv pack2-$pack2.* .git/objects/pack/ &&
+	touch .git/objects/pack/pack2-$pack2.keep &&
+	rm $(objpath $objsha2) &&
+	echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >2a.pack &&
+	git index-pack 2a.pack &&
+	packobjects 2a.idx >2a.objects &&
+	if hasany keepobjects 2a.objects; then
+		echo "Object from .keeped pack present in pack generated with --honor-pack-keep"
+		return 1
+	fi
+'
+
+test_expect_success 'pack-objects respects --local (non-local pack)' '
+	mv .git/objects/pack/pack2-$pack2.* alt_objects/pack/ &&
+	echo HEAD | git pack-objects --local --stdout --revs >2b.pack &&
+	git index-pack 2b.pack &&
+	packobjects 2b.idx >2b.objects &&
+	if hasany keepobjects 2b.objects; then
+		echo "Non-local object present in pack generated with --local"
+		return 1
+	fi
+'
+
+test_expect_success 'pack-objects respects --honor-pack-keep (local bitmapped pack)' '
+	ls .git/objects/pack/ | grep bitmap >output &&
+	test_line_count = 1 output &&
+	packbitmap=$(basename $(cat output) .bitmap) &&
+	packobjects .git/objects/pack/$packbitmap.idx >packbitmap.objects &&
+	touch .git/objects/pack/$packbitmap.keep &&
+	echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >3a.pack &&
+	git index-pack 3a.pack &&
+	packobjects 3a.idx >3a.objects &&
+	if hasany packbitmap.objects 3a.objects; then
+		echo "Object from .keeped bitmapped pack present in pack generated with --honour-pack-keep"
+		return 1
+	fi &&
+	rm .git/objects/pack/$packbitmap.keep
+'
+
+test_expect_success 'pack-objects respects --local (non-local bitmapped pack)' '
+	mv .git/objects/pack/$packbitmap.* alt_objects/pack/ &&
+	echo HEAD | git pack-objects --local --stdout --revs >3b.pack &&
+	git index-pack 3b.pack &&
+	packobjects 3b.idx >3b.objects &&
+	if hasany packbitmap.objects 3b.objects; then
+		echo "Non-local object from bitmapped pack present in pack generated with --local"
+		return 1
+	fi &&
+	mv alt_objects/pack/$packbitmap.* .git/objects/pack/
+'
+
 test_expect_success 'full repack, reusing previous bitmaps' '
 	git repack -ad &&
 	ls .git/objects/pack/ | grep bitmap >output &&
@@ -143,6 +237,23 @@ test_expect_success 'create objects for missing-HAVE tests' '
 	EOF
 '
 
+test_expect_success 'pack-objects respects --incremental' '
+	cat >revs2 <<-EOF &&
+	HEAD
+	$commit
+	EOF
+	git pack-objects --incremental --stdout --revs <revs2 >4.pack &&
+	git index-pack 4.pack &&
+	packobjects 4.idx >4.objects &&
+	test_line_count = 4 4.objects &&
+	git rev-list --objects $commit >revlist &&
+	cut -d" " -f1 revlist |sort >objects &&
+	if !hasany objects 4.objects; then
+		echo "Expected objects not present in incremental pack"
+		return 1
+	fi
+'
+
 test_expect_success 'pack with missing blob' '
 	rm $(objpath $blob) &&
 	git pack-objects --stdout --revs <revs >/dev/null
-- 
2.9.2.701.gf965a18.dirty
