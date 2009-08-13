From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: rebase-with-history -- a technique for rebasing without
 trashing your repo history
Date: Thu, 13 Aug 2009 18:12:56 +0200
Message-ID: <20090813161256.GA8292@atjola.homenet>
References: <4A840B0F.9060003@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bazaar <bazaar@lists.canonical.com>,
	Git Mailing List <git@vger.kernel.org>,
	mercurial mailing list <mercurial@selenic.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 13 18:13:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbcvR-00016v-0N
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 18:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbZHMQNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 12:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbZHMQNB
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 12:13:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:50765 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751318AbZHMQNA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 12:13:00 -0400
Received: (qmail invoked by alias); 13 Aug 2009 16:13:00 -0000
Received: from i59F57353.versanet.de (EHLO atjola.homenet) [89.245.115.83]
  by mail.gmx.net (mp046) with SMTP; 13 Aug 2009 18:13:00 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+ZCapr2xGZhcxUicXcMU9q4/XMQRibHNumVjXpsk
	Tn2jA0hBaRBscW
Content-Disposition: inline
In-Reply-To: <4A840B0F.9060003@alum.mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125828>

On 2009.08.13 14:46:07 +0200, Michael Haggerty wrote:
> Sorry to cross-post, but I think this might be interesting to all thr=
ee
> projects...
>=20
> I've been thinking a lot about the problems of tracking upstream chan=
ges
> while developing a feature branch.  As I think everybody knows, both
> rebasing and merging have serious disadvantages for this use case.
> Rebasing discards history and makes it difficult to share
> work-in-progress with others, whereas merging makes it difficult to
> prepare a clean patch series that is suitable for submission upstream=
=2E
>=20
> I've written some articles describing another possibility, which
> combines the advantages of both methods.  The key idea is to retain
> rebase history correctly, on a patch-by-patch level.  The resulting D=
AG
> retains enough history to prevent problems with merge conflicts
> downstream, while also allowing the patch series to be kept tidy.
>=20
> (Please note that this technique only works for the typical "tracking
> upstream" type of rebase; it doesn't help with rebases whose goals ar=
e
> changing the order of commits, moving only part of a branch, rewritin=
g
> commits, etc.)

Hm, so that pretty much doesn't work at all for creating a clean patch
series, which usually involves rewriting commits, squasing bug fixes
into the original commits that introduced the bug etc.

And even for just continously forward porting a series of commits, a
common case might be that upstream applied some patches, but not all.
Can you deal with that?

Example:

A---B---C (upstream)
     \
      H---I---J---K (yours)

Upstream takes some changes:

A---B---C---I'--K'--D (upstream)
     \
      H---I---J---K (yours)

rebase leads to:

A---B---C---I'--K'--D (upstream)
                     \
                      H'--J' (yours)

What would your approach generate in that case?

> For more information, please see the full articles:
>=20
> * Upstream rebase Just Works=E2=84=A2 if history is retained [2]

In this one you have two DAGs:
(I fixed the second one to also have the merge commit in "subsystem"
instead of "topic", so they only differ WRT to the rebased stuff)

A)
m---N---m---m---m---m---m---M  (master)
     \                       \
      o---o---O---o---o       o'--o'--o'--o'--o'--S  (subsystem)
                       \                         /
                        *---*---*-..........-*--T (topic)


B)
m---N---m---m---m---m---m---M  (master)
     \                       \
      \                       o'--o'--o'--o'--o'----------S  (subsystem=
)
       \                     /   /   /   /   /           /
        --------------------o---o---O---o---o---*---*---T (topic)


And you say that the former creates problems when you want to merge
again. How so?

Merging "master" to "subsystem" is a no-op in both cases.
Merging "subsystem" to "master" is a fast-forward in both cases.
Merging "subsystem" to "topic" is a fast-forward in both cases.
Merging "topic" to "subsystem" is a no-op in both cases.

Merging "topic" and "master" (in either direction) has merge base N in
both cases.

Let's assume that there's another dev, having his own history based on
the old "O" commit. So:

A)
m---N---m---m---m---m---m---M  (master)
     \                       \
      o---o---O---o---o       o'--o'--o'--o'--o'--S  (subsystem)
               \       \                         /
                \       *---*---*-..........-*--T (topic)
                 \
                  X---Y---Z (outsider)

B)
m---N---m---m---m---m---m---M  (master)
     \                       \
      \                       o'--o'--o'--o'--o'----------S  (subsystem=
)
       \                     /   /   /   /   /           /
        --------------------o---o---O---o---o---*---*---T (topic)
                                     \
                                      X---Y---Z (outsider)

Merging "master" and "outsider" has merge base N in both cases.
Merging "subsystem" and "outsider" has merge base O in both cases.
Merging "topic" and "outsider" has merge base O in both cases.

The only thing that really makes a difference is when you have another
dev having based his history upon one of the o' commits. If that histor=
y
is merged with "topic", then you get merge base N in A) and one of the
o's in B).

But, in that case, merging "topic" is basically just a complicated way
of merging "subsystem". Both contain the full series of "o" commits, an=
d
all the "topic" commits (due to the merge). So you could just trivially
merge "subsystem" instead, which leads the o' commit as the merge base
in both cases.

And, that merge of "topic" to "subsystem" was wrong to begin with. If
you rewrite history, that has to trickle down. So A) should really have
been:

m---m---m---m-...--m---m (master)
                        \
                         o'--o'-...-o'--*'--*'--*' (topic) (subsystem)

(topic was rebased, and subsystem fast-forwarded)

So AFAICT, what your system achieves WRT ease of rebasing is that it
obsoletes the need to use "--onto" with git's rebase.

Instead of "git rebase --onto subsystem old_subsystem", you can just sa=
y
"git rebase subsystem", at the cost of a very complicated DAG.

Bj=C3=B6rn
