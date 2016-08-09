Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D22DC1FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 11:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbcHILVf (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 07:21:35 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:42648 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbcHILVe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 07:21:34 -0400
Received: from teco.navytux.spb.ru (unknown [178.70.73.8])
	by mail2.tiolive.com (Postfix) with ESMTPSA id 507E2BF01A5;
	Tue,  9 Aug 2016 13:21:31 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bX567-0002Gr-B0; Tue, 09 Aug 2016 14:21:27 +0300
Date:	Tue, 9 Aug 2016 14:21:27 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	=?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: Teach --use-bitmap-index codepath to
 respect --local, --honor-pack-keep and --incremental
Message-ID: <20160809112123.GA14273@teco.navytux.spb.ru>
References: <20160808135020.yggthtfekdiwq3lz@sigill.intra.peff.net>
 <20160808181942.GD3995@teco.navytux.spb.ru>
 <xmqqoa53dpue.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqoa53dpue.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio, first of all thanks for feedback,

On Mon, Aug 08, 2016 at 12:26:33PM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@nexedi.com> writes:
[...]
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index c4c2a3c..e06c1bf 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -944,13 +944,45 @@ static int have_duplicate_entry(const unsigned char *sha1,
> >  	return 1;
> >  }
> >  
> > +static int want_found_object(int exclude, struct packed_git *p)
> > +{
> > +	if (exclude)
> > +		return 1;
> > +	if (incremental)
> > +		return 0;
> > +
> > +	/*
> > +	 * When asked to do --local (do not include an
> > +	 * object that appears in a pack we borrow
> > +	 * from elsewhere) or --honor-pack-keep (do not
> > +	 * include an object that appears in a pack marked
> > +	 * with .keep), we need to make sure no copy of this
> > +	 * object come from in _any_ pack that causes us to
> > +	 * omit it, and need to complete this loop.  When
> > +	 * neither option is in effect, we know the object
> > +	 * we just found is going to be packed, so break
> > +	 * out of the search loop now.
> > +	 */
> 
> The blame is mine, but "no copy of this object appears in _any_ pack"
> would be more correct and easier to read.
> 
> This code is no longer in a search loop; its caller is.  Further
> rephrasing is needed.  "When asked to do ...these things..., finding
> a pack that matches the criteria is sufficient for us to decide to
> omit it.  However, even if this pack does not satisify the criteria,
> we need to make sure no copy of this object appears in _any_ pack
> that makes us to omit the object, so we need to check all the packs.
> Signal that by returning -1 to the caller." or something along that
> line.

Ok, I've rephrased it your way. Thanks for advising.

> >  /*
> >   * Check whether we want the object in the pack (e.g., we do not want
> >   * objects found in non-local stores if the "--local" option was used).
> >   *
> > - * As a side effect of this check, we will find the packed version of this
> > - * object, if any. We therefore pass out the pack information to avoid having
> > - * to look it up again later.
> > + * As a side effect of this check, if object's pack entry was not already found,
> > + * we will find the packed version of this object, if any. We therefore pass
> > + * out the pack information to avoid having to look it up again later.
> 
> The reasoning leading to "We therefore" is understandable, but "pass
> out the pack information" is not quite.  Is this meant to explain
> the fact that *found_pack and *found_offset are in-out parameters?
> 
> The explanation to justify why *found_pack and *found_offset that
> used to be out parameters are made in-out parameters belongs to the
> log message.  We do not want this in-code comment to explain the
> updated code relative to what the code used to do; that is not
> useful to those who read the code for the first time in the context
> of the committed state.
> 
>         /* 
>          * Check whether we want to pack the object in the pack (e.g. ...).
>          *
>          * If the caller already knows an existing pack it wants to
>          * take the object from, that is passed in *found_pack and
>          * *found_offset; otherwise this function finds if there is
>          * any pack that has the object and returns the pack and its
>          * offset in these variables.
>          */

The "pass out the pack information ..." is not my text - I only added
"if object's pack entry was not already found" in the middle of the
sentence and rewrapped this paragraph. The "pass out the pack
information ..." comes from ce2bc424 (pack-objects: split
add_object_entry; 2013-12-21)

I agree your text is more clear and it is better to adjust the comments.

> > diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> > index 3893afd..e71caa4 100755
> > --- a/t/t5310-pack-bitmaps.sh
> > +++ b/t/t5310-pack-bitmaps.sh
> > @@ -7,6 +7,19 @@ objpath () {
> >  	echo ".git/objects/$(echo "$1" | sed -e 's|\(..\)|\1/|')"
> >  }
> >  
> > +# show objects present in pack ($1 should be associated *.idx)
> > +packobjects () {
> > +	git show-index <$1 | cut -d' ' -f2
> > +}
> 
> That is a misleading name for a helper function that produces a list
> of objects that were packed.  "list_packed_objects", perhaps.

I agree it is ambiguous wrt `git pack-objects` and sorry for choosing
not good name from the start. I'm changing it to pack_list_objects().
( personally I would use pack_obj_list a-la git-rev-list, but let's try
  not to create another review step because of abbreviate vs not-abbreviate )

> > +# hasany pattern-file content-file
> > +# tests whether content-file has any entry from pattern-file with entries being
> > +# whole lines.
> > +hasany () {
> > +	# NOTE `grep -f` is not portable
> > +	git grep --no-index -qFf $1 $2
> > +}
> 
> I doubt "grep -f pattern_file" is not portable, but in any case, it
> is probably a good idea to have this helper function to make the
> caller easier to read.  Please name it "has_any", though, and quote
> "$1" and "$2" as they are meant to be able to take any filename.

Ok, thanks for the info `grep -f` is portable


> > +test_expect_success 'pack-objects respects --local (non-local loose)' '
> > +	mkdir -p alt_objects/pack &&
> 
> I'd really really prefer to see an empty repository created for
> this.  Even though the original intent was .git/objects/ alone,
> i.e. GIT_OBJECT_DIRECTORY can exist without associated refs, we
> discovered that it is in general not a good idea (think: "gc").

The "mkdir alt_objects/" comes from t7700-repack.sh - e.g. from
3c3df429 which I've ported from there. However as you say let's switch
this to having full another repo.


> > +	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
> > +	echo content1 >file1 &&
> > +	# non-local loose object which is not present in bitmapped pack
> > +	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file1) &&
> 
> Don't say "sha" when you mean "object name".  Otherwise you would
> end up introducing funky variable names like $objsha2 we see below
> that is confusing (we don't use SHA-2).

Ok makes sense, I've changed objsha1 to altblob and objsha2 to blob2.
Thanks for head-ups on this.


> > +	# non-local loose object which is also present in bitmapped pack
> > +	git cat-file blob $blob | GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w --stdin &&
> > +	git add file1 &&
> > +	test_tick &&
> > +	git commit -m commit_file1 &&
> > +	echo HEAD | git pack-objects --local --stdout --revs >1.pack &&
> > +	git index-pack 1.pack &&
> > +	packobjects 1.idx >1.objects &&
> > +	printf "$objsha1\n$blob\n" >nonlocal-loose &&
> 
> I think Peff meant to suggest this instead:
> 
> 	printf "%s\n" "$objsha1" "$blob"

Oops, yes, my bad. Corrected.


> > +	if hasany nonlocal-loose 1.objects; then
> > +		echo "Non-local object present in pack generated with --local"
> > +		return 1
> > +	fi
> 
> Just saying
> 
> 	! has_any nonlocal-loose 1.objects
> 
> is sufficient.  Same comment for all other uses of these verbose
> output.
> 
> Besides, we spell "if/then/fi" like this:
> 
> 	if condition
>         then
>         	body
> 	fi
> 
> without a semicolon.

I initially copied this check-templates from t7700-repack.sh, e.g. from
3289b9de (t7700: test that 'repack -a' packs alternate packed objects;
2008-11-13) and other places.

But ok, let's switch the checks to oneliners like "! has_any ..."

> > +test_expect_success 'pack-objects respects --honor-pack-keep (local non-bitmapped pack)' '
> > +...
> > +	touch .git/objects/pack/pack2-$pack2.keep &&
> 
> Please don't do "touch" _unless_ you care about the timestamp of the
> file.  Redirect an empty command into it, i.e.
> 
> 	>.git/objects/pack/pack2-$pack2.keep
> 
> or
> 
> 	echo "reason to keep it" >.git/objects/pack/pack2-$pack2.keep
> 
> instead.

Ok, I've changed to >file as the reason here is obvious.
Would you please explain why we should not use touch if we do not care
about timestamps? Simply style?

> > +test_expect_success 'pack-objects respects --honor-pack-keep (local bitmapped pack)' '
> > +	ls .git/objects/pack/ | grep bitmap >output &&
> > +	test_line_count = 1 output &&
> > +	packbitmap=$(basename $(cat output) .bitmap) &&
> > +	packobjects .git/objects/pack/$packbitmap.idx >packbitmap.objects &&
> > +	touch .git/objects/pack/$packbitmap.keep &&
> > +	echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >3a.pack &&
> > +	git index-pack 3a.pack &&
> > +	packobjects 3a.idx >3a.objects &&
> > +	if hasany packbitmap.objects 3a.objects; then
> > +		echo "Object from .keeped bitmapped pack present in pack generated with --honour-pack-keep"
> > +		return 1
> > +	fi &&
> > +	rm .git/objects/pack/$packbitmap.keep
> 
> Arrange this removal to happen even when any earlier step fails, so
> that later tests will not get affected by stray existence of this
> file, by using test_when_finished.  E.g.
> 
> 	list_packed_objects .git/objects/pack/$packbitmap.idx >packbitmap.objects &&
> 	test_when_finished "rm -f .git/objects/pack/$packbitmap.keep" &&
> 	>.git/objects/pack/$packbitmap.keep" &&

Ok, I did not knew about test_when_finished, and thanks for pointing
this out. Adjusted here and in similar place.

Will send v4 patch as reply to this mail with below interdiff:

Thanks again,
Kirill

---- 8< ---- (interdiff)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4c129bd..c92d7fc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -953,16 +953,14 @@ static int want_found_object(int exclude, struct packed_git *p)
 		return 0;
 
 	/*
-	 * When asked to do --local (do not include an
-	 * object that appears in a pack we borrow
-	 * from elsewhere) or --honor-pack-keep (do not
-	 * include an object that appears in a pack marked
-	 * with .keep), we need to make sure no copy of this
-	 * object come from in _any_ pack that causes us to
-	 * omit it, and need to complete this loop.  When
-	 * neither option is in effect, we know the object
-	 * we just found is going to be packed, so break
-	 * out of the search loop now.
+	 * When asked to do --local (do not include an object that appears in a
+	 * pack we borrow from elsewhere) or --honor-pack-keep (do not include
+	 * an object that appears in a pack marked with .keep), finding a pack
+	 * that matches the criteria is sufficient for us to decide to omit it.
+	 * However, even if this pack does not satisfy the criteria, we need to
+	 * make sure no copy of this object appears in _any_ pack that makes us
+	 * to omit the object, so we need to check all the packs. Signal that by
+	 * returning -1 to the caller.
 	 */
 	if (!ignore_packed_keep &&
 	    (!local || !have_non_local_packs))
@@ -981,9 +979,10 @@ static int want_found_object(int exclude, struct packed_git *p)
  * Check whether we want the object in the pack (e.g., we do not want
  * objects found in non-local stores if the "--local" option was used).
  *
- * As a side effect of this check, if object's pack entry was not already found,
- * we will find the packed version of this object, if any. We therefore pass
- * out the pack information to avoid having to look it up again later.
+ * If the caller already knows an existing pack it wants to take the object
+ * from, that is passed in *found_pack and *found_offset; otherwise this
+ * function finds if there is any pack that has the object and returns the pack
+ * and its offset in these variables.
  */
 static int want_object_in_pack(const unsigned char *sha1,
 			       int exclude,
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index cce95d8..44914ac 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -8,16 +8,15 @@ objpath () {
 }
 
 # show objects present in pack ($1 should be associated *.idx)
-packobjects () {
-	git show-index <$1 | cut -d' ' -f2
+pack_list_objects () {
+	git show-index <"$1" | cut -d' ' -f2
 }
 
-# hasany pattern-file content-file
+# has_any pattern-file content-file
 # tests whether content-file has any entry from pattern-file with entries being
 # whole lines.
-hasany () {
-	# NOTE `grep -f` is not portable
-	git grep --no-index -qFf $1 $2
+has_any () {
+	grep -qFf "$1" "$2"
 }
 
 test_expect_success 'setup repo with moderate-sized history' '
@@ -133,83 +132,68 @@ test_expect_success 'incremental repack can disable bitmaps' '
 '
 
 test_expect_success 'pack-objects respects --local (non-local loose)' '
-	mkdir -p alt_objects/pack &&
-	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
+	git init --bare alt.git &&
+	echo $(pwd)/alt.git/objects >.git/objects/info/alternates &&
 	echo content1 >file1 &&
 	# non-local loose object which is not present in bitmapped pack
-	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file1) &&
+	altblob=$(GIT_DIR=alt.git git hash-object -w file1) &&
 	# non-local loose object which is also present in bitmapped pack
-	git cat-file blob $blob | GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w --stdin &&
+	git cat-file blob $blob | GIT_DIR=alt.git git hash-object -w --stdin &&
 	git add file1 &&
 	test_tick &&
 	git commit -m commit_file1 &&
 	echo HEAD | git pack-objects --local --stdout --revs >1.pack &&
 	git index-pack 1.pack &&
-	packobjects 1.idx >1.objects &&
-	printf "$objsha1\n$blob\n" >nonlocal-loose &&
-	if hasany nonlocal-loose 1.objects; then
-		echo "Non-local object present in pack generated with --local"
-		return 1
-	fi
+	pack_list_objects 1.idx >1.objects &&
+	printf "%s\n" "$altblob" "$blob" >nonlocal-loose &&
+	! has_any nonlocal-loose 1.objects
 '
 
 test_expect_success 'pack-objects respects --honor-pack-keep (local non-bitmapped pack)' '
 	echo content2 >file2 &&
-	objsha2=$(git hash-object -w file2) &&
+	blob2=$(git hash-object -w file2) &&
 	git add file2 &&
 	test_tick &&
 	git commit -m commit_file2 &&
-	printf "$objsha2\n$bitmaptip\n" >keepobjects &&
+	printf "%s\n" "$blob2" "$bitmaptip" >keepobjects &&
 	pack2=$(git pack-objects pack2 <keepobjects) &&
 	mv pack2-$pack2.* .git/objects/pack/ &&
-	touch .git/objects/pack/pack2-$pack2.keep &&
-	rm $(objpath $objsha2) &&
+	>.git/objects/pack/pack2-$pack2.keep &&
+	rm $(objpath $blob2) &&
 	echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >2a.pack &&
 	git index-pack 2a.pack &&
-	packobjects 2a.idx >2a.objects &&
-	if hasany keepobjects 2a.objects; then
-		echo "Object from .keeped pack present in pack generated with --honor-pack-keep"
-		return 1
-	fi
+	pack_list_objects 2a.idx >2a.objects &&
+	! has_any keepobjects 2a.objects
 '
 
 test_expect_success 'pack-objects respects --local (non-local pack)' '
-	mv .git/objects/pack/pack2-$pack2.* alt_objects/pack/ &&
+	mv .git/objects/pack/pack2-$pack2.* alt.git/objects/pack/ &&
 	echo HEAD | git pack-objects --local --stdout --revs >2b.pack &&
 	git index-pack 2b.pack &&
-	packobjects 2b.idx >2b.objects &&
-	if hasany keepobjects 2b.objects; then
-		echo "Non-local object present in pack generated with --local"
-		return 1
-	fi
+	pack_list_objects 2b.idx >2b.objects &&
+	! has_any keepobjects 2b.objects
 '
 
 test_expect_success 'pack-objects respects --honor-pack-keep (local bitmapped pack)' '
 	ls .git/objects/pack/ | grep bitmap >output &&
 	test_line_count = 1 output &&
 	packbitmap=$(basename $(cat output) .bitmap) &&
-	packobjects .git/objects/pack/$packbitmap.idx >packbitmap.objects &&
-	touch .git/objects/pack/$packbitmap.keep &&
+	pack_list_objects .git/objects/pack/$packbitmap.idx >packbitmap.objects &&
+	test_when_finished "rm -f .git/objects/pack/$packbitmap.keep" &&
+	>.git/objects/pack/$packbitmap.keep &&
 	echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >3a.pack &&
 	git index-pack 3a.pack &&
-	packobjects 3a.idx >3a.objects &&
-	if hasany packbitmap.objects 3a.objects; then
-		echo "Object from .keeped bitmapped pack present in pack generated with --honour-pack-keep"
-		return 1
-	fi &&
-	rm .git/objects/pack/$packbitmap.keep
+	pack_list_objects 3a.idx >3a.objects &&
+	! has_any packbitmap.objects 3a.objects
 '
 
 test_expect_success 'pack-objects respects --local (non-local bitmapped pack)' '
-	mv .git/objects/pack/$packbitmap.* alt_objects/pack/ &&
+	mv .git/objects/pack/$packbitmap.* alt.git/objects/pack/ &&
+	test_when_finished "mv alt.git/objects/pack/$packbitmap.* .git/objects/pack/" &&
 	echo HEAD | git pack-objects --local --stdout --revs >3b.pack &&
 	git index-pack 3b.pack &&
-	packobjects 3b.idx >3b.objects &&
-	if hasany packbitmap.objects 3b.objects; then
-		echo "Non-local object from bitmapped pack present in pack generated with --local"
-		return 1
-	fi &&
-	mv alt_objects/pack/$packbitmap.* .git/objects/pack/
+	pack_list_objects 3b.idx >3b.objects &&
+	! has_any packbitmap.objects 3b.objects
 '
 
 test_expect_success 'pack-objects to file can use bitmap' '
@@ -256,14 +240,11 @@ test_expect_success 'pack-objects respects --incremental' '
 	EOF
 	git pack-objects --incremental --stdout --revs <revs2 >4.pack &&
 	git index-pack 4.pack &&
-	packobjects 4.idx >4.objects &&
+	pack_list_objects 4.idx >4.objects &&
 	test_line_count = 4 4.objects &&
 	git rev-list --objects $commit >revlist &&
 	cut -d" " -f1 revlist |sort >objects &&
-	if !hasany objects 4.objects; then
-		echo "Expected objects not present in incremental pack"
-		return 1
-	fi
+	test_cmp 4.objects objects
 '
 
 test_expect_success 'pack with missing blob' '
