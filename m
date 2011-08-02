From: martin f krafft <madduck@madduck.net>
Subject: working prototype of orphan parent commits as datastores (was:
 Storing additional information in commit headers)
Date: Tue, 2 Aug 2011 17:03:21 +0200
Message-ID: <20110802150321.GA1390@fishbowl.rw.madduck.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <20110801201301.GA17111@sigill.intra.peff.net>
 <20110801211104.GC15401@fishbowl.rw.madduck.net>
 <20110802035056.GB17494@sigill.intra.peff.net>
 <20110802082810.GC29887@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
To: Jeff King <peff@peff.net>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Aug 02 17:03:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoGVS-0006Jc-Lg
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 17:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab1HBPDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 11:03:38 -0400
Received: from seamus.madduck.net ([213.203.238.82]:41322 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab1HBPDh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 11:03:37 -0400
Received: from fishbowl.rw.madduck.net (28-193.78-83.cust.bluewin.ch [83.78.193.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id 0FE07407D3B;
	Tue,  2 Aug 2011 17:03:22 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id E83122014A; Tue,  2 Aug 2011 17:03:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110802082810.GC29887@fishbowl.rw.madduck.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux wheezy/sid kernel 3.0.0-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97.1 at seamus
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178474>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach martin f krafft <madduck@madduck.net> [2011.08.02.1028 +0200]:
> What do you think about using the idea of orphan parent commits
> (OPC) for now? These are conceptually closest to the x-*-ref
> pointers, do not require extra setup, pollute history only a little
> bit (IMHO), and slot in with Git and fsck/gc alright.
>=20
> Here's the idea again, graphically:
>=20
>   o--o--o--=E2=97=8F
>        /
>       #
>=20
> while at HEAD, I would backtrack history until I found HEAD^, which
> has a parent with a well-defined commit message and holding the data
> I am looking for.
>=20
> Later, when x-*-ref is mainline, instead of parent pointers, it can
> be used in place.
>=20
> When there is a merge and the TopGit data need updating, a new
> OPC is slotted into place, on the merge commit. In
> the following graph, the user then decided also at a later point to
> update e.g. the TopGit patch description (.topmsg), which is also
> stored in this OPC:
>=20
>        o--o-o
>       /      \      maint       master
>   o--o--o--o--+--o--O--o--o--o--=E2=97=8F
>        /     /           /
>       #     #           #
>=20
> To keep things simple, every OPC copies the unchanged data from the
> previous one as well (compression will reduce the overhead).

I have published a working prototype of this kind of datastore, in
case people are interested:

  http://git.madduck.net/v/code/topgit-ng.git

Here's a bit of synopsis:



% ./tg-datastore list
I: returns non-zero if no datastore found at given commit.
I: prints contents of datastore otherwise.
message: this is a proof-of-concept

% ./tg-datastore find commitref
I: prints the value of the parameter, or empty if parameter is not found.
I: returns non-zero if no datastore was found.
dc58ec49df849ec1aef6929cd40c759a6018e056

% git commit --allow-empty -mone
[master 78918bb] one

% git commit --allow-empty -mtwo
[master 7eca0cd] two

% ./tg-datastore find message
I: prints the value of the parameter, or empty if parameter is not found.
I: returns non-zero if no datastore was found.
this is a proof-of-concept

% ./tg-datastore find commitref
I: prints the value of the parameter, or empty if parameter is not found.
I: returns non-zero if no datastore was found.
dc58ec49df849ec1aef6929cd40c759a6018e056

% ./tg-datastore add message=3D'this is a new message'
I: returns non-zero if there is already a datastore on HEAD.
I: adding the following data to the datastore of HEAD:
I:   message: this is a new message

% ./tg-datastore find commitref
I: prints the value of the parameter, or empty if parameter is not found.
I: returns non-zero if no datastore was found.
8e6179050a1aca5485f3e1702780f1b555d8643b

% ./tg-datastore find message
I: prints the value of the parameter, or empty if parameter is not found.
I: returns non-zero if no datastore was found.
this is a new message

  tig output now:
    2011-08-02 16:52 martin f. krafft   M=E2=94=80=E2=94=90 [master] two
    2011-08-02 16:54 TopGit             =E2=94=82 I TopGit data node
    2011-08-02 16:52 martin f. krafft   I one
    2011-08-02 16:50 martin f. krafft   M=E2=94=80=E2=94=90 [origin/master]=
 import first prototype
    2011-08-02 16:50 TopGit             =E2=94=82 I TopGit data node
    2011-08-02 16:48 martin f. krafft   I Initial (empty) root commit

% ./tg-datastore remove
I: always returns zero, even if there was nothing to remove.

% ./tg-datastore find message
I: prints the value of the parameter, or empty if parameter is not found.
I: returns non-zero if no datastore was found.
this is a proof-of-concept



Note three things:

  1. I am actually using a x-* header in the TopGit data node commit
     object to help identify it as a commit. This could be done
     differently (e.g. parse the commit message for some magic), but
     I chose to do this on purpose to see how well it fares.

  2. If Git grew x-*-ref headers (refs to objects in general),
     I could use that instead and drop the parent pointer, which
     would make the DAG cleaner.

  3. Right now, you cannot add parent orphan commits to orphans
     themselves, but it would be trivial to enable. I just couldn't
     be bothered.

Enjoy, and comments of course welcome.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
windoze nt crashed.
i am the blue screen of death.
no one hears your screams.
=20
spamtraps: madduck.bogus@madduck.net

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJOOBG5wBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xHyx
D/9W7GIPttJQqJ14h8Jd9qZrJzM/LrLbwI8rGtUOq6+4ff/8ajscpl9gjcMRFlSl
emMSbPOVXm/UeCKU16PHLFqq2LNV+HZldRAOD/W0N0ekW7vUzTCGiQTMrinSbSkZ
/nSK4tgNwco1O3k9gQLhEuwXD2vLrbNTC9JsJAiAQOUYP4P0t8Ba45GGWZxyPFPm
H+ahZFIh+ww7TtPGDpStPT3CUe2dj6FTJMn2JQEAx4Wsm+tU1FcDLsYdsOL+8jV2
+0a5hWr3qzC9sbw7i/IUA+x6PMmVklP7dUN084/dcWvIZgA/a1GuRTbzigmnpTuJ
3Y1bF+0wCLnm93iZxQdh6fWFffnKTq1Qv1fo5PEUFxE770lC1UqHxo2bL+VVh0hj
owlRlXl2+NK0vKYRC/xYqxXWM29FK8LzEvtC+eZJPcdhzzoF/GINOv9p/+eO6nF8
R5cKd5zYpycpCCD5wK1YvXLm171MyO7XigTvVCmqYJ5NokbyY2W/WMXKXYxz59nN
K1o0YMefZpzMD+O1EtG2V94RjcPZtlUCHItgtHWkYAgmAU+YyzqugUMkwElRjXf1
vHmrpf4zNiXRrz/9IZDOrq15DEGJCOUdwS0Ybuog23N7HbYoenbjuaUE+BHNem+c
6YdTGVz36FuPLVq2DGzt6Ph2ljzk41iHG5aA5+rBoMYTrw==
=ZmrJ
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
