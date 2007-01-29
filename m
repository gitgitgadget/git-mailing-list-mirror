From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: [PATCH] Replace perl code with pure shell code
Date: Mon, 29 Jan 2007 09:09:25 +0100
Message-ID: <45BDABB5.4070301@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig03C9E1CE91A728434193F75B"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 29 09:09:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBRaG-0007Rc-PW
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 09:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933179AbXA2IJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 03:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933186AbXA2IJh
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 03:09:37 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:54223 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933179AbXA2IJg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 03:09:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 1E2A92816B
	for <git@vger.kernel.org>; Mon, 29 Jan 2007 09:09:34 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HcRMCIa35aKP for <git@vger.kernel.org>;
	Mon, 29 Jan 2007 09:09:34 +0100 (CET)
Received: from [62.216.202.244] (ppp-62-216-202-244.dynamic.mnet-online.de [62.216.202.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id C82D928168
	for <git@vger.kernel.org>; Mon, 29 Jan 2007 09:09:33 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38067>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig03C9E1CE91A728434193F75B
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
---
 git-clone.sh |   65 ++++++++++++++++++----------------------------------=
-----
 1 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index ced7dfb..b3c6fa4 100755
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
@@ -332,8 +290,27 @@ test -d "$GIT_DIR/refs/reference-tmp" && rm -fr "$GI=
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



--------------enig03C9E1CE91A728434193F75B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFvau4r5S+dk6z85oRAmgEAJ9W0V1gZ7x6RRUiKzDwlQsWgTtIcgCfeypT
5zsGobeY1tJ4hw7e9aCU5fE=
=AhUQ
-----END PGP SIGNATURE-----

--------------enig03C9E1CE91A728434193F75B--
