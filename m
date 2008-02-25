From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCHv2] clone: support cloning full bundles
Date: Mon, 25 Feb 2008 11:12:29 +0100
Message-ID: <1203934349-12125-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 11:13:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTaL1-0001B1-3Y
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 11:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbYBYKMv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 05:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbYBYKMu
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 05:12:50 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:63379 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbYBYKMs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 05:12:48 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1252484fga.17
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 02:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=Emg0c58EC9ETpndEEsxHqShy+xq2bYyHkeiIhkszy48=;
        b=baJmI7k9V35f1Nld6rCZ+SWKM+38wti7rCi3WGjT/UeemY4J+xv/nNufLL7wHKPfEMZB5Gi+CXjN3kiZmsyVWd9R54NzkMgspULGJl28DsWP8Qrp+hnDoHThCD8avZB/ASPC775X5GAeMvZuc7WR0ymRlMzkh1J6ycrHv/Mw2lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=XSx5cTBKJrbiy9vpHTTcU/MBqcI5+GD1JhUSdUfUGOozYZe/GSvn68irX5jsCoJwmiHzciffwmnUg01HGkdV5Xik+6yhHJXyGs7fUGiV1Z+mLOE2v+HUKBQYW7DON8dygOToKnQ5LneyH8Vn/Zq3/7p62jp4ndl7ewpgLMZrmPo=
Received: by 10.86.84.5 with SMTP id h5mr2706167fgb.53.1203934364744;
        Mon, 25 Feb 2008 02:12:44 -0800 (PST)
Received: from localhost ( [91.13.105.170])
        by mx.google.com with ESMTPS id 4sm4710622fgg.4.2008.02.25.02.12.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Feb 2008 02:12:43 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.293.gac81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75022>

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---

Hi *,

  while waiting for the C port of git-clone I've updated my patch to
support bundles in "git clone".

Santi

 git-clone.sh           |   17 +++++++++++++----
 t/t5701-clone-local.sh |   11 +++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 0d686c3..2efb947 100755
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
 [ -z "$dir" ] && dir=3D$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.gi=
t$||' -e 's|.*[/:]||g')
+[ -f "$dir" ] && dir=3D$(expr "$repo" : '.*/\([^/]*\)\.[^/]*')
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
index 59a165a..8a8e65c 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -9,6 +9,7 @@ test_expect_success 'preparing origin repository' '
 	: >file && git add . && git commit -m1 &&
 	git clone --bare . a.git &&
 	git clone --bare . x &&
+	git bundle create b1.bundle --all HEAD &&
 	test "$(GIT_CONFIG=3Da.git/config git config --bool core.bare)" =3D t=
rue &&
 	test "$(GIT_CONFIG=3Dx/config git config --bool core.bare)" =3D true
 '
@@ -71,4 +72,14 @@ test_expect_success 'local clone of repo with nonexi=
stent ref in HEAD' '
 	git fetch &&
 	test ! -e .git/refs/remotes/origin/HEAD'
=20
+test_expect_success 'bundle clone with suffix' '
+	cd "$D" &&
+	git clone b1.bundle
+'
+
+test_expect_success 'bundle clone' '
+	cd "$D" &&
+	git clone b1.bundle bdl1
+'
+
 test_done
--=20
1.5.4.3.293.gac81
