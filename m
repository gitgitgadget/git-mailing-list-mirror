From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [BUG] git-new-workdir doesn't understand packed refs
Date: Wed, 18 Apr 2007 19:43:50 +0200
Message-ID: <20070418174350.GB5913@xp.machine.xx>
References: <20070417161720.GA3930@xp.machine.xx> <Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk> <20070418055215.GA32634@xp.machine.xx> <7v7isajfl1.fsf@assigned-by-dhcp.cox.net> <20070418081122.GB32634@xp.machine.xx> <Pine.LNX.4.64.0704181251040.19261@reaper.quantumfyre.co.uk> <7vfy6xird9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 19:44:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeECQ-0000zQ-Ct
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 19:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992943AbXDRRnu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 13:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992947AbXDRRnu
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 13:43:50 -0400
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:54260 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S2992943AbXDRRnt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 13:43:49 -0400
Received: (qmail 10302 invoked by uid 0); 18 Apr 2007 17:43:47 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 18 Apr 2007 17:43:47 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vfy6xird9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44919>

On Wed, Apr 18, 2007 at 09:23:14AM -0700, Junio C Hamano wrote:
> Julian Phillips <julian@quantumfyre.co.uk> writes:
> 
> >>>  (1) We could by convention declare a worktree whose .git/refs
> >>>      is a symlink, and have git-gc and friends check for it, and
> >>>      either refuse to run or automatically chdir and run there.
> >>>
> >>>      If we were to do this, we probably should check more than
> >>>      just .git/refs but some other symlinks under .git/ as well.
> >>>
> >>>  (2) We could dereference .git/packed-refs, when it is a
> >>>      symlink, by hand, just like we dereference a symlink HEAD
> >>>      by hand (see resolve_ref() in refs.c), and run the
> >>>      creat-to-temp-and-then-rename sequence to update the real
> >>>      file that is pointed at by it.
> >>>
> >>
> >> Its not all the clear which one is the best, but (2) sounds as the most
> >> promosing aproach. Hopefully, I'll have time to cook up a patch this
> >> evening.
> >
> > Personally I think (1) might be slightly better, in the refuse to run
> > form.  gc is a repository operation, not a working directory one - and
> > by refusing to run in a workdir this is made clear.  You could print
> > out a message that includes the location of the actual repo to be more
> > friendly though.
> 
> I've seen Peter's patch that attempts to do (2), and I think
> that probably is a right direction.  A worktree that borrows a
> repository from another worktree is trying to allow you to do
> as many things you would normally do in the original worktree,
> with a caveat: certain things are less safe and/or confusing and
> you must know what you are doing if you use such a setting.
> 
> > But whatever solution you go for, you can't use _any_ workdir that
> > points at a repo that is having gc run on, either directly or
> > indirectly, without risky odd behaviour.
> 
> And I think the above is just one of certain things that are
> less safe (one "confusing" is that working on the same branch
> would result in gremlin updates).  
> 
> There still is an issue of what to do if the .git/packed-refs is
> a symlink to a symlink.  Peter's patch does a wrong thing, by
> creat-then-rename overwriting the symlinked target; at least we
> should detect that case and error out, I think.
> 
> Recursively dereferencing the symbolic link by hand to a limit
> to avoid infinite recursion (error out when we reach the limit)
> would be a more elaborate solution that probably is the right
> thing to do.
>
I thought about the case where packed-refs is a symlink to another symlink
and then decided that it's not worth to implement this because a workdir
should be linked to a _repo_ and not another workdir.

-Peter
