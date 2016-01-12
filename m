From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] lock_ref_sha1_basic: handle REF_NODEREF with invalid
 refs
Date: Tue, 12 Jan 2016 04:52:57 -0500
Message-ID: <20160112095257.GB9855@sigill.intra.peff.net>
References: <20160111154651.GA25338@sigill.intra.peff.net>
 <20160111155239.GB22778@sigill.intra.peff.net>
 <5694873D.5000001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 12 10:53:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIvdT-0004BW-Ak
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 10:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761706AbcALJxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 04:53:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:51988 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760803AbcALJxA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 04:53:00 -0500
Received: (qmail 21017 invoked by uid 102); 12 Jan 2016 09:53:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 04:53:00 -0500
Received: (qmail 11472 invoked by uid 107); 12 Jan 2016 09:53:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 04:53:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 04:52:57 -0500
Content-Disposition: inline
In-Reply-To: <5694873D.5000001@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283781>

On Tue, Jan 12, 2016 at 05:55:25AM +0100, Michael Haggerty wrote:

> On 01/11/2016 04:52 PM, Jeff King wrote:
> > We sometimes call lock_ref_sha1_basic both with REF_NODEREF
> > to operate directly on a symbolic ref.
> 
> ^^^ This sentence seems to be missing some words.

I think it has one too many. :)

It was originally "both with a regular ref and with a symref", but I
shortened it since we only care about the symref case. I think just
getting rid of "both" is the right thing.

> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 180c837..ea67d82 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -1901,6 +1901,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
> >  
> >  	refname = resolve_ref_unsafe(refname, resolve_flags,
> >  				     lock->old_oid.hash, &type);
> > +	if (!refname && (flags & REF_NODEREF))
> > +		refname = resolve_ref_unsafe(orig_refname,
> > +					     resolve_flags | RESOLVE_REF_NO_RECURSE,
> > +					     lock->old_oid.hash, &type);
> > [...]
> 
> The main risk for this change would be that this new recovery code
> allows the function to continue, but one of the outputs of the second
> function invocation is not correct for the code that follows. Let me
> think out loud:
> 
> * refname -- now will be equal to orig_refname. I think the main effect
> is that it will be passed to verify_refname_available_dir(). This seems
> to be what we want.
> 
> * type -- now reflects orig_refname; i.e., usually REF_ISSYMREF. This
> also seems correct.
> 
> * lock->old_oid.hash -- is now ZEROS. This might get compared to the
> caller's old_sha1 in verify_lock(), and it will also be written to the
> reflog as the "old" value. I think this is also what we want.
> 
> So this change looks good to me.

Thanks. I had a nagging feeling that I hadn't considered all cases, but
the way you've framed it makes sense to me.

-Peff
