From: "W. Trevor King" <wking@tremily.us>
Subject: Elegant subdirectory checkout of remote-tracking branch?
Date: Fri, 01 Mar 2013 10:22:53 -0500
Message-ID: <20130301152253.GA9312@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=OgqxwSJOaUobr8KG
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 01 16:23:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBRoB-0000QQ-Jf
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 16:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320Ab3CAPXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 10:23:14 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:57113 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab3CAPXN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 10:23:13 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIZ00CSYMQ62K40@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 01 Mar 2013 09:22:55 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id E38128EA0E4; Fri,
 01 Mar 2013 10:22:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1362151373; bh=Cf1zDBY6SWuEcj6frt1I7W0QATVgAgW20EngU4FZ478=;
	h=Date:From:To:Subject;
	b=Wx5QgzUph++iMYTQMvH/+VFMrqlb0buRixsxd8vD7Q6jgt3dzKc+rV9TfuTBKAtPz
 ZJm99bql+syPJm+GhfNJsUkAdK+StfN0XpiGomRbUyfENNa52IxREncNCdg0b5wlrx
 jTwr1FnNDT6xLDaL4JGqaUJ3mnghQjwwK2NhpTnY=
Content-disposition: inline
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217280>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm trying to figure out the most efficient way to keep an up to
date `todo` branch checked out in Meta [1].  I've tried a few
things like:

  $ git submodule add -b refs/remotes/origin/todo --reference ./ -- ./ Meta

and:

  $ git clone --single-branch --branch refs/remotes/origin/todo ./ Meta

These fail because I can't use a remote tracking branch as a
source for the clone.  It should be possible to do:

  $ git clone --reference . --single-branch --branch todo git://git.kernel.=
org/pub/scm/git/git.git Meta

but that will require (I think) network access during a fetch.
Since I'm already fetching `origin` from the superproject, I
don't want to have to refetch them for the submodule (or whatever
Meta ends up being).  Here's what I think happens with a
submodule fetch:

1. Query the remote URL to dereference its current `todo` branch.
2. Check if we have that object in our local object share (which
   we should, due to --reference and a recent superproject
   fetch).
3. Fetch any missing objects from the remote URL.

I want to replace step 1 with:

1b. Query the superproject to dereference its current
    `origin/todo` branch.

and step 3 with:

3b. Access objects from the superproject directly (as with
    --reference / --shared).

Do I need to setup something like:

  [remote "origin"]
    url =3D ../.git
    fetch =3D +refs/remotes/origin/todo:refs/remotes/origin/todo

by hand, or is there an easier way?

I can, of course, clone a local `todo` branch if I've set one up in my
superproject.  However, then I'd have to update-ref that branch to
sync with origin/todo after every fetch (that updates origin/todo).
This could be handled with a `git fetch` wrapper, but=E2=80=A6 yuck :p.

Any suggestions for an elegant solution would be appreciated :).
Once we figure something out, I can write it up and stick it in
howto/maintain-git.txt.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/144748

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRMMfMAAoJEEUbTsx0l5OM8vAP/RppvSAq+9jq2s+0fn9y44ZZ
TKaZt6OvANDmP7VwOL9gPRQvq5CwDSEKnncMQvgJoHNs/aXG4K3ev6iOpEEvBCZI
gZ2pbwavaiogX58E/CkkeQ4F8FErTSTHp4294dwQXclOqYq9yyJSWr+qUE5tjMfy
z+ZTv40cWSVgi0SCZDiot9b0NOTMGD9ydAtnSxE4EV/1jYdb0BUrfp9okv9wKRq7
0eF0dYe0HnUY20YIYIHLjZ+nKmGr6ApVnGOoiOzE+vLCuSLswohulphvPB7aankQ
sfEBUX2yC8k/+hFT0hfe7tv4Ub1R55p1qlFyQv2EU/EOAJidarwFpLB+jTHVR+kB
ZSFSz6tgzP9YdY01oG4RrIq6HZIcFc4TQIs06+Dk3xf58yq7/wEo5ByUVpak3aL4
BjwVmOTxO9Ppg/RDmkgYWtJqMdkiFkFjZvwikZx9HT0aOvktApwtXlx12pw1mHSd
aFIb9GmLuzehsjZjxKAoS72pWNW+zWXMW7+PT4aIUBiSQxAKpJhc9JjwzlGU8BAO
LgMtBsHYnsYQTjLy3MSZ1mc6IZL+2lTuwYiEuUkRyCOOcajqF84YzCvChvYw4neV
NGBpIN0ESHE1vY5AGo9Gq+BzuFZeJ8DGblKueAEz7VRegj4IVB6PcSiKRQIqWVDz
mgZZeujFSsoMshISMmy3
=RrT8
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
