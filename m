From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Storing state in $GIT_DIR
Date: Fri, 26 Aug 2005 00:53:07 -0600
Message-ID: <m17je9tcj0.fsf@ebiederm.dsl.xmission.com>
References: <46a038f905082420323b025e3b@mail.gmail.com>
	<Pine.LNX.4.58.0508251053000.3317@g5.osdl.org>
	<46a038f905082518306e9d7d2a@mail.gmail.com>
	<Pine.LNX.4.58.0508252051400.3317@g5.osdl.org>
	<46a038f90508252115415acc04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, GIT <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 10:04:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8Y68-0006Zn-R8
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 08:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVHZGxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 02:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVHZGxe
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 02:53:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51659 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932529AbVHZGxd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 02:53:33 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j7Q6rBBS005215;
	Fri, 26 Aug 2005 00:53:11 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j7Q6r79a005214;
	Fri, 26 Aug 2005 00:53:07 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90508252115415acc04@mail.gmail.com> (Martin Langhoff's
 message of "Fri, 26 Aug 2005 16:15:37 +1200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7774>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Hmmm. That repo is in sync, but there are no guarantees that they will
> travel together to a different repo. In fact, the push/pull
> infrastructure wants to push/pull one head at a time.
>
> And if they are not in sync, I have no way of knowing. Hmpf. I lie:
> the arch metadata could keep track of what it expects the last head
> commits to be, and complain bitterly if something smells rotten.
>
> let me think about it ;)


Thinking about it going from arch to git should be just a matter
of checking sha1 hashes, possibly back to the beginning of the
arch tree.  

Going from git to arch is the trickier mapping, because you
need to know the full repo--category--branch--version--patch
mapping.

Hmm.  Thinking about arch from a git perspective arch tags every
commit.  So the really sane thing to do (I think) is to create
a git tag object for every arch commit.

With that structure you would just need to create a git-arch-rev-list
so you can get a list of which arch branches you already have.
And then a git-arch-push and a git-arch-pull should be just a matter
of finding the common ancestor and continuing along the branch until
you reach the head.  Handling all heads in an arch repository is a
little trickier but should not be too bad.

On the push side you can just treat git as an arch working directory 
and push changsets into the appropriate branch.  For branches that
do not have tla as the ancestor you can do the equivalent of
tla archive-mirror.

Changes can be merged on whichever side make sense.

With patch trading (Martin I think I know what you are refering to)
arch does seem to have a concept that does not map very well to git,
and this I think is a failing in git.  Arch can record that just the
changes from a single changset/patch were merged.  This happens all
of the time in the kernel tree when patches are merged.  The
interesting case for merge algorithms is when two maintainers merge
the same patches into separate branches and then the branches are
merged.  Does git have a good way of coping with that case?

On the simple side it for patch trading it might just be worth
treating them as a special git merge with just one parent in
the parents line and the real parent listed in the merge comment,
along with the original parents commit comment.  But that just
might be too ugly to think about.

How does StGit handle this?

Eric
