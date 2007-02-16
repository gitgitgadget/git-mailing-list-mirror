From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH/RFC 2/3] git-fetch: Split fetch and merge logic
Date: Fri, 16 Feb 2007 09:09:30 +0100
Message-ID: <87vei2o75x.fsf@gmail.com>
References: <874ppmplw7.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 16 09:09:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHyAA-0002Hx-Go
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 09:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966188AbXBPIJr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 16 Feb 2007 03:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966189AbXBPIJr
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 03:09:47 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:47898 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966188AbXBPIJq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 03:09:46 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l1G89cB03874
	for <git@vger.kernel.org>; Fri, 16 Feb 2007 09:09:41 +0100
In-Reply-To: <874ppmplw7.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Fri, 16 Feb
	2007 09:06:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39902>


git-fetch fetches the branches from the remote and saves this
information in .git/FETCH_FETCHED, and at the end it generates
the file .git/FETCH_HEAD.

There are two cases where the behaviour is changed:

1) branch.*.merge no longer must exactly match the remote part
   of the branch fetched. Both are expanded in full (as refs/heads/...)
   and matched afterwards.
2) When the remote is specified with $GIT_DIR/branches/... and there is
   a branch.*.merge, the remote branch name must match to get them merg=
ed.
   Before the branch in $GIT_DIR/branches/... was always merged.
   In the documentation the $GIT_DIR/branches/ is documented as a
   short-hand for a corresponding file in $GIT_DIR/remotes/, so I think
   this makes the new behaviour consistent.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/config.txt |    2 +-
 git-fetch.sh             |   74 ++++++++++++++++++++++++++------------=
-------
 git-parse-remote.sh      |   60 +++++++++----------------------------
 t/t5510-fetch.sh         |   16 ++++++++++
 4 files changed, 75 insertions(+), 77 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9620126..e695de5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -238,7 +238,7 @@ branch.<name>.remote::
=20
 branch.<name>.merge::
 	When in branch <name>, it tells `git fetch` the default refspec to
-	be marked for merging in FETCH_HEAD. The value has exactly to match
+	be marked for merging in FETCH_HEAD. The value has to match
 	a remote part of one of the refspecs which are fetched from the remot=
e
 	given by "branch.<name>.remote".
 	The merge information is used by `git pull` (which at first calls
diff --git a/git-fetch.sh b/git-fetch.sh
index ca984e7..727538d 100755
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
@@ -101,6 +101,7 @@ if test "" =3D "$append"
 then
 	: >"$GIT_DIR/FETCH_HEAD"
 fi
+: >"$GIT_DIR/FETCH_FETCHED"
=20
 # Global that is reused later
 ls_remote_result=3D$(git ls-remote $exec "$remote") ||
@@ -112,10 +113,6 @@ append_fetch_head () {
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
@@ -146,9 +143,7 @@ append_fetch_head () {
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
@@ -256,7 +251,7 @@ then
 		  git-show-ref --exclude-existing=3Drefs/tags/ |
 	          while read sha1 name
 		  do
-			echo ".${name}:${name}"
+			echo "${name}:${name}"
 		  done` || exit
 	if test "$#" -gt 1
 	then
@@ -279,13 +274,6 @@ fetch_main () {
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
@@ -366,7 +354,7 @@ fetch_main () {
       esac
=20
       append_fetch_head "$head" "$remote" \
-	  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge" || exi=
t
+	  "$remote_name" "$remote_nick" "$local_name" || exit
=20
   done
=20
@@ -409,28 +397,16 @@ fetch_main () {
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
@@ -454,7 +430,7 @@ case "$no_tags$tags" in
 		do
 			git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
 			echo >&2 "Auto-following $name"
-			echo ".${name}:${name}"
+			echo "${name}:${name}"
 		done)
 	esac
 	case "$taglist" in
@@ -482,3 +458,39 @@ case "$orig_head" in
 	fi
 	;;
 esac
+
+# Generate $GIT_DIR/FETCH_HEAD
+case ",$#,$remote_nick," in
+,1,$origin,)
+	curr_branch=3D$(git-symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
+	merge_branches=3D$(git-repo-config \
+		--get-all "branch.${curr_branch}.merge")
+	[ -z "$merge_branches" ] && merge_first=3Dyes;;
+,1,$remote,) merge_branches=3DHEAD;;
+,1,*)merge_first=3Dyes ;;
+*)
+	shift
+	merge_branches=3D$(for ref; do
+		expr "z$ref" : 'z.*:' >/dev/null || ref=3D"${ref}:"
+		echo "$(expr "z$ref" : 'z\([^:]*\):')"; done);;
+esac
+
+test "$merge_first" =3D=3D "yes" &&
+test "$(get_remote_default_refs_for_fetch -t $remote_nick)" !=3D "expl=
icit" &&
+merge_branches=3D && merge_first=3D
+
+merge_branches=3D$(canon_refs_list_for_fetch $merge_branches | sed 's/=
:.*$//g')
+
+cat "$GIT_DIR"/FETCH_FETCHED | while IFS=3D'	' read sha1 ref note ; do
+	remote_branch=3D$(expr "z$ref" : 'z\([^:]*\):')
+	for merge_branch in $merge_branches ; do
+		[ "$merge_branch" =3D=3D "$remote_branch" ] &&
+			echo "$sha1		$note" && continue 2
+	done
+	if ! test "$merge_first" || test "$merge_first" =3D=3D "done" ; then
+		echo "$sha1	not-for-merge	$note"
+	else
+		echo "$sha1		$note"
+		merge_first=3Ddone
+	fi
+done >> "$GIT_DIR/FETCH_HEAD"
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 5208ee6..212b3bc 100755
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
@@ -196,32 +159,39 @@ canon_refs_list_for_fetch () {
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
+	test "$1" =3D=3D -t && type=3Dyes && shift
 	data_source=3D$(get_data_source "$1")
 	case "$data_source" in
 	'')
-		echo "HEAD:" ;;
+		set explicit "HEAD:" ;;
 	config)
-		canon_refs_list_for_fetch -d "$1" \
-			$(git-config --get-all "remote.$1.fetch") ;;
+		set $(expand_refs_wildcard "$1" \
+			$(git-repo-config --get-all "remote.$1.fetch")) ;;
 	branches)
 		remote_branch=3D$(sed -ne '/#/s/.*#//p' "$GIT_DIR/branches/$1")
 		case "$remote_branch" in '') remote_branch=3Dmaster ;; esac
-		echo "refs/heads/${remote_branch}:refs/heads/$1"
+		set explicit "refs/heads/${remote_branch}:refs/heads/$1"
 		;;
 	remotes)
-		canon_refs_list_for_fetch -d "$1" $(sed -ne '/^Pull: */{
+		set $(expand_refs_wildcard "$1" $(sed -ne '/^Pull: */{
 						s///p
-					}' "$GIT_DIR/remotes/$1")
+					}' "$GIT_DIR/remotes/$1"))
 		;;
 	*)
 		die "internal error: get-remote-default-ref-for-push $1" ;;
 	esac
+	if [ "$type" ] ; then
+		echo $1
+	else
+		shift
+		canon_refs_list_for_fetch "$@"
+	fi
 }
=20
 get_remote_refs_for_push () {
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 50c6485..0a19a7d 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -50,6 +50,22 @@ test_expect_success "fetch test" '
 	test "z$mine" =3D "z$his"
 '
=20
+test_expect_success "fetch test fetched" '
+	cd "$D" &&
+	cd three &&
+	git fetch &&
+	test -f .git/refs/heads/two &&
+	test -f .git/refs/heads/one &&
+	master_in_two=3D`cd ../two && git rev-parse master` &&
+	one_in_two=3D`cd ../two && git rev-parse one` &&
+	{
+		echo "$master_in_two	refs/heads/master:refs/heads/two"
+		echo "$one_in_two	refs/heads/one:refs/heads/one"
+	} >expected &&
+	cut -f -2 .git/FETCH_FETCHED >actual &&
+	diff expected actual'
+
+
 test_expect_success "fetch test for-merge" '
 	cd "$D" &&
 	cd three &&
--=20
1.5.0.35.gaaba
