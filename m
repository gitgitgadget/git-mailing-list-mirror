From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] guilt(1): simplifications...
Date: Thu, 14 Jun 2007 17:16:58 +0200
Message-ID: <20070614151658.GK23324@artemis>
References: <11818254621527-git-send-email-madcoder@debian.org> <11818254621458-git-send-email-madcoder@debian.org> <20070614145845.GA934@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="7ArrI7P/b+va1vZ8";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Josef Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 17:17:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyr4I-0006fZ-Ul
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 17:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbXFNPRB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 11:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbXFNPRA
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 11:17:00 -0400
Received: from pan.madism.org ([88.191.52.104]:36142 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170AbXFNPRA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 11:17:00 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9BAFDDA55;
	Thu, 14 Jun 2007 17:16:58 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 187281078; Thu, 14 Jun 2007 17:16:58 +0200 (CEST)
Mail-Followup-To: Josef Sipek <jsipek@cs.sunysb.edu>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070614145845.GA934@filer.fsl.cs.sunysb.edu>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50205>


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2007 at 10:58:45AM -0400, Josef Sipek wrote:
> On Thu, Jun 14, 2007 at 02:50:58PM +0200, Pierre Habouzit wrote:

> >  # usage: do_make_header <hash>
> >  do_make_header()
> >  {
> > -	# which revision do we want to work with?
> > -	local rev=3D"$1"
> > -
> >  	# we should try to work with commit objects only
> > -	if [ `git-cat-file -t "$rev"` !=3D "commit" ]; then
> > -		echo "Hash $rev is not a commit object" >&2
> > +	if [ `git-cat-file -t "$1"` !=3D "commit" ]; then
> > +		echo "Hash $1 is not a commit object" >&2
> >  		echo "Aborting..." >&2
> >  		exit 2
> >  	fi
> > =20
> > -	# get the author line from the commit object
> > -	local author=3D`git-cat-file -p "$rev" | grep -e '^author ' | head -1`
> > -
> > -	# strip the timestamp & '^author ' string
> > -	author=3D`echo "$author" | sed -e 's/^author //' -e 's/ [0-9]* [+-]*[=
0-9][0-9]*$//'`
> > -
> > -	git-cat-file -p "$rev" | awk "
> > -BEGIN{ok=3D0}
> > -(ok=3D=3D1){print \$0; print \"\nFrom: $author\"; ok=3D2; next}
> > -(ok=3D=3D2){print \$0}
> > -/^\$/ && (ok=3D=3D0){ok=3D1}
> > -"
> > +	git-cat-file -p "$1" | sed -e \
> > +		'1,/^$/ {
> > +			/^author/ {
> > +				s/^author /From: /
> > +				s/ [0-9]* [+-]*[0-9][0-9]*$//
> > +				p
> > +			}
> > +			/^$/p
> > +			d
> > +		}'
>=20
> You changed the output slightly. The original awk script outputed:
>=20
> >>>>>
> the first line of the commit message
>=20
> From: foo@....
>=20
> remainder of the commit message
> <<<<<
>=20
> Yours outputs:
>=20
> >>>>>
> From: foo@....
>=20
> the entire commit message
> <<<<<
>=20
> I'd like to keep the previous format as it makes it easier to grab the fi=
rst
> line of each patch file to get the "short summary" (assuming you follow t=
he
> kernel/git/guilt commit message conventions). This doesn't make anything =
in
> guilt easier, it just makes the patch files more friendly to other tools =
one
> might use. (Especially if they grab the first line and use it as the subj=
ect
> in emails.)

  damn, I thought I had checked that thouroughly, I'll see that in
details then. and will give you a new patch.

> > @@ -283,10 +264,11 @@ series_remove_patch()
> >  # usage: series_rename_patch <oldname> <newname>
> >  series_rename_patch()
> >  {
> > -	local old=3D`echo "$1" | sed -e 's,/,\\\\/,g'`
> > -	local new=3D`echo "$2" | sed -e 's,/,\\\\/,g'`=20
> > +	awk -v old=3D"$1" -v new=3D"$2" \
> > +		'{ if ($0 =3D=3D old) print new; else print $0 }' \
> > +		"$series.tmp" > "$series"
> =20
> Shouldn't that be '"$series" > "$series.tmp"' ?
>=20
> > -	sed -i -e "s/^$old\$/$new/" "$series"
> > +	mv "$series.tmp" "$series"
> >  }
> > =20
> >  # Beware! This is one of the few (only?) places where we modify the ap=
plied
> > @@ -295,10 +277,15 @@ series_rename_patch()
> >  # usage: applied_rename_patch <oldname> <newname>
> >  applied_rename_patch()
> >  {
> > -	local old=3D`echo "$1" | sed -e 's,/,\\\\/,g'`
> > -	local new=3D`echo "$2" | sed -e 's,/,\\\\/,g'`=20
> > +	awk -v old=3D"$1" -v new=3D"$2" \
> > +			'BEGIN{FS=3D":"}
> > +			{ if ($1 ~ /^[0-9a-f]*$/ && length($1) =3D=3D 40 && substr($0, 42) =
=3D=3D old)
> > +				print substr($0, 0, 41) new;
> > +			else
> > +				print;
> > +			}' "$applied" > "$applied.new"
>                                                  ^^^^
>=20
> > -	sed -i -e "s/^\\([0-9a-f]\\{40\\}\\):$old\$/\\1:$new/" "$applied"
> > +	mv "$applied.tmp" "$applied"
>                     ^^^^
>=20
> ..new or .tmp?

  Those are obvious blatant mistakes. THe fixes will be available in the
coming patch as well.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGcVvqvGr7W6HudhwRAj8VAKCjf8Ser2rmTGpLBuy/8cQf62n+ywCaAn0A
vFfAhijA8IO69nQawmgCraY=
=O9Mn
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--
