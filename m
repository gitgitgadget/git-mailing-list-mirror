From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFH] filter-branch: ancestor detection weirdness
Date: Fri, 8 Aug 2008 16:14:41 +0200
Message-ID: <200808081614.44422.trast@student.ethz.ch>
References: <200808080148.27384.trast@student.ethz.ch> <1218153242-18837-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0808081341170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1983395.8ugoBLGHRK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jan Wielemaker <J.Wielemaker@uva.nl>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 16:15:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRSkk-00031b-LS
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 16:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbYHHOOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 10:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbYHHOOg
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 10:14:36 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:42719 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbYHHOOf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 10:14:35 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 16:14:33 +0200
Received: from cx-public-docking-1-043.ethz.ch ([129.132.149.43]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 16:14:34 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0808081341170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
X-OriginalArrivalTime: 08 Aug 2008 14:14:34.0471 (UTC) FILETIME=[154F1F70:01C8F961]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91667>

--nextPart1983395.8ugoBLGHRK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
>=20
> On Fri, 8 Aug 2008, Thomas Rast wrote:
>=20
> > diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> > index 182822a..52b2bdf 100755
> > --- a/git-filter-branch.sh
> > +++ b/git-filter-branch.sh
> > @@ -325,15 +325,9 @@ while read ref
> >  do
> >  	sha1=3D$(git rev-parse "$ref"^0)
> >  	test -f "$workdir"/../map/$sha1 && continue
> > -	# Assign the boundarie(s) in the set of rewritten commits
> > -	# as the replacement commit(s).
> > -	# (This would look a bit nicer if --not --stdin worked.)
> > -	for p in $( (cd "$workdir"/../map; ls | sed "s/^/^/") |
> > -		git rev-list $ref --boundary --stdin |
> > -		sed -n "s/^-//p")
> > -	do
> > -		map $p >> "$workdir"/../map/$sha1
> > -	done
> > +	# Assign the first commit not pruned as the replacement.
> > +	candidate=3D$(git rev-list $ref -1 -- "$filter_subdir")

I think I see the actual problem.  I made a small testing repository
with history that looks like this:

*   a6f2213... (refs/heads/master) Merge branch 'side'
|\
| * 311f888... (refs/heads/side) outside
| * 472893d... inside dir
* | 9bd52bc... (refs/heads/stale) outside
* | d1b451a... inside dir
|/
* 1c48eea... initial

It is available at

  git://persephone.dnsalias.net/git/filtertest.git

if you want to try.  All commits labelled 'inside dir' do something in
dir/; the others don't.  (You can disregard the 'other' branch for
now; I wanted to test the behaviour on completely disconnected history
too, since that's the case with Jan's repo.)

Let's depict this as the following for now, where capitals stand for
"interesting" commits under the subdirectory filter:

   i -- A -- b(stale) -- M(master)
    \                   /
     \- C -- d(side) --/

When saying

  $ git filter-branch --subdirectory-filter dir -- --all'

I would expect the history to look like:

   A(stale) -- M(master)
              /
   C(side) --/

I think treating it this way makes a lot of sense; you get the last
state that your subdirectory had on the corresponding branch or tag.
(Similarly, a leaf branch that does not affect 'dir' should be backed
up until it hits an ancestor that survives the filter.)

Now the problem with the above ancestor detection is the following.
Consider that at this point, the 'map' directory contains the
(unfiltered) SHA1 for every commit that was rewritten during the
filtering process, i.e.

  $ g rev-list --all -- dir | git name-rev --stdin
  093c591b3d751ce778b4a6e5c2a0906b097b5868 (other~1)
  a6f22134f8ab8bcc762949df53f674e3410f7fc3 (master)
  d1b451a4b0657ea894fd772fc609f7863b7dfd15 (stale~1)
  472893d579383f56f006ff42c563dcbb730bc5b8 (side~1)

So 'map' has the values for M, A, and C.  Now if you expand the call

  (cd "$workdir"/../map; ls | sed "s/^/^/") |
          git rev-list $ref --boundary --stdin

you'll find that during ref=3Drefs/heads/side, it is equivalent to

  $ git rev-list side --boundary ^master ^side~1 ^stale~1 ^other~1
  [no output!]

Oops, it seems that wasn't what we wanted.  The '^master', which
reaches 'side' already, precludes all output.

So now that I've finally understood what is going on, I think a more
careful use of rev-list -1 is actually a correct and easy way to
figure out an ancestor.  Patch follows.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart1983395.8ugoBLGHRK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkicVNQACgkQqUud07tmzP27fgCffot0cFDCG0Z1w6+9MQTc4tLG
vlsAoIvdDoocLLwLvAS/IC1EpqYRUzVM
=udIN
-----END PGP SIGNATURE-----

--nextPart1983395.8ugoBLGHRK--
