From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] clone: support cloning full bundles
Date: Wed, 12 Dec 2007 11:48:05 +0100
Message-ID: <1197456485-22909-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 11:41:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2P1Z-0008Lm-2X
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 11:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667AbXLLKkr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 05:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756182AbXLLKkr
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 05:40:47 -0500
Received: from mail.mppmu.mpg.de ([134.107.24.11]:58909 "EHLO
	mail.mppmu.mpg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755995AbXLLKkq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 05:40:46 -0500
Received: by mail.mppmu.mpg.de (Postfix, from userid 998)
	id 2BB421203F; Wed, 12 Dec 2007 11:40:45 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on mail.mppmu.mpg.de
X-Spam-Status: No, score=-3.2 required=6.0 tests=ALL_TRUSTED,BAYES_00,
	J_CHICKENPOX_13,J_CHICKENPOX_53 autolearn=ham version=3.1.7
X-Spam-Level: 
Received: from localhost.localdomain (sn3dhcp15.mppmu.mpg.de [134.107.3.155])
	by mail.mppmu.mpg.de (Postfix) with ESMTP id 163D712027;
	Wed, 12 Dec 2007 11:40:36 +0100 (CET)
X-Mailer: git-send-email 1.5.3.7.2094.gff6c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68035>

It still fails for incremental bundles.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
Hi *,

Does anyone know how to create a repository from an incremental bundle?

Also, when a repo/bundle does not have a HEAD, clone does not setup the
remote configs, is this the desired behavior?=20

I know that Kristian is working in the C conversion, I'll rebase this
patch on top if that is prefered. Or maybe it will not be necessary at =
all,
as "git fetch" supports bundles.

Santi

 git-clone.sh           |   17 +++++++++++++----
 t/t5701-clone-local.sh |   11 +++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index ecf9d89..a4a2124 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -206,11 +206,14 @@ fi
 if base=3D$(get_repo_base "$repo"); then
 	repo=3D"$base"
 	local=3Dyes
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
@@ -359,11 +362,17 @@ yes)
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
index 822ac8c..a7e5a31 100755
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
@@ -63,4 +64,14 @@ test_expect_success 'Even without -l, local will mak=
e a hardlink' '
 	test 0 =3D $copied
 '
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
1.5.3.7.2094.gff6c
