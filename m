X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 12:31:03 +0100
Message-ID: <20061201113103.GM18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200612010919.06030.andyparkins@gmail.com> <20061201095751.GK18810@admingilde.org> <200612011029.28059.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qgd2S+2VS1hsWwXW"
NNTP-Posting-Date: Fri, 1 Dec 2006 11:31:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612011029.28059.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32898>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq6bl-0000m8-Dx for gcvg-git@gmane.org; Fri, 01 Dec
 2006 12:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936461AbWLALbG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 06:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936462AbWLALbG
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 06:31:06 -0500
Received: from agent.admingilde.org ([213.95.21.5]:65469 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S936461AbWLALbF (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 06:31:05 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gq6bf-00052L-Ra; Fri, 01 Dec 2006 12:31:03 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--Qgd2S+2VS1hsWwXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 10:29:26AM +0000, Andy Parkins wrote:
> On Friday 2006 December 01 09:57, Martin Waitz wrote:
>=20
> > So why do you need the url hint committed to the supermodule?
> > We don't store remote information in the object database, too.
>=20
> That's why it was a hint, probably configured when you first create the=
=20
> submodule connection.
>=20
> In truth, the clone will be perfectly able to get the submodule
> objects from the upstream supermodule, maintaining the distributed
> nature easily.

that's exactly the reason why the hint is not needed.
Althogh you need to have one common project object database, storing the
objects of all modules.

> > > I say:
> > >  submodulecommithash points at a commit /in the submodule/
> >
> > But unluckily, this does not work.
>=20
> Eh?  "Not work", we're talking about code that doesn't even exist, of
> course it doesn't "work".   Do you mean "doesn't work if we're using
> my implementation of submodules"?  Well that hardly seems like a fair
> attack.

Well, at first I started exactly as you described: only store the
submodule commit sha1 in the parent somewhere, but don't traverse it.
So this is a fair attack: your implementation already exists in
http://git.admingilde.org/tali/git.git/module ;-)
(ok, yes, it really is different to what you described as I stored the
sha1 differently, but I really learned that it is important to be able
to traverse the entire commit chain, from the root of the project to the
deepest submodule.)


> > You really have to be able to traverse the entire commit chain
> > from the supermodule into all submodules.
>=20
> You can: when you hit a submodule tree object you set GIT_DIR to that
> submodule and continue.  If you don't do it like that then you have
> stored submodule trees in the supermodule and it's no longer a
> separate repository.

Well, a submodule repository _is_ special in some ways:
fsck and prune have to take the references from the supermodule into
account.  In this sense it is _not_ separate from the supermodule.

I think that is important for the submodule repository to be independent
in other ways than its object database:  you should be able to exchange
commits with other repositories (be they stand-alone or a submodule in
another supermodule).  You should be able to use log/diff/blame/whatever
inside the submodule.

All this does not need an object database of its own.
So I chose to do it the easy way and use one object database for the
entire project - and disallow git-prune in a submodule.
There may be other/better ways to do this, but you have to be able
to access all objects which belong the project inside the toplevel
project repository.

> Why you'd want to - I have no idea.  What
> purpose would you have for traversing the commit chain into the
> submodules?  The commit in the submodule is just a note of where that
> submodule was during the supermodule commit in question.

Things get much simpler if you have one big graph of objects.

clone and especially fetch/pull naturally work at once.
You can ask for all objects inside the whole project which are needed to
be transferred between project version A and B, including all submodules.

You can even have one bare repository for the whole project.

> I notice though that you avoided my question: what does YOUR submodule
> object contain?  I really do want to know, as there is obviously a
> fundamental difference in what I think a submodule does and what you
> (and maybe everybody else) thinks a submodule does.

It really only stores the commit of the submodule directly.
So there is no new submodule object type.  The parent has a direct link
to the submodule commit in his tree object and in its index.  In order
to separate them from normal files or normal subdirectories, they get a
special mode: they are represented as socket.

--=20
Martin Waitz

--Qgd2S+2VS1hsWwXW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcBJ3j/Eaxd/oD7IRAliBAKCA0CO7IMaXxtlk/MXhVhOVlJFe+QCdH3HK
4qgQsOoQJdeExcp+JC6Y33g=
=6n4s
-----END PGP SIGNATURE-----

