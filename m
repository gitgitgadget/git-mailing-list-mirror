From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 10/21] pack-bitmap: add support for bitmap indexes
Date: Mon, 2 Dec 2013 11:12:08 -0500
Message-ID: <20131202161208.GB24202@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
 <20131114124432.GJ10757@sigill.intra.peff.net>
 <87siuedhvj.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Dec 02 17:12:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnW6a-0007kg-Fk
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 17:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab3LBQMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 11:12:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:49096 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752024Ab3LBQMK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 11:12:10 -0500
Received: (qmail 25786 invoked by uid 102); 2 Dec 2013 16:12:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Dec 2013 10:12:09 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Dec 2013 11:12:08 -0500
Content-Disposition: inline
In-Reply-To: <87siuedhvj.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238637>

On Fri, Nov 29, 2013 at 10:21:04PM +0100, Thomas Rast wrote:

> I do think it's worth fixing the syntax pedantry at the end so that we
> can keep supporting arcane compilers, but otherwise, meh.

Agreed. I've picked up those changes in my tree.

> > +static int open_pack_bitmap_1(struct packed_git *packfile)
> 
> This goes somewhat against the naming convention (if you can call it
> that) used elsewhere in git.  Usually foo_1() is an implementation
> detail of foo(), used because it is convenient to wrap the main part in
> another function, e.g. so that it can consistently free resources or
> some such.  But this one operates on one pack file, so in the terms of
> the rest of git, it should probably be called open_pack_bitmap_one().

Hmm. I see your point, but I think that my (and Vicent's) mental model
was that is _was_ a helper for open_pack_bitmap. It just happens to also
fill the role of open_pack_bitmap_one(), but you would not want the
latter. We only support a single bitmap at a time; by calling the
helper, you would miss out on the assert which would catch the error.

So I don't care much, but I have a slight preference to leave it, as it
signals "you should not be calling this directly" more clearly.

> A bit unfortunate that you inherit the strange show_* naming from
> builtin/pack-objects.c, which seems to have stolen some code from
> builtin/rev-list.c at some point without worrying about better naming...

Yes, I agree they're not very descriptive. Let's leave it for now to
stay consistent with pack-objects, and I'd be happy to see a patch
giving all of them better names come later.

> > +	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
> > +		eword_t word = objects->words[i] & filter;
> > +
> > +		for (offset = 0; offset < BITS_IN_WORD; ++offset) {
> > +			const unsigned char *sha1;
> > +			struct revindex_entry *entry;
> > +			uint32_t hash = 0;
> > +
> > +			if ((word >> offset) == 0)
> > +				break;
> > +
> > +			offset += ewah_bit_ctz64(word >> offset);
> > +
> > +			if (pos + offset < bitmap_git.reuse_objects)
> > +				continue;
> > +
> > +			entry = &bitmap_git.reverse_index->revindex[pos + offset];
> > +			sha1 = nth_packed_object_sha1(bitmap_git.pack, entry->nr);
> > +
> > +			show_reach(sha1, object_type, 0, hash, bitmap_git.pack, entry->offset);
> > +		}
> 
> You have a very nice bitmap_each_bit() function in ewah/bitmap.c, why
> not use it here?

We are bitwise-ANDing against an on-disk ewah bitmap to filter out
objects which do not match the desired type. bitmap_each_bit would make
this more complicated, because we wouldn't be able to move the
ewah_iterator in single-word lockstep. And it would probably be slower
(if you did it naively), because we'd end up checking each bit in the
ewah, rather than AND-ing whole words.

The right, reusable way to do it would probably be to bitmap_and_ewah
the original and the filter together, and then bitmap_each_bit the
result. But you would have to write bitmap_and_ewah first. :)

> > +	/*
> > +	 * Reuse the packfile content if we need more than
> > +	 * 90% of its objects
> > +	 */
> > +	static const double REUSE_PERCENT = 0.9;
> 
> Curious: is this based on some measurements or just a guess?

I think it's mostly a guess.

> > +enum pack_bitmap_opts {
> > +	BITMAP_OPT_FULL_DAG = 1,
> 
> And I think this trailing comma on the last enum item is also strictly
> speaking not allowed, even though it is very nice to have:
> 
> pack-bitmap.h:28:27: warning: comma at end of enumerator list [-Wpedantic]

It's allowed in C99, but was not in C89.  I've fixed this site for
consistency with the rest of git. But I wonder how relevant it still is.
The only data points I know of are:

  http://article.gmane.org/gmane.comp.version-control.git/145739

and

  http://article.gmane.org/gmane.comp.version-control.git/145739

It sounds like an ancient IBM VisualAge is the only reported problem.
And according to IBM, they stopped supporting it 10 years ago (well,
technically we have a few more weeks to hit the 10-year mark):

  http://www-01.ibm.com/common/ssi/cgi-bin/ssialias?infotype=an&subtype=ca&supplier=897&appname=IBMLinkRedirect&letternum=ENUS903-227

I do wonder if at some point we should revisit our "do not use any
C99-isms" philosophy. It was very good advice in 2005. I don't know how
good it is over 8 years later (it seems like even ancient systems should
be able to get gcc compiled as a last resort, but maybe there really are
people for whom that is a burden).

-Peff
