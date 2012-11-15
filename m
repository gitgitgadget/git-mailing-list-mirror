From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] pickaxe: use textconv for -S counting
Date: Wed, 14 Nov 2012 17:21:31 -0800
Message-ID: <20121115012131.GA17894@sigill.intra.peff.net>
References: <20121028124540.GF11434@sigill.intra.peff.net>
 <20121028124701.GB24548@sigill.intra.peff.net>
 <7vk3tpcd0w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Oberndorfer <kumbayo84@arcor.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 02:21:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYo9M-0003Tk-Qn
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 02:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847Ab2KOBVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 20:21:35 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48885 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964820Ab2KOBVe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 20:21:34 -0500
Received: (qmail 9768 invoked by uid 107); 15 Nov 2012 01:22:23 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Nov 2012 20:22:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2012 17:21:31 -0800
Content-Disposition: inline
In-Reply-To: <7vk3tpcd0w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209778>

On Tue, Nov 13, 2012 at 03:13:19PM -0800, Junio C Hamano wrote:

> >  static int has_changes(struct diff_filepair *p, struct diff_options *o,
> >  		       regex_t *regexp, kwset_t kws)
> >  {
> > +	struct userdiff_driver *textconv_one = get_textconv(p->one);
> > +	struct userdiff_driver *textconv_two = get_textconv(p->two);
> > +	mmfile_t mf1, mf2;
> > +	int ret;
> > +
> >  	if (!o->pickaxe[0])
> >  		return 0;
> >  
> > -	if (!DIFF_FILE_VALID(p->one)) {
> > -		if (!DIFF_FILE_VALID(p->two))
> > -			return 0; /* ignore unmerged */
> 
> What happened to this part that avoids showing nonsense for unmerged
> paths?

It's moved down. fill_one will return an empty mmfile if
!DIFF_FILE_VALID, so we end up here:

        fill_one(p->one, &mf1, &textconv_one);
        fill_one(p->two, &mf2, &textconv_two);

        if (!mf1.ptr) {
                if (!mf2.ptr)
                        ret = 0; /* ignore unmerged */

Prior to this change, we didn't use fill_one, so we had to check manually.

> > +	/*
> > +	 * If we have an unmodified pair, we know that the count will be the
> > +	 * same and don't even have to load the blobs. Unless textconv is in
> > +	 * play, _and_ we are using two different textconv filters (e.g.,
> > +	 * because a pair is an exact rename with different textconv attributes
> > +	 * for each side, which might generate different content).
> > +	 */
> > +	if (textconv_one == textconv_two && diff_unmodified_pair(p))
> > +		return 0;
> 
> I am not sure about this part that cares about the textconv.
> 
> Wouldn't the normal "git diff A B" skip the filepair that are
> unmodified in the first place at the object name level without even
> looking at the contents (see e.g. diff_flush_patch())?

Hmph. The point was to find the case when the paths are different (e.g.,
in a rename), and therefore the textconvs might be different. But I
think I missed the fact that diff_unmodified_pair will note the
difference in paths. So just calling diff_unmodified_pair would be
sufficient, as the code prior to my patch does.

I thought the point was an optimization to avoid comparing contains() on
the same data (which we can know will match without looking at it).
Exact renames are the obvious one, but they are not handled here. So I
am not sure of the point (to catch "git diff $blob1 $blob2" when the two
are identical? I am not sure at what layer we cull that from the diff
queue).

So there is room for optimization here on exact renames, but
diff_unmodified_pair is too forgiving of what is interesting (a rename
is interesting to diff_flush_patch, because it wants to mention the
rename, but it is not interesting to pickaxe, because we did not change
the content, and it could be culled here).

I don't know that it is that big a deal in general. Pure renames are
going to be the minority of blobs we look at, so it is probably not even
measurable. You could construct a pathological case (e.g., an otherwise
small repo with a 2G file, rename the 2G file without modification, then
running "git log -Sfoo" will unnecessarily load the giant blob while
examining the rename commit).

> Shouldn't this part of the code emulating that behaviour no matter
> what textconv filter(s) are configured for these paths?

Yeah, I just missed that it is checking the path already. It may still
make sense to tighten the optimization, but that is a separate issue. It
should just check diff_unmodified_pair as before; textconv only matters
if you are trying to optimize out exact renames.

-Peff
