From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Wed, 15 Feb 2006 11:11:36 +0100
Message-ID: <20060215101136.GB26911@diana.vm.bytemark.co.uk>
References: <20060210195914.GA1350@spearce.org> <20060210211740.GO31278@pasky.or.cz> <20060213210001.GA31278@pasky.or.cz> <tnxoe1aqoj2.fsf@arm.com> <20060214100844.GA1234@diana.vm.bytemark.co.uk> <43F1F5CB.10402@citi.umich.edu> <20060214160747.GA6350@diana.vm.bytemark.co.uk> <43F2445A.6020109@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Feb 15 11:12:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Jdo-00049T-1M
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 11:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWBOKLq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 15 Feb 2006 05:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWBOKLq
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 05:11:46 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:14089 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751091AbWBOKLp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 05:11:45 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1F9JdI-00075r-00; Wed, 15 Feb 2006 10:11:36 +0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <43F2445A.6020109@citi.umich.edu>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16230>

On 2006-02-14 15:58:02 -0500, Chuck Lever wrote:

> Karl Hasselstr=F6m wrote:
>
> > No, I literally want the opposite of "stg commit", so that the
> > sequence "stg commit; stg uncommit" has zero net effect.
>
> well, that would work OK for maintainers, but would be kind of
> strange for folks who are pulling from such a repository. how would
> that work?

I didn't plan to publish branches where this kind of history munging
was being done. It's precisely like "git rebase" in that regard --
it's a tool for cleaning up history before it is published.

> my impression of git is that you don't change stuff that's already
> committed. you revert changes by applying a new commit that backs
> out the original changes.

You don't change stuff that's already committed _and published_ (well,
except for pu branches :-). Rewriting history is perfectly OK up until
the moment someone has pulled your branch.

> i'm speculating, but i suspect that's why there's a "stg pick
> --reverse" and not a "stg uncommit."

I don't think I've been very successful in communicating exactly what
I want "stg uncommit" for. It's not that I want to undo a committed
change -- what I want is to transform it into an stgit patch so that I
can edit it with a minimum of effort.

  $ edit edit edit
  $ git-commit -a -m "create foo"
  $ edit edit edit
  $ git-commit -a -m "improve foo"
  $ edit edit edit
  $ git-commit -a -m "improve bar"

  # Oops, I realize that the "create foo" changeset had a debug
  # printout left in it, and I wasn't already using stgit.

  $ stg init
  $ stg uncommit improve-bar improve-foo create-foo
  $ stg stg pop --to=3Dcreate-foo
  $ edit --remove=3Ddebug-printout
  $ stg refresh
  $ stg push --all

Similar use-cases for e.g. reordering commits, merging commits,
deleting one commit in the middle of a chain of good ones, etc. are
easy to come up with. The point is that stgit alreay handles all this,
_but only if you have been using stgit from the start_. What "stg
uncommit" does is basically to import (linear) git history into stgit,
where a powerful toolset exists to edit it.

You can actually do this today; just create a new branch where you
want your new stgit stack to be based, and "stg pick" the
commits/patches from the old branch:

  $ git-checkout -b new-branch HEAD^^^
  $ stg init
  $ stg pick old-branch^^^ -n create-foo
  $ stg pick old-branch^^ -n improve-foo
  $ stg pick old-branch^ -n improve-bar
  $ git-branch -D old-branch
  $ git-checkout -b old-branch
  $ git-branch -d new-branch

This series of commands also converts the top three commits to stgit
patches, and leaves the user on the same branch where she started (it
does _exactly_ the same job as "stg uncommit improve-bar improve-foo
create-foo"), but it's a lot of work, and a typo could lose commits.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
