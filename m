Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8636E2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 13:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbcHHNuY (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 09:50:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:51124 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752007AbcHHNuX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 09:50:23 -0400
Received: (qmail 5576 invoked by uid 109); 8 Aug 2016 13:50:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 13:50:22 +0000
Received: (qmail 4990 invoked by uid 111); 8 Aug 2016 13:50:21 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 09:50:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Aug 2016 09:50:20 -0400
Date:	Mon, 8 Aug 2016 09:50:20 -0400
From:	Jeff King <peff@peff.net>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Vicent Marti <tanoku@gmail.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: Teach --use-bitmap-index codepath to
 respect --local, --honor-pack-keep and --incremental
Message-ID: <20160808135020.yggthtfekdiwq3lz@sigill.intra.peff.net>
References: <20160729074051.GA5987@teco.navytux.spb.ru>
 <20160729074656.23813-1-kirr@nexedi.com>
 <xmqqy44gjqv9.fsf@gitster.mtv.corp.google.com>
 <20160808123734.GA3995@teco.navytux.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160808123734.GA3995@teco.navytux.spb.ru>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 08, 2016 at 03:37:35PM +0300, Kirill Smelkov wrote:

> @@ -958,15 +958,30 @@ static int want_object_in_pack(const unsigned char *sha1,
>  			       off_t *found_offset)
>  {
>  	struct packed_git *p;
> +	struct packed_git *pack1 = *found_pack;
> +	int pack1_seen = !pack1;
>  
>  	if (!exclude && local && has_loose_object_nonlocal(sha1))
>  		return 0;
>  
> -	*found_pack = NULL;
> -	*found_offset = 0;
> +	/*
> +	 * If we already know the pack object lives in, start checks from that
> +	 * pack - in the usual case when neither --local was given nor .keep files
> +	 * are present the loop will degenerate to have only 1 iteration.
> +	 */
> +	for (p = (pack1 ? pack1 : packed_git); p;
> +	     p = (pack1_seen ? p->next : packed_git), pack1_seen = 1) {
> +		off_t offset;

Hmm. So this is basically sticking the found-pack at the front of the
loop.

We either need to look at zero packs here (we already know where the
object is, and we don't need to bother with --local or .keep lookups),
or we need to look at all of them (to check for local/keep).

I guess you structured it this way to try to reuse the "can we break out
early" logic from the middle of the loop. So we go through the loop one
time, and then break out. And then this:

> +		if (p == pack1) {
> +			if (pack1_seen)
> +				continue;
> +			offset = *found_offset;
> +		}
> +		else {
> +			offset = find_pack_entry_one(sha1, p);
> +		}

is meant to make that one-time through the loop cheaper. So I don't
think it's wrong, but it's very confusing to me.

Would it be simpler to stick that logic in a function like:

  static int want_found_object(int exclude, struct packed_git *pack)
  {
	if (exclude)
		return 1;
	if (incremental)
		return 0;

	/* if we can break early, then do so */
	if (!ignore_packed_keep &&
	    (!local || !have_non_local_packs))
		return 1;

	if (local && !p->pack_local)
		return 0;
	if (ignore_packed_keep && p->pack_local && p->pack_keep)
		return 0;

	/* indeterminate; keep looking for more packs */
	return -1;
  }

  static int want_object_in_pack(...)
  {
	...
	if (!exclude && local && has_loose_object_nonlocal(sha1))
		return 0;

	if (*found_pack) {
		int ret = want_found_object(exclude, *found_pack);
		if (ret != -1)
			return ret;
	}

	for (p = packed_git; p; p = p->next) {
		off_t offset;

		if (p == *found_pack)
			offset = *found_offset;
		else
			offset = find_pack_entry(sha1, p);
		if (offset) {
			... fill in *found_pack ...
			int ret = want_found_object(exclude, p);
			if (ret != -1)
				return ret;
		}
	}
	return 1;
  }

That's a little more verbose, but IMHO the flow is a lot easier to
follow (especially as the later re-rolls of that series actually muck
with the loop order more, but with this approach there's no conflict).

>  static int add_object_entry(const unsigned char *sha1, enum object_type type,
>  			    const char *name, int exclude)
>  {
> -	struct packed_git *found_pack;
> -	off_t found_offset;
> +	struct packed_git *found_pack = NULL;
> +	off_t found_offset = 0;
>  	uint32_t index_pos;
>  
>  	if (have_duplicate_entry(sha1, exclude, &index_pos))
> @@ -1073,6 +1088,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
>  	if (have_duplicate_entry(sha1, 0, &index_pos))
>  		return 0;
>  
> +	if (!want_object_in_pack(sha1, 0, &pack, &offset))
> +		return 0;
> +

This part looks correct and easy to understand.

> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 3893afd..1a61de4 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -16,6 +16,7 @@ test_expect_success 'setup repo with moderate-sized history' '
>  		test_commit side-$i
>  	done &&
>  	git checkout master &&
> +	bitmaptip=$(git show-ref -s master) &&

Our usual method for getting a sha1 is "git rev-parse". I don't think
there's anything wrong with your method, but it might be better to stick
to the canonical one (I had to actually look up "show-ref -s").

> @@ -118,6 +119,90 @@ test_expect_success 'incremental repack can disable bitmaps' '
>  	git repack -d --no-write-bitmap-index
>  '
>  
> +test_expect_success 'pack-objects respects --local (non-local loose)' '
> +	mkdir -p alt_objects/pack &&
> +	echo $(pwd)/alt_objects > .git/objects/info/alternates &&
> +	echo content1 > file1 &&

Style: we don't put a space between ">" and the filename.

> +	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file1) &&
> +	git cat-file blob $blob | GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w --stdin &&

I'm not sure why we need two objects in the fake alt_objects repository.
Shouldn't one be enough to do the test?

> +	git add file1 &&

I think this will actually skip the writing of the loose object, because
it's already available in the alternate object store. You probably want
to do this before adding it there.

> +	test_tick &&
> +	git commit -m commit_file1 &&
> +	echo HEAD | \

No need for "\" after a "|"; the shell knows it has to keep looking.

> +	git pack-objects --local --stdout --revs >1.pack &&
> +	git index-pack 1.pack &&

I'd have expected you to use the non-stdout version here. Is this meant
to be independent of your other patch (I think that's OK).

> +	git verify-pack -v 1.pack >1.objects &&

It's cheaper to use "git show-index <1.pack", and the output is saner,
too.

> +	echo -e "$objsha1\n$blob" >nonlocal-loose &&

"echo -e" isn't portable. You can use "printf", or two echos like:

  {
    echo one &&
    echo two
  } >file

(though I'm still not sure what we gain by checking both).

> +	if grep -qFf nonlocal-loose 1.objects; then
> +		echo "Non-local object present in pack generated with --local"
> +		return 1
> +	fi
> +'

grep -f isn't portable. However, I think:

  echo $objsha1 >expect &&
  git show-index <1.pack | cut -d' ' -f2 >actual
  test_cmp expect actual

would work (if you do stick with two entries, you might need to sort
your "expect").

I think similar comments apply to the other tests. I would have expected
"respects --local (non-local pack)" to come next (i.e., to keep all of
the --local tests together). But you seem to interleave them with
--honor-pack-keep.

-Peff
