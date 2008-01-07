From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: RFC/RFH submodule handling in big setups
Date: Mon, 7 Jan 2008 21:59:05 +0100
Message-ID: <20080107205905.GB19728@pvv.org>
References: <20080107102327.GA12427@pvv.org> <20080107200756.GA20892@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Jan 07 21:59:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBz4K-0006Ed-GI
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 21:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbYAGU7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 15:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753437AbYAGU7I
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 15:59:08 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:32948 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbYAGU7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 15:59:07 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1JBz3p-0000F5-Qe; Mon, 07 Jan 2008 21:59:05 +0100
Content-Disposition: inline
In-Reply-To: <20080107200756.GA20892@efreet.light.src>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69805>

On Mon, Jan 07, 2008 at 09:07:56PM +0100, Jan Hudec wrote:
> On Mon, Jan 07, 2008 at 11:23:27 +0100, Finn Arne Gangstad wrote:
> > 3. each time you push a submodule, do a merge ours to a
> >    "internal-submodule-tracking" branch, and push to that. Something
> >    like this in other words:
> > 
> >      git fetch origin internal-submodule-tracking
> >      git merge -s ours origin/internal-submodule-tracking
> >      git push origin internal-submodule-tracking
> >      git reset --hard HEAD^1
> > 
> >    Issue: feels wrong somehow?
> 
> Only one thing feels wrong here -- the merge -s ours. For one thing, the
> commit is probably descendant of what was in the internal-submodule-tracking
> branch (the branch name should actually have product2 in it's name).
> If it is not, you should not artificially make it so, but rewind the branch.

The idea of the branch is to not have to make thousands of tags as
time passes, just to have a branch that refers to all the commits that
the supermodule refers to in the submodule.

The internal-submodule-tracking branch should look like this:

        / ... etc
       m
      / \
     m   o-commit 3  
    / \
   m   o-commit 2
  / \
 .   o-commit 1

Where all the "m" commits are just dummy merge commits, the contents
are of no consequence (hence the "merge -s ours" that should always
silently go through). commit 1, 2 and 3, ... are the interesting ones,
they are the sha1s the supermodule refers to in the submodule. They
may or may not have any relationship to eachother.  If they _do_ have
a realtionship to eachother, this will be tracked in some other branch
in the submodule.

So the purpose of the internal-submodule-tracking branch is: Have a
branch to push to (you cannot just push a sha1 to nowhere), have
something that refers to the sha1 so that it will not be pruned away,
and have something that refers to the sha1 so it will actually be
_fetched_ by git fetch.

> But as Junio already told you, you should really manage the subproject like
> a project (because it is a project), so the change should get to a topic
> branch where the other superprojects can look at the change and decide
> whether they want it or not.

See another mail I wote, I don't want to manage the subproject like a
separate project (it isn't).

- Finn Arne
