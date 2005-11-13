From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Remove unneeded packs
Date: Sun, 13 Nov 2005 15:00:51 +0300
Message-ID: <20051113150051.4a10365d.vsu@altlinux.ru>
References: <1131800663.29461.11.camel@blade>
	<4375EA80.7070405@op5.se>
	<1131802238.29461.18.camel@blade>
	<43766687.2000007@etek.chalmers.se>
	<7voe4pclwm.fsf@assigned-by-dhcp.cox.net>
	<43771C43.7000104@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__13_Nov_2005_15_00_51_+0300_byGCazDNw0IUgu5Y"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Nov 13 13:02:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbGYJ-0000Iv-7e
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 13:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVKMMBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 07:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVKMMBS
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 07:01:18 -0500
Received: from master.altlinux.ru ([62.118.250.235]:24582 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932475AbVKMMBS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 07:01:18 -0500
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id 74668E3642; Sun, 13 Nov 2005 15:01:07 +0300 (MSK)
Received: by procyon.home (Postfix, from userid 500)
	id F3A8DE385D3; Sun, 13 Nov 2005 15:00:54 +0300 (MSK)
To: Lukas Sandstr__m <lukass@etek.chalmers.se>
In-Reply-To: <43771C43.7000104@etek.chalmers.se>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11735>

--Signature=_Sun__13_Nov_2005_15_00_51_+0300_byGCazDNw0IUgu5Y
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 13 Nov 2005 11:58:11 +0100 Lukas Sandstr__m wrote:

> Subject: [PATCH] Make sure all old packfiles are removed when doing a full repack
> 
> This is nessecary because unrachable objects in packfiles makes git-pack-redundant
> flag them as non-redundant.
> 
> Signed-off-by: Lukas Sandstr____m <lukass@etek.chalmers.se>
> 
> ---
> 
>  git-repack.sh |   16 +++++++++++++++-
>  1 files changed, 15 insertions(+), 1 deletions(-)
> 
> applies-to: 9a0f0c748316751fbf593a21f2b16bcdd975095a
> 08df1f641bd3f98a607a8413d647667adc18a633
> diff --git a/git-repack.sh b/git-repack.sh
> index f347207..293bb50 100755
> --- a/git-repack.sh
> +++ b/git-repack.sh
> @@ -32,6 +32,8 @@ case ",$all_into_one," in
>  	rev_list=
>  	rev_parse='--all'
>  	pack_objects=
> +	existing=`cd "$PACKDIR" && \
> +	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
>  	;;
>  esac
>  if [ "$local" ]; then
> @@ -60,7 +62,19 @@ mv .tmp-pack-$name.pack "$PACKDIR/pack-$
>  mv .tmp-pack-$name.idx  "$PACKDIR/pack-$name.idx" ||
>  exit
>  
> -if test "$remove_redandant" = t
> +if test "$all_into_one" = t

This should be

if test "$all_into_one$remove_redandant" = tt

(otherwise "git repack -a" becomes the same as "git repack -a -d").

> +then
> +	sync
> +	( cd "$PACKDIR" &&
> +		for e in $existing
> +		do
> +		case "$e" in
> +		./pack-$name.pack | ./pack-$name.idx) ;;
> +		*)	rm -f $e ;;
> +		esac
> +		done
> +	)
> +else if test "$remove_redandant" = t
>  then
>  	sync
>  	redundant=$(git-pack-redundant --all)
> ---
> 0.99.9.GIT

--Signature=_Sun__13_Nov_2005_15_00_51_+0300_byGCazDNw0IUgu5Y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDdyr2W82GfkQfsqIRAohSAJ0WVL0xAxYmrvPCcvrspy3UbS/SKQCglduq
bwbyP5KCmDJNPyTkEMPkAPc=
=gb8i
-----END PGP SIGNATURE-----

--Signature=_Sun__13_Nov_2005_15_00_51_+0300_byGCazDNw0IUgu5Y--
