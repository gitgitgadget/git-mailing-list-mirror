From: jepler@unpythonic.net
Subject: Re: gitk "hyperlinks" (was Re: Display of merges in gitk)
Date: Fri, 5 Aug 2005 13:51:00 -0500
Message-ID: <20050805185056.GF19009@unpythonic.net>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0508050658260.3258@g5.osdl.org> <Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oPmsXEqKQNHCSXW7"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 05 21:21:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E17jf-0008Ct-Ta
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 21:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbVHESxJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 14:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbVHESwc
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 14:52:32 -0400
Received: from craie.unpythonic.net ([206.222.212.219]:52102 "EHLO
	craie.unpythonic.net") by vger.kernel.org with ESMTP
	id S263074AbVHESvB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2005 14:51:01 -0400
Received: by craie.unpythonic.net (Postfix, from userid 405)
	id 407BF5DC335; Fri,  5 Aug 2005 13:51:00 -0500 (CDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
User-Agent: Mutt/1.4.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 05, 2005 at 07:37:41AM -0700, Linus Torvalds wrote:
> For 2.6.13 we've been reverting some stuff lately, to make sure we get a=
=20
> stable release. That's fine, and when I revert something I try to mention=
=20
> the commit ID of the thing I revert in the message. Apparently others do=
=20
> too, as indicated by a patch I just got from Petr Vandovec. So we've got=
=20
> for example:
[snipped]

The following code worked for me on a toy commit.  I'm not sure the regular
expression in linkcommits is right if the SHA1 is followed by a colon or a =
comma,
as I noticed it was in your examples.  If it doesn, then removing the [[:<:=
]]
and [[:>:]] will probably fix it.

Things that look like SHA1s are highlighted even if they don't actually exi=
st.

There is probably a "more right" place to do the '$ctext tag bind Commit' c=
ommands
but I didn't find it right away.

diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -1753,6 +1753,11 @@ proc selectline {l} {
     $ctext conf -state disabled
     set commentend [$ctext index "end - 1c"]
=20
+    linkcommits $ctext 0.0 $commentend
+    $ctext tag configure Commit -underline yes -foreground blue
+    $ctext tag bind Commit <Enter> { %W configure -cursor hand2 }
+    $ctext tag bind Commit <Leave> { %W configure -cursor {} }
+    $ctext tag bind Commit <Button-1><ButtonRelease-1> { linkclick %W %x %=
y }
     $cflist delete 0 end
     $cflist insert end "Comments"
     if {$nparents($id) =3D=3D 1} {
@@ -1762,6 +1767,30 @@ proc selectline {l} {
     }
 }
=20
+proc linkclick {w x y} {
+    set index [$w index @$x,$y]
+    set tags [$w tag names $index]
+    foreach c $tags {
+        if {![string match {C_*} $c]} { continue; }
+        global sha1string
+        set sha1string [string range $c 2 end]
+        gotocommit
+    }
+}
+
+proc linkcommits {w start end} {
+    while {1} {
+        set pos [$w search -regexp {[[:<:]][0-9a-fA-F]{40}[[:>:]]} $start =
$end]
+        if {$pos =3D=3D {}} {break}
+       =20
+        set commit [$w get $pos "$pos+40c"]
+
+        $w tag add Commit $pos "$pos+40c"
+        $w tag add C_$commit $pos "$pos+40c"
+        set start [$w index "$pos+40c"]
+    }
+}
+
 proc selnextline {dir} {
     global selectedline
     if {![info exists selectedline]} return


--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFC87UQJd01MZaTXX0RAs28AKCAfNjsK4e438QT1PbHyVSvyMCEyQCeIXmB
42aOx2Mc7+reJNacI81qZgQ=
=b6Xv
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--
