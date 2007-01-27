From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 10:04:52 +0100
Message-ID: <45BB15B4.7030009@fs.ei.tum.de>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC04063FA0185382223480291"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 10:05:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAjVB-0005Kg-MS
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 10:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbXA0JFe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 04:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbXA0JFe
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 04:05:34 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:32952 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbXA0JFF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 04:05:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id F1C04281ED;
	Sat, 27 Jan 2007 10:05:00 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RW6Ytr53pgo9; Sat, 27 Jan 2007 10:05:00 +0100 (CET)
Received: from [62.216.202.61] (ppp-62-216-202-61.dynamic.mnet-online.de [62.216.202.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 4086C281E8;
	Sat, 27 Jan 2007 10:05:00 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <20070127080126.GC9966@spearce.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37937>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC04063FA0185382223480291
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Shawn O. Pearce wrote:
> This triplet would probably be encoded with descendant-commit using
> OBJ_REF, ancestor-commit being an OBJ_OFS style back reference within
> the pack (or OBJ_REF if not in this pack) and ancestor-object would
> also be an OBJ_REF.  So a triplet probably would wind up costing
> ~60 bytes.

I'd propose the following:

Have a "shadow" tree which is storing DAG information per entry of the or=
iginal tree.  keep this shadow tree sorted in the same order the original=
 tree object is.  for simplicity i will now add the new information to th=
e tree examples, but of course this new data cannot be stored in the tree=
 itself and can't be hashed.

tree
<filename> <mode> <object> (<new: ancestor commit> <new: ancestor object>=
)*

the ancestor object isn't necessary, it would just speed up annotations. =
 considering that we want to look only at the path, it is superfluous.  i=
f we want to traverse copies/moves as well, this could be helpful.

now, this information allows us to build a object-level (read: path ident=
ifies object) DAG, by starting out on the current tree and retrieving the=
 associated information.  using this it is possible to jump to the next c=
ommit/tree which changed the object and start over.

expense:  8 or 40 bytes per parent, per object, per commit, for each tree=
 modified.

per parent:  we of course store information about all parents
per object:  as this is a "shadow" tree, we need to annotate all entries =
and not just changed ones
for each tree modified:  (sub)trees not being modified of course do not n=
eed annotation *again*

but:  this shadow tree can be deltified quite tightly, i'd say.  possibly=
 with a different, specialized tree delta method.  then this boils down t=
o 8 or 40 bytes per *changed* object, plus delta overhead.

> This of course penalizes objects which don't ever change, as we'd
> have to walk back a good chunk of the DAG before we find a matching
> triplet.  But I would suspect that files which never change are
> also not given to log/blame very often either.  And once we do find
> a triplet, we can skip through the DAG in time proportional to the
> rate of change for the path, rather than to the entire repository.

using my proposal this penalty does not exist.  i think it would be reall=
y awkward to have the annotation of a never-changed Makefile to take way =
longer than the operation on a recently/often changed file.

we'd have to compare the space requirements of both approaches.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigC04063FA0185382223480291
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFuxW3r5S+dk6z85oRAtibAJ9akgst7Bb8YbAQ03a3zDL7+BzmjACgxtUt
TOJq4Nrn5HtO5oVg97aMB3g=
=cBt7
-----END PGP SIGNATURE-----

--------------enigC04063FA0185382223480291--
