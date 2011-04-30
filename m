From: Jeff King <peff@peff.net>
Subject: Re: git symbolic-ref vs. reflog (vs. rebase)
Date: Sat, 30 Apr 2011 00:13:12 -0400
Message-ID: <20110430041312.GA5287@sigill.intra.peff.net>
References: <ipek0o$l0v$1@dough.gmane.org>
 <7vk4edyqqn.fsf@alter.siamese.dyndns.org>
 <BANLkTi=yDECQs=mVkEfrkrFfy0dgFf4U3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Csaba Henk <csaba@lowlife.hu>
X-From: git-owner@vger.kernel.org Sat Apr 30 06:13:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QG1Yc-00020t-QU
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 06:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882Ab1D3ENQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Apr 2011 00:13:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57228
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab1D3ENP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2011 00:13:15 -0400
Received: (qmail 18680 invoked by uid 107); 30 Apr 2011 04:14:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 30 Apr 2011 00:14:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Apr 2011 00:13:12 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=yDECQs=mVkEfrkrFfy0dgFf4U3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172516>

On Fri, Apr 29, 2011 at 10:51:31PM +0530, Csaba Henk wrote:

> > Yes, it is. =C2=A0But you can choose to do:
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git branch side
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git symoblic-ref -m "move to side" HEA=
D refs/heads/side
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git log --oneline -g HEAD@{0}
> > =C2=A0 =C2=A0 =C2=A0 =C2=A005ddb9b HEAD@{0}: move to side
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0e69de29 HEAD@{1}: commit (initial): firs=
t commit
> >
> > if you wanted to.
>=20
> So do you think the following patch would be the correct fix for the
> rebase issue:
>=20
> diff --git a/git-rebase.sh b/git-rebase.sh
> index cbb0ea9..10c1727 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -284,7 +284,7 @@ do
>                 head_name=3D"$(cat "$dotest"/head-name)" &&
>                 case "$head_name" in
>                 refs/*)
> -                       git symbolic-ref HEAD $head_name ||
> +                       git symbolic-ref -m "rebase: aborting" HEAD
> $head_name ||
>                         die "Could not move back to $head_name"
>                         ;;
>                 esac

I count 2 uses of symbolic-ref without reflogs in git-rebase, one more
in git-rebase--interactive, and one in git-cvsexportcommit. Should all
be fixed to write a reflog entry?

The one in git-rebase.sh:move_to_original_branch even takes care to
write a reflog message when updating the ref. So the branch reflog has
an entry for the rebase being finished, but the HEAD reflog gets
nothing. Presumably it's OK because we're moving from the detached
version of some commit to seeing it on the branch.

What does a user expect? Personally I think it would be more readable t=
o
see the extra entry. For example, this is from my current reflog:

  $ git log -g --oneline
  ...
  50d3062 HEAD@{23}: checkout: moving from jk/merge-one-file to 50d3062=
ab2cea4e999b8f3bafd211ff348bca600
  660fe6b HEAD@{24}: commit (amend): merge-one-file: fix broken merges =
with GIT_WORK_TREE
  ebad5e6 HEAD@{25}: commit (amend): merge-one-file: fix broken merges =
with GIT_WORK_TREE
  306f37e HEAD@{26}: rebase -i (pick): merge-one-file: fix broken merge=
s with GIT_WORK_TREE
  0681894 HEAD@{27}: commit (amend): add tests for merge-index / merge-=
one-file
  77d4cba HEAD@{28}: cherry-pick
  50d3062 HEAD@{29}: checkout: moving from jk/merge-one-file to 50d3062=
ab2cea4e999b8f3bafd211ff348bca600
  ...

So reading in reverse order, I see that I started a rebase, which moved
us to a detached HEAD, then picked and amended some commits. And then
nothing, and suddenly I'm moving back from a branch to another detached
HEAD (I rebased again). It would be easier to follow if HEAD{23} were
actually:

  660fe6b HEAD{23}: rebase finished: returning to jk/merge-one-file

This feels a little nit-picky. I have to admit I don't try to follow
these sorts of reflogs all the time, so it's not like this is a pressin=
g
issue. But when it comes to a user deciphering a broken state in their
repository, or trying to figure out which actions they took in a rebase
last week, the more entries we can give them, the better.

-Peff
