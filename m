From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch-pack: fix object_id of exact sha1
Date: Mon, 29 Feb 2016 04:50:41 -0500
Message-ID: <20160229095041.GA2950@sigill.intra.peff.net>
References: <CABaesJ+yNJ6_z=sFc+bDEPqDDsw9fkB5bYgxJaAkAMVqHNWwrQ@mail.gmail.com>
 <1456605174-28360-1-git-send-email-gabrielfrancosouza@gmail.com>
 <20160227221248.GB17475@sigill.intra.peff.net>
 <CABaesJJCfd6FzgEVCWMJH8-gKiv3pT8BGq4f-qFgprVde+ViQQ@mail.gmail.com>
 <xmqqh9gseiqk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 10:50:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaKTa-00044b-VS
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 10:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbcB2Juq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 04:50:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:51234 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751201AbcB2Jup (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 04:50:45 -0500
Received: (qmail 10252 invoked by uid 102); 29 Feb 2016 09:50:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 04:50:45 -0500
Received: (qmail 24163 invoked by uid 107); 29 Feb 2016 09:50:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 04:50:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 04:50:41 -0500
Content-Disposition: inline
In-Reply-To: <xmqqh9gseiqk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287815>

On Sun, Feb 28, 2016 at 11:29:39AM -0800, Junio C Hamano wrote:

> Gabriel Souza Franco <gabrielfrancosouza@gmail.com> writes:
> 
> >>>       struct object_id oid;
> >>>
> >>> -     if (!get_oid_hex(name, &oid) && name[GIT_SHA1_HEXSZ] == ' ')
> >>> -             name += GIT_SHA1_HEXSZ + 1;
> >>> -     else
> >>> +     if (get_oid_hex(name, &oid))
> >>>               oidclr(&oid);
> >>> +     else if (name[GIT_SHA1_HEXSZ] == ' ')
> >>> +             name += GIT_SHA1_HEXSZ + 1;
> >>
> >> This makes sense to me. I wonder if we should be more particular about
> >> the pure-sha1 case consuming the whole string, though. E.g., if we get:
> >>
> >>   1234567890123456789012345678901234567890-bananas
> >>
> >> that should probably not have sha1 1234...
> >>
> >> I don't think it should ever really happen in practice, but it might be
> >> worth noticing and complaining when name[GIT_SHA1_HEXSZ] is neither
> >> space nor '\0'.
> >
> > Right. What kind of complaining? Is doing oidclr(&oid) and letting it
> > fail elsewhere enough?
> 
> I think that is the most sensible.  After all, the first get-oid-hex
> expects to find a valid 40-hex object name at the beginning of line,
> and oidclr() is the way for it to signal a broken input, which is
> how the callers of this codepath expects errors to be caught.

Actually, I think we _don't_ want to signal an error here, but checking
for '\0' is still the right thing to do.

Once upon a time, fetch-pack took just the names of refs, like:

  git fetch-pack $remote refs/heads/foo

and the same format was used for --stdin. Then in 58f2ed0 (remote-curl:
pass ref SHA-1 to fetch-pack as well, 2013-12-05), it learned to take
"$sha1 $ref". But if we didn't see a sha1, then we continued to treat it
as a refname.

This patch adds a new format, just "$sha1". So if get_oid_hex() succeeds
_and_ we see '\0', we know we have that case. But if we don't see '\0',
then we should assume it's a refname (e.g., "1234abcd...-bananas").

I think in practice it shouldn't matter much, as callers should be
feeding fully qualified refs (and we document this). However, we still
want to distinguish so that we give the correct error ("no such remote
ref 1234abcd...-bananas", not "whoops, the other side doesn't have
1234abcd").

-Peff
