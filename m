From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 18:06:33 +0200
Message-ID: <20090420160633.GA17241@atjola.homenet>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> <20090420113216.GC25059@dpotapov.dyndns.org> <49EC6596.8060208@drmicha.warpmail.net> <20090420132414.GD25059@dpotapov.dyndns.org> <alpine.DEB.1.00.0904201621290.6771@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 18:09:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvw2b-0000Tt-RD
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 18:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934AbZDTQGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 12:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755940AbZDTQGn
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 12:06:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:34771 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755729AbZDTQGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 12:06:42 -0400
Received: (qmail invoked by alias); 20 Apr 2009 16:06:40 -0000
Received: from i59F5B531.versanet.de (EHLO atjola.local) [89.245.181.49]
  by mail.gmx.net (mp001) with SMTP; 20 Apr 2009 18:06:40 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19VRhdyr05VnoPJQXaATfQEwrLGTGW5yCVsw0K+9k
	gN/aL1X4f9A9r7
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904201621290.6771@intel-tinevez-2-302>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117004>

On 2009.04.20 16:25:38 +0200, Johannes Schindelin wrote:
> On Mon, 20 Apr 2009, Dmitry Potapov wrote:
>=20
> > When you create a new commit, it is always belong to _one_ branch
> > and never to two or more branches.
>=20
> Certainly you forgot about detached HEADs? And about the ability to
> create new branches which point to the _exact_ same commit as other
> branches? And about the option to delete the original branch, not
> removing the commit, or the other branches, at all?
>=20
> No, this all shows: we _have_ a different branch model from most othe=
r
> VCSes, and we _obviously_ make that not clear enough.

Basically, git has no actual entities that I'd call "branches", it just
has named branch heads. The branches themselves are implicit in the
commit DAG.

If you go out, and look at a tree lit-up by the evil daystar, branches
start at the trunk and end at their tip. The trunk isn't part of the
branch. And as e.g. a SVN user, you can use an analogy and say "There's
branch XYZ and it has these three commits", ignoring commits from the
trunk or other branches leading up to this one. And you can even ask SV=
N
which commits make up that branch, by using a "stop on copy" feature
(because that copy usually tells where the branching point is).

Let's take this history:

A---B---C---D (refs/heads/master)
 \
  E---F---G (refs/heads/foo)
       \
        H---I---J (refs/heads/bar)

The branches might be thought of to contain these commits:

master: A, B, C, D
foo: E, F, G
bar: H, I, J

Because those commits are (from a task oriented view) what makes those
branches. If branch "bar" implements feature Y, then the commits A, E
and F might not be interesting when talking about the branch in the
context of the feature it implements.

With SVN you could do:
svn log --stop-on-copy .../bar

Which automatically ignores commits that are on other branches.

With git you need:
git log foo..bar

Which gives the same result, but you need to be more explicit about wha=
t
you want to ignore. Because git just sees branch heads, not branches.
The same "you need to think a bit more/different" applies to merging
branches. As svn has just glorified cherry-picking, you can ignore the
whole history leading up to a branch, and still think of just "this
branch does this task", and "merge" that branch. For git, that obviousl=
y
won't do, you need to see the branch as it's embedded into the history.
I'm not saying this is bad, as it gives you a more useful history, and
more flexibility, but it is definitely different from at least one wide
spread system.

The only thing I'm aware of where git really draws a line between
"branches" and branch heads is git checkout. You can checkout a "branch=
"
using its name:
	git checkout master

But using the name of the branch head, will detach HEAD:
	git checkout refs/heads/master

(The quotes are there because this "branch" doesn't match the definitio=
n
of a branch as I used it earlier...)


So basically, we don't have explicit branches, just a mechanism to
control where the branches grow.

Bj=F6rn
