From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git push to a non-bare repository
Date: Sun, 18 Mar 2007 23:47:55 -0400
Message-ID: <20070319034755.GH20658@spearce.org>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <20070319020053.GA11371@thunk.org> <7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net> <20070319022143.GF20658@spearce.org> <20070319024744.GD11371@thunk.org> <20070319025603.GG20658@spearce.org> <20070319033340.GG11371@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 19 04:48:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT8r8-0006Ub-WD
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 04:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965345AbXCSDsD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 23:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965425AbXCSDsD
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 23:48:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49730 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965453AbXCSDsB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 23:48:01 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HT8qX-0008T7-PN; Sun, 18 Mar 2007 23:47:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0D85E20FBAE; Sun, 18 Mar 2007 23:47:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070319033340.GG11371@thunk.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42579>

Theodore Tso <tytso@mit.edu> wrote:
> Ah, so that's controlled by receive.denyNonFastForwards, right?  Cool,
> I missed that.  Thanks!!
> 
> Documentation/config.txt doesn't say it defaults to true, but from
> your comments that is the default?

Ah, my bad, it defaults to false:

  static int deny_non_fast_forwards = 0;

I should have known better, as I run a 1.5.x (aka 'next') server
for a workgroup and I never have that set, but use instead a complex
update hook that decides if a fast-forward is required or not.
 
> > > 	* Only accept the push if there are no locally modified files
> > > 		that would be affected when the working directory is
> > > 		updated to reflect the new HEAD
> > 
> > If git-runstatus exits to indicate the tree is clean (nothing to
> > commit) then a simple `read-tree -m -u HEAD $new` should update
> > the working directory and index, right?
> 
> What git-runstatus will allow me to do is to abort if there are any
> local modifications, regardless of whether or not they would conflict
> with the working tree update.  The key phrase in my criteria was no
> locally modified files "THAT WOULD BE AFFECTED".

  git-diff $old $new | git-apply --index ?

If the patch does not apply, nothing gets updated.  If it does apply,
the index is also updated and stat data updated.

OK, it doesn't quite handle every case, as sometimes a patch will
reject but the internal 3-way merge from xdiff that is called by
merge-recursive will succeed, but this does protect your working
tree and doesn't require making a temporary copy.


Of course another possible approach is to stuff the entire working
directory into a temporary tree, and then merge.  If the merge
doesn't work, you can reset to the temporary tree.  Unfortunately the
working directory is "in flux" during that process... its not atomic.

-- 
Shawn.
