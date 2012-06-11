From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Mon, 11 Jun 2012 12:08:24 -0400
Message-ID: <20120611160824.GB12773@sigill.intra.peff.net>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 11 18:08:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se7AO-0001HZ-Mm
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 18:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558Ab2FKQI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 12:08:28 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50115
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221Ab2FKQI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 12:08:27 -0400
Received: (qmail 4454 invoked by uid 107); 11 Jun 2012 16:08:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 12:08:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 12:08:24 -0400
Content-Disposition: inline
In-Reply-To: <20120611153103.GA16086@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199668>

On Mon, Jun 11, 2012 at 11:31:03AM -0400, Ted Ts'o wrote:

> I'm currently using 1.7.10.2.552.gaa3bb87, and a "git gc" still kicked
> loose a little over 4.5 megabytes of loose objects were not pruned via
> "git prune" (since they hadn't yet expired).  These loose objects
> could be stored in a 244k pack file.

Out of curiosity, what is the size of the whole repo? If it's a 500M
kernel repository, then 4.5M is not all _that_ worrisome. Not that it
could not be better, or that it's not worth addressing (since there are
corner cases that behave way worse). But it gives a sense of the urgency
of the problem, if that is the scope of the issue for average use.

> What I think would make sense is for git pack-objects to have a new
> option which outputs a list of object id's which whould have been
> kicked out as loose objects if it had been given the (undocumented)
> --unpacked-unreachable option.  Then the git-repack shell script (if
> given the -A option) would use that new option instead of
> --unpacked-unreachable, and then using the list created by this new
> option, create another pack which contains all of these
> unreachable-but-not-yet-expired objects.

I don't think that will work, because we will keep repacking the
unreachable bits into new packs. And the 2-week expiration is based on
the pack timestamp. So if your "repack -Ad" ends in two packs (the one
you actually want, and the pack of expired crap), then you would get
into this cycle:

  1. You run "git repack -Ad". It makes A.pack, with stuff you want, and
     B.pack, with unreachable junk. They both get a timestamp of "now".

  2. A day passes. You run "git repack -Ad" again. It makes C.pack, the
     new stuff you want, and repacks all of B.pack along with the
     new expired cruft from A.pack, making D.pack. B.pack can go away.
     D.pack gets a timestamp of "now".

And so on, as long as you repack within the two week window, the objects
from the cruft pack will never get ejected. So you might suggest that
the problem is that in step 2, we repack the items from B. But if you
don't, then you will accumulate a bunch of cruft packs (2 weeks worth),
and those objects won't be delta'd against each other.  It's probably
better than making them all loose, of course (you get chunks of delta'd
objects from each repack, instead of none at all), but it's far from a
full solution to the issue.

I think solving it for good would involve a separate list of per-object
expiration dates. Obviously we get that easily with loose objects (since
it is one object per file).

As a workaround, it might be worth lowering the default pruneExpire from
2 weeks to 1 day or something. It is really about creating safety for
operations in progress (e.g., you write the object, and then are _about_
to add it to the index or update a ref when it gets pruned). I think the
2 weeks number was pulled out of a hat as "absurdly long for an
operation to take", and was never revisited because nobody cared or
complained.

-Peff
