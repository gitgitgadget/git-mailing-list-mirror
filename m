From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: [PATCH] Replace perl code with pure shell code
Date: Mon, 29 Jan 2007 10:18:02 +0100
Message-ID: <45BDBBCA.6030107@fs.ei.tum.de>
References: <<7vtzya8b4g.fsf@assigned-by-dhcp.cox.net>>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig046BCEB876EA6FA9E9C1FE08"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 29 10:18:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBSeW-0000l6-5V
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 10:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbXA2JSL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 04:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbXA2JSL
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 04:18:11 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:60663 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbXA2JSK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 04:18:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 43A5E28183;
	Mon, 29 Jan 2007 10:18:08 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 25AvMD1340ca; Mon, 29 Jan 2007 10:18:08 +0100 (CET)
Received: from [62.216.202.244] (ppp-62-216-202-244.dynamic.mnet-online.de [62.216.202.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id C294428135;
	Mon, 29 Jan 2007 10:18:07 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <7vtzya8b4g.fsf@assigned-by-dhcp.cox.net>>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38069>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig046BCEB876EA6FA9E9C1FE08
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
---
>> -	next if ($name =3D~ /\^\173/);
>> -	if ($name eq "HEAD") {
>> ...
>=20
> Thanks.  I like the general direction, but not quite.
>=20
> You exposed one outstanding bug, which is a hint about what is
> not quite right with your patch.

I already wondered.  What's those ^{} tags, and why is CLONE_HEAD littere=
d with them?

 git-clone.sh |   67 ++++++++++++++++++++--------------------------------=
------
 1 files changed, 23 insertions(+), 44 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index ced7dfb..869caf9 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -66,48 +66,6 @@ Perhaps git-update-server-info needs to be run there?"=

 	rm -f "$GIT_DIR/REMOTE_HEAD"
 }
=20
-# Read git-fetch-pack -k output and store the remote branches.
-copy_refs=3D'
-use File::Path qw(mkpath);
-use File::Basename qw(dirname);
-my $git_dir =3D $ARGV[0];
-my $use_separate_remote =3D $ARGV[1];
-my $origin =3D $ARGV[2];
-
-my $branch_top =3D ($use_separate_remote ? "remotes/$origin" : "heads");=

-my $tag_top =3D "tags";
-
-sub store {
-	my ($sha1, $name, $top) =3D @_;
-	$name =3D "$git_dir/refs/$top/$name";
-	mkpath(dirname($name));
-	open O, ">", "$name";
-	print O "$sha1\n";
-	close O;
-}
-
-open FH, "<", "$git_dir/CLONE_HEAD";
-while (<FH>) {
-	my ($sha1, $name) =3D /^([0-9a-f]{40})\s(.*)$/;
-	next if ($name =3D~ /\^\173/);
-	if ($name eq "HEAD") {
-		open O, ">", "$git_dir/REMOTE_HEAD";
-		print O "$sha1\n";
-		close O;
-		next;
-	}
-	if ($name =3D~ s/^refs\/heads\///) {
-		store($sha1, $name, $branch_top);
-		next;
-	}
-	if ($name =3D~ s/^refs\/tags\///) {
-		store($sha1, $name, $tag_top);
-		next;
-	}
-}
-close FH;
-'
-
 quiet=3D
 local=3Dno
 use_local=3Dno
@@ -332,8 +290,29 @@ test -d "$GIT_DIR/refs/reference-tmp" && rm -fr "$GI=
T_DIR/refs/reference-tmp"
 if test -f "$GIT_DIR/CLONE_HEAD"
 then
 	# Read git-fetch-pack -k output and store the remote branches.
-	@@PERL@@ -e "$copy_refs" "$GIT_DIR" "$use_separate_remote" "$origin" ||=

-	exit
+	if [ -n "$use_separate_remote" ]
+	then
+		branch_top=3D"remotes/$origin"
+	else
+		branch_top=3D"heads"
+	fi
+	tag_top=3D"tags"
+	while read sha1 name
+	do
+		case "$name" in
+		*^{*)
+			continue ;;
+		HEAD)
+			destname=3D"REMOTE_HEAD" ;;
+		refs/heads/*)
+			destname=3D"refs/$branch_top/${name#refs/heads/}" ;;
+		refs/tags/*)
+			destname=3D"refs/$tag_top/${name#refs/tags/}" ;;
+		*)
+			continue ;;
+		esac
+		git-update-ref -m "clone: from $repo" "$destname" "$sha1" ""
+	done < "$GIT_DIR/CLONE_HEAD"
 fi
=20
 cd "$D" || exit
--=20
1.5.0.rc1.196.geebfb



--------------enig046BCEB876EA6FA9E9C1FE08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFvbvKr5S+dk6z85oRAoLTAKCBy5wZjjnHoeRQwnzSqO+S/g65nACfVHNR
oSEhuHhHxFZBQCKtyh+HFyI=
=HAsj
-----END PGP SIGNATURE-----

--------------enig046BCEB876EA6FA9E9C1FE08--
