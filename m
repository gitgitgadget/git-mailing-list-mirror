From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Thu, 10 Dec 2009 08:43:58 +0100
Message-ID: <20091210074358.GA7723@atjola.homenet>
References: <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0912090941420.470@ds9.cixit.se>
 <20091209093758.GA2977@redhat.com>
 <alpine.DEB.2.00.0912091150470.470@ds9.cixit.se>
 <20091209112237.GA27740@atjola.homenet>
 <m2pr6ocqrb.fsf@igel.home>
 <20091209120610.GA29430@atjola.homenet>
 <20091209120748.GI2977@redhat.com>
 <20091209130653.GA30218@atjola.homenet>
 <7v1vj4orra.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 08:44:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIdh5-0005mR-Mk
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 08:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760612AbZLJHn7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Dec 2009 02:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760611AbZLJHn7
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 02:43:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:56392 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760504AbZLJHn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 02:43:58 -0500
Received: (qmail invoked by alias); 10 Dec 2009 07:44:04 -0000
Received: from i59F5468C.versanet.de (EHLO atjola.homenet) [89.245.70.140]
  by mail.gmx.net (mp033) with SMTP; 10 Dec 2009 08:44:04 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19GaeJ0cwBGLfWGQboT+iQESxcWE9DFqH48K09YG1
	S27KKLqsQwMUk6
Content-Disposition: inline
In-Reply-To: <7v1vj4orra.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135013>

On 2009.12.09 11:46:01 -0800, Junio C Hamano wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>=20
> > "merge --squash" is one of the things I really dislike, because it =
turns
> > off the "history" part of the merge. You can say "Merging in git is=
 about
> > histories, merging in svn is about changes only" to describe the ma=
jor
> > difference for the merge commands in the two systems... "But then
> > there's --squash which turns git into svn".
>=20
> I agree with this to some degree, but I do not offhand think of a bet=
ter
> alternative. =20
>=20
> At the first sight, it looks as if what "merge --squash" does was
> implemented as a new option "--squash" to the "merge" command merely
> because the way _how_ it internally needs to compute the result was
> already available in the implementation of "merge" command, and not
> necessarily because _what_ it does was conceptually consistent with t=
he
> way "merge" works.
>=20
> But at the conceptual level, "merge --squash" is a short-hand for thi=
s
> command sequence:
>=20
>     git rebase -i HEAD that-branch
>     ... make everything except the first one into "squash"
>     git checkout - ;# come back to the original branch
>     git merge that-branch ;# fast forward to it
>=20
> So after all, it is "merge it after squashing them".

To me, that approach looks backwards, just like the "rebase --revisions=
"
proposal. "rebase" just happens to already provide the necessary
operations, but if cherry-pick would accepts ranges, this looks a lot
more logical to me:

git cherry-pick HEAD..that_branch
git reset --soft this_branch@{1} # [1]
git commit

[1] I assume that like "rebase", such a cherry-pick command would
already add a single reflog entry for the current branch

I cherry-pick all changes, and then use reset + commit to squash them
together to a single commit. To me, it's "I want to get all the changes
and squash them into a single commit", not "I want to squash the other
side's history in the background, without actually affecting the other
side and then merge that squashed version of the history".

So "cherry-pick --squash ..that_branch" seems more logical at the
conceptual level.  Internally, it could of course just do a three-way
merge, instead of being stupid and repeating the "apply, commit --amend=
"
sequence over and over again.

Bj=F6rn
