From: Daniel Hahler <genml+git-2014@thequod.de>
Subject: Re: Bug: relative core.worktree is resolved from symlink and not
 its target
Date: Mon, 17 Feb 2014 10:36:53 +0100
Message-ID: <5301D835.1060301@thequod.de>
References: <52F0BEF7.5020600@thequod.de> <20140209090803.GA24578@lanh>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VXFnp4Bmq65WF324mkOC1K5BdM5iaHLXC"
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 17 10:37:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFKdI-0000BV-VK
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 10:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbaBQJg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Feb 2014 04:36:56 -0500
Received: from hahler.de ([188.40.33.212]:47606 "EHLO elfe.thequod.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbaBQJgz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 04:36:55 -0500
Received: from localhost (amavis [10.122.1.24])
	by elfe.thequod.de (Postfix) with ESMTP id E8BC462105;
	Mon, 17 Feb 2014 10:36:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thequod.de; h=
	content-type:content-type:in-reply-to:references:subject:subject
	:mime-version:user-agent:from:from:date:date:message-id:received
	:received; s=postfix2; t=1392629812; bh=1SHIpCg29yfmVlBWYEkb4hyn
	JV7dUNLr80YU7vgWhCk=; b=sUGQgXeqfRSVbawqghFYjEl478WKNEKapI6lFzQs
	VDIOR5a+zGgKWV22Irn8OGDPDqdjZjVpxgFrK+YhTVjKm8KfJ2plu1kHOfbMgmrm
	Cjnw3rQ8/mks38kV7YnEe0MZBZRBGcci6AVCINpWRbSD/XM+1lOpNpRsiGiVRGU5
	wN8=
X-Virus-Scanned: Debian amavisd-new at amavis.thequod.de
Received: from elfe.thequod.de ([10.122.1.25])
	by localhost (amavis.thequod.de [10.122.1.24]) (amavisd-new, port 10026)
	with ESMTP id mR9EyoMNWQ+2; Mon, 17 Feb 2014 10:36:52 +0100 (CET)
Received: from lenny.thequod.de (91-65-218-186-dynip.superkabel.de [91.65.218.186])
	(Authenticated sender: daniel@hahler.de)
	by elfe.thequod.de (Postfix) with ESMTPSA;
	Mon, 17 Feb 2014 10:36:52 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140209090803.GA24578@lanh>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242249>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VXFnp4Bmq65WF324mkOC1K5BdM5iaHLXC
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09.02.2014 10:08, Duy Nguyen wrote:
> On Tue, Feb 04, 2014 at 11:20:39AM +0100, Daniel Hahler wrote:

Thanks for looking into this.

>> when using a submodule "sm", there is a relative worktree in its confi=
g:
>>
>>    .git/modules/sm/config:
>>    [core]
>>     worktree =3D ../../../smworktree
>>
>> git-new-worktree (from contrib) symlinks this config the new worktree.=

>>
>> From inside the new worktree, git reads the config, but resolves the
>> relative worktree setting based on the symlink's location.
>=20
> Hmm.. core.worktree is relative to $GIT_DIR. Whether "config" is a
> symlink should have no effects.

If "config" is a symlink, the relative path for worktree is meant to be
resolved based on the config file's location, and not from the symlink
($GIT_DIR).

Here is a test case to reproduce it:

  # Create a submodule repo
  mkdir /tmp/t-sm
  cd /tmp/t-sm
  git init
  touch foo
  git add foo
  git commit -m init

  # Create the root repo
  mkdir /tmp/t-root
  cd /tmp/t-root
  git init
  mkdir submodules
  git submodule add /tmp/t-sm submodules/sm
  git commit -m init

  # Create a new worktree from the submodule
  cd /tmp/t-root/submodules/sm
  git-new-workdir . /tmp/new-workdir

This then fails when checking out:
+ git checkout -f
fatal: Could not chdir to '../../../../submodules/sm': No such file or di=
rectory

% ls -l /tmp/new-workdir/.git/config=20
[=85] /tmp/new-workdir/.git/config -> /tmp/t-root/.git/modules/submodules=
/sm/config

% cat /tmp/new-workdir/.git/config=20
[core]
	repositoryformatversion =3D 0
	filemode =3D true
	bare =3D false
	logallrefupdates =3D true
	worktree =3D ../../../../submodules/sm


=46rom inside of /tmp/new-workdir `git rev-parse --git-dir` fails already=

(with the same "cannot chdir" error).

The problem appears to be that it tries to chdir based on
/tmp/new-workdir/.git, but should do so based on
$(readlink -f .git/config).

I recognize that this case is constructed anyway, because even if
`worktree` would get resolved correctly, it would not be what you'd
expect: the point of git-new-workdir is to get a separate worktree, and
not use the existing one.

Therefore I see two problems here:
1. worktree is not resolved correctly by git itself (with .git/config
   being a symlink)
2. git-new-workdir should handle this better, e.g. by creating a copy of
   the "config" file with the worktree setting removed and printing a
   warning about it.

The workaround appears to be to explicitly set
GIT_WORK_TREE=3D/tmp/new-workdir.


Regards,
Daniel.

--=20
http://daniel.hahler.de/


--VXFnp4Bmq65WF324mkOC1K5BdM5iaHLXC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iD8DBQFTAdg1fAK/hT/mPgARAhVrAKCDhXxMYkVNW+AzYABMsBKd8bWGJACfcMg0
sg9d7+hpqG8lFN87pBz+/84=
=Pu26
-----END PGP SIGNATURE-----

--VXFnp4Bmq65WF324mkOC1K5BdM5iaHLXC--
