From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: rebase-with-history -- a technique for rebasing without
 trashing your repo history
Date: Sat, 15 Aug 2009 05:36:23 +0200
Message-ID: <20090815033623.GB19833@atjola.homenet>
References: <4A840B0F.9060003@alum.mit.edu>
 <20090813161256.GA8292@atjola.homenet>
 <4A849634.1020609@alum.mit.edu>
 <20090813233027.GA19833@atjola.homenet>
 <4A85D53D.9050805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Aug 15 05:36:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McA4V-00077J-Vo
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 05:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbZHODg2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 23:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbZHODg1
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 23:36:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:52165 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753495AbZHODg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 23:36:27 -0400
Received: (qmail invoked by alias); 15 Aug 2009 03:36:26 -0000
Received: from i59F55E84.versanet.de (EHLO atjola.homenet) [89.245.94.132]
  by mail.gmx.net (mp060) with SMTP; 15 Aug 2009 05:36:26 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19qNlsc4blq9jjG4XKoKMunf4V9tepLODZ4PLeFyI
	aJ/cnCYKI0lW0k
Content-Disposition: inline
In-Reply-To: <4A85D53D.9050805@alum.mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125980>

On 2009.08.14 23:21:01 +0200, Michael Haggerty wrote:
> Bj=F6rn Steinbrink wrote:
> > On 2009.08.14 00:39:48 +0200, Michael Haggerty wrote:
> >> Bj=F6rn Steinbrink wrote:
> >>> On 2009.08.13 14:46:07 +0200, Michael Haggerty wrote:
> > [...]
> > Doing a plain "git rebase subsystem topic" would of course also try=
 to
> > rebase the "o" commits, so that problematic. Instead, you do:
> >=20
> > git rebase --onto subsystem O topic
> >=20
> > That turns O..topic (the * commits) into patches, and applies them =
on
> > top of O'. So the "o" commits aren't to be rebased.
> >=20
> > And that's exactly what your rebase-with-history would do as well. =
Just
> > that O is naturally a common ancestor of subsystem and topic, and s=
o
> > just using "git rebase-w-h subsystem topic" would be enough. Confli=
cts
> > etc. should be 100% the same.
> >=20
> > If you know that your upstream is going to rebase/rewrite history, =
you
> > can tag (or otherwise mark) the current branching point of your bra=
nch,
> > so you can easily specify it for the --onto rebase. IOW: This is
> > primarily a social problem (tell your downstream that you rebase th=
is or
> > that branch), but having built-in support to store the branching po=
int
> > for rebasing _might_ be worth a thought.
>=20
> Recording branch points manually, coordinating merges via email -- OM=
G
> you are giving me flashbacks of CVS ;-)

Not merging, but rewriting history. One of the primary purposes of
rebasing is to forget the old history, the new version overrides it. An=
d
telling someone to forget something is a social problem. You can help
the user to forget the history by tracking the branching points and I
said that git could maybe learn to do that, so the user doesn't have
to do so. Quick idea:

On branch creation, create refs/bases/<branchname> (let's call that
<base>) referencing the commit the branch initially references.

On rebase, check if <branchname>..<onto> is not empty. If so, update
refs/bases/<branchname> to reference <base>.

On reset, check if the commit the branch head is being reset to is
reachable through the commit the branch head currently references. If
not, update <base> to reference the commit we're resetting to.

=46ind some sane syntax for rebase that implicitly uses <base> as the
<upstream> argument, e.g. just "git rebase --onto <whatever>" could wor=
k
as "git rebase --onto <whatever> <base>".

Most likely, I missed a bunch of corner cases though...

> *Of course* you can get around all of these problems if you put the
> burden of bookkeeping on the user.  The whole point of
> rebase-with-history is to have the VCS handle it automatically!

What your approach does, is simply moving the "just forget the
history" part. Instead of forgetting it at rebase time, you have to
forget it when you want to submit patches. It's obviously a bit easier
though, as you can just say "--first-parent <upstream>", assuming that
you teach format-patch to use a special first-parent diff mode for the
merge commits (see below).

> >> and merging in a topic branch makes it more difficult to create an
> >> easily-reviewable patch series.  rebase-with-history has neither o=
f
> >> these problems.
> >=20
> > Sure, merging is a no-go if you submit patches by email (or other,
> > similar means). But you compared that to an "enhanced" rebase appro=
ach,
> > instead of comparing your rebase approach to the currently availabl=
e
> > one.
>=20
> In [1] I compared rebase-with-history with both of the
> currently-available options (rebase and merge).  Rebase and merge can
> each deal with some of the issues that come up, but each one falls fl=
at
> on others.  I believe that rebase-with-history has the advantages of =
both.

And some disadvantages.

1) Cluttered history, which needs to be rewritten again when the emaile=
d
patches are just for review, but the maintainer will actually merge fro=
m
you later.

Taking the old master, subsystem, topic example, you get (for example):

          o2--o2 (subsystem)
         /     \
m---m---m---m---m (master)
     \   \
      \   o'--o'
       \ /   / \
        o---o   *'--*' (topic)
             \ /   /
              *---*

Now the user that maintains "topic" is back at the hard case. He now
needs to rebase onto master, using the last o' as <upstream>. The
DAG doesn't help here, the base-tracking would handle that.


2) Merge commits, which are usually displayed in a special format. So
for "git show" or "git log -p" to give useful output for those special
merges, you'd have to introduce a new "diff only against first-parent"
mode, and mark those merge in a special way, so that diff mode is used
for them, but not for real merges. And users of old git versions would
have to deal with the basic -m merge diff mode, ignoring the useless
diff for the second parent and the fact that the real merges also get
shown in that format. The base tracking doesn't have this problem
either.


> The example in [2] was taken straight from the git-rebase man page [3=
];
> I did not want to claim that current practice would use merging in th=
is
> situation, but rather just to show that rebase-with-history removes t=
he
> pain from this well-known example.

Well, the man pages says: Don't merge, rebase needs to trickle down, bu=
t
you'll likely need to use "git rebase --onto subsystem subsystem@{1}".
So the rebase-with-history really just saves that "use --onto and the
right <upstream>" from the hard case. The plain base-tracking does the
same.

Another way to reach the same goal would be just to explictly override
the old history.

m---m---m (master)
     \
      o---o (subsystem)
           \
            *---* (topic)

(Hypothetical): git rebase --override master subsystem

Leads to:

m---m---m---- (master)
     \       \
      o---o---O---o'--o' (subsystem)
           \
            *---* (topic)

Where O is an --ours merge, that just marks the old o commits as merged=
,
but has the same tree as the last m commit.

Now topic can be rebase using: git rebase --override subsystem topic

m---m---m---- (master)
     \       \
      o---o---O---o'--o' (subsystem)
           \           \
            *---*-------X---*'--*' (topic)

Again, X being an ours merge.

As the O and X commits have the last o and * commits as their second
parents, this even doesn't break things like "git show" and "git log
-p", as the interesting commits aren't merge commits. So "git
log -p --first-parent subsystem..topic" would do the right thing
(optionally with --no-merges to avoid the merge commit, but seeing that
doesn't hurt that much I guess).

This also trivially supports the reorder, squash, edit whatever stuff,
as it doesn't rely on 1:1 commit counterparts to exist. But it also
falls flat on its face as soon as subsystem gets "really" rewritting, s=
o
that the old history is no longer reachable from the new history.

Bj=F6rn
