From: Jeff King <peff@peff.net>
Subject: Re: another packed-refs race
Date: Fri, 3 May 2013 13:28:53 -0400
Message-ID: <20130503172853.GB21715@sigill.intra.peff.net>
References: <20130503083847.GA16542@sigill.intra.peff.net>
 <CALKQrgdHudF1fDLSXzaKfb2kne0B3rC5mM95CJGsLqL_2xemnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri May 03 19:29:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYJn3-0006rB-TY
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 19:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933573Ab3ECR24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 13:28:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:40248 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758925Ab3ECR2z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 13:28:55 -0400
Received: (qmail 5806 invoked by uid 102); 3 May 2013 17:29:13 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 May 2013 12:29:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 May 2013 13:28:53 -0400
Content-Disposition: inline
In-Reply-To: <CALKQrgdHudF1fDLSXzaKfb2kne0B3rC5mM95CJGsLqL_2xemnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223315>

On Fri, May 03, 2013 at 11:26:11AM +0200, Johan Herland wrote:

> You don't really need to be sure that packed-refs is up-to-date. You
> only need to make sure that don't rely on lazily loading loose refs
> _after_ you have loaded packed-refs.

True. As long as you load them both together, and always make sure you
do loose first, you'd be fine. But I think there will be corner cases
where you have loaded _part_ of the loose ref namespace. I think part of
the point of Michael's ref work is that if you call "for_each_tag_ref",
we would not waste time loading refs/remotes/ at all. If you then follow
that with a call to "for_each_ref", you would want to re-use the cached
work from traversing refs/tags/, and then traverse refs/remotes/. You
know that your cached packed-refs is good with respect to refs/tags/,
but you don't with respect to refs/remotes.

> The following solution might work in both the resolve-a-single-ref and
> enumerating-refs case:
> 
> 0. Look for ref already cached in memory. If found, OK.
> 
> 1. Look for loose ref. If found, OK.
> 
> 2. If not found, load all loose refs and packed-refs from disk (in
> that order), and store in memory for remainder of this process. Never
> reload packed-refs from disk (unless you also reload all loose refs
> first).

I think that would be correct (modulo that step 1 cannot happen for
enumeration). But we would like to avoid loading all loose refs if we
can. Especially on a cold cache, it can be quite slow, and you may not
even care about those refs for the current operation (I do not recall
the exact original motivation for the lazy loading, but it was something
along those lines).

> My rationale for this approach is that if you have a packed-refs file,
> you will likely have fewer loose refs, so loading all of them in
> addition to the pack-refs file won't be that expensive. (Conversely,
> if you do have a lot of loose refs, you're more likely to hit #1, and
> not have to load all refs.)
> 
> That said, my intuition on the number of loose vs. packed refs, or the
> relative cost of reading all loose refs might be off here...

I don't think that is necessarily true about the number of loose refs.
In a busy repository, you may have many loose refs that have been
updated.

-Peff
