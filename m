From: Jeff King <peff@peff.net>
Subject: Re: another packed-refs race
Date: Tue, 7 May 2013 00:44:56 -0400
Message-ID: <20130507044456.GA29757@sigill.intra.peff.net>
References: <20130503083847.GA16542@sigill.intra.peff.net>
 <51879C1C.5000407@alum.mit.edu>
 <20130506184122.GA23568@sigill.intra.peff.net>
 <518883CC.7050609@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 07 06:45:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZZm0-0000hb-7t
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 06:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757587Ab3EGEpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 00:45:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:44516 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757383Ab3EGEo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 00:44:59 -0400
Received: (qmail 20337 invoked by uid 102); 7 May 2013 04:45:20 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 23:45:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2013 00:44:56 -0400
Content-Disposition: inline
In-Reply-To: <518883CC.7050609@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223544>

On Tue, May 07, 2013 at 06:32:12AM +0200, Michael Haggerty wrote:

> Another potential problem caused by the non-atomicity of loose reference
> reading could be to confuse reachability tests if process 1 is reading
> loose references while process 2 is renaming a reference:
> 
> 1. Process 1 looks for refs/heads/aaaaa and finds it missing.
> 
> 2. Process 2 renames zzzzz -> aaaaa
> 
> 3. Process 1 looks for refs/heads/zzzzz and finds it missing.
> 
> Process 2 would think that any objects pointed to by aaaaa (formerly
> zzzzz) are unreachable.  This would be unfortunate if it is doing an
> upload-pack and very bad if it is doing a gc.  I wonder if this could be
> a problem in practice?  (Gee, wouldn't it be nice to keep reflogs for
> deleted refs? :-) )

Ugh. Yeah, that is definitely a possible race, and it could be quite
disastrous for prune.

I am really starting to think that we need a pluggable refs
architecture, and that busy servers can use something like sqlite to
keep the ref storage. That would require bumping repositoryformatversion,
of course, but it would be OK for a server accessible only by git
protocols.

I also wonder if we can spend extra time to get more reliable results
for prune, like checking refs, coming up with a prune list, and then
checking again. I have a feeling it's a 2-generals sort of problem where
we can always miss a ref that keeps bouncing around, but we could bound
the probability. I haven't thought that hard about it. Perhaps this will
give us something to talk about on Thursday. :)

> > My proposal above gets rid of the need to invalidate the loose refs
> > cache, so we can ignore that complexity.
> 
> The same concern applies to invalidating the packed-ref cache, which you
> still want to do.

True. In theory a call to resolve_ref can invalidate it, so any call
from inside a for_each_ref callback would be suspect.

> * Preloading the whole tree of loose references before starting an
> iteration.  As I recall, this was a performance *win*.  It was on my
> to-do list of things to pursue when I have some free time (ha, ha).  I
> mostly wanted to check first that there are not callers who abort the
> iteration soon after starting it.  For example, imagine a caller who
> tries to determine "are there any tags at all" by iterating over
> "refs/tags" with a callback that just returns 1; such a caller would
> suffer the cost of reading all of the loose references in "refs/tags".

Well, you can measure my patches, because that's what they do. :) I
didn't really consider an early termination from the iteration.
Certainly something like:

  git for-each-ref refs/tags | head -1

would take longer. Though if you have that many refs that the latency is
a big problem, you should probably consider packing them (it can't
possibly bite you with a race condition, right?).

-Peff
