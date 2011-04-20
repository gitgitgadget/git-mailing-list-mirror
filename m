From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4 issue
Date: Tue, 19 Apr 2011 20:31:00 -0400
Message-ID: <20110420003100.GC28768@arf.padd.com>
References: <BANLkTikeQSqAhm2CwCYBkE74OxPUnA0cOg@mail.gmail.com>
 <BANLkTimmVQAcx7hiQFUBcoAGdvPhktPuMg@mail.gmail.com>
 <BANLkTikDDDtyJB992DFNtvgMrGvbWf=rMw@mail.gmail.com>
 <BANLkTinJecAsXt+5JzscFYEx_ez2q9DioQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arvid Lund <torarvid@gmail.com>, git@vger.kernel.org
To: Michael Horowitz <michael.horowitz@ieee.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 02:31:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCLKL-00009l-AB
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 02:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082Ab1DTAbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 20:31:12 -0400
Received: from honk.padd.com ([74.3.171.149]:32970 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382Ab1DTAbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 20:31:12 -0400
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 659D0F8;
	Tue, 19 Apr 2011 17:31:08 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D3F14319E7; Tue, 19 Apr 2011 20:31:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinJecAsXt+5JzscFYEx_ez2q9DioQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171827>

michael.horowitz@ieee.org wrote on Mon, 18 Apr 2011 23:57 -0400:
> OK, after some digging, I think I have figured out what is going on,
> but I am not sure how to fix it, at least not safely.
> 
> There seem to be several different ways of detecting branches, and I
> am not exactly sure what they are all used for, or why there are so
> many, but the core of the issue I am having is that in importChanges
> when it calls splitFilesIntoBranches, it assumes "self.knownBranches"
> has all the branches, even though it already has the branches from
> "self.p4BranchesInGit".  The exact reason I don't know, but the
> results is splitFilesIntoBranches returns an empty array, and so when
> the code loops over it, it silently does nothing.

I too am confused by the branch handling in git-p4, and have never
used it.  I'd love to rip it all out, along with the confusion,
but know that some people use it with success.

At least it all could use some overhaul and documentation so we
can see what's going on.

> The first fix that would be helpful is to at least report an error if
> it can't find the branches, rather than silently doing nothing.  I am
> not exactly sure why it needs to look in "self.knownBranches", so I
> don't know what the error should report, maybe the error should be
> reported earlier?
> 
> The other issue is how "self.knownBranches" seems to be populated.  It
> looks like form my code path, which decides to "Import from/to
> multiple branches", it tries to detect branches by using "p4
> branches".  Again, this is odd, since I can see it already has the
> names of the branches from "self.p4BranchesInGit".  I am not familiar
> enough with the code (and figuring out Python as I go along) to know
> why.  The problem with using "p4 branches" is those aren't really
> branches, they are aliases to a merge command (integrate in p4 lingo)
> which stores the from and to branch.  The branch in Perforce is really
> just a directory.  Interestingly enough, it seems this logic also
> attempts to detect new branches and automatically import them, but
> ironically this doesn't actually work for me.

This is my understanding of "p4 branch" as well.  At our site,
the list of p4 branches does not at all correspond to what we
think of as code development branches in git.  Again, maybe
others use it differently?

We do maintain p4 view lists, but that is kept out-of-band, not
in any p4 mechanism.  These map friendlier short names to a list
of directories in p4 and how to assemble those into a workspace.

> So, the crux of the problem is that "p4 branches" are not necessary to
> have at all.  The reason this suddenly stopped working for me is that
> someone had created one of these branch definitions and I didn't know,
> so it was accidentally working all this time, but only for 2 of the
> branches.  Then the person removed the definition, and it stopped
> working.  Now the workaround is to go and create these things for
> every branch, but considering these are unnecessary and cumbersome to
> create, and the code seems to be able to find the branches already
> from the "self.p4BranchesInGit" anyway, I would like to remove the
> dependency on that logic.
> 
> Now, I could go ahead and hack something that does things differently,
> but since I don't really know the intention of these structures or how
> it might impact elsewhere in the code, I could use some guidance from
> someone who knows this code well.

Vitor uses branches, and his patch that he recommends might be
the work-around you are looking for.

I thought all this branch code was opt-in, so if you fail to say
"--detect-branches", it won't try to auto-detect anything.

But there is maybe another use case in here, which is to
import multiple directories of the depot into _different_
refs/remotes/p4/<branch>.  (I've only ever done one at a
time, and into the default p4/master.)  And now that you
have multiple git-p4 branches, you're stuck with them due to the
login in p4BranchesInGit().  That feature should be handled
independently of the "p4 branch" auto-detection one.

The branch handling needs rework.  You might help by describing
how you want it to work and we can see if this is the same as how
Vitor uses branches.

		-- Pete
