From: Martin Waitz <tali@admingilde.org>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 17:25:07 +0200
Message-ID: <20070327152507.GO22773@admingilde.org>
References: <20070326183523.GG22773@admingilde.org> <200703262133.44520.Josef.Weidendorfer@gmx.de> <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net> <20070326233603.GL22773@admingilde.org> <Pine.LNX.4.63.0703261515330.14387@qynat.qvtvafvgr.pbz> <20070326235527.GM22773@admingilde.org> <Pine.LNX.4.63.0703261530030.14387@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3hAdtgBjtgL7p0NQ"
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 17:25:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWDXx-00036T-TE
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 17:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbXC0PZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 11:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753901AbXC0PZK
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 11:25:10 -0400
Received: from mail.admingilde.org ([213.95.32.147]:58641 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbXC0PZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 11:25:08 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HWDXn-0002I1-3Y; Tue, 27 Mar 2007 17:25:07 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703261530030.14387@qynat.qvtvafvgr.pbz>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43274>


--3hAdtgBjtgL7p0NQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

Its really funny that when I proposed one big object database everybody
wanted it separated and now that I propose a separate database everybody
wants it as one combined database.
I read this as a sign that people really try to think critically about
the design, which is a good thing and will hopefully lead to a good
and stable submodule implementation.

On Mon, Mar 26, 2007 at 03:40:15PM -0800, David Lang wrote:
> useing the same object store makes this work automaticaly (think of all t=
he=20
> copies of COPYING that would end up being the same as a trivial example)

Yes, but I guess not much more than COPYING, INSTALL, some trivial
Makefiles and empty files will be shared between subprojects.
Except when you have the same subproject in your tree multiple times,
of course.

Yet this sharing is exactly why I started to do it that way, until Linus
stopped me.

> >If someone comes up with a nice way to handle everything in one big
> >object store I would happily use that! :-)
>=20
> what exactly are the problems with one big object store?

I think we really have to discuss this separation on several layers:
traversal, pack-files, and object database.

For the traversal the point of separating it into a per-module traversal
is that only one module has to be loaded into RAM at a time.
This effects all operations which do a (potentially) recursive traversal:
push, pull, fsck, prune, repack.
However a separated traversal will no longer be garanteed to only list
an object once, so this has to be handled in some way.

Pack files should have better access patterns if they are per-module.
Most of the time you are only interested in one individual module and
locality is important here.

Separating the entire object database is a way to improve unreachability
analysis, as it now can be done per module.
The other two separations are easier to implement with a separated
object database, but that's not too strong an argument.


So if we can come up with a nice way to do unreachability analysis we
can indeed go on with the shared object database and tackle the
remaining scalability issues as they arise.  Those could then be added
later without changing the on-disk format.

> ones that I can think of:
>=20
> 1. when you are doing a fsck you need to walk all the trees and find out=
=20
> the list of objects that you know about.
>=20
>   done as a tree of binary values you can hold a LOT in memory before=20
>   running into swap.

Could you explain the algorithm you are thinking about in more detail?

>   if it's enough larger then available ram then an option for fsck to use=
=20
>   trees on disk is an option.

This could simplify some things.
There could be an on-disk index of all known objects, so that the sha1
sums do not have to loaded into RAM all at once.

--=20
Martin Waitz

--3hAdtgBjtgL7p0NQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGCTdSj/Eaxd/oD7IRAlODAJ96jojW84apYT5x2RBpvM5llgu93gCdHLc7
MQbW6NqR7nlH7LJm6d+OSRY=
=fKs7
-----END PGP SIGNATURE-----

--3hAdtgBjtgL7p0NQ--
