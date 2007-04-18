From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [BUG] git-new-workdir doesn't understand packed refs
Date: Wed, 18 Apr 2007 10:11:22 +0200
Message-ID: <20070418081122.GB32634@xp.machine.xx>
References: <20070417161720.GA3930@xp.machine.xx> <Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk> <20070418055215.GA32634@xp.machine.xx> <7v7isajfl1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 10:11:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He5GB-0002LK-6j
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 10:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933036AbXDRILX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 04:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933040AbXDRILX
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 04:11:23 -0400
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:54163 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S933036AbXDRILW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 04:11:22 -0400
Received: (qmail 6474 invoked by uid 0); 18 Apr 2007 08:11:20 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 18 Apr 2007 08:11:20 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7isajfl1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44871>

On Wed, Apr 18, 2007 at 12:40:10AM -0700, Junio C Hamano wrote:
> Peter Baumann <waste.manager@gmx.de> writes:
> 
> > The problem is, when I created the new workdir, I don't have a file
> > .git/packed-refs, so a new workdir was created with a dangling symlink,
> > e.g.  workdir/.git/packed-refs -> repo/.git/packed-refs (but the last one
> > doesn't exist). As it seems, git gc removes the dangling symlink and
> > replaces it with a file.
> 
> Yes, packed-refs file is creat-to-temp-and-then-rename, and we
> will lose the sharing if it is run in the symlink-shared work
> tree.
> 
> We can do one of two things.  I am not sure which one is better.
> 
>  (0) The effect of 'git gc' by definition in the symlink-shared
>      work tree should be the same as in the original repository
>      as the former is to share all the refspace and object
>      database.  So we _could_ declare that running 'git gc' in
>      symlink-shared work tree is insane and educate people to
>      run that in the original repository.  This is _not_ doing
>      anything.
> 
>  (1) We could by convention declare a worktree whose .git/refs
>      is a symlink, and have git-gc and friends check for it, and
>      either refuse to run or automatically chdir and run there.
> 
>      If we were to do this, we probably should check more than
>      just .git/refs but some other symlinks under .git/ as well.
> 
>  (2) We could dereference .git/packed-refs, when it is a
>      symlink, by hand, just like we dereference a symlink HEAD
>      by hand (see resolve_ref() in refs.c), and run the
>      creat-to-temp-and-then-rename sequence to update the real
>      file that is pointed at by it.
>

Its not all the clear which one is the best, but (2) sounds as the most
promosing aproach. Hopefully, I'll have time to cook up a patch this
evening.

-Peter
