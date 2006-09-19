From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Subversion-style incrementing revision numbers
Date: Tue, 19 Sep 2006 18:09:36 -0400
Message-ID: <20060919220936.GA11601@spearce.org>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 00:09:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPnmk-00031E-0o
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWISWJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWISWJm
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:09:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:2244 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751224AbWISWJl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 18:09:41 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GPnmU-00062d-A5; Tue, 19 Sep 2006 18:09:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2C5CB20E48E; Tue, 19 Sep 2006 18:09:37 -0400 (EDT)
To: Joel Dice <dicej@mailsnare.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27296>

Joel Dice <dicej@mailsnare.net> wrote:
> I'm considering adopting Git for a medium-sized project which is currently 
> managed using Subversion.  I've used Git for a few smaller projects 
> already, and the thing I've missed most from Subversion is the convenience 
> of incrementing revision numbers.  The following is a proposal to add this 
> feature to Git.

I can't say I miss that particular feature.  Abbrevations of
SHA1 IDs tend to work very well for the projects I use Git on;
6-8 characters is easily more than enough to uniquely identify
a revision.  Heck half the time even 4 hex characters is enough.
 
> Rationale:
> 
> Incrementing revision numbers (IRNs - an acronym I just made up) are 
> useful in that they can be treated as auto-generated tags which are easier 
> to remember and communicate than SHA hashes, yet do not require extra 
> effort to create like real tags.  Also, they have the advantage of being 
> chronologically ordered, so if I assert that a bug was fixed in revision 
> 42 of a shared repository, everyone may assume that revision 45 has that 
> fix as well.

But with respect to what branch?

Branches in a Git repository are very common:

    o------o-o-o-o-o-o---  B1
   /
  -o--o--o-----o--------o  B2

Assuming the branch point on the left was r60, what is the latest
commit on B1?  On B2?  What about if I merge B1 and B2 together?

Or are you proposing that the commits are ordered by the time that
they arrive into the repository?

But even if that's the case lets say I fix the bug on B1 in r42
but a commit on B2 gets assigned r45.  The bug isn't fixed in r45;
not unless B1 was merged into B2 in r43, r44 or r45. But there's
no way to know that from just an IRN.

I fail to see how IRNs simplify commit naming or determining where
a feature or bug fix is within the branching structure.
 
> A simple, efficient implementation of this feature would be based on a 
> single file, $GIT_DIR/history, which would contain a newline-delimited 
> list of SHA commit IDs in chronological order, oldest first.  The current 
> repository IRN would be calculated as the size of that file divided by the 
> SHA+newline length, and the commit ID of any IRN could be determined by 
> seeking to the correct offset in that file.  Every commit would cause a 
> new line to be appended to the history file with that commit's ID. 
> Finally, a history file could be generated for an existing repository by 
> serializing the commit history based on chronological order.

How about just using bare tags under the namespace 'refs/tags/r/'?
With the new packed refs implemention these would cost you a tiny
amount of overhead over what you propose (due to the ref name also
being stored) but its already implemented and does the job just
as well.

-- 
Shawn.
