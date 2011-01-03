From: Eric Blake <eblake@redhat.com>
Subject: Re: fatal: ambiguous message
Date: Mon, 03 Jan 2011 08:04:20 -0700
Organization: Red Hat
Message-ID: <4D21E574.50404@redhat.com>
References: <4D1D33D7.7040809@gmail.com> <4D1DFF96.4010004@redhat.com>	<4D20BE0B.6040104@gmail.com> <20110102183453.GA13463@burratino> <4D211555.1040502@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigB5613A78432AE0FAE80FD0EE"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	GNU Autoconf mailing list <autoconf@gnu.org>,
	GIT Development <git@vger.kernel.org>,
	bug-gnulib <bug-gnulib@gnu.org>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 03 16:04:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZlxa-00064K-2e
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 16:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163Ab1ACPE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 10:04:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61007 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932124Ab1ACPEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 10:04:25 -0500
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id p03F4LUC022059
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 3 Jan 2011 10:04:21 -0500
Received: from [10.3.113.114] (ovpn-113-114.phx2.redhat.com [10.3.113.114])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p03F4KLC002172;
	Mon, 3 Jan 2011 10:04:21 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.7
In-Reply-To: <4D211555.1040502@gmail.com>
X-Enigmail-Version: 1.1.2
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164450>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB5613A78432AE0FAE80FD0EE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[redirecting to bug-gnulib as the owner of the git-version-gen script in
question; replies can drop other lists]

On 01/02/2011 05:16 PM, Bruce Korb wrote:
> Hi Jonathan,
>=20
> On Sun, Jan 2, 2011 at 10:34 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> Were you been able to reproduce that outside the script?
>=20
> No, I was blind to the invocation.  You found it.  I was looking
> without seeing.  Thank you.
>=20
> Given that shells without functions can be considered sufficiently
> obsolete to not be a consideration, perhaps a better solution is
> to put the I-don't-care-about-error-messages code into a separate
> function with stderr redirected.  Doing that turned out messier
> than I had hoped....

Jonathan's patch:

> diff --git a/build-aux/git-version-gen b/build-aux/git-version-gen
> index 5617eb8..119d7aa 100755
> --- a/build-aux/git-version-gen
> +++ b/build-aux/git-version-gen
> @@ -119,7 +119,7 @@ then
>  	    # result is the same as if we were using the newer version
>  	    # of git describe.
>  	    vtag=3D`echo "$v" | sed 's/-.*//'`
> -	    numcommits=3D`git rev-list "$vtag"..HEAD | wc -l`
> +	    numcommits=3D`git rev-list "$vtag"..HEAD 2>/dev/null | wc -l`
>  	    v=3D`echo "$v" | sed "s/\(.*\)-\(.*\)/\1-$numcommits-\2/"`;
>  	    ;;
>      esac

makes sense to suppress the error message from leaking (whether or not
git can be improved to have the error message claim which program is
issuing the message); but there's still the nagging issue that because
git output is fed to a pipe, there's no way to check $? to see if git
failed, in order to properly react to that situation.

Bruce's patch mixes refactoring with bug fixing, making it a bit harder
to read, and introduced a bug in its own right:

> diff --git a/build-aux/git-version-gen b/build-aux/git-version-gen
> index c278f6a..8a238b0 100755
> --- a/build-aux/git-version-gen
> +++ b/build-aux/git-version-gen
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  # Print a version string.
> -scriptversion=3D2010-10-13.20; # UTC
> +scriptversion=3D2011-01-03.00; # UTC
> =20
>  # Copyright (C) 2007-2011 Free Software Foundation, Inc.
>  #
> @@ -78,76 +78,96 @@ tag_sed_script=3D"${2:-s/x/x/}"
>  nl=3D'
>  '
> =20
> -# Avoid meddling by environment variable of the same name.
> -v=3D
> +get_ver()
> +{
> +    local PS4=3D'>gv> '

Portable scripts CANNOT use local (since POSIX does not require it), and
setting PS4 is not commonly done in portable scripting.

I'll probably end up writing yet a third approach, which collects git
rev-list output into a temporary variable in order to correctly detect
failures, without refactoring into a helper function.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigB5613A78432AE0FAE80FD0EE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNIeV0AAoJEKeha0olJ0NqDlsH/3nHgZZmRsh+gryQ+GrJHCwl
0ST+1K69KZmBcIaH/6zOu1xX/NooWTiuzw37++t4qdXE9JmxOwjbtjAZ1BiesH3Q
GBfzljJBPEFim2L7vu9mwVW4v0+xWZBWVzaPWBnXEHohFRURD6dGHljNv+MtQHUT
OMTrfyE0p4fj+/Flp3BXwE6v4fgDYJBkAsJNt86zLA0ki/FA5T6R6Taq8MwY24HM
uER3woI/JkP837BvwlskewHP/KZG7G3NePwR922c/Ij3PubdWl+2hME48HARGNXR
qIEY900JXBNUwnUlSwrwT5ABzMpSZDSpAHpznfSGTstGkIxyAIuK7rnPIaqP/4o=
=ThL5
-----END PGP SIGNATURE-----

--------------enigB5613A78432AE0FAE80FD0EE--
