From: Theodore Tso <tytso@mit.edu>
Subject: Re: Rollback of git commands
Date: Thu, 29 Nov 2007 03:28:21 -0500
Message-ID: <20071129082821.GC22397@thunk.org>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com> <7vmyszb39s.fsf@gitster.siamese.dyndns.org> <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com> <20071128092234.GA12977@diana.vm.bytemark.co.uk> <9e4733910711280713n6b439866m55bea4824efd959@mail.gmail.com> <Pine.LNX.4.64.0711281600320.5349@iabervon.org> <9e4733910711281542r5b1e5dd9o68ff8565f9000453@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 10:20:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxfZ8-0007kY-Og
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 10:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124AbXK2JTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 04:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755501AbXK2JTy
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 04:19:54 -0500
Received: from thunk.org ([69.25.196.29]:51822 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754823AbXK2JTw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 04:19:52 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IxfjB-0001Li-V1; Thu, 29 Nov 2007 04:30:40 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1Ixel5-00078q-CO; Thu, 29 Nov 2007 03:28:31 -0500
Content-Disposition: inline
In-Reply-To: <9e4733910711281542r5b1e5dd9o68ff8565f9000453@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66521>

On Wed, Nov 28, 2007 at 06:42:56PM -0500, Jon Smirl wrote:
> I'm a patch developer. You need to change the patches continuously to
> track feedback on the lkml type lists. You also have to rebase in
> order to keep tracking head. Other people often work on the same
> things and this triggers merges against the pending patches.

Yeah, I use guilt for projects where I have a patch queue that takes a
while to merge into the mainline, due to quality control or review
guidelines that still need to be met.  Basically the kernel has a
different workflow than git, where each project or developer has a
separate patch queue that is maintained inside git (possibly with
guilt or stgit as helpers) or quilt, instead of a centrally managed pu
branch.  This is I suspect mainly a scaling issue; it's hard to keep a
centrally maintained pu branch because anytime someone wants to make a
change to one of their topic branches, they have to go through the
central maintainer.  The closest analogue to the pu branch is Andrew
Morton's akpm, and he gets grumpy when there are merge conflicts
between the various branches and patch queues that he pulls from in
order to make the -mm tree for integration testing.

> I'd just like for stgit to become a core part of git so that is can be
> made more bullet proof. I'm losing my patch stack every couple of
> weeks. It's normally a "user error" but it is way to easy to make
> these user errors.

I haven't tried using stgit in quite a while mainly because I was
finding it too easy to lose my patch queue.  It was happening to me
*way* to often, and while it sounds like it's gotten better due to
adding more sanity checks --- and when I tried it last, "stg repair"
didn't exist --- it sounds like it is still possible for someone who
typo's a command to get themselves into trouble.  I'm sure it's not an
issue for the stgit developers because they know which commands to
avoid, but if something isn't 100% bulletproof --- I get nervous.

So my solution to this problem is I use guilt.  I *like* the fact that
the primary storage mechanism is actual flat ASCII patch files, since
as a result I've never lost a patch stack --- ASCII patch files are
much more robust.  My way of rebasing a set of patches is very simple;
I just do "guilt pop -a; git merge master; guilt push -a" --- and if
there are any conflicts, then I do a "guilt push -f", fix up the
conflicts, follow it with a "guilt refresh", and then resume pushing
the rest of my patches sing "guilt push -a".  It just works; no muss,
no fuss, no dirty dishes.

Another thing this allows me to do is that it is possible to put the
guilt patch stack itself under git control.  This allows me to go
backwards in time and see what the patch stack looked like n days or n
weeks ago.  A comment in the patch header indicates what version of
the kernel the patch stack was meant against.

For example for ext4 development the guilt patch stack is themselves
stored using git on repo.or.cz, with multiple people having access to
push updates to the patch queue.  Before I start hacking the ext4,
I'll do run the command "(cd .git/patches/ext4dev; git pull") to check
for new updates in the ext4 patch queue, and if it has changed, I'll
do a "guilt pop -a; guilt push -a" to refresh the working directory
and ext4dev branch in my Linux git tree.  When I'm done making
changes, by using commands such as "guilt pop", "guilt refresh",
"guilt pop", et. al., I'll commit changes in the .git/patches/ext4dev
tree, and then push them back to repo.or.cz.  

We also have a system where an automated build/test server checks
every few hours if the patch queue on repo.or.cz has changed, and if
so, it pulls the patch queue, and then builds and tests the patch
queue on a wide variety of hardware architectures (i386, x86_64, ia64,
ppc64, s390, etc.) and sends an e-mail pack to the developers list
telling us which test hardware platforms passed, and which platforms
fail.  Actually, we do two such tests --- one up to the "stable" point
in the patch series, which represents the next set of patches we plan
to push to Linus during the next merge window, and one for the entire
patch queue (stable plus unstable patches that need more work).

It works quite well for us --- and while there are some advanced
feature that stgit has which guilt doesn't, the feeling of safety of
knowing that the ASCII patch files won't get lost, and the ability to
do things such as shared patch queue maintenance and ability to keep
the patch queue under SCM are enough of a win that at least for my
purposes guilt is the better choice.

> stgit is what you need for this work flow. It lets me easily rebase or
> edit specific patches. It also lets me easily maintain private debug
> patches that I can apply as needed.

As mentioned above, I use guilt for major patch queues.  For smaller
sets of patches, such as private debug patches, I just use a separate
git branch for those, and keep them up-to-date by using "git rebase"
and "git rebase -i".  Then when I want to enable some debug patch,
I'll just do a "git merge" in a scratch branch.

							- Ted
