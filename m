From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] Write .editmsg in GIT_DIR to avoid being in git-status.
Date: Wed, 05 Oct 2005 18:54:36 +0200
Message-ID: <87achnq4z7.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Oct 05 18:56:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENCX7-0005QX-HF
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 18:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbVJEQyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Oct 2005 12:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbVJEQyS
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 12:54:18 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:40142 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1030244AbVJEQyR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 12:54:17 -0400
Received: from bela (nb-sbejar.ifae.es [192.101.162.156])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id j95Gs7I28975
	for <git@vger.kernel.org>; Wed, 5 Oct 2005 18:54:12 +0200
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9720>


It appears in the git-status output during a git-commit if you have
something in info/exclude.

Also for .cmitmsg and .cmitchk to make git-commit work
in read-only working trees.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>


---

 git-commit.sh |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

applies-to: 9eec9ff9326032bca405a12a265918725edf4ac7
4e61f41c1feed7345fc442747c82b9ea701fb59c
diff --git a/git-commit.sh b/git-commit.sh
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -129,7 +129,7 @@ then
 elif test "$use_commit" !=3D ""
 then
 	git-cat-file commit "$use_commit" | sed -e '1,/^$/d'
-fi | git-stripspace >.editmsg
+fi | git-stripspace >"$GIT_DIR"/.editmsg=20
=20
 case "$signoff" in
 t)
@@ -139,7 +139,7 @@ t)
 			s/>.*/>/
 			s/^/Signed-off-by: /
 		'
-	} >>.editmsg
+	} >>"$GIT_DIR"/.editmsg
 	;;
 esac
=20
@@ -153,7 +153,7 @@ if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
 	echo "#	$GIT_DIR/MERGE_HEAD"
 	echo "# and try again"
 	echo "#"
-fi >>.editmsg
+fi >>"$GIT_DIR"/.editmsg
=20
 PARENTS=3D"-p HEAD"
 if GIT_DIR=3D"$GIT_DIR" git-rev-parse --verify HEAD >/dev/null 2>&1
@@ -197,16 +197,16 @@ else
 	fi
 	PARENTS=3D""
 fi
-git-status >>.editmsg
+git-status >>"$GIT_DIR"/.editmsg
 if [ "$?" !=3D "0" -a ! -f $GIT_DIR/MERGE_HEAD ]
 then
-	rm -f .editmsg
+	rm -f "$GIT_DIR"/.editmsg
 	git-status
 	exit 1
 fi
 case "$no_edit" in
 '')
-	${VISUAL:-${EDITOR:-vi}} .editmsg
+	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR"/.editmsg
 	;;
 esac
=20
@@ -214,16 +214,16 @@ case "$verify" in
 t)
 	if test -x "$GIT_DIR"/hooks/commit-msg
 	then
-		"$GIT_DIR"/hooks/commit-msg .editmsg || exit
+		"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/.editmsg || exit
 	fi
 esac
=20
-grep -v '^#' < .editmsg | git-stripspace > .cmitmsg
-grep -v -i '^Signed-off-by' .cmitmsg >.cmitchk
-if test -s .cmitchk
+grep -v '^#' < "$GIT_DIR"/.editmsg | git-stripspace > "$GIT_DIR"/.cmit=
msg
+grep -v -i '^Signed-off-by' "$GIT_DIR"/.cmitmsg >"$GIT_DIR"/.cmitchk
+if test -s "$GIT_DIR"/.cmitchk
 then
 	tree=3D$(git-write-tree) &&
-	commit=3D$(cat .cmitmsg | git-commit-tree $tree $PARENTS) &&
+	commit=3D$(cat "$GIT_DIR"/.cmitmsg | git-commit-tree $tree $PARENTS) =
&&
 	git-update-ref HEAD $commit $current &&
 	rm -f -- "$GIT_DIR/MERGE_HEAD"
 else
@@ -231,7 +231,7 @@ else
 	false
 fi
 ret=3D"$?"
-rm -f .cmitmsg .editmsg .cmitchk
+rm -f "$GIT_DIR"/{.cmitmsg,.editmsg,.cmitchk}
=20
 if test -x "$GIT_DIR"/hooks/post-commit && test "$ret" =3D 0
 then
---
0.99.8.GIT
