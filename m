From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tag: do not show ambiguous tag names as "tags/foo"
Date: Sun, 24 Jan 2016 18:05:31 -0500
Message-ID: <20160124230531.GB29115@sigill.intra.peff.net>
References: <CAAB=nN=RSQuDPdg6Y2heeBXpQVdWSwFAcDDTfxE=XRSOu5gGEg@mail.gmail.com>
 <20160124071234.GA24084@sigill.intra.peff.net>
 <20160124071815.GB24084@sigill.intra.peff.net>
 <xmqqvb6iboxj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pete Harlan <pgit@tento.net>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 00:05:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNTj3-0002tr-8V
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 00:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbcAXXFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 18:05:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:59633 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752051AbcAXXFe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 18:05:34 -0500
Received: (qmail 15753 invoked by uid 102); 24 Jan 2016 23:05:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jan 2016 18:05:34 -0500
Received: (qmail 13138 invoked by uid 107); 24 Jan 2016 23:05:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jan 2016 18:05:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Jan 2016 18:05:31 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvb6iboxj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284701>

On Sun, Jan 24, 2016 at 02:19:52PM -0800, Junio C Hamano wrote:

> Also there is "what happens if the expected prefix is not there?"
> question.  Perhaps strip=2 can be defined to "strip 2 levels of
> hierarchy prefix no matter what that is", and strip refs/tags/foo,
> refs/heads/foo and refs/remotes/origin/foo to foo, foo, origin/foo,
> respectively?  The filtering natively done by the listing mode of
> "branch" and "tags" would ensure the prefixes are always what we
> implicitly expect, so the case we need to worry about how we should
> signal errors becomes "what if there are not enough levels".  That
> may be simpler to handle.

The "not enough levels" question is interesting. Here are the options I
can think of:

  1. Signal an error and die. Safest, but potentially annoying.

  2. Strip everything and print a blank. Logically consistent, but the
     output is not particularly useful, and may introduce parsing
     confusion.

  3. Strip nothing (i.e., "%(refname:strip=4)" on "refs/heads/master"
     remains "refs/heads/master"). Easy to explain, and provides
     useful-ish output. The output is technically ambiguous, though (was
     it "refs/heads/foo/refs/heads/master", or just
     "refs/heads/master"?).

  4. Strip all but the final entry. Kind-of also useful, but like (3),
     ambiguous.

I implemented (3) semi-arbitrarily (mostly because it was only slightly
less easy than (2), and (2) seems kind of crazy).

There is also a question of what "strip=-1" or "strip=foobar" should do.
They are both equivalent to strip=0 in my implementation, but we could
also report an error.

I ended up doing a preparatory patch for t6300; I wanted to add new
tests there, and the existing content was so messy I couldn't bear it.

  [1/2]: t6300: use test_atom for some un-modern tests
  [2/2]: tag: do not show ambiguous tag names as "tags/foo"

-Peff
