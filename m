From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] cvsimport: setup indexes correctly for ancestors and  
 incremental imports
Date: Sat, 24 Jun 2006 17:06:38 +0400
Message-ID: <20060624170638.6f127420.vsu@altlinux.ru>
References: <11511475882820-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__24_Jun_2006_17_06_38_+0400_fGvoje0oyB6w86lB"
Cc: git@vger.kernel.org, junkio@cox.net, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Sat Jun 24 15:07:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu7qm-0007UL-WB
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 15:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbWFXNG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 09:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbWFXNG5
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 09:06:57 -0400
Received: from master.altlinux.org ([62.118.250.235]:23313 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751495AbWFXNG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 09:06:57 -0400
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id C7393E34DB; Sat, 24 Jun 2006 17:06:54 +0400 (MSD)
Received: by procyon.home (Postfix, from userid 500)
	id B0A7AE36BCF; Sat, 24 Jun 2006 17:06:41 +0400 (MSD)
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <11511475882820-git-send-email-martin@catalyst.net.nz>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22516>

--Signature=_Sat__24_Jun_2006_17_06_38_+0400_fGvoje0oyB6w86lB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 24 Jun 2006 23:13:08 +1200 Martin Langhoff wrote:

> Two bugs had slipped in the "keep one index per branch during import"
> patch. Both incremental imports and new branches would see an
> empty tree for their initial commit. Now we cover all the relevant
> cases, checking whether we actually need to setup the index before
> preparing the actual commit, and doing it.
>=20
> Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
>=20
> ---
>  git-cvsimport.perl |   19 +++++++++++++++++--
>  1 files changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> old mode 100644
> new mode 100755
> index d961b7b..1c1fd02
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -813,11 +813,26 @@ while(<CVS>) {
>  			unless ($index{$branch}) {
>  			    $index{$branch} =3D tmpnam();
>  			    $ENV{GIT_INDEX_FILE} =3D $index{$branch};
> -			    system("git-read-tree", $branch);
> +			}
> +			if ($ancestor) {
> +			    system("git-read-tree", $ancestor);
>  			    die "read-tree failed: $?\n" if $?;
>  			} else {
> +			    unless ($index{$branch}) {

This seems to be dead code - even if $index{$branch} was not set, it
will be set inside "unless ($index{$branch})" above.  Or there is
another bug here?

> +				$index{$branch} =3D tmpnam();
> +				$ENV{GIT_INDEX_FILE} =3D $index{$branch};
> +				system("git-read-tree", $branch);
> +				die "read-tree failed: $?\n" if $?;
> +			    }
> +			}   =20
> +		} else {
> +			# just in case
> +			unless ($index{$branch}) {
> +			    $index{$branch} =3D tmpnam();
>  			    $ENV{GIT_INDEX_FILE} =3D $index{$branch};
> -		        }
> +			    system("git-read-tree", $branch);
> +			    die "read-tree failed: $?\n" if $?;
> +			}
>  		}
>  		$last_branch =3D $branch if $branch ne $last_branch;
>  		$state =3D 9;

--Signature=_Sat__24_Jun_2006_17_06_38_+0400_fGvoje0oyB6w86lB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEnTjhW82GfkQfsqIRAg6mAJ90o5FQsV6Y/buytpwYBfoHVfnnXgCglG7r
0+sASCiKAWAfFBXKOIFyqA8=
=xCja
-----END PGP SIGNATURE-----

--Signature=_Sat__24_Jun_2006_17_06_38_+0400_fGvoje0oyB6w86lB--
