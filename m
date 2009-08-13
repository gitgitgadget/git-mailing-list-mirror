From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: rebase-with-history -- a technique for rebasing without
 trashing your repo history
Date: Fri, 14 Aug 2009 01:30:34 +0200
Message-ID: <20090813233027.GA19833@atjola.homenet>
References: <4A840B0F.9060003@alum.mit.edu>
 <20090813161256.GA8292@atjola.homenet>
 <4A849634.1020609@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 14 01:30:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbjkt-0007o4-Ms
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 01:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756441AbZHMXai convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 19:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754889AbZHMXai
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 19:30:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:41295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752913AbZHMXai (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 19:30:38 -0400
Received: (qmail invoked by alias); 13 Aug 2009 23:30:37 -0000
Received: from i59F57353.versanet.de (EHLO atjola.homenet) [89.245.115.83]
  by mail.gmx.net (mp001) with SMTP; 14 Aug 2009 01:30:37 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18Bisg0YBIBZipmYn79Sgx/1wvolT+R9Kky3LbYQ2
	smr6OH4z0idrBZ
Content-Disposition: inline
In-Reply-To: <4A849634.1020609@alum.mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125892>

On 2009.08.14 00:39:48 +0200, Michael Haggerty wrote:
> Bj=F6rn Steinbrink wrote:
> > On 2009.08.13 14:46:07 +0200, Michael Haggerty wrote:
> > And even for just continously forward porting a series of commits, =
a
> > common case might be that upstream applied some patches, but not al=
l.
> > Can you deal with that?
> >=20
> > Example:
> >=20
> > A---B---C (upstream)
> >      \
> >       H---I---J---K (yours)
> >=20
> > Upstream takes some changes:
> >=20
> > A---B---C---I'--K'--D (upstream)
> >      \
> >       H---I---J---K (yours)
> >=20
> > rebase leads to:
> >=20
> > A---B---C---I'--K'--D (upstream)
> >                      \
> >                       H'--J' (yours)
> >=20
> > What would your approach generate in that case?
>=20
> There *is no way* to represent this history in a DAG, and therefore t=
he
> history of this operation will necessarily be lost.  (Well, of course=
 it
> could be recorded in metadata supplemental to the DAG, but since the
> history would not affect future merges it would be pointless.)  The
> problem is that there is no way to claim that I' is derived from I
> without also implying that I' includes the change in H (which it
> doesn't).  I discuss this sort of thing in another article [1].

Well, I' isn't even interesting here. I' is _upstream's_ commit, likely
created from an email. Upstream didn't have "I" when I' was created to
begin with. The interesting commits are H' and J', which were actually
rebased. And the situation is even "worse" than for I' or K'. H' does
include H, I, and K, but not J and J' contains H, I, J and K.

So possibly you'd have:

A---B---C---I'--K'--D (upstream)
     \               \
      \       --------H'--J'
       \     /           /
        H---I---J---K----

Which only ignores that K is "contained" in H'.

But you only get to know that I is in H' (and that K is in J') _after_
H' (or J') have been created. So you'd need a preprocessing run.

The non-preprocessing result would be something like:

A---B---C---I'--K'--D (upstream)
     \               \
      \  -------------H'--J'
       \/                /
        H---I---J--------
                 \
                  K

But that's obviously total crap.

> >> For more information, please see the full articles: [...]
> >=20
> > In this one you have two DAGs:
> > (I fixed the second one to also have the merge commit in "subsystem=
"
> > instead of "topic", so they only differ WRT to the rebased stuff)
> >=20
> > A)
> > m---N---m---m---m---m---m---M  (master)
> >      \                       \
> >       o---o---O---o---o       o'--o'--o'--o'--o'--S  (subsystem)
> >                        \                         /
> >                         *---*---*-..........-*--T (topic)
> >=20
> >=20
> > B)
> > m---N---m---m---m---m---m---M  (master)
> >      \                       \
> >       \                       o'--o'--o'--o'--o'----------S  (subsy=
stem)
> >        \                     /   /   /   /   /           /
> >         --------------------o---o---O---o---o---*---*---T (topic)
> >=20
> >=20
> > And you say that the former creates problems when you want to merge
> > again. How so?
>=20
> As you very clearly showed (thanks!), the merge problems that I claim=
ed
> only occur in some obscure edge cases.
>=20
> What I *should* have emphasized is that the merge S itself is much mo=
re
> prone to conflicts in case A) (with merge base N) than in case B) (wi=
th
> the last "o" as merge base).  That is the first advantage of
> rebase-with-history.

Yeah, but as I said, actually, topic should have been rebased, not
merged, and then that ends up the same, as you'd do:
git rebase --onto subsystem $last_o topic

Taking the last o commit as upstream.

> And please note that I really advocate C), not B):
>=20
> C)
> m---N---m---m---m---m---m---M  master
>      \                       \
>       \                       o'--o'--o'--o'--o'  subsystem
>        \                     /   /   /   /   / \
>         --------------------o---o---O---o---o   \
>                                              \   \
>                                               \   *'--*'--*'  topic
>                                                \ /   /   /
>                                                 *---*---*
>=20

=46ine, but this should then be compared to the result from the above
rebase command, which is:

D)
m--...--m (master)
         \
          o'-...-o' (subsystem)
                  \
                  *'-...-*' (topic)

> where the topic branch is not merged into the subsystem branch but
> rather rebased-with-history.  C) has the significant advantage over A=
)
> or B) that the topic branch can be converted to a series of patches (=
the
> *' patches) that apply cleanly to the rebased subsystem branch and ca=
n
> therefore be submitted upstream.  In the case of A) or B), the only
> available patch that applies cleanly to the rebased subsystem branch =
is
> S, which is a single commit that squashes together the entire topic
> branch and is therefore difficult to review.

Same for D)

> So rebasing in a public repository makes it difficult for downstream
> developers to apply their work to the rebased branch (because they ha=
ve
> to repeat the conflict resolution that was done in the upstream rebas=
e),

There's no difference between C) and D) there, except for the fact that
D) requires you to use --onto, because that needs to differ from
<upstream>.

Let's take the pre-topic-rebase history:

m---m---m (master)
     \   \
      \   o'--o'--O' (subsystem)
       \
        o---o---O---*---*---* (topic)

Doing a plain "git rebase subsystem topic" would of course also try to
rebase the "o" commits, so that problematic. Instead, you do:

git rebase --onto subsystem O topic

That turns O..topic (the * commits) into patches, and applies them on
top of O'. So the "o" commits aren't to be rebased.

And that's exactly what your rebase-with-history would do as well. Just
that O is naturally a common ancestor of subsystem and topic, and so
just using "git rebase-w-h subsystem topic" would be enough. Conflicts
etc. should be 100% the same.

If you know that your upstream is going to rebase/rewrite history, you
can tag (or otherwise mark) the current branching point of your branch,
so you can easily specify it for the --onto rebase. IOW: This is
primarily a social problem (tell your downstream that you rebase this o=
r
that branch), but having built-in support to store the branching point
for rebasing _might_ be worth a thought.

> and merging in a topic branch makes it more difficult to create an
> easily-reviewable patch series.  rebase-with-history has neither of
> these problems.

Sure, merging is a no-go if you submit patches by email (or other,
similar means). But you compared that to an "enhanced" rebase approach,
instead of comparing your rebase approach to the currently available
one.

So, as I see it, your approach does:
 * Save the need to use --onto, allowing to just specify <upstream>, as
   if <upstream> was not rewritten.
 * Allows to keep older versions of commits more easily accessible for
   inspection, e.g. creating interdiffs.

The latter is (to me) of limited use, and the former could be done by
tracking the branching point, not sure how well it work out, but maybe
worth investigating.

Bj=F6rn
