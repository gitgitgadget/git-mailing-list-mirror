From: Jeff King <peff@peff.net>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 14:21:57 -0400
Message-ID: <20120522182157.GB20305@sigill.intra.peff.net>
References: <4FB9F92D.8000305@alum.mit.edu>
 <201205211215.14455.mfick@codeaurora.org>
 <20120521194114.GA28358@sigill.intra.peff.net>
 <3b77e2a3-872a-41c1-9a51-0f219a549c04@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue May 22 20:22:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWtih-0008Bo-7Y
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 20:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065Ab2EVSWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 14:22:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51878
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625Ab2EVSWA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 14:22:00 -0400
Received: (qmail 20922 invoked by uid 107); 22 May 2012 18:22:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 14:22:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 14:21:57 -0400
Content-Disposition: inline
In-Reply-To: <3b77e2a3-872a-41c1-9a51-0f219a549c04@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198220>

On Mon, May 21, 2012 at 11:51:16PM -0600, Martin Fick wrote:

> >Anyway, my point is that we don't even have to talk about "reasonable"
> >or "absurd". Git should be fast even on absurd cases, because 99% of
> >the work has already been done, and the last 1% is easy.
> 
> I hope you are right, but I don't quite completely share your
> optimism.  Some of that last 1% is perhaps last exactly because it is
> hard.  More specificaly, I am talking about the git protocol's ref
> advertisement on connection.  This has been considered a known issue
> for many years, yet it has not been fixed because it is hard to fix
> since it requires breaking the protocol in a non backwards compatible
> way.  I would be delighted if you had an easy fix for this rather
> fundamental ref scaling issue? We talked with Junio and Shawn and they
> agreed that it would be reasonable to put forward a proposal which
> does break backwards compatibility. So if there is a chance that there
> still may be another way, I hope it is found before this gets underway
> (no, I don't really expect that to happen),

I may be overly optimistic, but I think I may also have not communicated
the limits to my optimism. Right now, it is the case that some
operations on many refs are just impossibly slow due to poor algorithm
selection in the implementation. I am optimistic that we can drop those
in favor of linear algorithms, or at least O(n lg n) algorithms in most
cases. And that would bring these cases down from "don't do that, it's
broken" to "it works, but obviously it's slower than not having a
zillion refs".

I am not nearly as optimistic about the work scaling better than linear.
That is going to take some clever algorithms, as well as possibly some
design tradeoffs. AFAIK, ref advertisement scales linearly. Which is
probably not acceptable over a slow link, and we could do better.

But in my mind, we are still doing the "make it at least linear" portion
of the process. People aren't really using repos with tons of refs
because they currently perform so poorly, so we don't yet have good data
on how to solve the "better than linear" problems. As the quadratic
problems clear up, hopefully the locations of (and solutions to) those
other problems will be more clear.

-Peff
