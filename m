From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: rebase-with-history -- a technique for rebasing without trashing
 your repo history
Date: Fri, 14 Aug 2009 00:39:48 +0200
Message-ID: <4A849634.1020609@alum.mit.edu>
References: <4A840B0F.9060003@alum.mit.edu> <20090813161256.GA8292@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?QmrDtnJuIFN0ZWluYnJpbms=?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 14 00:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbj11-0006eV-V5
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 00:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbZHMWjv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 18:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbZHMWjv
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 18:39:51 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:60518 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467AbZHMWjv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2009 18:39:51 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.129] (p4FC1BCB5.dip.t-dialin.net [79.193.188.181])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n7DMdnuj001790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Aug 2009 00:39:50 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.22) Gecko/20090608 Thunderbird/2.0.0.22 Mnenhy/0.7.6.666
In-Reply-To: <20090813161256.GA8292@atjola.homenet>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125890>

Bj=C3=B6rn Steinbrink wrote:
> On 2009.08.13 14:46:07 +0200, Michael Haggerty wrote:
>> (Please note that this technique only works for the typical "trackin=
g
>> upstream" type of rebase; it doesn't help with rebases whose goals a=
re
>> changing the order of commits, moving only part of a branch, rewriti=
ng
>> commits, etc.)
>=20
> Hm, so that pretty much doesn't work at all for creating a clean patc=
h
> series, which usually involves rewriting commits, squasing bug fixes
> into the original commits that introduced the bug etc.

Now that you mention it, there are some other uses of rebase whose
history could be recorded correctly, or at least better, in the DAG.  I
am not ready to advocate any of these changes, but I think they are
worth discussing.


A squash of two adjacent commits currently transforms this:

A---B1---B2---C

to this

A---B12---C'

(C' has the same contents and commit message as C but a different
history and therefore a different SHA1.)

But B12 includes both B1 and B2, so the correct history is this:

A---B1---B2----C
 \         \    \
  ---------B12---C'

The fact that B12 has B1 and B2 as ancestors tells git that it
incorporates both of their changes, which correctly describes reality.


Splitting a commit (not really an elementary rebase operation, but
achievable with "edit") transforms this:

A---B12---C

to this:

A---B1---B2---C'

It is not possible to represent this correctly in the DAG, because ther=
e
is no way to express that "B1" includes part of "B12" as a parent.  But
the following would be more accurate than discarding all history:

A---B12---C
 \     \   \
  B1---B2---C'

It would of course be difficult for the user-interface layer to be
confident that the changes in B1 and B2 are really equivalent to B12
unless the content of B12 and B2 are identical.


Inserting a new commit into the history (for example as part of
reordering later commits) transforms this:

A---C

to this:

A---B---C'

In this case C' includes everything that is in C, so the correct histor=
y is

A---C
 \   \
  B---C'


However, deleting a commit, which transforms this:

A---B---C

to this:

A---C'

cannot be represented in the DAG, because there is no way to express
that C' includes the changes from C without also implying that it
includes the changes from B.


Rewriting a single commit, under the assumption that the rewritten
commit is the logical equivalent of the original, transforms this:

A---B1---C

to this:

A---B2---C'

where B2 is a hand-rewritten version of B1, and C' is the version of C
produced by the rebase.  In this case, the history could be recorded as=
:

A---B1---C
 \    \   \
  ----B2---C'

but again, it is impossible for the user-interface layer to ascertain
that B2 is equivalent to B1 without help from the user.


All of this extra history would currently create far more clutter than
it is worth, but if there were a way to suppress the display of rebased
commits (as discussed in the third article I quoted), then the extra
information would be there to help git without overwhelming users.

> And even for just continously forward porting a series of commits, a
> common case might be that upstream applied some patches, but not all.
> Can you deal with that?
>=20
> Example:
>=20
> A---B---C (upstream)
>      \
>       H---I---J---K (yours)
>=20
> Upstream takes some changes:
>=20
> A---B---C---I'--K'--D (upstream)
>      \
>       H---I---J---K (yours)
>=20
> rebase leads to:
>=20
> A---B---C---I'--K'--D (upstream)
>                      \
>                       H'--J' (yours)
>=20
> What would your approach generate in that case?

There *is no way* to represent this history in a DAG, and therefore the
history of this operation will necessarily be lost.  (Well, of course i=
t
could be recorded in metadata supplemental to the DAG, but since the
history would not affect future merges it would be pointless.)  The
problem is that there is no way to claim that I' is derived from I
without also implying that I' includes the change in H (which it
doesn't).  I discuss this sort of thing in another article [1].

>> For more information, please see the full articles: [...]
>=20
> In this one you have two DAGs:
> (I fixed the second one to also have the merge commit in "subsystem"
> instead of "topic", so they only differ WRT to the rebased stuff)
>=20
> A)
> m---N---m---m---m---m---m---M  (master)
>      \                       \
>       o---o---O---o---o       o'--o'--o'--o'--o'--S  (subsystem)
>                        \                         /
>                         *---*---*-..........-*--T (topic)
>=20
>=20
> B)
> m---N---m---m---m---m---m---M  (master)
>      \                       \
>       \                       o'--o'--o'--o'--o'----------S  (subsyst=
em)
>        \                     /   /   /   /   /           /
>         --------------------o---o---O---o---o---*---*---T (topic)
>=20
>=20
> And you say that the former creates problems when you want to merge
> again. How so?

As you very clearly showed (thanks!), the merge problems that I claimed
only occur in some obscure edge cases.

What I *should* have emphasized is that the merge S itself is much more
prone to conflicts in case A) (with merge base N) than in case B) (with
the last "o" as merge base).  That is the first advantage of
rebase-with-history.

And please note that I really advocate C), not B):

C)
m---N---m---m---m---m---m---M  master
     \                       \
      \                       o'--o'--o'--o'--o'  subsystem
       \                     /   /   /   /   / \
        --------------------o---o---O---o---o   \
                                             \   \
                                              \   *'--*'--*'  topic
                                               \ /   /   /
                                                *---*---*

where the topic branch is not merged into the subsystem branch but
rather rebased-with-history.  C) has the significant advantage over A)
or B) that the topic branch can be converted to a series of patches (th=
e
*' patches) that apply cleanly to the rebased subsystem branch and can
therefore be submitted upstream.  In the case of A) or B), the only
available patch that applies cleanly to the rebased subsystem branch is
S, which is a single commit that squashes together the entire topic
branch and is therefore difficult to review.

So rebasing in a public repository makes it difficult for downstream
developers to apply their work to the rebased branch (because they have
to repeat the conflict resolution that was done in the upstream rebase)=
,
and merging in a topic branch makes it more difficult to create an
easily-reviewable patch series.  rebase-with-history has neither of
these problems.

Michael

[1] "Git, Mercurial, and Bazaar=E2=80=94simplicity through inflexibilit=
y",
http://softwareswirl.blogspot.com/2009/08/git-mercurial-and-bazaarsimpl=
icity.html
