From: Martin von Gagern <Martin.vGagern@gmx.net>
Subject: [BUG] Assertion failed: (child->real_type == OBJ_REF_DELTA), function
 find_unresolved_deltas_1, file builtin/index-pack.c
Date: Fri, 01 Aug 2014 14:24:27 +0200
Message-ID: <53DB86FB.9080204@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HGeShXcluVN0u55IJwxfOHE5FberrfpDm"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 14:24:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDBt2-0002pS-F3
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 14:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405AbaHAMYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 08:24:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:64714 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbaHAMYf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 08:24:35 -0400
Received: from [192.168.71.20] ([178.27.35.248]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0Lz3JU-1WQmH40Ee8-0149Tb for <git@vger.kernel.org>;
 Fri, 01 Aug 2014 14:24:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:5/jAws2UeQjPplDLZeafoTIHLFNN6/kwGNHAc5xq52gi10LeBgf
 gEYqdWXVVKUT39bYtlbeYNjQ2gFZK9m27R3LXJCBPR6RTOn4gRWG9fH8K/oW75+v568q2nE
 nzdgmmCGbhLOswioQbOJ8Q/M8PZJDF2V9kS8SIBRr8biBMOr8bmWILgjSH4fJY+V03D7Xid
 SfijuGxNNttZlzhryuA1g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254626>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HGeShXcluVN0u55IJwxfOHE5FberrfpDm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

See also https://code.google.com/p/support/issues/detail?id=3D31571

Executing the command

git clone https://code.google.com/p/mapsforge/

fails with the error message

Assertion failed: (child->real_type =3D=3D OBJ_REF_DELTA),
function find_unresolved_deltas_1, file builtin/index-pack.c

Bisecting the code I found that 7218a215efc7ae46f7ca8d82 (from 2011,
first released in git 1.7.7) is the first bad commit. It is also the one
to introduce that assertion.

The idea behind that commit seems simple: instead of just sorting by
base hash, also sort by type. Then when iterating over the matching
objects, we can rely on the type and don't have to check that.

So far, so good. But the problem here is that the sorting is based on
the "type" attribute, while the assertion and the case distinction it
replaces was based on "real_type". I guess that at the point where the
sorting takes place, these two should be identical. But once
resolve_delta gets called, the real_type is changed to that of the base
object. Which means that the original case distinction did more than
just drop deltas of the wrong type: it also prevented resolution of
already-resolved deltas. Therefore the change caused stuff to fail which
used to work before. In this particular instance, the real_type changed
from OBJ_REF_DELTA to OBJ_TREE which caused the assertion to fail.

I'm not sure whether this kind of duplicate resolution is something
normal or indicates some breakage in the repository in question. If it
is considered normal (although rare, otherwise others would have
complained by now), then someone should likely turn the assertion back
into a normal conditional. If this is a broken repository, then I think
it should be reported as such, since in my book a failed assertion
indicates a problem with the program itself, not its input data.

Thank you very much,
 Martin von Gagern


--HGeShXcluVN0u55IJwxfOHE5FberrfpDm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPbhwEACgkQRhp6o4m9dFsYPACePaoMbh3MfOwV2Awu6yFQ1S/4
BMgAnR6x23SH65qwK+DrC9NEpb0is/ve
=t8vZ
-----END PGP SIGNATURE-----

--HGeShXcluVN0u55IJwxfOHE5FberrfpDm--
