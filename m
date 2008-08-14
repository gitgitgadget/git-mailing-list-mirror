From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 12:04:01 +0200
Message-ID: <200808141204.07530.trast@student.ethz.ch>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <48A3D1D7.5030805@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12567311.o8uFzln6yg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Aug 14 12:06:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTZhi-0008IK-5a
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 12:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbYHNKEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 06:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbYHNKEI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 06:04:08 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:4419 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbYHNKEI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 06:04:08 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 Aug 2008 12:04:06 +0200
Received: from cx-public-docking-1-043.ethz.ch ([129.132.149.43]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 Aug 2008 12:04:05 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <48A3D1D7.5030805@op5.se>
X-OriginalArrivalTime: 14 Aug 2008 10:04:05.0707 (UTC) FILETIME=[15F239B0:01C8FDF5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92341>

--nextPart12567311.o8uFzln6yg
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Andreas Ericsson wrote:
> Nicolas Pitre wrote:
> > |nico@xanadu:linux-2.6> time git rev-list --objects --all > /dev/null
> > |
> > |real    0m21.742s
> > |user    0m21.379s
> > |sys     0m0.360s
> >=20
> > That's way too long for 1030198 objects (roughly 48k objects/sec).  And=
=20
> > it gets even worse with the gcc repository:
> >=20
> > |nico@xanadu:gcc> time git rev-list --objects --all > /dev/null
> > |
> > |real    1m51.591s
> > |user    1m50.757s
> > |sys     0m0.810s
> >=20
> > That's for 1267993 objects, or about 11400 objects/sec.
> >=20
> > Clearly something is not scaling here.
> >=20
>=20
> What are the different packing options for the two repositories?
> A longer deltachain and larger packwindow would increase the
> enumeration time, wouldn't it?

=46or the fun of it, I ran a test without deltas.  Here's my normal
git.git:

  $ du -h .git/objects/pack
  26M     .git/objects/pack
  $ git rev-list --all | wc -l
  17638
  $ git rev-list --all --objects | wc -l
  82194

On a hot cache I get about 61800 objects/sec:

  $ /usr/bin/time git rev-list --all --objects >/dev/null
  1.33user 0.04system 0:01.39elapsed 98%CPU (0avgtext+0avgdata 0maxresident=
)k
  0inputs+0outputs (0major+8087minor)pagefaults 0swaps

I then made a copy of that and repacked it without deltas (remember to
remove *.keep, I tripped over that twice):

  $ git repack --depth=3D0 --window=3D0 -a -f -d
  Counting objects: 82906, done.
  Writing objects: 100% (82906/82906), done.
  Total 82906 (delta 0), reused 0 (delta 0)
  $ du -h .git/objects/pack
  339M    .git/objects/pack

Which results in only 28739 objects/sec:

  $ /usr/bin/time git rev-list --all --objects >/dev/null
  2.86user 0.11system 0:02.98elapsed 99%CPU (0avgtext+0avgdata 0maxresident=
)k
  0inputs+0outputs (0major+50162minor)pagefaults 0swaps

So maybe the GCC repository would need to be packed _better_?

Unfortunately I cannot sensibly run the same test on linux-2.6.git,
which is the next bigger git I have around: it inflates to about 3GB
after the repack, which does not fit into memory.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart12567311.o8uFzln6yg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkikAxcACgkQqUud07tmzP3biwCbBTIPYsDw/vuW7lqeYNP3byYf
xRUAnjiUydXVqBj2CSQv3yq0Pj+tFYpe
=2/3g
-----END PGP SIGNATURE-----

--nextPart12567311.o8uFzln6yg--
