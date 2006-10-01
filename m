From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 1/2] fetch: Misc output cleanup
Date: Sun, 01 Oct 2006 05:33:05 +0200
Message-ID: <87y7s0677y.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Oct 01 05:33:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTs52-00019i-Pj
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 05:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWJADdM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 30 Sep 2006 23:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWJADdM
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 23:33:12 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:61568 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1751769AbWJADdK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Sep 2006 23:33:10 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k913X8Q12157
	for <git@vger.kernel.org>; Sun, 1 Oct 2006 05:33:08 +0200
To: git <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28167>


In particular it removes duplicate information, uses short hashes (as
git-log and company) and uses .. for fast forwarding commits and ... fo=
r
not-fast-forwarding commits (shorter, easier to copy&paste). It also
reformat the output as:

1. the ones we store in our local ref (either branches or tags):

 1a) fast-forward

 * refs/heads/origin: fast forward to branch 'master' of ../git/
   old..new: 1ad7a06..bc1a580

 1b) same (only shown under -v)

 * refs/heads/next: same as branch 'origin/next' of ../git/
   commit: ce47b9f

 1c) non-fast-forward, forced

 * refs/heads/pu: forcing update to not fast forwarding branch 'pu' of =
=2E./git/
   old...new: 7c733a8...5faa935

 1d) non-fast-forward, did not update because not forced

 * refs/heads/po: not updating to not fast forwarding branch 'po' of ..=
/git/
   old...new: 7c733a8...5faa935

 1e) creating a new local ref to store

 * refs/tags/v1.4.2-rc4: storing tag 'v1.4.2-rc4' of ../git/
   tag: 8c7a107
 * refs/heads/next: storing branch 'next' of ../git/
   commit: f8a20ae

2. the ones we do not store in our local ref (only shown under -v):

 * fetched branch 'master' of ../git
   commit: 695dffe
 * fetched tag 'v1.4.2-rc4' of ../git
   tag: 8c7a107

With the help of Junio.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 git-fetch.sh |   41 +++++++++++++++++++++++++----------------
 1 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index f1522bd..60ae552 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -129,22 +129,25 @@ append_fetch_head () {
     then
 	headc_=3D$(git-rev-parse --verify "$head_^0") || exit
 	echo "$headc_	$not_for_merge_	$note_" >>"$GIT_DIR/FETCH_HEAD"
-	[ "$verbose" ] && echo >&2 "* committish: $head_"
-	[ "$verbose" ] && echo >&2 "  $note_"
     else
 	echo "$head_	not-for-merge	$note_" >>"$GIT_DIR/FETCH_HEAD"
-	[ "$verbose" ] && echo >&2 "* non-commit: $head_"
-	[ "$verbose" ] && echo >&2 "  $note_"
-    fi
-    if test "$local_name_" !=3D ""
-    then
-	# We are storing the head locally.  Make sure that it is
-	# a fast forward (aka "reverse push").
-	fast_forward_local "$local_name_" "$head_" "$note_"
     fi
+
+    update_local_ref "$local_name_" "$head_" "$note_"
 }
=20
-fast_forward_local () {
+update_local_ref () {
+    # If we are storing the head locally make sure that it is
+    # a fast forward (aka "reverse push").
+
+    label_=3D$(git-cat-file -t $2)
+    newshort_=3D$(git-rev-parse --short $2)
+    if test -z "$1" ; then
+	[ "$verbose" ] && echo >&2 "* fetched $3"
+	[ "$verbose" ] && echo >&2 "  $label_: $newshort_"
+	return 0
+    fi
+    oldshort_=3D$(git-rev-parse --short "$1" 2>/dev/null)
     mkdir -p "$(dirname "$GIT_DIR/$1")"
     case "$1" in
     refs/tags/*)
@@ -154,13 +157,16 @@ fast_forward_local () {
 	then
 		if now_=3D$(cat "$GIT_DIR/$1") && test "$now_" =3D "$2"
 		then
-			[ "$verbose" ] && echo >&2 "* $1: same as $3" ||:
+			[ "$verbose" ] && echo >&2 "* $1: same as $3"
+			[ "$verbose" ] && echo >&2 "  $label_: $newshort_" ||:
 		else
 			echo >&2 "* $1: updating with $3"
+			echo >&2 "  $label_: $newshort_"
 			git-update-ref -m "$rloga: updating tag" "$1" "$2"
 		fi
 	else
 		echo >&2 "* $1: storing $3"
+		echo >&2 "  $label_: $newshort_"
 		git-update-ref -m "$rloga: storing tag" "$1" "$2"
 	fi
 	;;
@@ -178,31 +184,34 @@ fast_forward_local () {
 	        if test -n "$verbose"
 		then
 			echo >&2 "* $1: same as $3"
+			echo >&2 "  $label_: $newshort_"
 		fi
 		;;
 	    *,$local)
 		echo >&2 "* $1: fast forward to $3"
-		echo >&2 "  from $local to $2"
+		echo >&2 "  old..new: $oldshort_..$newshort_"
 		git-update-ref -m "$rloga: fast-forward" "$1" "$2" "$local"
 		;;
 	    *)
 		false
 		;;
 	    esac || {
-		echo >&2 "* $1: does not fast forward to $3;"
 		case ",$force,$single_force," in
 		*,t,*)
-			echo >&2 "  forcing update."
+			echo >&2 "* $1: forcing update to not fast forwarding $3"
+			echo >&2 "  old...new: $oldshort_...$newshort_"
 			git-update-ref -m "$rloga: forced-update" "$1" "$2" "$local"
 			;;
 		*)
-			echo >&2 "  not updating."
+			echo >&2 "* $1: not updating to not fast forwarding $3"
+			echo >&2 "  old...new: $oldshort_...$newshort_"
 			exit 1
 			;;
 		esac
 	    }
 	else
 	    echo >&2 "* $1: storing $3"
+	    echo >&2 "  $label_: $newshort_"
 	    git-update-ref -m "$rloga: storing head" "$1" "$2"
 	fi
 	;;
--=20
1.4.2.1.g38049
