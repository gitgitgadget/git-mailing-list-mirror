From: Junio C Hamano <junkio@cox.net>
Subject: Re: Notes on supporting Git operations in/on partial Working Directories
Date: Thu, 14 Sep 2006 19:43:16 -0700
Message-ID: <7v8xkl26kb.fsf@assigned-by-dhcp.cox.net>
References: <4509A7EC.9090805@gmail.com>
	<7vu03a2po8.fsf@assigned-by-dhcp.cox.net> <4509B954.60101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 04:43:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO3g0-0005Fp-CZ
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 04:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWIOCnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 22:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWIOCnU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 22:43:20 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:9136 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751466AbWIOCnT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 22:43:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060915024319.VJAM6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Sep 2006 22:43:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NSj61V00K1kojtg0000000
	Thu, 14 Sep 2006 22:43:08 -0400
To: gitzilla@gmail.com
In-Reply-To: <4509B954.60101@gmail.com> (A. Large Angry's message of "Thu, 14
	Sep 2006 13:19:32 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27055>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Junio C Hamano wrote:
>> A Large Angry SCM <gitzilla@gmail.com> writes:
> ...
>>
>> While this may be a good start, you need a lot more than this if
>> you want to do (1) and (2):
>>
>> The tree object contained by a commit is by definition a full
>> tree snapshot, so if you want to do a WD_Prefix, you somehow
>> need a way to come up with the final tree that is a combination
>> of what write-tree would write out from such a partial index
>> (i.e. an index that describes only a subdirectory) and the rest
>> of the tree from the current HEAD.  I think you can more or less
>> do this change to Porcelain using today's git core.  The
>> sequence to emulate it with the today's git would be:
>
> I think you misunderstood, the index file would list all of the tree
> entries of the the checked out commit, same as the current index, but
> would flag the entries that are actually present in the working
> directory. The WD_Prefix is to identify which index entries _can not_
> be part of the working directory, and where the working directory fits
> in the full index. That way, all the information needed by the top
> level write-tree is still in the index and the cache-tree extension.

Ah indeed.  That makes it more palatable ;-).

Having said that, I do not necessarily agree that highly modular
projects would want to put everything in one git repository and
track everything as a whole unit.

The primary audience of git, the kernel project, is reasonably
modular (although Andrew seems to be suffering from subsystem
maintainers touching overlapping areas these days and says it is
rather unusual), and is a non-trivial size, yet it has
everything under one umbrella.  The model makes sense in that
project, since the core developers need to occasionally change
an internal API wholesale across the tree.  The people at fringe
who work only on limited part of the system (e.g. one particular
filesystem implementation), on the other hand, may not care what
happens in the other parts (e.g. random device drivers that
should not interact directly with the filesystem implementation
in question) of the system most of the time, but they do have to
care if the layer closer to the core that their work depends on
changes (e.g. a VFS layer update changes the rule filesystems
must play under), so having to check out the full kernel tree
while they usually work only on one part of it often cumbersome
but sometimes absolutely necessary so it is tolerated.

Everybody is forced to work on the same codebase and merge the
whole tree as a unit, which might inconvenience the people
really at the fringe (e.g. driver writers), but being able to
make sure everything is in sync is a good thing to the core
developers, and that benefit outweighs the convenience of fringe
people (also the core people are who gets to pick the tool they
use ;-).

In the kernel case, out-of-tree driver people have a choice to
build out of tree against just kernel headers as modlues.
Nobody (including git) gives mechanical support to enforce that
this version of the out-of-tree driver must be used only with
such and such main tree, but build procedure and INSTALL
documents of such a driver usually take care of that integration
issues.

I suspect most highly modular projects are run that way, not
just from the version control point of view, but simply because
of people interaction issues.  Nobody can be on top of all
possible interface details between many modular pieces of a
truly huge project, so there would be clean separation of parts
and narrow definition of how they mesh together (after all, that
is what being highly modular is all about).  And in such a case,
subsystems can be (and I'd even claim they had better be)
version controlled more or less independently with each other,
with certain version dependencies, such as "libfoo subsystem is
used by all of our programs A, B, ..., Z, but recent libfoo 1.29
release added some feature to support enhancement in version 2.4
of program Z.  So libfoo 1.29 or later is required if you are
building the latest tip of program Z, but everybody else can
stay at 1.28 if updating libfoo is not convenient, oh by the way
1.30 has a thinko that broke what is used heavily only by
program A, so if you are working on program A use libfoo 1.30 or
later, or stay at libfoo 1.28."  And there would be tons of tiny
commits between these point releases.

My point is that while there will always be _some_ version
synchronization requirements between subcomponents of such a
huge highly modular project, it is a lot looser than tracking
each and every change in the entire tree as a whole, like git's
commit does.  The model of throwing all subcomponents in a
single repository and trying to track everything as a whole may
not match the real requirement of such a project.

In other words, when somebody adds a line in a file in a tiny
corner of libfoo to fix a typo in the comment and makes a
commit, that should not have to necessarily mean the version
number of the project as a whole needs to be bumped up.  It is
my understanding that people who house collection of related
projects in subversion gets this wrong, because subversion makes
it too eacy to propagate the revision number increment up to the
root level when you update something in a subtree.  It may be a
cheap operation from the storage point of view (incrementing the
revision number stored in a few tree nodes near the root), but
it does not change the fact that it changes the revision of the
whole project and affects other parts of projects that is not
affected by the particular change at all (it is not Subversion's
fault, but more of a fault of people who put everything in one
repository).  You could manage the versions that way, but you do
not have to.  And if it gets in the way of things you would want
to do, maybe you shouldn't.

I think what truly huge but highly modular projects need is a
good support to lay-out check-outs from multiple subprojects,
each of which is managed in its own repository but has loose
(looser than the level of individual commits) version
dependency.  That would need to solve three issues: (1) the
right versions from many repositories need to be checked out in
correct locations for a build, (2) after building and testing to
make sure they work together as a whole, these specific versions
from the subcomponent repositories need to be tagged to mark a
release, and (3) maybe a single large tarball that contains all
subprojects' checkout can be made easily.

So the issue may not be partial repository support, but support
for managing multiple projects.
