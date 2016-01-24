From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tag: do not show ambiguous tag names as "tags/foo"
Date: Sun, 24 Jan 2016 17:27:36 -0500
Message-ID: <20160124222736.GA29115@sigill.intra.peff.net>
References: <CAAB=nN=RSQuDPdg6Y2heeBXpQVdWSwFAcDDTfxE=XRSOu5gGEg@mail.gmail.com>
 <20160124071234.GA24084@sigill.intra.peff.net>
 <20160124071815.GB24084@sigill.intra.peff.net>
 <xmqqvb6iboxj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pete Harlan <pgit@tento.net>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 23:28:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNT8o-0001kJ-Ew
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 23:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382AbcAXW2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 17:28:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:59617 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754367AbcAXW1j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 17:27:39 -0500
Received: (qmail 13631 invoked by uid 102); 24 Jan 2016 22:27:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jan 2016 17:27:38 -0500
Received: (qmail 12950 invoked by uid 107); 24 Jan 2016 22:28:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jan 2016 17:28:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Jan 2016 17:27:36 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvb6iboxj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284700>

On Sun, Jan 24, 2016 at 02:19:52PM -0800, Junio C Hamano wrote:

> >> Instead, let's extend the "short" modifier in the formatting
> >> language to handle a specific prefix. This fixes "git tag",
> >> and lets users invoke the same behavior from their own
> >> custom formats (for "tag" or "for-each-ref") while leaving
> >> ":short" with its same consistent meaning in all places.
> 
> Yeah, I do agree with the analysis.
> 
> I however wonder if short=$prefix is a good end-user interface,
> though, as strip=$prefix may be more intuitive to them, I suspect.

Yeah, I picked "short" just because of the existing feature. But we are
not bound to use the same name at all, and "strip" is probably more
descriptive (I thought "prefix" might also be, but that only
communicates what it _is_, not that we are removing it).

> Also there is "what happens if the expected prefix is not there?"
> question.

I think "do not strip anything" (as I have here) is an OK behavior. It
would not come up for sane requests (i.e., you would generally be
filtering to match your prefix anyway).

But...

> Perhaps strip=2 can be defined to "strip 2 levels of
> hierarchy prefix no matter what that is", and strip refs/tags/foo,
> refs/heads/foo and refs/remotes/origin/foo to foo, foo, origin/foo,
> respectively?  The filtering natively done by the listing mode of
> "branch" and "tags" would ensure the prefixes are always what we
> implicitly expect, so the case we need to worry about how we should
> signal errors becomes "what if there are not enough levels".  That
> may be simpler to handle.

Yeah, "strip=2" would also get the job done, and extends more naturally
to the branch case.

To be honest, I cannot imagine anybody using anything _but_ strip=2, but
maybe there are special cases, like:

  git for-each-ref --format='%(refname:strip=3)' refs/heads/jk/

to get my list of topics, sans initials.

I had originally hoped to avoid exposing any of this to the user, and
just make things internal, so that we would not be locked into a
particular formatting behavior. But since we now have "tag --format" and
advertise "%(refname:short)" as its default, I think it has become
user-visible.

Let me see what the "strip=X" patch looks like.

-Peff
