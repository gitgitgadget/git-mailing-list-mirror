From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] git-fetch: Split fetch and merge logic
Date: Sat, 24 Feb 2007 10:50:08 +0100
Message-ID: <87ps7zj35b.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 24 10:50:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKtXl-0001XU-Ht
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 10:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933465AbXBXJuN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 24 Feb 2007 04:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933466AbXBXJuN
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 04:50:13 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:48247 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933465AbXBXJuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 04:50:11 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l1O9o6B20850
	for <git@vger.kernel.org>; Sat, 24 Feb 2007 10:50:06 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40511>


It makes git-parse-remote.sh and almost all git-fetch independent
of the merge logic.

git-fetch fetches the branches from the remote and saves this
information in .git/FETCH_FETCHED (a temporary file), and at the end it
generates the file .git/FETCH_HEAD.

The current merge behaviour is unchanged.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
Hi *,

  I've addressed all the comments, now prepared to even more comments :=
)

  Junio, from your "What's cooking in git.git (topics)" I undestand tha=
t
  the jc/fetch topic is not going to be in next soon (even for the firs=
t
  commit?). Anyway, the simple question is: Which branch (or commit) yo=
u
  want me to base this patch?

 git-fetch.sh        |   80 +++++++++++++++++++++++++++++++------------=
-------
 git-parse-remote.sh |   65 ++++++++++++-----------------------------
 2 files changed, 68 insertions(+), 77 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index d230995..fccfc7d 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -77,9 +77,9 @@ do
 	shift
 done
=20
+origin=3D$(get_default_remote)
 case "$#" in
 0)
-	origin=3D$(get_default_remote)
 	test -n "$(get_remote_url ${origin})" ||
 		die "Where do you want to fetch from today?"
 	set x $origin ; shift ;;
@@ -101,6 +101,8 @@ if test "" =3D "$append"
 then
 	: >"$GIT_DIR/FETCH_HEAD"
 fi
+: >"$GIT_DIR/FETCH_FETCHED"
+trap 'rm -f "$GIT_DIR"/FETCH_FETCHED' 0 1 2 3 15
=20
 # Global that is reused later
 ls_remote_result=3D$(git ls-remote $exec "$remote") ||
@@ -112,10 +114,6 @@ append_fetch_head () {
     remote_name_=3D"$3"
     remote_nick_=3D"$4"
     local_name_=3D"$5"
-    case "$6" in
-    t) not_for_merge_=3D'not-for-merge' ;;
-    '') not_for_merge_=3D ;;
-    esac
=20
     # remote-nick is the URL given on the command line (or a shorthand=
)
     # remote-name is the $GIT_DIR relative refs/ path we computed
@@ -146,9 +144,7 @@ append_fetch_head () {
     if git-cat-file commit "$head_" >/dev/null 2>&1
     then
 	headc_=3D$(git-rev-parse --verify "$head_^0") || exit
-	echo "$headc_	$not_for_merge_	$note_" >>"$GIT_DIR/FETCH_HEAD"
-    else
-	echo "$head_	not-for-merge	$note_" >>"$GIT_DIR/FETCH_HEAD"
+	echo "$headc_	$remote_name_:$local_name_	$note_" >>"$GIT_DIR/FETCH_FE=
TCHED"
     fi
=20
     update_local_ref "$local_name_" "$head_" "$note_"
@@ -265,7 +261,7 @@ then
 		  git-show-ref --exclude-existing=3Drefs/tags/ |
 	          while read sha1 name
 		  do
-			echo ".${name}:${name}"
+			echo "${name}:${name}"
 		  done` || exit
 	if test "$#" -gt 1
 	then
@@ -288,13 +284,6 @@ fetch_main () {
=20
       # These are relative path from $GIT_DIR, typically starting at r=
efs/
       # but may be HEAD
-      if expr "z$ref" : 'z\.' >/dev/null
-      then
-	  not_for_merge=3Dt
-	  ref=3D$(expr "z$ref" : 'z\.\(.*\)')
-      else
-	  not_for_merge=3D
-      fi
       if expr "z$ref" : 'z+' >/dev/null
       then
 	  single_force=3Dt
@@ -375,7 +364,7 @@ fetch_main () {
       esac
=20
       append_fetch_head "$head" "$remote" \
-	  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge" || exi=
t
+	  "$remote_name" "$remote_nick" "$local_name" || exit
=20
   done
=20
@@ -418,28 +407,16 @@ fetch_main () {
 	      case "$ref" in
 	      +$remote_name:*)
 		  single_force=3Dt
-		  not_for_merge=3D
-		  found=3D"$ref"
-		  break ;;
-	      .+$remote_name:*)
-		  single_force=3Dt
-		  not_for_merge=3Dt
-		  found=3D"$ref"
-		  break ;;
-	      .$remote_name:*)
-		  not_for_merge=3Dt
 		  found=3D"$ref"
 		  break ;;
 	      $remote_name:*)
-		  not_for_merge=3D
 		  found=3D"$ref"
 		  break ;;
 	      esac
 	  done
 	  local_name=3D$(expr "z$found" : 'z[^:]*:\(.*\)')
 	  append_fetch_head "$sha1" "$remote" \
-		  "$remote_name" "$remote_nick" "$local_name" \
-		  "$not_for_merge" || exit
+		  "$remote_name" "$remote_nick" "$local_name" || exit
         done
       )
     ) || exit ;;
@@ -463,7 +440,7 @@ case "$no_tags$tags" in
 		do
 			git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
 			echo >&2 "Auto-following $name"
-			echo ".${name}:${name}"
+			echo "${name}:${name}"
 		done)
 	esac
 	case "$taglist" in
@@ -491,3 +468,44 @@ case "$orig_head" in
 	fi
 	;;
 esac
+
+# Generate $GIT_DIR/FETCH_HEAD
+case ",$#,$remote_nick," in
+,1,$origin,)
+	curr_branch=3D$(git-symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
+	merge_branches=3D$(git-config \
+		--get-all "branch.${curr_branch}.merge" | sort -u)
+	fetch_branches=3D$(get_remote_default_refs_for_fetch -n $remote_nick =
|
+		sed -e 's/:.*$//g' -e 's/^+//' | sort -u)
+	test -n "$merge_branches" && test -n "$fetch_branches" &&
+	merge_branches=3D$(printf '%s\n%s' "$merge_branches" "$fetch_branches=
" | sort | uniq -d)
+	[ -z "$merge_branches" ] ||
+	test "$(get_data_source $remote_nick)" =3D branches && merge_first=3D=
yes;;
+,1,$remote,) merge_branches=3DHEAD;;
+,1,*)merge_first=3Dyes ;;
+*)
+	shift
+	merge_branches=3D$(for ref; do
+		expr "z$ref" : 'z.*:' >/dev/null || ref=3D"${ref}:"
+		echo "$(expr "z$ref" : 'z\([^:]*\):')"; done);;
+esac
+
+test "$merge_first" =3D "yes" &&
+test "$(get_remote_default_refs_for_fetch -t $remote_nick)" !=3D "expl=
icit" &&
+merge_branches=3D && merge_first=3D
+
+merge_branches=3D$(canon_refs_list_for_fetch $merge_branches | sed 's/=
:.*$//g')
+
+while IFS=3D'	' read sha1 ref note ; do
+	remote_branch=3D$(expr "z$ref" : 'z\([^:]*\):')
+	for merge_branch in $merge_branches ; do
+		[ "$merge_branch" =3D "$remote_branch" ] &&
+			echo "$sha1		$note" && continue 2
+	done
+	if ! test "$merge_first" || test "$merge_first" =3D "done" ; then
+		echo "$sha1	not-for-merge	$note"
+	else
+		echo "$sha1		$note"
+		merge_first=3Ddone
+	fi
+done < "$GIT_DIR"/FETCH_FETCHED >> "$GIT_DIR/FETCH_HEAD"
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 5208ee6..307ab06 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -70,8 +70,7 @@ get_remote_default_refs_for_push () {
 	esac
 }
=20
-# Called from canon_refs_list_for_fetch -d "$remote", which
-# is called from get_remote_default_refs_for_fetch to grok
+# Called from get_remote_default_refs_for_fetch to grok
 # refspecs that are retrieved from the configuration, but not
 # from get_remote_refs_for_fetch when it deals with refspecs
 # supplied on the command line.  $ls_remote_result has the list
@@ -130,30 +129,6 @@ expand_refs_wildcard () {
=20
 # Subroutine to canonicalize remote:local notation.
 canon_refs_list_for_fetch () {
-	# If called from get_remote_default_refs_for_fetch
-	# leave the branches in branch.${curr_branch}.merge alone,
-	# or the first one otherwise; add prefix . to the rest
-	# to prevent the secondary branches to be merged by default.
-	merge_branches=3D
-	curr_branch=3D
-	if test "$1" =3D "-d"
-	then
-		shift ; remote=3D"$1" ; shift
-		set $(expand_refs_wildcard "$remote" "$@")
-		is_explicit=3D"$1"
-		shift
-		if test "$remote" =3D "$(get_default_remote)"
-		then
-			curr_branch=3D$(git-symbolic-ref -q HEAD | \
-			    sed -e 's|^refs/heads/||')
-			merge_branches=3D$(git-config \
-			    --get-all "branch.${curr_branch}.merge")
-		fi
-		if test -z "$merge_branches" && test $is_explicit !=3D explicit
-		then
-			merge_branches=3D..this.will.never.match.any.ref..
-		fi
-	fi
 	for ref
 	do
 		force=3D
@@ -166,18 +141,6 @@ canon_refs_list_for_fetch () {
 		expr "z$ref" : 'z.*:' >/dev/null || ref=3D"${ref}:"
 		remote=3D$(expr "z$ref" : 'z\([^:]*\):')
 		local=3D$(expr "z$ref" : 'z[^:]*:\(.*\)')
-		dot_prefix=3D.
-		if test -z "$merge_branches"
-		then
-			merge_branches=3D$remote
-			dot_prefix=3D
-		else
-			for merge_branch in $merge_branches
-			do
-			    [ "$remote" =3D "$merge_branch" ] &&
-			    dot_prefix=3D && break
-			done
-		fi
 		case "$remote" in
 		'' | HEAD ) remote=3DHEAD ;;
 		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
@@ -196,32 +159,42 @@ canon_refs_list_for_fetch () {
 		   git-check-ref-format "$local_ref_name" ||
 		   die "* refusing to create funny ref '$local_ref_name' locally"
 		fi
-		echo "${dot_prefix}${force}${remote}:${local}"
+		echo "${force}${remote}:${local}"
 	done
 }
=20
 # Returns list of src: (no store), or src:dst (store)
 get_remote_default_refs_for_fetch () {
+	test "$1" =3D -t && type=3Dyes && shift
+	test "$1" =3D -n && canon=3Dno && shift
 	data_source=3D$(get_data_source "$1")
 	case "$data_source" in
 	'')
-		echo "HEAD:" ;;
+		set explicit "HEAD:" ;;
 	config)
-		canon_refs_list_for_fetch -d "$1" \
-			$(git-config --get-all "remote.$1.fetch") ;;
+		set $(expand_refs_wildcard "$1" \
+			$(git-config --get-all "remote.$1.fetch")) ;;
 	branches)
 		remote_branch=3D$(sed -ne '/#/s/.*#//p' "$GIT_DIR/branches/$1")
 		case "$remote_branch" in '') remote_branch=3Dmaster ;; esac
-		echo "refs/heads/${remote_branch}:refs/heads/$1"
+		set explicit "refs/heads/${remote_branch}:refs/heads/$1"
 		;;
 	remotes)
-		canon_refs_list_for_fetch -d "$1" $(sed -ne '/^Pull: */{
-						s///p
-					}' "$GIT_DIR/remotes/$1")
+		set $(expand_refs_wildcard "$1" $(sed -ne '/^Pull: */s///p'\
+					"$GIT_DIR/remotes/$1"))
 		;;
 	*)
 		die "internal error: get-remote-default-ref-for-push $1" ;;
 	esac
+	if test "$type" =3D yes ; then
+		echo $1
+	elif test "$canon" =3D no ; then
+		shift
+		for ref ; do echo "$ref" ; done
+	else
+		shift
+		canon_refs_list_for_fetch "$@"
+	fi
 }
=20
 get_remote_refs_for_push () {
--=20
1.5.0.1.576.g78541
