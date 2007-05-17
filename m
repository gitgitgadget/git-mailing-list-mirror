From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 22:04:31 +0200
Message-ID: <20070517200431.GA3079@efreet.light.src>
References: <20070515201006.GD3653@efreet.light.src> <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com> <Pine.LNX.4.64.0705161232120.6410@racer.site> <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com> <Pine.LNX.4.64.0705170152470.6410@racer.site> <20070517010335.GU3141@spearce.org> <alpine.LFD.0.99.0705162309310.24220@xanadu.home> <Pine.LNX.4.64.0705171143350.6410@racer.site> <alpine.LFD.0.99.0705170954200.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu May 17 22:05:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HomDa-0006UI-BX
	for gcvg-git@gmane.org; Thu, 17 May 2007 22:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbXEQUEu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 16:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754377AbXEQUEu
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 16:04:50 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:2570 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754072AbXEQUEu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 16:04:50 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP  id 5203017.316220;
	Thu, 17 May 2007 22:04:34 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HomD9-000190-BW; Thu, 17 May 2007 22:04:31 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99.0705170954200.24220@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47552>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2007 at 10:41:37 -0400, Nicolas Pitre wrote:
> On Thu, 17 May 2007, Johannes Schindelin wrote:
> > On Wed, 16 May 2007, Nicolas Pitre wrote:
> And if you have 1) the permission and 2) the CPU power to execute such a=
=20
> cgi on the server and obviously 3) the knowledge to set it up properly,=
=20
> then why aren't you running the Git daemon in the first place?  After=20
> all, they both boil down to running git-pack-objects and sending out the=
=20
> result.  I don't think such a solution really buys much.

Yes, it does. I had 2 accounts where I could run CGI, but not separate
server, at university while I studied and now I can get the same on friend's
server. Neither of them would probably be ok for serving larger busy git
repository, but something smaller accessed by several people is OK. I think
this is quite common for university students.

Of course your suggestion which moves the logic to client-side is a good on=
e,
but even the cgi with logic on server side would help in some situations.

> On the other hand, if the client does all the work and provides the=20
> server with a list of ranges within a pack it wants to be sent, then you=
=20
> simply have zero special setup to perform on the hosting server and you=
=20
> keep the server load down due to not running pack-objects there.  That,=
=20
> at least, is different enough from the Git daemon to be worth=20
> considering.  Not only does it provide an advantage to those who cannot=
=20
> do anything but http out of their segregated network, but it also=20
> provide many advantages on the server side too while the cgi approach=20
> doesn't.
>=20
> And actually finding out the list of objects the remote has that you=20
> don't have is not that complex.  It could go as follows:
>=20
> 1) Fetch every .idx files the remote has.

=2E.. for git it's 1.2 MiB. And that definitely isn't a huge source tree.
Of course the local side could remember which indices it already saw during
previous fetch from that location and not re-fetch them.

A slight problem is, that git-repack normally recombines everything to
a single pack, so the index would have to be re-fetched again anyway.

> 2) From those .idx files, keep only a list of objects that are unknown=20
>    locally.  A good starting point for doing this really efficiently is=
=20
>    the code for git-pack-redundant.
>=20
> 3) From the .idx files we got in (1), create a reverse index to get each=
=20
>    object's size in the remote pack.  The code to do this already exists=
=20
>    in builtin-pack-objects.c.
>=20
> 4) With the list of missing objects from (2) along with their offset and=
=20
>    size within a given pack file, fetch those objects from the remote=20
>    server.  Either perform multiple requests in parallel, or as someone=
=20
>    mentioned already, provide the server with a list of ranges you want=
=20
>    to be sent.

Does the git server really have to do so much beyond that? I didn't look at
the algorithm that finds what deltas should be based on, but depending on
that it might (or might not) be possible to proof the client has everything=
 to
understand if the server sends the objects as it currently has them.

> 5) Store the received objects as loose objects locally.  If a given=20
>    object is a delta, verify if its base is available locally, or if it=
=20
>    is listed amongst those objects to be fetched from the server.  If=20
>    not, add it to the list.  In most cases, delta base objects will be=20
>    objects already listed to be fetched anyway.  To greatly simplify=20
>    things, the loose delta object type from 2 years ago could be revived=
=20
>    (commit 91d7b8afc2) since a repack will get rid of them.
>=20
> 6 Repeat (4) and (5) until everything has been fetched.

Unless I am really seriously missing something, there is no point in
repeating. For each pack you need to unpack a delta either:
 - you have it =3D> ok.
 - you don't have it, but the server does =3D>
    but than it's already in the fetch set calculated in 2.
 - you don't have it and nor does server =3D>
    the repository at server is corrupted and you can't fix it.

> 7) Run git-pack-objects with the list of fetched objects.
>=20
> Et voil=C3=A0.  Oh, and of course update your local refs from the remote'=
s.
>=20
> Actually there is nothing really complex in the above operations. And=20
> with this the server side remains really simple with no special setup=20
> nor extra load beyond the simple serving of file content.

On the other hand the amount of data transfered is larger, than with the git
server approach, because at least the indices have to be transfered in
entirety. So each approach has it's own advantages.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFGTLVPRel1vVwhjGURAsL3AJd7auk084G/pepK2iWS5dmHOhZXAKC7x6Us
VeXL08KyAj1VqHtqMdujog==
=Kxff
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
