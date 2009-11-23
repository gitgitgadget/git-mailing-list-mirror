From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git svn: strip leading path when making empty dirs
Date: Sun, 22 Nov 2009 18:21:36 -0800
Message-ID: <20091123022136.GA1055@dcvr.yhbt.net>
References: <20091122134638.GA12233@atjola.homenet> <20091122232504.GA28127@dcvr.yhbt.net> <20091122235248.GA17418@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 03:21:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCOYi-0005h0-GA
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 03:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130AbZKWCVb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 21:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756096AbZKWCVa
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 21:21:30 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:34116 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754373AbZKWCVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 21:21:30 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9721F682;
	Mon, 23 Nov 2009 02:21:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091122235248.GA17418@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133475>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> wrote:
> Argh, yeah, I messed that patch up, the test only failed because I al=
so
> messed up this line, adding the trunk prefix there, too. Fixed patch
> below.
>=20
> SVN Repo layout:
>=20
> /
> |
> |---trunk
> |   |
> ... |---foo/ # Empty
>     |
>     |---bar/
>         |
>         somefile
>=20
> with "git svn clone -s svn://host/path/to/repo you get:
>=20
> .git
> bar/
> bar/somefile
> trunk/foo # This should be just foo/
>=20
> i.e. the empty directories have their path relative to the repo root,
> instead of relative to the directory the git branch is associated wit=
h.
>=20
> Sorry for the messed up first patch.

No worries, thanks for the bug report and test case.  My brain's been
completely fried lately so I was completely confused :x
Anyways this should fix it:

     Also pushed out to git://git.bogomips.org/git-svn:
	Eric Wong (2):
	      git svn: always reuse existing remotes on fetch
	      git svn: strip leading path when making empty dirs

=46rom 9be30eed61993a6f2d04a1609723e64e7632a64e Mon Sep 17 00:00:00 200=
1
=46rom: Eric Wong <normalperson@yhbt.net>
Date: Sun, 22 Nov 2009 18:11:32 -0800
Subject: [PATCH] git svn: strip leading path when making empty dirs
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Since unhandled.log stores paths relative to the repository
root, we need to strip out leading path components if the
directories we're tracking are not the repository root.

Reported-by: Bj=F6rn Steinbrink
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl                  |    3 +++
 t/t9146-git-svn-empty-dirs.sh |   23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 7f7a56f..957d44e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2752,8 +2752,11 @@ sub mkemptydirs {
 		}
 	}
 	close $fh;
+
+	my $strip =3D qr/\A\Q$self->{path}\E(?:\/|$)/;
 	foreach my $d (sort keys %empty_dirs) {
 		$d =3D uri_decode($d);
+		$d =3D~ s/$strip//;
 		next if -d $d;
 		if (-e _) {
 			warn "$d exists but is not a directory\n";
diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs=
=2Esh
index 5948544..70c52c1 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -82,4 +82,27 @@ test_expect_success 'git svn mkdirs -r works' '
 	)
 '
=20
+test_expect_success 'initialize trunk' '
+	for i in trunk trunk/a trunk/"weird file name"
+	do
+		svn_cmd mkdir -m "mkdir $i" "$svnrepo"/"$i"
+	done
+'
+
+test_expect_success 'clone trunk' 'git svn clone -s "$svnrepo" trunk'
+
+test_expect_success 'empty directories in trunk exist' '
+	(
+		cd trunk &&
+		for i in a "weird file name"
+		do
+			if ! test -d "$i"
+			then
+				echo >&2 "$i does not exist"
+				exit 1
+			fi
+		done
+	)
+'
+
 test_done
--=20
Eric Wong
