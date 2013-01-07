From: "W. Trevor King" <wking@tremily.us>
Subject: Moving (renaming) submodules, recipe/script
Date: Sun, 06 Jan 2013 19:36:03 -0500
Message-ID: <20130107003603.GA25698@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=8t9RHnE3ZwKMSgU+
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 01:36:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts0ht-0001hg-MT
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 01:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044Ab3AGAgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 19:36:25 -0500
Received: from vms173009pub.verizon.net ([206.46.173.9]:19692 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab3AGAgX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 19:36:23 -0500
Received: from odin.tremily.us ([unknown] [72.68.82.220])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MG800DH7CC34530@vms173009.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 06 Jan 2013 18:36:04 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 94000779A60; Sun,
 06 Jan 2013 19:36:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1357518963; bh=AXLWkSoxaWYWe0+g8pDhXhXZ2N75KWrQjB9RK1QQb0U=;
	h=Date:From:To:Subject;
	b=IzUy/zRHcgxDGUplmeH3ZodOWiQc6qZnmU48rGvYXvGxmraE+gFTKZoVEFPwqfNoI
 /l6uReoVK1sr5SeNc4yw/tlc9nj3XEyliBYCycAvLZyanWUeOn3vUYJ20p+80QtY9F
 S8Cwa2rFGxOtGusTWpo8VtYq2qR5PIxG5u2vbwpA=
Content-disposition: inline
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212861>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Today I had to move my first submodule, and I discovered that Git's
support for this is pretty limited.  There have been a few patch
series attempting to address this [1,2], but none of them seems to
have pushed through into master (although I can't put my finger on a
reason for why).  There are also some SO postings discussing this
[3,4].  It would be nice if `git mv` worked out of the box on
submodules.  Failing that, there could be a `git submodule mv` command
that casts the appropriate spell.  Failing that, there could be a
recipe in Documentation/git-submodule.txt.  Here's the best I could
come up with for a `git-submodule-mv.sh`:

  #!/bin/sh
  # usage: git-submodule-mv.sh OLD NEW
  OLD=3D$(realpath --relative-to . "$1")
  NEW=3D$(realpath --relative-to . "$2")
  SHA=3D$(git ls-files -s "$OLD" | sed 's|^[0-9]* \([0-9a-f]*\) .*|\1|')
  NAME=3D$(git config -f .gitmodules --get-regexp 'submodule\..*\.path' "$O=
LD" |
    sed -e 's|^submodule.||' -e "s|.path $OLD\$||")
  GITDIR=3D$(realpath --relative-to "$NEW" .git/modules/"$NAME")
  git config -f .gitmodules submodule."$NAME".path "$NEW"
  git config -f .git/modules/"$NAME"/config core.worktree "../../../$NEW"
  git rm --cached "$OLD"
  mv "$OLD" "$NEW"
  echo "gitdir: $GITDIR" > "$NEW/.git"
  git update-index --add --cacheinfo 160000 "$SHA" "$NEW"

This only works from the repository root directory, and I'm sure makes
a number of poor assumptions (e.g. old-style submodules that don't use
`gitdir` links are not supported).  It does work for some simple test
cases.  The tricky parts (e.g. path -> name conversion) are already
worked out more robustly git-submodule.sh, so adding a new cmd_mv
shouldn't be very difficult.

Could something like this live somewhere in Git, or are we waiting for
a more integrated solution?

Cheers,
Trevor

[1]: http://thread.gmane.org/gmane.comp.version-control.git/88720
[2]: http://thread.gmane.org/gmane.comp.version-control.git/143250
[4]: http://stackoverflow.com/questions/4323558/moving-submodules-with-git
[3]: http://stackoverflow.com/questions/4604486/how-do-i-move-an-existing-g=
it-submodule-within-a-git-repository

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ6hhwAAoJEEUbTsx0l5OMh0IP/RLMqiTuWzKMYSr8kukwkhZL
/ilhuIZLUXM4cuO1kA9lVzIUrK5Ra4GwFWPEHFcOAOMoaYTr82GT6gVCuRNtERRA
Y+kIrqxX3Yec57MuZkV7GNCIPEsqombGaVHxf7nxu+/8psG5pjiHHG5n8r3wmPHw
1x0NfY4JHIvO/SezQM6HVfuQnYfEwggpx6K1HAWBX3xMg3gyhBdLWIWHGaWWfoSy
y9Lcw6rEK76VHFgtfznqC+rTfG6t+3ckDdXtLy7L9tkUCrWnBCeBaj3L09hcXMzn
vPIunxrH6r2qnCtLxE+kCDR7rlRX6J/XEzwFEQtk0XRhK+YWOh3psc5L1VuVmclb
RtJS2VAzbL+0rol0k690i/GnzY4S5TDQLLWPF3BmvBghsOjGEbGNjMHkJzHvYV34
k6kLayXxAA39ut/9W+UezCs6hd2EGrIXGNDBoGk22H4DGWknxExqzRpelj2zd2Zr
zhxkulu+5X+MjQ0N2Rlvoh2bjvtFVVm6r+wFffvLHtO3EhBEvorzPCgPt0Ra3lNF
J3Wh5P060r+4lhn+Do80wYGq/SpNCL9fw1iPH0to3zMoSDaTzrq9IlFWxpIc/cJm
vw1aKrq4XGMYD8INqq8gQVYFasLsKsicDvHqiCZZFo79w4jwmaG88dvYYx/xLDIj
ZxYTMR1Mi6s3OkD8BcV5
=aD5a
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
