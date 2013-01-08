From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Moving (renaming) submodules, recipe/script
Date: Tue, 08 Jan 2013 09:32:14 -0500
Message-ID: <20130108143214.GA3755@odin.tremily.us>
References: <20130107003603.GA25698@odin.tremily.us>
 <20130107013952.GE3823@elie.Belkin> <50EA7269.1080006@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=liOOAslEiF7prFVr
Cc: Jonathan Nieder <jrnieder@gmail.com>, Git <git@vger.kernel.org>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 08 15:32:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsaET-00046S-4j
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 15:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756493Ab3AHOcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 09:32:24 -0500
Received: from vms173007pub.verizon.net ([206.46.173.7]:27273 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756490Ab3AHOcW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 09:32:22 -0500
Received: from odin.tremily.us ([unknown] [72.68.82.220])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MGB004ZM9PRJS90@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 08 Jan 2013 08:32:21 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id B5D0577E19D; Tue,
 08 Jan 2013 09:32:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1357655534; bh=4r6eghwDzB7vb8TNi4OCrW4pkmnMMhcrF0XSqnW9sW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=r5dt2dJJC+ti313fX6mHh1vfTENmyu0S4lulIkl4igun+0R4IZcHx9jBZ6WoC7afp
 P17cXVz8tomkGyaIJFpGbibsaS2Z0LeAIOW5mg2YODcus6ITYcxmNPZK8X9/e1yRQj
 /HbkKCMc6TYRgL8Cwo/LpjDjs8VrR8+ZMsCmxwPE=
Content-disposition: inline
In-reply-to: <50EA7269.1080006@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212966>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2013 at 07:59:53AM +0100, Jens Lehmann wrote:
> Am 07.01.2013 02:39, schrieb Jonathan Nieder:
> > (just cc-ing Jens and Peter, who might be interested)
>=20
> I=B4m currently working on teaching mv to move submodules and intend
> to send those patches to the list after finishing submodule deinit.
> Please see
>   https://github.com/jlehmann/git-submod-enhancements/commits/mv-submodul=
es
> for the current state of this series.

Thinking about this a bit more, I'm not clear on how out-of-tree
updates (i.e. worktree in .git/modules/*/config) propogated during
branch checkouts (merges, rebases, etc.).  I just got a broken rebase
trying to move a trivial patch back before the submodule move, and Git
was confused about what had happened to the submodules.  Here's a
simple script that illustrates the problem:

  #!/bin/sh
  rm -rf a b c
  mkdir a
  (cd a
   git init
   echo a > README
   git add README
   git commit -am 'a'
  )
  git clone a b
  (cd b
   git submodule add ../a submod-1
   git commit -am 'add submodule at submod-1'
  )
  git clone b c
  (cd c
   git submodule update --init
  )
  (cd b
   git-submodule-mv.sh submod-1 submod-2
   git commit -am 'move submodule from submod-1 to submod-2'
  )
  (cd c
   git pull
   ls -d .git/modules/*
   cat .git/modules/submod-1/config
   ls -a submod*
  )

The end result is that `c` gets the `.gitmodules` path updates and new
gitlinked directory from the submodule move in `b` (using my
git-submodule-mv.sh posted earlier in this thread), but `submod-1` is
left lying around (because Git doesn't know that it can remove
submod-1/.git and submod-1/README).  The Git directory for the
submodule stays in .git/modules/submod-1/ (good), but the worktree in
=2Egit/modules/submod-1/config still points to ../../../submod-1 (bad).

This means that submodule moves are possible, but anyone trying to
share them between several repositories (or trying to rebase across
the move within their own repository) is in for a world of suffering
;).  I'm not sure how this should be addressed, but I didn't see
anything handling it in Jens' new series.

Thanks,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ7C3sAAoJEEUbTsx0l5OMj5gP/3a3MiBu/PJhguu8IPGW9Kw6
hY98l33YBB1LHH/0o+cOjedvmSp20hZCSHbsNhTXiLlgmxSjwRihzGjHCzDKLQv2
zUX4mZ1QfOeiYh3GJ0cBUu61uhzcyIMNgDVlZ6aRBd5WbM46JFOdrkvZMXpKWmMl
bLQjKdpnFqeX9hQDdM94FPYdlT61yH15qXXzMqRQCIwr+Uk0MMHgx6uTitdMCmAO
tXtg0qY1oPXgtoMmR5kUf4iekgG7Fth/U+h6hgT03QEaAZKYYXkyeSWGi78dzh7P
koACNbFOEwXGPXeKxq1KQHWuP8EyAQgw7peD+RzKncmohtMQTtgCBPTLgMwQQ/LU
xSaTn7GR2g6uDhNaDB0xSYy+FWl8u7r0mtr0piA69VAqnuCfC7/IoLhxFfFdFKNI
RJZlNlLpeA9fcW1vhUOL926zAAIpAIRSlmkFMti9uKqpIih7GNdxq/mjYmfoR8PR
EVD0D9FXa6AEEKhaNDdb7C+0OhoOAXxrKJVTvKhqVWeSKI7sPqMZ/ynK4JkIfdUb
+U4z6zUhl5iOsyCO1P0zPxQ1YRNfr87etQ+sAl19UZMAgxtexGdKhKWQljhsna6W
TlyaM+Quhiu8zC+iUyBy4tcPMaFLiu5quqorwiyRvkAgjXS7BUny9jxcsH7hQCBz
tJfyCQ8yLvHBTj++Pgmi
=1Tbl
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
