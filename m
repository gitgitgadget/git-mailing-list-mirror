From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use --upload-pack in clone, fetch and ls-remote instead of --exec
Date: Tue, 23 Jan 2007 01:25:47 -0800
Message-ID: <7vlkjunlgk.fsf@assigned-by-dhcp.cox.net>
References: <20070123082017.GA10007@cepheus> <20070123082437.GA10053@cepheus>
	<7vveiynnju.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 10:25:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Hub-0001TH-H0
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 10:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932916AbXAWJZu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 23 Jan 2007 04:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932921AbXAWJZu
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 04:25:50 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:55850 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932916AbXAWJZt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jan 2007 04:25:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070123092548.YDFL15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Tue, 23 Jan 2007 04:25:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id EZQs1W00D1kojtg0000000; Tue, 23 Jan 2007 04:24:53 -0500
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
In-Reply-To: <7vveiynnju.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 23 Jan 2007 00:40:37 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37492>

Junio C Hamano <junkio@cox.net> writes:

> Uwe Kleine-K=F6nig  <ukleinek@informatik.uni-freiburg.de> writes:
>
>> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.=
de>
>> ---
>> I don't like the change to git-fetch.sh.  But currently git-fetch-pa=
ck
>> needs a =3D and ls-remote doesn't like it.  So it continues to have =
two
>> variables for the remote upload program.
>
> Then maybe something like this is in order to make things more
> consistent?

Merging these two together,...

-- >8 --
[PATCH] ls-remote and clone: accept --upload-pack=3D<path> as well.

This makes them consistent with other commands that take the
path to the upload-pack program.  We also pass --upload-pack
instead of --exec to the underlying fetch-pack, although it is
not strictly necessary.

[jc: original motivation from Uwe]

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-clone.sh     |    4 +++-
 git-fetch.sh     |   11 +++++++----
 git-ls-remote.sh |    6 +++++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 0f7bbbf..ced7dfb 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -163,7 +163,9 @@ while
 	1,-u|1,--upload-pack) usage ;;
 	*,-u|*,--upload-pack)
 		shift
-		upload_pack=3D"--exec=3D$1" ;;
+		upload_pack=3D"--upload-pack=3D$1" ;;
+	*,--upload-pack=3D*)
+		upload_pack=3D--upload-pack=3D$(expr "$1" : '-[^=3D]*=3D\(.*\)') ;;
 	1,--depth) usage;;
 	*,--depth)
 		shift
diff --git a/git-fetch.sh b/git-fetch.sh
index 87b940b..07a1d05 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -22,7 +22,6 @@ force=3D
 verbose=3D
 update_head_ok=3D
 exec=3D
-upload_pack=3D
 keep=3D
 shallow_depth=3D
 while case "$#" in 0) break ;; esac
@@ -34,8 +33,12 @@ do
 	--upl|--uplo|--uploa|--upload|--upload-|--upload-p|\
 	--upload-pa|--upload-pac|--upload-pack)
 		shift
-		exec=3D"--exec=3D$1"=20
-		upload_pack=3D"-u $1"
+		exec=3D"--upload-pack=3D$1"
+		;;
+	--upl=3D*|--uplo=3D*|--uploa=3D*|--upload=3D*|\
+	--upload-=3D*|--upload-p=3D*|--upload-pa=3D*|--upload-pac=3D*|--uploa=
d-pack=3D*)
+		exec=3D--upload-pack=3D$(expr "$1" : '-[^=3D]*=3D\(.*\)')
+		shift
 		;;
 	-f|--f|--fo|--for|--forc|--force)
 		force=3Dt
@@ -94,7 +97,7 @@ then
 fi
=20
 # Global that is reused later
-ls_remote_result=3D$(git ls-remote $upload_pack "$remote") ||
+ls_remote_result=3D$(git ls-remote $exec "$remote") ||
 	die "Cannot get the repository state from $remote"
=20
 append_fetch_head () {
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index 03b624e..dd22783 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -23,7 +23,11 @@ do
   -u|--u|--up|--upl|--uploa|--upload|--upload-|--upload-p|--upload-pa|=
\
   --upload-pac|--upload-pack)
 	shift
-	exec=3D"--exec=3D$1"
+	exec=3D"--upload-pack=3D$1"
+	shift;;
+  -u=3D*|--u=3D*|--up=3D*|--upl=3D*|--uplo=3D*|--uploa=3D*|--upload=3D=
*|\
+  --upload-=3D*|--upload-p=3D*|--upload-pa=3D*|--upload-pac=3D*|--uplo=
ad-pack=3D*)
+	exec=3D--upload-pack=3D$(expr "$1" : '-[^=3D]*=3D\(.*\)')
 	shift;;
   --)
   shift; break ;;
--=20
1.5.0.rc2.g4e4d0
