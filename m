From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 11:57:40 -0700
Message-ID: <20090520185740.GP30527@spearce.org>
References: <4A136C40.6020808@workspacewhiz.com> <alpine.LFD.2.00.0905192300070.3906@xanadu.home> <20090520032139.GB10212@coredump.intra.peff.net> <alpine.LFD.2.00.0905192328310.3906@xanadu.home> <025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com> <alpine.LFD.2.00.0905200853010.3906@xanadu.home> <20090520141709.GO30527@spearce.org> <7vab57zmd8.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0905201406280.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 20 20:57:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6qz9-0000Lm-In
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 20:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483AbZETS5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 14:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755321AbZETS5k
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 14:57:40 -0400
Received: from george.spearce.org ([209.20.77.23]:36079 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754955AbZETS5j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 14:57:39 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D0722381FE; Wed, 20 May 2009 18:57:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0905201406280.3906@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119631>

Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 20 May 2009, Junio C Hamano wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> > 
> > > You did say "uncommitted entry causes reflog append", so in Peff's
> > > original example of "git add a; vi a; git add a", we should be
> > > creating a reflog entry for that first added state, which is clearly
> > > not a disagreement.
> > >
> > > FWIW, I think this is a great idea, but lack the time to code it
> > > myself, otherwise I probably would start hacking on it right now.
> > 
> > The devil's in the details.  There are at least four things you would need
> > to design before start hacking.
> > 
> >  (0) Do you want this to apply only to Porcelains, or do you want to use
> >      this for plumbing operations as well?
> 
> Depends if current plumbing already takes care of reflogs for normal 
> operations.

git update-ref and git symbolic-ref, both plumbing, update the
reflog automatically.

Why?  Because that was the best way to ensure we always caught the
change, so we didn't miss updates and have a missing but important
state.

However, git rebase was moved from operating on its branch to work
on detached HEAD to avoid polluting the branch reflog with all of
the intermediate states.  So, here is a case where porcelain had to
be changed after the fact to work around the log-by-default nature
of the plumbing.
 
> >  (2) Enumerate the operations that falls into the category you decided in
> >      the above question.  For example, "git apply --index" and "git apply
> >      --cached" would fall into the same category as "git add".  If you
> >      cover plumbing, you would also need to cover "git update-index".
> 
> Plumbing should probably have the mechanism to create those trash 
> reflogs if desired, but not active by default.  Plumbing is normally for 
> scripts, and once a script is debugged it shouldn't discard data by 
> mistake.  Let's not forget that this is a feature for mistake inducing 
> humans.

git gui calls plumbing.  It uses git update-index directly.  IMHO,
git gui is porcelain, and wants this log, if its available.  But,
by the same token, git filter-branch is porcelain, and probably
does *not* want this logging on the index updates it makes.

So, if its off by default, we really need a way to allow git gui
to force it on.

But... given that it is a safety measure, I would prefer to make it
on by default, and permit scripts to disable it, and update tools
like git filter-branch to disable it, because that fits with our
other rules to try and err on the side of caution for the user's
data when given the choice between raw speed and some minor safety.
(E.g. we fsync objects to disk for safety, not because its fast.)
 
> >  (3) What should happen when you cannot write the index out as a tree?  I
> >      think it is easier to make mistakes during a conflicted merge
> >      resolution than during a straight linear development of your own, and
> >      one of the cases that would benefit most would be that you have
> >      resolved a path to your satisfaction but then later you screw up
> >      while resolving some other paths, losing an earlier resolution.
> 
> This one is tricky.  Maybe storing two reflog entries corresponding to 
> the unresolved stages?

Yea, and as was pointed out, git stash doesn't support this, but
it probably should be able to do it, assuming the index could write
out 3 (or maybe 4) trees in this case, one for each stage.

-- 
Shawn.
