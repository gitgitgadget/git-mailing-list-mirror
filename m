From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [BUG] git-new-workdir doesn't understand packed refs
Date: Wed, 18 Apr 2007 23:08:20 +0200
Message-ID: <20070418210819.GG5913@xp.machine.xx>
References: <Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk> <20070418055215.GA32634@xp.machine.xx> <7v7isajfl1.fsf@assigned-by-dhcp.cox.net> <20070418081122.GB32634@xp.machine.xx> <Pine.LNX.4.64.0704181251040.19261@reaper.quantumfyre.co.uk> <7vfy6xird9.fsf@assigned-by-dhcp.cox.net> <20070418174350.GB5913@xp.machine.xx> <7vlkgph7i0.fsf@assigned-by-dhcp.cox.net> <20070418183156.GF5913@xp.machine.xx> <7v647th6cv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 23:08:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeHO4-0000E9-Dc
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 23:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbXDRVIU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 17:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbXDRVIU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 17:08:20 -0400
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:54311 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S964935AbXDRVIT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 17:08:19 -0400
Received: (qmail 11605 invoked by uid 0); 18 Apr 2007 21:08:17 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 18 Apr 2007 21:08:17 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v647th6cv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44949>

On Wed, Apr 18, 2007 at 11:42:24AM -0700, Junio C Hamano wrote:
> Peter Baumann <waste.manager@gmx.de> writes:
> 
> <ot>
> 
> Getting more and more annoyed by your stupid Mail-Followup-To...
> I do *not* want to bother Julian with a message that points out
> a flaw (in my opinion) in YOUR reasoning but you are forcing me
> to send my message that way, which I have to waste time
> correcting every time.  Grumble.
> 
> </ot>

Hm. Sorry. I don't understand. I'm just pressing 'g' for group reply in
mutt which should do the right thing; even your mail has a CC to Julian
set so I _really_ don't understand the problem. I addressed him in the
begining because he was the author of git-new-workdir. But please
forgive me if I'm breaking some netiquette rules but I just started to
hang out activly on mailinglists ...

> 
> > On Wed, Apr 18, 2007 at 11:17:43AM -0700, Junio C Hamano wrote:
> >> Peter Baumann <waste.manager@gmx.de> writes:
> >> ...
> >> > I thought about the case where packed-refs is a symlink to another symlink
> >> > and then decided that it's not worth to implement this because a workdir
> >> > should be linked to a _repo_ and not another workdir.
> >> 
> >> That's incredibly weak, as the initial motivation of this patch
> >> is that you did not want to say "you should run gc only in the
> >> _repo_ not in workdir".
> >
> > Yes. That's my motivation and it works right now
> >
> > 	git init a
> > 	<hack, hack, hack,>
> > 	git commit -a
> >
> > 	git-new-workdir a b 	# allowed
> > 	git-new-workdir a c	# allowed
> >
> > 	git-new-workdir b d	# NOT ALLOWED
> 
> But I do not think you are disallowing it; instead you are
> making the same problem appear without telling the user.
> 
> Also, how is the above different from this?
> 
> 	git init a
>         cd a ; git gc ; cd ..	# allowed
> 	git new-workdir a b
> 	cd b ; git gc ; cd ..	# NOT ALLOWED
> 

Sorry, you lost me here. Your above sequence _is_ allowed and that was
just the point of the patch. I lightly tested it that it does the right
thing, so perhaps I'm missing something?

What isn't allowed is the following:

	mkdir a; cd a; git-init; cd ..
	git new-workdir a b
	cd b; git gc ; cd .. # IS ALLOWED
	git new-workdir b c
	cd b; git gc ; cd .. # NOT ALLOWED

Because now you created a new workdir c which doesn't point to a repo,
but only to another _workdir_ b. And only in this case you get a symlink
chain like this:

c/.git/packed-refs -> b/.git/packed-refs -> a/.git/packed-refs

This is even dissallowed by the code in git-new-workdir (Sorry, I just
saw it now; otherwise I wouldn't spend so much time in arguing this)):

# don't link to a workdir
if test -L "$orig_git/.git/config"
then
        die "\"$orig_git\" is a working directory only, please specify" \
                "a complete repository."
fi

> You are saying "you should run workdir only in the _repo_ not in
> workdir".
> 

This sentence doesn't make any sense to me. Did you mean "you should run
gc only ..." ?

> As I already said, certain things work differently between a
> proper repository and a worktree that borrows .git/refs from a
> proper repository, and you always have to know what you are
> doing when you use such a setup.  If your goal is to minimize
> the difference, I do not think it makes much sense to allow gc
> and not allow new-workdir.
> 

I think you missunderstud me. Hopefully the above explanation clears this
missunderstanding. The case I feared (symlink chain of workdirs) is not
allowed in git-new-workdir from the very begining of this script, so
there shouldn't be any problem with the symlink handling in my patch.

> On the other hand, if we admit that things work differently, I
> think erroring out gc or pack-refs when we see .git/packed-refs
> is a symbolic link is much simpler, less error prone and easier
> to explain.
> 

But with my patch it just works! I really tested it again. The link
in b/.git/packed-refs -> a/.git/packed-refs (using the example from above)
isn't broken up and in the new generated packed-refs are stored inside
the repo a (as they should).

-Peter
