From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Keeping unreachable objects in a separate pack instead of
 loose?
Date: Mon, 11 Jun 2012 13:27:32 -0400
Message-ID: <20120611172732.GB16086@thunk.org>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 19:28:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se8PF-0000DQ-IF
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 19:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476Ab2FKR1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 13:27:52 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:49098 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942Ab2FKR1v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 13:27:51 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1Se8P1-0003SR-UO; Mon, 11 Jun 2012 17:27:44 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1Se8Oq-00054R-La; Mon, 11 Jun 2012 13:27:32 -0400
Content-Disposition: inline
In-Reply-To: <20120611160824.GB12773@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199681>

On Mon, Jun 11, 2012 at 12:08:24PM -0400, Jeff King wrote:
> On Mon, Jun 11, 2012 at 11:31:03AM -0400, Ted Ts'o wrote:
> 
> > I'm currently using 1.7.10.2.552.gaa3bb87, and a "git gc" still kicked
> > loose a little over 4.5 megabytes of loose objects were not pruned via
> > "git prune" (since they hadn't yet expired).  These loose objects
> > could be stored in a 244k pack file.
> 
> Out of curiosity, what is the size of the whole repo? If it's a 500M
> kernel repository, then 4.5M is not all _that_ worrisome. Not that it
> could not be better, or that it's not worth addressing (since there are
> corner cases that behave way worse). But it gives a sense of the urgency
> of the problem, if that is the scope of the issue for average use.

It' my e2fsprogs development repo.  I have my "base" repo, which is
what has been pushed out to the public (including a rewinding pu
branch).  The total size of that repo is a little over 15 megs:

<tytso@tytso-glaptop.cam.corp.google.com> {/usr/projects/e2fsprogs/e2fsprogs}  [maint]
899% ls ../base/objects/pack/
total 16156
  908 pack-6964a1516433f16e43dcdf4fcec1996052099f31.idx
15248 pack-6964a1516433f16e43dcdf4fcec1996052099f31.pack

I then have my development repo, which uses a
.git/objects/info/alternates pointing at the bare "base" repo, so the
only thing in this repo are my private development branches, and other
things that haven't been pushed for public consumption.

<tytso@tytso-glaptop.cam.corp.google.com> {/usr/projects/e2fsprogs/e2fsprogs}  [maint]
900% ls .git/objects/pack/
total 1048
 28 5a486e6c2156109f7dfc725b36a201c10652803d.idx    28 pack-7b2a9cccab669338f61a681e34c39362976fb5de.idx
224 5a486e6c2156109f7dfc725b36a201c10652803d.pack  768 pack-7b2a9cccab669338f61a681e34c39362976fb5de.pack

The 4.5 megabytes of loose objects packed down to a 224k "cruft" repo,
and 768k worth of private development objects.

So depending on how you would want to do the comparison, probably the
fairest thing to say is that I had a total "good" packs totally about
16 megs, and the loose cruft objects was an additional 4.5 megabytes.

> I don't think that will work, because we will keep repacking the
> unreachable bits into new packs. And the 2-week expiration is based on
> the pack timestamp. So if your "repack -Ad" ends in two packs (the one
> you actually want, and the pack of expired crap), then you would get
> into this cycle:
> 
>   1. You run "git repack -Ad". It makes A.pack, with stuff you want, and
>      B.pack, with unreachable junk. They both get a timestamp of "now".
> 
>   2. A day passes. You run "git repack -Ad" again. It makes C.pack, the
>      new stuff you want, and repacks all of B.pack along with the
>      new expired cruft from A.pack, making D.pack. B.pack can go away.
>      D.pack gets a timestamp of "now".

Hmm, yes.  What we'd really want to do is to make D.pack contain those
items that were are newly unreachable, not including the objects in
B.pack, and keep B.pack around until the expiry window goes by.  But
that's a much more complicated thing, and the proof-of-concept
algorithm I had outlined wouldn't do that.

> I think solving it for good would involve a separate list of per-object
> expiration dates. Obviously we get that easily with loose objects (since
> it is one object per file).

Well, either that or we need to teach git-repack the difference
between packs that are expected to contain good stuff, and packs that
contain cruft, and to not copy "old cruft" to new packs, so the old
pack can finally get nuked 2 weeks (or whatever the expire window
might happen to be) later.

					- Ted
