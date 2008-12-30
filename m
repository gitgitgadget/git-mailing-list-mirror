From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: rebase -i: learn to rebase root commit
Date: Tue, 30 Dec 2008 13:23:27 +0100
Message-ID: <200812301323.30550.trast@student.ethz.ch>
References: <cover.1230568082.git.trast@student.ethz.ch> <200812292249.45900.trast@student.ethz.ch> <200812291621.35732.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2865655.cYEvi9gOFD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 13:24:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHdeI-0000sB-4E
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 13:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbYL3MXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 07:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbYL3MXR
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 07:23:17 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:56465 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbYL3MXR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 07:23:17 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 30 Dec 2008 13:23:15 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 30 Dec 2008 13:23:15 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <200812291621.35732.bss@iguanasuicide.net>
X-OriginalArrivalTime: 30 Dec 2008 12:23:15.0669 (UTC) FILETIME=[63EAD050:01C96A79]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104179>

--nextPart2865655.cYEvi9gOFD
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Boyd Stephen Smith Jr. wrote:
> Here's the interpretation that *I* come up with for -p --root used togeth=
er:
> The commit with no parents (OLD_ROOT) is rebased as if -p were not given,=
 call=20
> the resulting commit NEW_ROOT.  Then, the rebase continues as if "--onto=
=20
> NEW_ROOT OLD_ROOT <branch>" was specified instead of "--onto=3DNEW_ROOT^ =
=2D-root=20
> <branch>".

I like this logic, but it feels inconsistent as soon as there are
several root commits.  (This may be somewhat academic, since any repo
with several roots should also be able to cope with a merge...)

Some digging into the -p code shows that it knows which commits were
rewritten, and which were untouched.  It rewrites such that _all_
commits in $(git merge-base --all $branch $upstream) are rewritten to
look like $onto instead, i.e., all their occurrences in parent lists
of commits are rewritten to $onto.  All other commits are only
rewritten if they have a parent that was rewritten.

So I think one sane way is to define a virtual parent 'root', and
think of parentless commits as having the (sole) parent 'root'.  Then
we can rewrite such that 'root' becomes $onto, i.e., all occurrences
of 'root' in parent lists become $onto, consistent with the normal
operation.  (For the other commits, the same rule as above is
applied.)

Of course this just boils down to saying that _all_ root commits
reachable from $branch are rewritten to have $onto as their parent.
Subsequently, all other commits will also be rewritten because they
all must have at least one rewritten parent.

> Basically, --root only changes how the first commit is handled, which I t=
hink=20
> is consistent with other uses of --root.  It's also similar to cherry-pic=
king=20
> the first commit, follwed by a non-root rebase, which I think is also=20
> consistent with the intention of --root.

I believe this remark still holds if there is only a single root
commit on $branch.

I will reroll with an updated 2/3 shortly.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart2865655.cYEvi9gOFD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklaEsIACgkQqUud07tmzP2qPACfVAcWj4yCkWVixGClfHxJboqy
1h4An2s3cMayUEsVJQC66wuQZAFlh4xN
=SxW/
-----END PGP SIGNATURE-----

--nextPart2865655.cYEvi9gOFD--
