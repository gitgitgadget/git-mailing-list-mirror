From: Jeff King <peff@peff.net>
Subject: Re: got myself into trouble; now what? - how to revert once you've
 pushed
Date: Wed, 2 Mar 2011 08:37:20 -0500
Message-ID: <20110302133720.GA26989@sigill.intra.peff.net>
References: <AANLkTi=RGhGMcoDEL4q2pnnZ97tdswYG7OkjNS3wF7jn@mail.gmail.com>
 <20110301195027.GE10082@sigill.intra.peff.net>
 <AANLkTi==_zmSy4j-JwyCuYouV-J3shSObJe2y942PjCn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 14:37:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PumF7-0002el-RQ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 14:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415Ab1CBNhY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 08:37:24 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33855 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848Ab1CBNhX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 08:37:23 -0500
Received: (qmail 15187 invoked by uid 111); 2 Mar 2011 13:37:21 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 02 Mar 2011 13:37:21 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2011 08:37:20 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi==_zmSy4j-JwyCuYouV-J3shSObJe2y942PjCn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168310>

On Wed, Mar 02, 2011 at 08:10:38AM -0500, Robert Buck wrote:

> > If you can accept that history will be rewritten (which is a proble=
m if
> > people have built on top of your bogus merge), then what you want i=
s:
> >
> > =C2=A0git checkout master
> > =C2=A0git reset --hard $SHA1_OF_MERGE^
> >
> > and then re-push.
>=20
> That does not work; the central server rejects the commit. Now there
> are two other commits after mine, and the problem is getting worse.

Yeah, you would need "git push -f" to force push the rewrite of history=
=2E
But if people are building on top, then you would be removing their
history.

It's also possible that your server is configured to disallow pushing
history rewrites entirely, in which case all of the advice below will b=
e
useless to you.

> Does anyone have a detailed guide of how to obliterate a range of
> commits and replay subsequent history on top of that?

You can do what you want with rebase. But note that this is also
rewriting history, so people building on top of what you rewrite will b=
e
inconvenienced. If you are working a small-ish team where you can tell
everybody "stop what you're doing, let me fix this, and then we'll
proceed with working on top of my new history", then you can do
something like this.

Your history presumably looks something like this:

         T1--T2--T3
         /         \
  ...A--B--C--D--E--M--N1--N2 <-- master

where A..E are commits on master, T1..T3 are commits on the topic branc=
h
that accidentally got merged, M is the merge commit, and N1..N2 are
commits built on top. Presumably your master points at N2. Obviously th=
e
numbers of commits I just made up, but you should be able to identify
the sha1 id of the merge commit, "M".

Though the reflogs will provide a safety net for reversing the changes
we're about to make, it may be simpler to experiment on a new branch,
just in case we screw things up. Then when we have it looking good, we
can put our changes onto the master and topic branches.

So the first thing I would do is:

  git checkout -b new-master master

to make a new branch and check it out. We can also give a name to the
bogus merge commit to make it easier to refer to:

  git tag M <commit sha1 of M>

So now we want to go back to "E", and replay N1 and N2 on top of that.
Because M was a merge of topic to master, we know that E is the first
parent of M, which we can refer to as "M^1". So we can use rebase like:

  git rebase --onto M^1 M

which will take all commits between the merge and the current branch ti=
p
(which should be N1 and N2), and replay them on top of the commit just
prior to the merge. Check the result in "git log" or "gitk", or checkin=
g
it out, or whatever makes sense to you. If you're happy, you can force
it into master with:

  git branch -f master new-master

I think you also said you ended up merging the bogus merge back onto th=
e
topic branch. To undo that, probably you want to just move the topic
branch back to T3, where it was just prior to the merge. T3 is the
second parent of the merge, so you can use "M^2".

  git branch -f new-topic M^2

and then check that new-topic looks good, and install it with:

  git branch -f topic new-topic

Now you can push it all upstream with:

  git push -f origin master topic

Everybody else on your team will then want to fetch the new history and
reset their branch pointers to match:

  git fetch origin
  git branch -f master origin/master
  git branch -f topic origin/topic

Note that this will _throw away_ any work they had done that was not in
the rewritten history. If they had more commits that weren't pushed,
they will need to do a rebase. I think "git pull --rebase" will do what
they want, but I've never actually used it myself.

I hope that helps. Let me know if you try it and run into complications=
,
or if some of my assumptions don't match your situation.

-Peff
