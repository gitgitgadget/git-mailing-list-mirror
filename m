From: Martin Waitz <tali@admingilde.org>
Subject: Submodule object store
Date: Tue, 27 Mar 2007 01:16:38 +0200
Message-ID: <20070326231637.GJ22773@admingilde.org>
References: <1174825838.12540.5.camel@localhost> <1174930688.5662.20.camel@localhost> <20070326183523.GG22773@admingilde.org> <200703262133.44520.Josef.Weidendorfer@gmx.de> <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6lCXDTVICvIQMz0h"
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:16:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVyQh-0008L1-9g
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 01:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbXCZXQo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 19:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbXCZXQo
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 19:16:44 -0400
Received: from mail.admingilde.org ([213.95.32.147]:34151 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbXCZXQn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 19:16:43 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HVyQZ-00037r-Fm; Tue, 27 Mar 2007 01:16:40 +0200
Content-Disposition: inline
In-Reply-To: <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43202>


--6lCXDTVICvIQMz0h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Mar 26, 2007 at 03:51:21PM -0700, Junio C Hamano wrote:
> I was not following the gitlink discussion closely, but what is
> the motivation behind this separation of the object store?

Mostly scalability.
Some operations need to traverse all objects and this may be prohibitive
in large repositories.  So the traversal has to be split somehow to not
require all objects to be loaded into RAM at the same time.
The most natural separation is at the submodule level.
The idea is to collect all the submodule references in the supermodule
and then traverse the submodule independently with the saved references.

To make purge and fsck work we have the hard requirement that it
must be possible to list all objects which belong to one submodule.
As modules (rightfully!) don't have any project ID, we need some other
means to map submodule tree entries which are stored in the supermodule to
the corresponding object store.
The most simple way is to use the location of the submodule within the
parent to find the submodule object store.  prune and fsck can then use
a path-limited commit traversal in the parent to get all relevant
submodule references.


And moving the submodule object store into the .git directory of the
supermodule has several reasons: in bare repositories it has to be
that way anyway and I don't want to loose the submodules history if
the user decides to remove the submodule from his working directory.

Not the entire submodule object store has to be moved this way, only
that part that is referenced by the supermodule.  So it can make sense
to have a full .git repository in the submodule, together with another
object store (handled like alternates) in the supermodule.

--=20
Martin Waitz

--6lCXDTVICvIQMz0h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGCFRVj/Eaxd/oD7IRApVzAJ93vPcPWFdVnIHrQUTjlZ0Y1W/uJACfUIxP
Cb35s3+oLvNfN8Hs16ANs5Y=
=nN+I
-----END PGP SIGNATURE-----

--6lCXDTVICvIQMz0h--
