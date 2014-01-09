From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/5] refs: teach for_each_ref a flag to avoid recursion
Date: Thu, 9 Jan 2014 16:49:26 -0500
Message-ID: <20140109214926.GA32069@sigill.intra.peff.net>
References: <20140107235631.GA10503@sigill.intra.peff.net>
 <20140107235850.GC10657@sigill.intra.peff.net>
 <20140108034733.GA17198@sigill.intra.peff.net>
 <52CD36AF.2080705@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Brodie Rao <brodie@sf.io>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jan 09 22:49:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1NTp-0001va-Ai
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 22:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757465AbaAIVta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 16:49:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:58006 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756638AbaAIVt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 16:49:28 -0500
Received: (qmail 8526 invoked by uid 102); 9 Jan 2014 21:49:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jan 2014 15:49:28 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jan 2014 16:49:26 -0500
Content-Disposition: inline
In-Reply-To: <52CD36AF.2080705@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240275>

On Wed, Jan 08, 2014 at 12:29:51PM +0100, Michael Haggerty wrote:

> > Here's a fixed version of patch 3/5.
> 
> v2 4/5 doesn't apply cleanly on top of v3 3/5.  So I'm basing my review
> on the branch you have at GitHub peff/git "jk/cat-file-warn-ambiguous";
> I hope it is the same.

Hrmph. I didn't have to do any conflict resolution during the rebase, so
I would think it would apply at least with "am -3".

> > -- >8 --
> > Subject: refs: teach for_each_ref a flag to avoid recursion
> > 
> > The normal for_each_ref traversal descends into
> 
> You haven't changed any for_each_ref*() functions; you have only exposed
> the DO_FOR_EACH_NO_RECURSE option to the (static) functions
> for_each_entry*() and do_for_each_ref().  (This is part and parcel of
> your decision not to expose the new functionality in the refs API.)
> Please correct the line above.

Will do, and I'll add a note on not exposing it (basically because there
is not an existing "flags" parameter in the public API, and nobody needs
it).

> >  static int do_for_each_entry_in_dir(struct ref_dir *dir, int offset,
> > -				    each_ref_entry_fn fn, void *cb_data)
> > +				    each_ref_entry_fn fn, void *cb_data,
> > +				    int flags)
> >  {
> >  	int i;
> >  	assert(dir->sorted == dir->nr);
> 
> Please update the docstring for this function, which still says that it
> recurses without mentioning DO_FOR_EACH_NO_RECURSE.

Will do (and for the _in_dirs variant).

> >  static int do_for_each_entry(struct ref_cache *refs, const char *base,
> > -			     each_ref_entry_fn fn, void *cb_data)
> > +			     each_ref_entry_fn fn, void *cb_data,
> > +			     int flags)
> >  {
> >  	struct packed_ref_cache *packed_ref_cache;
> >  	struct ref_dir *loose_dir;
> 
> A few lines after this, do_for_each_entry() calls
> prime_ref_dir(loose_dir) to ensure that all of the loose references that
> will be iterated over are read before the packed-refs file is checked.
> It seems to me that prime_ref_dir() should also get a flags parameter to
> prevent it reading more loose references than necessary, something like
> this:

Hmm. I hadn't considered that, but yeah, it definitely nullifies part of
the purpose of the optimization.

However, is it safe to prime only part of the loose ref namespace? The
point of that priming is to avoid the race fixed in 98eeb09, which
depends on us caching the loose refs before the packed refs. But when we
read packed-refs, we will be reading and storing _all_ of it, even if we
do not touch it in this traversal. So it does not affect the race for
this traversal, but have we setup a cache situation where a subsequent
for_each_ref in the same process would be subject to the race?

I'm starting to wonder if this optimization is worth it.

> > [...]
> > @@ -1718,7 +1732,7 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
> >  	data.fn = fn;
> >  	data.cb_data = cb_data;
> >  
> > -	return do_for_each_entry(refs, base, do_one_ref, &data);
> > +	return do_for_each_entry(refs, base, do_one_ref, &data, flags);
> >  }
> 
> This change makes the DO_FOR_EACH_NO_RECURSE option usable with
> do_for_each_ref() (even though it is never in fact used).  It should
> either be mentioned in the docstring or (if there is a reason not to
> allow it) explicitly prohibited.

Hrm, yeah. I guess there are no callers, and there is no plan for any.
So we could just pass "0" here, and then "flags" passed to
do_for_each_ref really is _just_ for the callback data that goes to
do_one_ref. That clears up the weird "combined namespace" stuff I
mentioned in the commit message, and is a bit cleaner. I'll take it in
that direction.

> It would be possible to use your new flag to speed up
> is_refname_available(), but it would be a little bit of work and I doubt
> that is_refname_available() is ever a bottleneck.

Yeah, agreed on both counts.

-Peff
