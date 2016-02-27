From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch-pack: fix unadvertised requests validation
Date: Sat, 27 Feb 2016 14:07:12 -0500
Message-ID: <20160227190712.GC12822@sigill.intra.peff.net>
References: <1456577034-6494-1-git-send-email-gabrielfrancosouza@gmail.com>
 <xmqqd1riggd7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 20:07:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZkD5-0003Sp-Nd
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 20:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707AbcB0THR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 14:07:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:50810 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756704AbcB0THP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 14:07:15 -0500
Received: (qmail 1056 invoked by uid 102); 27 Feb 2016 19:07:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Feb 2016 14:07:15 -0500
Received: (qmail 14890 invoked by uid 107); 27 Feb 2016 19:07:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Feb 2016 14:07:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Feb 2016 14:07:12 -0500
Content-Disposition: inline
In-Reply-To: <xmqqd1riggd7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287723>

On Sat, Feb 27, 2016 at 10:25:40AM -0800, Junio C Hamano wrote:

> Gabriel Souza Franco <gabrielfrancosouza@gmail.com> writes:
> 
> > Check was introduced in b791642 (filter_ref: avoid overwriting
> > ref->old_sha1 with garbage, 2015-03-19), but was always false because
> > ref->old_oid.hash is empty in this case. Instead copy sha1 from ref->name.
> >
> > Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
> > ---
> 
> Peff, that commit points me at your direction.  And I can see the
> original patch avoids overwriting old_sha1 by saving the result from
> get_sha1_hex() in a temporary, it is true that old_sha1 is not
> updated from the temporary.
> 
> The original code before b791642 wanted to say "if ref->name is not
> 40-hex, continue, and otherwise, do the ref->matched thing" and an
> implementation of b791642 that is more faithful to the original
> would indeed have been the result of applying this patch from
> Gabriel, but I am scratching my head why we have hashcmp() there.
> 
> Was it to avoid adding the same thing twice to the resulting list,
> or something?

It is a sanity check. The code is looking in our list of things to fetch
for items that are pure objects, not refs (we already matched the refs
by name, but obviously would not have matched any pure-sha1 requests to
refnames).  So the conditional really is:

   if (!is_a_pure_sha1(ref))
	continue;

We can implement that as:

  if (get_sha1_hex(ref->name, sha1) || ref->name[40] != '\0')

but as noted in the commit message for b791642:

  We could just check that we have exactly 40 characters of
  sha1. But let's be even more careful and make sure that we
  have a 40-char hex refname that matches what is in old_sha1.
  This is perhaps overly defensive, but spells out our
  assumptions clearly.

E.g., if you did this:

  git fetch-pack --stdin $remote <<\EOF
  1234567890123456789012345678901234567890 abcdef1234abcdef1234abcdef1234abcdef1234
  EOF

you'd have a "struct ref" with a 40-hex sha1, but which does _not_ want
the object of the same name. This is not a pure-object request, and we
should only request 1234... if the ref abcd... is present on the remote.

I doubt it would ever come up in real life; refs tend to start with
"refs/", and I suspect short of manual prodding as above, you could not
get anything without "refs/" to this point of the code.

So the patch:

> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 01e34b6..83b937b 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -569,11 +569,11 @@ static void filter_refs(struct fetch_pack_args *args,
> >  			if (ref->matched)
> >  				continue;
> >  			if (get_sha1_hex(ref->name, sha1) ||
> > -			    ref->name[40] != '\0' ||
> > -			    hashcmp(sha1, ref->old_oid.hash))
> > +			    ref->name[40] != '\0')
> >  				continue;
> >  
> >  			ref->matched = 1;
> > +			hashcpy(ref->old_oid.hash, sha1);
> >  			*newtail = copy_ref(ref);
> >  			newtail = &(*newtail)->next;
> >  		}

is a wrong direction, I think. It removes the extra safety check that
skips the ref above. But worse, in the example above, it overwrites the
real object "1234..." with the name of the ref "abcd..." in the sha1
field. We'll ask for an object that may not even exist.

The commit message for Gabriel's patch says:

> > Check was introduced in b791642 (filter_ref: avoid overwriting
> > ref->old_sha1 with garbage, 2015-03-19), but was always false because
> > ref->old_oid.hash is empty in this case. Instead copy sha1 from ref->name.

but I don't think ref->old_oid.hash _is_ empty. At least, that was not
the conclusion from our discussion in:

   http://thread.gmane.org/gmane.comp.version-control.git/265480

We expect whoever creates the "sought" list to fill in the name and sha1
as appropriate. If that is not happening in some code path, then yeah,
filter_refs() will not work as intended. But I think the solution there
would be to fix the caller to set up the "struct ref" more completely.

Gabriel, did this come from a bug you noticed in practice, or was it
just an intended cleanup?

-Peff
