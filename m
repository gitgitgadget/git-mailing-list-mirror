From: Jeff King <peff@peff.net>
Subject: Re: Storing additional information in commit headers
Date: Tue, 2 Aug 2011 12:51:55 -0600
Message-ID: <20110802185154.GA2499@sigill.intra.peff.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <20110801201301.GA17111@sigill.intra.peff.net>
 <20110801211104.GC15401@fishbowl.rw.madduck.net>
 <20110802035056.GB17494@sigill.intra.peff.net>
 <20110802082810.GC29887@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Aug 02 20:52:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoK4R-0008Hc-I2
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 20:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868Ab1HBSv7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 14:51:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43964
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754715Ab1HBSv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 14:51:57 -0400
Received: (qmail 32032 invoked by uid 107); 2 Aug 2011 18:52:31 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Aug 2011 14:52:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Aug 2011 12:51:55 -0600
Content-Disposition: inline
In-Reply-To: <20110802082810.GC29887@fishbowl.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178496>

On Tue, Aug 02, 2011 at 10:28:10AM +0200, martin f krafft wrote:

> TopGit does what you suggest (a parallel ref structure), but there
> are three problems with this, which I am trying to address:
>=20
>   1. you need to ensure that these refs are pushed and fetched,
>      which requires set up and possible migration issues when things
>      change, and can cause big problems for contributors who just so
>      happened to forget.

I agree that is an annoyance, but it is one we can deal with. In the
near term, I wonder if a "tg clone" would be appropriate to add the
extra fetch refspecs when cloning (or even a "tg init" inside an
existing git repo -- I don't actually use topgit, so I'm not sure what
the usual initialization process, if any, is).

In the longer term, it might be nice if git was better at sharing
third-party refs. The problem is that we don't know what the refs mean,
so we don't know which ones are appropriate for sharing. Maybe we could
do something like "refs/shared/topgit/*", and git by default would push
and pull items under refs/shared?

There have also been proposals to have a more mirror-like structure to
what we fetch from remotes. E.g., to put remote refs/tags into
refs/remotes/origin/refs/tags, and similar for notes. It may be that it
is sensible for us to just fetch everything from a remote into
refs/remotes, including unknown hierarchies like topgit.

>   2. the additional refs confuse people a lot =E2=80=94 and I can att=
est to
>      that because I have also at times found myself overwhelmed by
>      them when staring at gitk.

Using "gitk --all", I assume? I agree it is annoying, though "gitk
--branches" probably better specifies what you want (unless you stick
the parallel ref structure under refs/heads above, which is also a
solution to the "should it be fetched" plan).

>   3. once a ref updates, we need to keep a pointer to the previous
>      location, since one of the goals is the ability to be able to
>      return to a point in history (e.g. for security updates to
>      a stable package, or backports). Additional refs enhance the
>      aforementioned two problems.

Reflogs provide a linear history of the ref updates, but I suspect you
want to be able to push and pull these histories. Which reflogs will no=
t
do.

If you want to version the state of refs, then using raw refs isn't the
right answer. You want a separate commit history with trees that map re=
f
names to commits or other objects. Which is _almost_ what notes are;
they map commit sha1s, but you want to map ref names.

> Therefore I thought it would be sensible to store these data in
> commit. When the data change, there will always be a new commit to
> store these data, and we do *not* want to update the data in
> previous commits. Finding the data then becomes backtracking the
> branch history until a commit is found containing them.

That seems to me like you are sticking information in a commit that is
not actually about the commit, but about the ref that happens to point
to the commit. What if I have two refs that point to the same commit,
but with two different topgit bases? What about years later, when that
information isn't interesting anymore? You're still carrying the cruft
inside your commit objects.

> > However, implementing such a thing would mean you have an awkward
> > transition period where some versions of git think the referenced
> > object is relevant, and others do not. That's something we can
> > overcome, but it's going to require code in git, and possibly
> > a dormant introduction period.
>=20
> Indeed. This could be adressed by letting a tool like TopGit require
> a minimum version of Git. For a while, this will burden developers,
> but ensure that it works. Over time, this will cease to be
> a problem.

Keep in mind that your requirement is not just a local thing. Object
reachability is something that both sides of a transfer need to agree
on. So imagine you use TopGit with a new version of git, and you push t=
o
a site like GitHub. The remote side will take your objects, but it will
not send them back to anyone who fetches from your repository (since it
has no idea they're relevant). And it will probably prune them after a
week or two.

> What do you think about using the idea of orphan parent commits
> (OPC) for now? These are conceptually closest to the x-*-ref
> pointers, do not require extra setup, pollute history only a little
> bit (IMHO), and slot in with Git and fsck/gc alright.

It doesn't seem like a good idea to me. Parent pointers have a
well-defined meaning, and other parts of git (and other tools, even) ar=
e
going to assume that's what your parent pointers mean. They are used in
merge base calculations, for example. I _think_ you are mostly safe
here, because your OPC wouldn't have any real history to it, so finding
a merge base down that path would be fruitless.

But consider something like "diff", which shows a merge commit
differently than a regular commit. Your commits will unexpectedly appea=
r
as merges to git, and we will show a combined diff versus the OPC, whic=
h
is going to be ugly.

> I am not yet sure what information needs storing. Right now, I am
> keeping five fields:
> [...]


Thanks, that helped with getting a sense of what you're doing.

> I think there are two questions:
>=20
>   1. would x-*-ref be a suitable idea for Git core?
>=20
>      I think the answer is yes, as (I think) it's well-defined and
>      I cannot see any problems with it, really.

I think it's a nice idea for extensibility. And if it had been there
from day one, there would be no problems. But now we have to deal with
the transition period, and the fact that two different versions of git
will have different ideas about the set of objects that are reachable
from a given commit.

>   2. can we prevent abuse?
>=20
>      No, never. But just like you cannot abuse X-* headers in the
>      RFC822 format due to their design, x-*-ref abuse would only
>      affect those who chose it.

I don't worry about abuse. You can already stick random cruft in a
commit header, and you can already connect objects to a commit via tree
entries. This idea is just giving git some rules for dealing with it.

I'm still not 100% convinced you want per-commit storage, though, and
not per-ref storage.

-Peff
