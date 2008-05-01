From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: Making submodules easier to work with
Date: Thu, 1 May 2008 20:38:37 +0200
Message-ID: <20080501183837.GA4772@pvv.org>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com> <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness> <BC221793-3FB5-4249-8E8D-819C1B413592@gmail.com> <32541b130804301331o70310831raf71db7cbb51d507@mail.gmail.com> <EFEF26F9-D5D6-4BAC-9A8F-6D96E45AFAF7@gmail.com> <32541b130804301448i537a0b98ta01cecc472e20aec@mail.gmail.com> <1209594215.25663.864.camel@work.sfbay.sun.com> <32541b130804301528k70ae2f7eq5229c0b4bb1d3788@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roman Shaposhnik <rvs@sun.com>, Tim Harper <timcharper@gmail.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 21:26:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JreQ5-00072O-5z
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 21:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119AbYEATZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 15:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbYEATZ3
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 15:25:29 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:42800 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbYEATZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 15:25:28 -0400
X-Greylist: delayed 2806 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 May 2008 15:25:27 EDT
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1Jrdfx-0002aU-Dc; Thu, 01 May 2008 20:38:37 +0200
Content-Disposition: inline
In-Reply-To: <32541b130804301528k70ae2f7eq5229c0b4bb1d3788@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80935>

On Wed, Apr 30, 2008 at 06:28:00PM -0400, Avery Pennarun wrote:
> On 4/30/08, Roman Shaposhnik <rvs@sun.com> wrote:
> > On Wed, 2008-04-30 at 17:48 -0400, Avery Pennarun wrote:
> >  > It would be awesome if you could turn the fancy behaviour of this
> >  > bundle into patches to git-submodule, for example, and then have your
> >  > textmate macros call the modified git-submodule.  It might be a bit of
> >  > an uphill battle to get the patches accepted into the release, but I
> >  > think it's worth the effort, as git-submodule in its current state is
> >  > just a non-starter for my group at least.
> >
> > Doesn't the fact that the workflows around submodules tend to differ so
> >  much call for different incarnations of git-submodule? IOW, wouldn't
> >  it be ok to have an alternative to git-submodule somewhere in contrib?
> 
> This would be okay with me.  git-submodule itself doesn't seem to do
> anything very complex.  I would be happy to help contribute to such a
> thing, as my group needs it rather desperately.

Where do we want to go with submodules?

Today, submodules seem to be a "read-only" implementation of the
supermodule. By that I mean that it is (only?) suited for creating a
supermodule that consists of independently released submodules, where
all development happens in the submodules, and you sometimes update
the supermodule to refer to a new version of a submodule.

What I've tried to achieve with submodules is a bit different: I want
most development to happen in the supermodule _as if_ the submodules
were part of the supermodule. There are two reasons for not doing it
with one big module: Total size can be a bit too big, but most
importantly, some submodules are shared between different super
modules and there is a certain level of synchronizing. Does this match
your scenarios in any way?

Simplified but realistic scenario [*]:

Supermodule "crawler" has some native code, and uses submodule "os-lib".
Supermodule "indexer" has some native code, and uses submodule "os-lib".

One group works on "crawler" and releases a new crawler every 3 months.
Another group works on "indexer" and releases a new indexer every 2 weeks.

The guy who wrote "os-lib" quit 2 years ago, and no one really
maintains it. Once a year or so someone might try to unify the
"os-lib" releases (so it should be POSSIBLE, just not the norm).


What I would like: People should be able to work on "crawler" as if it
was a single git repository, in particular this means:

o Branching "crawler" means branching "os-lib"
o You can send a patch that contains changes both to "crawler" and "os-lib"
  and get it applied in a resonable way as ONE modification (and git-am
  would do the right thing)
o Merging branch a and branch b in "crawler" also merges the matching
  branches a and b in "os-lib".
o Pushing the supermodule also pushes the submodules

The branch names in "os-lib" can (and probably should) be mangled, so
they are a combination of the supermodule and the branch
name. E.g. something like crawler::branch, crawler/branch, or even
{crawler}.branch. (Is there a character that is currently not allowed in
branch names that can be used as an escape?)

Some lose implementation ideas: (code would be better, I know):

- Enable new behaviour with "git subdirectory" instead of "git submodule",
  and let "git submodule" keep the old behaviour.
- subdirectories get the following magic additions:
  - branching in parent creates {parent}.<branch> in subdirectories
  - merging branches in parent merges the corresponding {parent}.branches
    in subdirectories
  - pushing a parent also pushes the subdirectories
  - changing the parent to something that does not contain the subdirectory
    is only allowed if the subdirectory is "clean" (no uncommitted changes).


[*] In reality: there are 300+ submodules, in all states from
"actively maintained" to "last person who understood the code left 10
years ago". There are maybe 5 or 10 supermodules.

- Finn Arne
