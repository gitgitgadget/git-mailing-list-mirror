From: Henri GEIST <geist.henri@laposte.net>
Subject: Re: [PATCH/RFC] git-gui: Add a 'recursive' checkbox in the clone
 menu.
Date: Thu, 06 Mar 2014 01:15:56 +0100
Message-ID: <1394064956.7891.28.camel@Naugrim>
References: <1393974076.7891.27.camel@Naugrim> <5317662C.6010404@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-9dQWxZHmT/Izg4Z1qmiE"
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 01:16:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLLys-0005nG-Ov
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 01:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848AbaCFAQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 19:16:05 -0500
Received: from smtpout5.laposte.net ([193.253.67.230]:27845 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865AbaCFAQE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 19:16:04 -0500
Received: from [192.168.1.104] ([109.164.199.213])
	by mwinf8509-out with ME
	id a0Fx1n0034ckmKR030FxZC; Thu, 06 Mar 2014 01:15:58 +0100
In-Reply-To: <5317662C.6010404@web.de>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243495>


--=-9dQWxZHmT/Izg4Z1qmiE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 05 mars 2014 =C3=A0 19:00 +0100, Jens Lehmann a =C3=A9crit :
> Am 05.03.2014 00:01, schrieb Henri GEIST:
> > Permit to do a 'git clone --recursive' through git-gui.
>=20
> I really like where this is heading!
>=20
> Some minor issues:
>=20
> - I think we should be more verbose in the commit message,
>   including that and why the default should be "on". Maybe
>   like this?
>=20
>   "Permit to do a 'git clone --recursive' through git-gui.
>   Add a 'recursive' checkbox in the clone menu which allows
>   users to clone a repository and all its submodules in one
>   go (unless the 'update' flag is set to "none" in the
>   .gitmodules file for a submodule, in that case that
>   specific submodule is not cloned automatically).
>=20
>   Enable this new option per default, as most users want to
>   clone all submodules too when cloning the superproject
>   (This is currently not possible without leaving git gui
>   or adding a custom tool entry for that)."
>=20

Ok for me.

>=20
> - I'd rather change the button text from "Recursive (For
>   submodules)" to something like "Recursively clone
>   submodules too" or such.
>=20

Perfect

>=20
> - Wouldn't it be easier to pass the '--recurse-submodules"
>   option to the "git clone" call for the superproject instead
>   of adding the _do_clone_submodules() function doing a
>   subsequent "git submodule update --init --recursive"? That
>   is also be more future proof with respect to the autoclone
>   config option we have in mind (which would add that behavior
>   for "git clone" itself, making the call you added redundant).
>=20

That is what I planned to do at beginning.
But git-gui never call git clone anywhere.
It make the clone step by step with a long and complicated list of
commands just like a Tcl rewrite of git-clone.
Have a look on the function _do_clone2 in choose_repository.tcl.

As I suspect there should be a good reason for this that I did not
understand I have choose to not refactoring it.
And in fact looking in the code 'git clone --recursive' do nothing
else than calling 'git submodule update --init --recursive' like I
have done to complete this rewrite of 'git-clone'.


>=20
> > Signed-off-by: Henri GEIST <geist.henri@laposte.net>
> > ---
> > I have set the default checkbox state to 'true' by default has all my g=
ui users
> > use it all the time this way.
> > But as it change the default behavior you may prefer to set it to 'fals=
e' by
> > default.
> >=20
> >  git-gui/lib/choose_repository.tcl |   34 +++++++++++++++++++++++++++++=
+++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_rep=
ository.tcl
> > index 3c10bc6..47d436b 100644
> > --- a/git-gui/lib/choose_repository.tcl
> > +++ b/git-gui/lib/choose_repository.tcl
> > @@ -18,6 +18,7 @@ field local_path       {} ; # Where this repository i=
s locally
> >  field origin_url       {} ; # Where we are cloning from
> >  field origin_name  origin ; # What we shall call 'origin'
> >  field clone_type hardlink ; # Type of clone to construct
> > +field recursive      true ; # Recursive cloning flag
> >  field readtree_err        ; # Error output from read-tree (if any)
> >  field sorted_recent       ; # recent repositories (sorted)
> > =20
> > @@ -525,6 +526,11 @@ method _do_clone {} {
> >  	foreach r $w_types {
> >  		pack $r -anchor w
> >  	}
> > +	${NS}::checkbutton $args.type_f.recursive \
> > +		-text [mc "Recursive (For submodules)"] \
> > +		-variable @recursive \
> > +		-onvalue true -offvalue false
> > +	pack $args.type_f.recursive
> >  	grid $args.type_l $args.type_f -sticky new
> > =20
> >  	grid columnconfigure $args 1 -weight 1
> > @@ -952,6 +958,30 @@ method _do_clone_checkout {HEAD} {
> >  	fileevent $fd readable [cb _readtree_wait $fd]
> >  }
> > =20
> > +method _do_validate_submodule_cloning {ok} {
> > +	if {$ok} {
> > +		$o_cons done $ok
> > +		set done 1
> > +	} else {
> > +		_clone_failed $this [mc "Cannot clone submodules."]
> > +	}
> > +}
> > +
> > +method _do_clone_submodules {} {
> > +	if {$recursive eq {true}} {
> > +		destroy $w_body
> > +		set o_cons [console::embed \
> > +			$w_body \
> > +			[mc "Cloning submodules"]]
> > +		pack $w_body -fill both -expand 1 -padx 10
> > +		$o_cons exec \
> > +			[list git submodule update --init --recursive] \
> > +			[cb _do_validate_submodule_cloning]
> > +	} else {
> > +		set done 1
> > +	}
> > +}
> > +
> >  method _readtree_wait {fd} {
> >  	set buf [read $fd]
> >  	$o_cons update_meter $buf
> > @@ -982,7 +1012,7 @@ method _readtree_wait {fd} {
> >  		fconfigure $fd_ph -blocking 0 -translation binary -eofchar {}
> >  		fileevent $fd_ph readable [cb _postcheckout_wait $fd_ph]
> >  	} else {
> > -		set done 1
> > +		_do_clone_submodules $this
> >  	}
> >  }
> > =20
> > @@ -996,7 +1026,7 @@ method _postcheckout_wait {fd_ph} {
> >  			hook_failed_popup post-checkout $pch_error 0
> >  		}
> >  		unset pch_error
> > -		set done 1
> > +		_do_clone_submodules $this
> >  		return
> >  	}
> >  	fconfigure $fd_ph -blocking 0
> >=20
>=20



--=-9dQWxZHmT/Izg4Z1qmiE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iF4EABEKAAYFAlMXvjwACgkQkKuHPdwEGdQXkQD/Q7jrYsdS8LoMLUshrvliFWSa
IdggNGVQhVMLvEJN9/EBAJMRC8I/BRpvbfCzFqNt5sbo5dYfRnPgeGcMnvprKSnh
=0a+y
-----END PGP SIGNATURE-----

--=-9dQWxZHmT/Izg4Z1qmiE--
