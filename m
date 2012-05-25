From: Jeff King <peff@peff.net>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Fri, 25 May 2012 02:50:40 -0400
Message-ID: <20120525065038.GA12249@sigill.intra.peff.net>
References: <4FB9F92D.8000305@alum.mit.edu>
 <201205241854.56934.mfick@codeaurora.org>
 <20120525010434.GA11861@sigill.intra.peff.net>
 <201205241932.37045.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri May 25 08:50:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXoMS-0004pL-Cr
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 08:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668Ab2EYGuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 02:50:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55556
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053Ab2EYGuv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 02:50:51 -0400
Received: (qmail 5433 invoked by uid 107); 25 May 2012 06:51:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 May 2012 02:51:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 May 2012 02:50:40 -0400
Content-Disposition: inline
In-Reply-To: <201205241932.37045.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198465>

On Thu, May 24, 2012 at 07:32:36PM -0600, Martin Fick wrote:

> > > > Yes, exclusively warm. And all of the refs were
> > We'd have to give some thought to potential race
> > conditions, though. Usually pack-refs isn't modifying
> > the ref, so it can just write out the value to the
> > packed-refs file, then delete the loose ref if nobody
> > has touched it since we wrote. But here we're combining
> > it with a modification, so I suspect there would be a
> > race with another process trying to modify it.
> 
> Yeah, I thought about that.  Could you just right the new 
> packed-ref file with the new refs and the old refs which 
> were in the file already, then just delete any loose refs 
> which were ones which were just added by this operation, 
> only if they have not changed?
> 
> This way, if someone else modifies one of the same refs, 
> they could just win?

I spent a bit of time thinking on this and trying to come up with an
exact sequence where we could lose the race, but I don't think we can
lose data.  Either:

  1. The loose ref is not changed afterwards, and we delete it, making
     our packed version the official one.

  2. The loose ref is changed, and we leave it, which means our packed
     version is not interesting to anybody (the loose version takes
     precedence). We have lost the race, and must consider our write a
     failure.

It's OK to fail in (2); that is no different than the regular loose
case. And likewise, it's worth it to look at the other writer.

They might see our packed-refs file in place before we have a chance to
modify the loose ref. But that's OK, because they must double-check the
existence of the loose ref, and it will still be there. So they will
take that as the real value and ignore the packed value.

All of that is more or less the same set of rules that make "git
pack-refs" work at all. The only novel situation we are introducing here
is that we might be writing a packed-ref without having an existing
loose ref at all (whereas usually we would be packing an existing ref,
either loose or packed). But I don't think it makes a difference.

I might be wrong, though. In the course of writing this email, I kept
thinking "wait, but here's a race", and then when I worked out the
details, it was OK. So either I was not clever enough to find a race, or
I am not clever enough to realize that there is not one. :)

-Peff
