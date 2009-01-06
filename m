From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH (topgit) 1/2] Implement setup_pager just like in git
Date: Tue, 6 Jan 2009 21:32:03 +0100
Message-ID: <20090106203203.GA11274@lapse.rw.madduck.net>
References: <cover.1231254832.git.kirr@landau.phys.spbu.ru> <acaae74f79d385014e726b97f8258b2a0caa3dd0.1231254832.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Cc: pasky@suse.cz
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 11:31:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKVge-0007Os-N5
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 11:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbZAGK3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 05:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbZAGK3X
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 05:29:23 -0500
Received: from clegg.madduck.net ([193.242.105.96]:59712 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbZAGK3W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 05:29:22 -0500
Received: from lapse.rw.madduck.net (lapse.rw.madduck.net [IPv6:2001:41e0:ff3a::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 63A841D40B0;
	Wed,  7 Jan 2009 11:29:01 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 71C7280F9; Tue,  6 Jan 2009 21:32:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <acaae74f79d385014e726b97f8258b2a0caa3dd0.1231254832.git.kirr@landau.phys.spbu.ru>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.27-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8841/Wed Jan  7 06:09:14 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104782>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks, Kirill, for the patches. A couple of comments inline. I hope
Petr has a chance to look too.

also sprach Kirill Smelkov <kirr@landau.phys.spbu.ru> [2009.01.06.1616 +010=
0]:
> +# isatty FD
> +isatty()
> +{
> +	tty -s 0<&$1 || return 1
> +	return 0
> +}

You don't need any of the return statements. Functions' return
values are the return values of the last commands they execute.
Since we are not using set -e, just "tty -s 0<&$1" in the body will
have the same effect.

> +	# TG_PAGER =3D GIT_PAGER | PAGER
> +	# http://unix.derkeiler.com/Newsgroups/comp.unix.shell/2004-03/0792.html
> +	case ${GIT_PAGER+XXX} in
> +	'')
> +		case ${PAGER+XXX} in
> +		'')
> +			# both GIT_PAGER & PAGER unset

I find this very confusing. Why not simply

  TG_PAGER=3D"${GIT_PAGER:-}"
  TG_PAGER=3D"${TG_PAGER:-$PAGER}"

?

> +     [ -z "$TG_PAGER"  -o  "$TG_PAGER" =3D "cat" ]  && return 0

What if I set my pager to /bin/cat? But I suppose then there's just
a wasted FIFO and process, nothing big.

> +	_pager_fifo=3D"$(mktemp -t tg-pager-fifo.XXXXXX)"
> +	rm "$_pager_fifo" && mkfifo -m 600 "$_pager_fifo"

There's a race condition here. I can't see a real problem with it,
though, nor do I know of a better way.

> +	"$TG_PAGER" < "$_pager_fifo" &
> +	exec > "$_pager_fifo"		# dup2(pager_fifo.in, 1)
> +
> +	# this is needed so e.g. `git diff` will still colorize it's output if
> +	# requested in ~/.gitconfig with color.diff=3Dauto
> +	export GIT_PAGER_IN_USE=3D1
> +
> +	# atexit(close(1); wait pager)
> +	trap "exec >&-; rm $_pager_fifo; wait" EXIT

Consistency: $_pager_fifo is not passed as a quoted string to rm
here. In the unlikely event that $TMPDIR contains a space, this
would fail.

I definitely want Petr's opinion on this before I integrate it.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
if you see an onion ring -- answer it!
=20
spamtraps: madduck.bogus@madduck.net

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkljv8AACgkQIgvIgzMMSnVBJACgssKSBSuykcPxgfoyJumYuaw4
ypoAoOYLTFlZ/+HeSyPzoa/typBBr6Dr
=QKhH
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
