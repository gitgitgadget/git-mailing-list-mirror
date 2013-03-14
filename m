From: Jeff King <peff@peff.net>
Subject: Re: Tag peeling peculiarities
Date: Thu, 14 Mar 2013 09:40:33 -0400
Message-ID: <20130314134032.GA9222@sigill.intra.peff.net>
References: <51409439.5090001@alum.mit.edu>
 <7vwqtb2ood.fsf@alter.siamese.dyndns.org>
 <20130313215800.GA23838@sigill.intra.peff.net>
 <51415516.2070702@alum.mit.edu>
 <20130314052448.GA2300@sigill.intra.peff.net>
 <5141B475.1000707@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 14 14:41:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG8P1-0004yB-Rt
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 14:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757984Ab3CNNkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 09:40:36 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51732 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757965Ab3CNNkf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 09:40:35 -0400
Received: (qmail 16132 invoked by uid 107); 14 Mar 2013 13:42:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Mar 2013 09:42:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2013 09:40:33 -0400
Content-Disposition: inline
In-Reply-To: <5141B475.1000707@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218136>

On Thu, Mar 14, 2013 at 12:28:53PM +0100, Michael Haggerty wrote:

> Perhaps if peel_ref() *were* 100% reliable, we might be able to use it
> to avoid object lookups in some other places.

In theory, some of the many uses of deref_tag could be adopted. However,
we do not always have the refname handy at that point (and I believe
peel_ref's optimization only kicks in during for_each_ref traversals
anyway).

It may still be a win to check the packed-refs file before peeling a
random sha1, as looking up there should be cheaper than actually loading
the object. But right now, the way the optimization is used is always
O(1) to just check the last ref loaded. With your recent ref
refactoring, I think we should be able to do lookups in O(lg n).

> > Another fun fact: upload-pack did not use peel_ref until recently
> > (435c833, in v1.8.1). So while it is tempting to say "well, this was
> > always broken, and nobody cared", it was not really; it is a fairly
> > recent regression in 435c833.
> 
> I didn't realize that; thanks for pointing it out.  Although peel_ref()
> itself has been broken since it was introduced, at least in the sense
> that it gives wrong answers for tags outside of refs/tags, prior to
> 435c833 it appears to only have been used for refs/tags.

Hmph. I coincidentally ran across another problem with 435c833 today.
Try this:

  git init repo &&
  cd repo &&
  git commit --allow-empty -m one &&
  git checkout -b other &&
  git commit --allow-empty -m two &&
  git checkout master &&
  git commit --allow-empty -m three &&
  git pack-refs --all &&
  git.compile clone --no-local --depth=1 --no-single-branch . foo

I get:

  Cloning into 'foo'...
  fatal: (null) is unknown object
  remote: Total 0 (delta 0), reused 0 (delta 0)
  fatal: recursion detected in die handler
  remote: aborting due to possible repository corruption on the remote side.
  fatal: error in sideband demultiplexer

This is not due to the same problem you are describing with peel_refs,
but simply due to the fact that we do not load and parse objects anymore
(which is the point of the optimization). The client feeds these back to
us in the "want" list, and we then feed these objects to the revision
walker, which expects them to be parsed and have their "type" field
actually filled in.

We never noticed before because:

  1. It only happens with --depth, because otherwise we do not do the
     revision walk in-process.

  2. Modern git, when given --depth, will default to --single-branch,
     and so ask only about HEAD, which we do parse. However, older
     versions of git (pre v1.7.10) will ask for much more, and trigger
     the bug.

     I haven't tried yet, but I suspect you may also be able to trigger
     it by asking for "clone --depth=1 -b other".

That's the overtly visible symptom. We also check the type in
ok_to_give_up, so I suspect that can produce subtly wrong results in
some situations. The solution is to actually parse the objects in
question, but I need to figure out when is the optimal time. Obviously
any time we read a "want" line would be enough, but we may be able to
get by with less. OTOH, it probably doesn't matter that much; the point
of the optimization was to avoid touching objects for the ref
advertisement. Once we have a "want", the client really is going to
fetch objects, and accessing them will probably be lost in the noise.

But that's somewhat off-topic for this discussion. I'll look into it
further and try to make a patch later today or tomorrow.

> Your patch looks about right aside from its lack of comments :-).  I was
> going to implement approximately the same thing in a patch series that I
> am working on, but if you prefer then go ahead and submit your patch and
> I will rebase my branch on top of it.

I just meant it as a quick sketch, since you said you were working in
the area. I'm not sure what you are working on. If we don't consider it
an urgent bugfix, I'm just as happy for you to incorporate the idea into
what you are doing.

But if we want to do it as a maint-track fix, I can clean up my patch.
Junio?

-Peff
