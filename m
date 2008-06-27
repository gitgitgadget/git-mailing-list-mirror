From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 09:10:14 +0200
Message-ID: <20080627071014.GA12344@atjola.homenet>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Robert Anderson <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 09:11:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC872-0002j7-Rw
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 09:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbYF0HKT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jun 2008 03:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbYF0HKT
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 03:10:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:60714 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754496AbYF0HKS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 03:10:18 -0400
Received: (qmail invoked by alias); 27 Jun 2008 07:10:16 -0000
Received: from i577B854A.versanet.de (EHLO atjola.local) [87.123.133.74]
  by mail.gmx.net (mp008) with SMTP; 27 Jun 2008 09:10:16 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+QVpN3F0CQJql3JZ72J2sMZEwXwV3B1FA4zoaeBm
	bjnizkqNnibjCO
Content-Disposition: inline
In-Reply-To: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86528>

On 2008.06.26 23:50:06 -0700, Robert Anderson wrote:
> Seems to me the concept of the "index" is a half-baked version of wha=
t
> I really want, which is the ability to factor a working tree's change=
s
> into its constituent parts in preparation for committing them.  The
> index provides some very nice facilities to factor out changes in a
> working tree into a "staging area", but the fundamental flaw of this
> in my view is that this "staging area" is not instantiated as a tree,
> so it cannot be compiled and/or tested before committing.
>=20
> Consider a facility where the state you want to commit next is built
> up in the current working directory, and the original set of changes
> exists in some proto-space like the index currently inhabits, where
> you can query and manipulate that state, but it isn't instantiated in
> your working tree.
>=20
> Imagine a session like this:
>=20
> You've got a couple of conflated changes in your working tree, that
> you think you can break up into two orthogonal changes, each of which
> will compile and pass a set of tests you've got.  You think.  You'd
> like to verify the build and test before you commit each piece.
>=20
> git prep
>=20
> where "prep" means "prepare commit".  Don't get hung up on command or
> option names I'm using as placeholders, I just made that up without
> much deep thought about what to call it.
>=20
> Now my tree appears clean (and git diff returns nothing).  I can now
> start adding the changes I had in my working tree that I want to
> include in the next commit, using git add (which would know I am in
> the "prep" mode).  I can examine those original working dir changes I
> am choosing from with:
>=20
> git diff --prep
>=20
> which, at this point, shows the same output that "git diff" did befor=
e
> I ran "git prep."  Now I want to add some subset of my original
> changes:
>=20
> git add newfile.c
> git add -i
> <add a couple of hunks of the changes from file modfile.c>
>=20
> Now I have a working tree state that I think I want to commit.  I can
> examine it with:
>=20
> git diff
>=20
> and I can compile and test it.  Yep, it works and passes my test suit=
e
> (an option I did not have if I had added these changes to the index).
> So now I want to commit:
>=20
> git commit -a -m "made change A"
>=20
> I think the commit should probably "pop" the rest of the changes I di=
d
> not commit back into the working directory.  If I want to pull anothe=
r
> subset of changes again, I can repeat the process with another "git
> prep".
>=20
> Does this idea resonate with anyone else?

Hm, I use "stash" for that purpose, which leads to kind of the reverse
of your approach. So I do sth. like this:

 - hack hack hack
 - Notice that I want to make two commits out of what I have in my
   working tree
 - git add -p -- stage what I want in the first commit
 - git commit -m tmp -- temporary commit
 - git stash -- stash away what doesn't belong in the first commit
 - git reset HEAD^ -- drop the temporary commit, with the changes kept
   in the working tree
 - test, fix bugs, read the diff, whatever
 - git commit -- this time for good
 - git stash apply -- get back the changes for the second commit

Instead of using reset, you could also use "commit --amend" (I actually
used to do that), but that needs you to do "git diff HEAD^" to see the
full changes, and (IMHO) makes it a harder sometimes to review your
stuff, because you now have three places where the changes for one
commit might reside (HEAD, index and working tree).

Bj=F6rn
