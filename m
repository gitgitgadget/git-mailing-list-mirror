From: Henri GEIST <geist.henri@laposte.net>
Subject: [PATCH/RFC] git-gui: Add a 'recursive' checkbox in the clone menu.
Date: Wed, 05 Mar 2014 00:01:16 +0100
Message-ID: <1393974076.7891.27.camel@Naugrim>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-1Vm65Z34j2dZj+ijsb8R"
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 00:01:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKyL5-00088P-Gp
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 00:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbaCDXBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 18:01:23 -0500
Received: from smtpout5.laposte.net ([193.253.67.230]:40819 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbaCDXBW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 18:01:22 -0500
Received: from [192.168.0.8] ([82.242.149.125])
	by mwinf8510-out with ME
	id Zb1G1n0042iaXuy03b1GPQ; Wed, 05 Mar 2014 00:01:17 +0100
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243403>


--=-1Vm65Z34j2dZj+ijsb8R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Permit to do a 'git clone --recursive' through git-gui.

Signed-off-by: Henri GEIST <geist.henri@laposte.net>
---
I have set the default checkbox state to 'true' by default has all my gui u=
sers
use it all the time this way.
But as it change the default behavior you may prefer to set it to 'false' b=
y
default.

 git-gui/lib/choose_repository.tcl |   34 ++++++++++++++++++++++++++++++++-=
-
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_reposit=
ory.tcl
index 3c10bc6..47d436b 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -18,6 +18,7 @@ field local_path       {} ; # Where this repository is lo=
cally
 field origin_url       {} ; # Where we are cloning from
 field origin_name  origin ; # What we shall call 'origin'
 field clone_type hardlink ; # Type of clone to construct
+field recursive      true ; # Recursive cloning flag
 field readtree_err        ; # Error output from read-tree (if any)
 field sorted_recent       ; # recent repositories (sorted)
=20
@@ -525,6 +526,11 @@ method _do_clone {} {
 	foreach r $w_types {
 		pack $r -anchor w
 	}
+	${NS}::checkbutton $args.type_f.recursive \
+		-text [mc "Recursive (For submodules)"] \
+		-variable @recursive \
+		-onvalue true -offvalue false
+	pack $args.type_f.recursive
 	grid $args.type_l $args.type_f -sticky new
=20
 	grid columnconfigure $args 1 -weight 1
@@ -952,6 +958,30 @@ method _do_clone_checkout {HEAD} {
 	fileevent $fd readable [cb _readtree_wait $fd]
 }
=20
+method _do_validate_submodule_cloning {ok} {
+	if {$ok} {
+		$o_cons done $ok
+		set done 1
+	} else {
+		_clone_failed $this [mc "Cannot clone submodules."]
+	}
+}
+
+method _do_clone_submodules {} {
+	if {$recursive eq {true}} {
+		destroy $w_body
+		set o_cons [console::embed \
+			$w_body \
+			[mc "Cloning submodules"]]
+		pack $w_body -fill both -expand 1 -padx 10
+		$o_cons exec \
+			[list git submodule update --init --recursive] \
+			[cb _do_validate_submodule_cloning]
+	} else {
+		set done 1
+	}
+}
+
 method _readtree_wait {fd} {
 	set buf [read $fd]
 	$o_cons update_meter $buf
@@ -982,7 +1012,7 @@ method _readtree_wait {fd} {
 		fconfigure $fd_ph -blocking 0 -translation binary -eofchar {}
 		fileevent $fd_ph readable [cb _postcheckout_wait $fd_ph]
 	} else {
-		set done 1
+		_do_clone_submodules $this
 	}
 }
=20
@@ -996,7 +1026,7 @@ method _postcheckout_wait {fd_ph} {
 			hook_failed_popup post-checkout $pch_error 0
 		}
 		unset pch_error
-		set done 1
+		_do_clone_submodules $this
 		return
 	}
 	fconfigure $fd_ph -blocking 0
--=20
1.7.9.3.369.gd715.dirty


--=-1Vm65Z34j2dZj+ijsb8R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iF4EABEKAAYFAlMWWzwACgkQkKuHPdwEGdQMBAD8Cktpj3IHXXGBK57SIWy40BMT
BREskkW1JGsZ1wu+o84A/iVk9eO8h8lCve+V6j5uAcTKwHDOFYMiNiMzGfN7pw5J
=1GX3
-----END PGP SIGNATURE-----

--=-1Vm65Z34j2dZj+ijsb8R--
