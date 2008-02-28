From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCHv3] clone: support cloning full bundles
Date: Thu, 28 Feb 2008 03:22:52 +0100
Message-ID: <1204165372-12175-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 03:25:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUYSq-00075G-5g
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 03:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbYB1CZE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 21:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbYB1CZE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 21:25:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:28047 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbYB1CZB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 21:25:01 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2498211fga.17
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 18:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=dDbNcUJkYN7gpXmDoKIUGPM4zdAfUcuQ+ImnrwYg240=;
        b=TjPEmuvPIt4FgRBHSG+DnGt8oGV8AP+PFiXOfTlGvmIjMbsSVYyh6gMBTYx692C8wTmMjKCMQTeY0p6ALXZbLWCUrSPT0D1k83pv3DSqQi1WrNTHqqEYKI75M/99YUSbyRaoo/+N5OWuCG9c77z2mfskMXD+rZtlZNBYVazOFBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=CA6Y1F9btJDcgstVzucITG0sdExRGhSVVG/NCSxrdXZ6NxOgfhBJGoNCSaug2ty+Ipc+d4Sy6tPU06k8tM4g8XJpb/T04AkZyfu4CLdw5leOfqPUblGXIPU3i0QIic/iMeP/tkKDorzTYiH1Amrdh9RBEslhXLwNzO81MuPzkDY=
Received: by 10.86.54.3 with SMTP id c3mr7129107fga.18.1204165499685;
        Wed, 27 Feb 2008 18:24:59 -0800 (PST)
Received: from localhost ( [91.13.66.49])
        by mx.google.com with ESMTPS id 28sm13641646fkx.11.2008.02.27.18.24.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Feb 2008 18:24:58 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.221.gf0f3f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75341>

The "humanish" part of a bundle is made removing the ".bundle" suffix.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
Hi,

  Just in case .bundle is the definitive suffix.

  Changes since v2:

  . fixed the && [ -f "$repo" ] test
  . make "offically" the .bundle suffix
  . test that "git fetch" works after the cloning
  . additional tests

Santi

 git-clone.sh           |   19 ++++++++++++++-----
 t/t5701-clone-local.sh |   45 ++++++++++++++++++++++++++++++++++++++++=
+++++
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 0d686c3..0580b5a 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -210,11 +210,14 @@ if base=3D$(get_repo_base "$repo"); then
 	then
 		local=3Dyes
 	fi
+elif [ -f "$repo" ] ; then
+	case "$repo" in /*);; *) repo=3D"$PWD/$repo" ; esac
 fi
=20
 dir=3D"$2"
 # Try using "humanish" part of source repo if user didn't specify one
-[ -z "$dir" ] && dir=3D$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.gi=
t$||' -e 's|.*[/:]||g')
+[ -z "$dir" ] && dir=3D$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.gi=
t$||' -e 's|.*[/:]||g') &&
+[ -f "$repo" ] && dir=3D$(echo "$repo" | sed -e 's|/*\.bundle$||' -e '=
s|.*/||g')
 [ -e "$dir" ] && die "destination directory '$dir' already exists."
 [ yes =3D "$bare" ] && unset GIT_WORK_TREE
 [ -n "$GIT_WORK_TREE" ] && [ -e "$GIT_WORK_TREE" ] &&
@@ -364,11 +367,17 @@ yes)
 		fi
 		;;
 	*)
-		case "$upload_pack" in
-		'') git-fetch-pack --all -k $quiet $depth $no_progress "$repo";;
-		*) git-fetch-pack --all -k $quiet "$upload_pack" $depth $no_progress=
 "$repo" ;;
-		esac >"$GIT_DIR/CLONE_HEAD" ||
+		if [ -f "$repo" ] ; then
+			git bundle unbundle "$repo" > "$GIT_DIR/CLONE_HEAD" ||
+			die "unbundle from '$repo' failed."
+		else
+			case "$upload_pack" in
+			'') git-fetch-pack --all -k $quiet $depth $no_progress "$repo";;
+			*) git-fetch-pack --all -k \
+				$quiet "$upload_pack" $depth $no_progress "$repo" ;;
+			esac >"$GIT_DIR/CLONE_HEAD" ||
 			die "fetch-pack from '$repo' failed."
+		fi
 		;;
 	esac
 	;;
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 59a165a..ef2db00 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -11,6 +11,11 @@ test_expect_success 'preparing origin repository' '
 	git clone --bare . x &&
 	test "$(GIT_CONFIG=3Da.git/config git config --bool core.bare)" =3D t=
rue &&
 	test "$(GIT_CONFIG=3Dx/config git config --bool core.bare)" =3D true
+	git bundle create b1.bundle --all HEAD &&
+	git bundle create b2.bundle --all &&
+	mkdir dir &&
+	cp b1.bundle dir/b3
+	cp b1.bundle b4
 '
=20
 test_expect_success 'local clone without .git suffix' '
@@ -71,4 +76,44 @@ test_expect_success 'local clone of repo with nonexi=
stent ref in HEAD' '
 	git fetch &&
 	test ! -e .git/refs/remotes/origin/HEAD'
=20
+test_expect_success 'bundle clone without .bundle suffix' '
+	cd "$D" &&
+	git clone dir/b3 &&
+	cd b3 &&
+	git fetch
+'
+
+test_expect_success 'bundle clone with .bundle suffix' '
+	cd "$D" &&
+	git clone b1.bundle &&
+	cd b1 &&
+	git fetch
+'
+
+test_expect_success 'bundle clone from b4' '
+	cd "$D" &&
+	git clone b1.bundle bdl1 &&
+	cd bdl1 &&
+	git fetch
+'
+
+test_expect_success 'bundle clone from b4.bundle that does not exist' =
'
+	cd "$D" &&
+	if git clone b4.bundle bb
+	then
+		echo "Oops, should have failed"
+		false
+	else
+		echo happy
+	fi
+'
+
+test_expect_success 'bundle clone with nonexistent HEAD' '
+	cd "$D" &&
+	git clone b2.bundle b2 &&
+	cd b2 &&
+	git fetch
+	test ! -e .git/refs/heads/master
+'
+
 test_done
--=20
1.5.4.3.221.gf0f3f
