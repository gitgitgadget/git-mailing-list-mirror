From: Theodore Tso <tytso@mit.edu>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 19:01:10 -0400
Message-ID: <20080823230110.GC18169@mit.edu>
References: <20080822174655.GP23334@one.firstfloor.org> <m37ia8sv49.fsf@localhost.localdomain> <20080823071552.GU23334@one.firstfloor.org> <200808231121.41694.jnareb@gmail.com> <20080823165350.GY23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Sun Aug 24 01:02:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX27f-0000bt-Jx
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 01:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbYHWXBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 19:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754288AbYHWXBQ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 19:01:16 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:39215 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754270AbYHWXBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 19:01:15 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KX26Z-0006BY-Cy; Sat, 23 Aug 2008 19:01:11 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KX26Y-0006tZ-Kc; Sat, 23 Aug 2008 19:01:10 -0400
Content-Disposition: inline
In-Reply-To: <20080823165350.GY23334@one.firstfloor.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93502>

On Sat, Aug 23, 2008 at 06:53:50PM +0200, Andi Kleen wrote:
> > If you are thinking about 'linux-next', it is exception rather than
> > the rule.
> 
> No you're wrong. The majority of Linux trees I have to deal with 
> do it now and then. And I must say I also understand why 
> they want it -- they want a clean history on top of Linus' tree.
> Otherwise there is no chance to find the own changes again
> after a few thousands other merges.

What I don't understand is in what context do you need to deal with
"the majority of Linux trees"?  Sure, the ext4 tree gets rebased all
the time.  But that's because it's a "leaf" tree; it means that people
can't base development trees off of the ext4 tree as a result.  But
then again, that's not what the ext4 git tree is intended for!  It's
like in Java when you declare a class with the 'final' keyword; such
classes can't be subclassed.

The main use of the ext4 git tree is to allow people to more easily
pull changes into their own trees, either for building their own
integration trees, or their own personal private trees.  It's simply a
much more efficient way of applying a large number of patch queues.
So for example, when I build my personal kernel that I use on my
laptops, servers, et. al, I start with ext4 and pull in various
"fixes" branches that I've needed over time to build a useful, stable
kernel.   So I have a personal merge script which does:

git branch -f master linus/master
git checkout master
git merge tp_smapi-0.37
git merge remotes/libata-dev/upstream-fixes
git merge remotes/ibm-acpi/for-upstream/acpi-release
git merge misc-fixes
git merge ext4dev

... and the result is an integration tree that always treet as
throwaway, because I've merged in trees which are indeed throwaway.
If I *do* any development work on this tree, say I cheat and fix some
ext4 bugs on this tree instead of the ext4 branch, I always will go
back to the ext4 branch, and use "git cherry-pick" to move those
changes back to the ext4 tree.

> > First, there isn't just _one_ way to deal with non fast-forward 
> > (rebased) branch; there are many possible workflow wrt rebasing.
> 
> I don't doubt there are a million ways to do it somehow in
> all kinds of convoluted ways. And that's exactly the problem.

There are, but the simpliest way to win (as the movie "Wargames" put
it), is not to play.  Just don't put commits on top of a non-terminal
trees; just use them to pull to create throw-away trees for
building/testing, for integration testing or to build your own
personal kernels.  The only time when you really need to build on top
of others' trees is if you have changes that depend on patches in
another tree, which in practice should happen rarely; and if it does,
you can ask the other maintainer to push the changes to Linus first.

In that case, what you can do is put a placeholder patch in your tree,
with a note in the commit log that this is a placeholder is pending
someone else pushing the equivalent patch to Linus, and once they push
it to Linus, when you do a rebase it will disappear.  In practice,
this happens so rarely that doing this manually with manual
coordination between maintainers about who pushes a patch to Linus
really isn't that big of a deal.

						- Ted
