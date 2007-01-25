From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH/RFC] git-fetch: Only fetch in fetch
Date: Thu, 25 Jan 2007 01:43:42 +0100
Message-ID: <87veiwszpd.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 25 01:44:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9sit-0006Yv-3x
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 01:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933158AbXAYAoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 19:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933132AbXAYAoL
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 19:44:11 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:51336 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933158AbXAYAoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 19:44:09 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l0P0i4q27950
	for <git@vger.kernel.org>; Thu, 25 Jan 2007 01:44:04 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37696>


---

 Hi *,

   I've tried to separate the fetch and merge logic. At the same time it
   has removed 40 lines of code to the git-*.sh.

   What do you think?

   Santi

   P.D.: I supose it is too late for v1.5.0.

 git-fetch.sh             |   41 +++++++-------------------
 git-parse-remote.sh      |   71 ++++++----------------------------------------
 git-pull.sh              |   40 +++++++++++++++++++++++--
 t/t5510-fetch.sh         |    6 ++--
 t/t6200-fmt-merge-msg.sh |   23 ++++++++++-----
 5 files changed, 74 insertions(+), 107 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 87b940b..564d633 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -74,9 +74,9 @@ do
 	shift
 done
 
+origin=$(get_default_remote)
 case "$#" in
 0)
-	origin=$(get_default_remote)
 	test -n "$(get_remote_url ${origin})" ||
 		die "Where do you want to fetch from today?"
 	set x $origin ; shift ;;
@@ -88,6 +88,12 @@ refs=
 rref=
 rsync_slurped_objects=
 
+cat > $GIT_DIR/FETCH_REMOTE <<EOF
+remote: $remote_nick
+url: $remote
+default: $origin
+refspec: $@
+EOF
 if test "" = "$append"
 then
 	: >"$GIT_DIR/FETCH_HEAD"
@@ -103,10 +109,6 @@ append_fetch_head () {
     remote_name_="$3"
     remote_nick_="$4"
     local_name_="$5"
-    case "$6" in
-    t) not_for_merge_='not-for-merge' ;;
-    '') not_for_merge_= ;;
-    esac
 
     # remote-nick is the URL given on the command line (or a shorthand)
     # remote-name is the $GIT_DIR relative refs/ path we computed
@@ -137,10 +139,8 @@ append_fetch_head () {
     if git-cat-file commit "$head_" >/dev/null 2>&1
     then
 	headc_=$(git-rev-parse --verify "$head_^0") || exit
-	echo "$headc_	$not_for_merge_	$note_" >>"$GIT_DIR/FETCH_HEAD"
-    else
-	echo "$head_	not-for-merge	$note_" >>"$GIT_DIR/FETCH_HEAD"
     fi
+    echo "$headc_	$remote_name	$note_" >>"$GIT_DIR/FETCH_HEAD"
 
     update_local_ref "$local_name_" "$head_" "$note_"
 }
@@ -283,13 +283,6 @@ fetch_main () {
 
       # These are relative path from $GIT_DIR, typically starting at refs/
       # but may be HEAD
-      if expr "z$ref" : 'z\.' >/dev/null
-      then
-	  not_for_merge=t
-	  ref=$(expr "z$ref" : 'z\.\(.*\)')
-      else
-	  not_for_merge=
-      fi
       if expr "z$ref" : 'z+' >/dev/null
       then
 	  single_force=t
@@ -370,7 +363,7 @@ fetch_main () {
       esac
 
       append_fetch_head "$head" "$remote" \
-	  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge" || exit
+	  "$remote_name" "$remote_nick" "$local_name" || exit
 
   done
 
@@ -413,28 +406,16 @@ fetch_main () {
 	      case "$ref" in
 	      +$remote_name:*)
 		  single_force=t
-		  not_for_merge=
-		  found="$ref"
-		  break ;;
-	      .+$remote_name:*)
-		  single_force=t
-		  not_for_merge=t
-		  found="$ref"
-		  break ;;
-	      .$remote_name:*)
-		  not_for_merge=t
 		  found="$ref"
 		  break ;;
 	      $remote_name:*)
-		  not_for_merge=
 		  found="$ref"
 		  break ;;
 	      esac
 	  done
 	  local_name=$(expr "z$found" : 'z[^:]*:\(.*\)')
 	  append_fetch_head "$sha1" "$remote" \
-		  "$remote_name" "$remote_nick" "$local_name" \
-		  "$not_for_merge" || exit
+		  "$remote_name" "$remote_nick" "$local_name" || exit
         done
       )
     ) || exit ;;
@@ -458,7 +439,7 @@ case "$no_tags$tags" in
 		do
 			git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
 			echo >&2 "Auto-following $name"
-			echo ".${name}:${name}"
+			echo "${name}:${name}"
 		done)
 	esac
 	case "$taglist" in
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 4fc6020..3352964 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -70,16 +70,11 @@ get_remote_default_refs_for_push () {
 	esac
 }
 
-# Called from canon_refs_list_for_fetch -d "$remote", which
-# is called from get_remote_default_refs_for_fetch to grok
+# Called from get_remote_default_refs_for_fetch to grok
 # refspecs that are retrieved from the configuration, but not
 # from get_remote_refs_for_fetch when it deals with refspecs
 # supplied on the command line.  $ls_remote_result has the list
 # of refs available at remote.
-#
-# The first token returned is either "explicit" or "glob"; this
-# is to help prevent randomly "globbed" ref from being chosen as
-# a merge candidate
 expand_refs_wildcard () {
 	first_one=yes
 	for ref
@@ -87,21 +82,10 @@ expand_refs_wildcard () {
 		lref=${ref#'+'}
 		# a non glob pattern is given back as-is.
 		expr "z$lref" : 'zrefs/.*/\*:refs/.*/\*$' >/dev/null || {
-			if test -n "$first_one"
-			then
-				echo "explicit"
-				first_one=
-			fi
 			echo "$ref"
 			continue
 		}
 
-		# glob
-		if test -n "$first_one"
-		then
-			echo "glob"
-			first_one=
-		fi
 		from=`expr "z$lref" : 'z\(refs/.*/\)\*:refs/.*/\*$'`
 		to=`expr "z$lref" : 'zrefs/.*/\*:\(refs/.*/\)\*$'`
 		local_force=
@@ -123,30 +107,6 @@ expand_refs_wildcard () {
 
 # Subroutine to canonicalize remote:local notation.
 canon_refs_list_for_fetch () {
-	# If called from get_remote_default_refs_for_fetch
-	# leave the branches in branch.${curr_branch}.merge alone,
-	# or the first one otherwise; add prefix . to the rest
-	# to prevent the secondary branches to be merged by default.
-	merge_branches=
-	curr_branch=
-	if test "$1" = "-d"
-	then
-		shift ; remote="$1" ; shift
-		set $(expand_refs_wildcard "$@")
-		is_explicit="$1"
-		shift
-		if test "$remote" = "$(get_default_remote)"
-		then
-			curr_branch=$(git-symbolic-ref -q HEAD | \
-			    sed -e 's|^refs/heads/||')
-			merge_branches=$(git-repo-config \
-			    --get-all "branch.${curr_branch}.merge")
-		fi
-		if test -z "$merge_branches" && test $is_explicit != explicit
-		then
-			merge_branches=..this.will.never.match.any.ref..
-		fi
-	fi
 	for ref
 	do
 		force=
@@ -159,22 +119,6 @@ canon_refs_list_for_fetch () {
 		expr "z$ref" : 'z.*:' >/dev/null || ref="${ref}:"
 		remote=$(expr "z$ref" : 'z\([^:]*\):')
 		local=$(expr "z$ref" : 'z[^:]*:\(.*\)')
-		dot_prefix=.
-		if test -z "$merge_branches"
-		then
-			merge_branches=$remote
-			dot_prefix=
-		else
-			for merge_branch in $merge_branches
-			do
-			    if	test "$remote" = "$merge_branch" ||
-				test "$local" = "$merge_branch"
-			    then
-				    dot_prefix=
-				    break
-			    fi
-			done
-		fi
 		case "$remote" in
 		'') remote=HEAD ;;
 		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
@@ -193,7 +137,7 @@ canon_refs_list_for_fetch () {
 		   git-check-ref-format "$local_ref_name" ||
 		   die "* refusing to create funny ref '$local_ref_name' locally"
 		fi
-		echo "${dot_prefix}${force}${remote}:${local}"
+		echo "${force}${remote}:${local}"
 	done
 }
 
@@ -204,17 +148,20 @@ get_remote_default_refs_for_fetch () {
 	'')
 		echo "HEAD:" ;;
 	config)
-		canon_refs_list_for_fetch -d "$1" \
-			$(git-repo-config --get-all "remote.$1.fetch") ;;
+		set $(expand_refs_wildcard \
+			$(git-repo-config --get-all "remote.$1.fetch"))
+		canon_refs_list_for_fetch "$@"
+		;;
 	branches)
 		remote_branch=$(sed -ne '/#/s/.*#//p' "$GIT_DIR/branches/$1")
 		case "$remote_branch" in '') remote_branch=master ;; esac
 		echo "refs/heads/${remote_branch}:refs/heads/$1"
 		;;
 	remotes)
-		canon_refs_list_for_fetch -d "$1" $(sed -ne '/^Pull: */{
+		set $(expand_refs_wildcard $(sed -ne '/^Pull: */{
 						s///p
-					}' "$GIT_DIR/remotes/$1")
+					}' "$GIT_DIR/remotes/$1"))
+		canon_refs_list_for_fetch "$@"
 		;;
 	*)
 		die "internal error: get-remote-default-ref-for-push $1" ;;
diff --git a/git-pull.sh b/git-pull.sh
index a3665d7..cc1295a 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -77,9 +77,41 @@ to recover.'
 
 fi
 
-merge_head=$(sed -e '/	not-for-merge	/d' \
-	-e 's/	.*//' "$GIT_DIR"/FETCH_HEAD | \
-	tr '\012' ' ')
+remote=$(grep "^remote: " $GIT_DIR/FETCH_REMOTE)
+remote=${remote#remote: }
+url=$(grep "^url: " $GIT_DIR/FETCH_REMOTE)
+url=${url#url: }
+default=$(grep "^default: " $GIT_DIR/FETCH_REMOTE)
+default=${default#default: }
+refspec=$(grep "^refspec: " $GIT_DIR/FETCH_REMOTE)
+refspec=${refspec#refspec: $remote}
+
+merge_head=
+merge_branches=
+if test ",$remote,$refspec," == ",$default,," ; then
+	curr_branch=$(git-symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
+	merge_branches=$(git-repo-config \
+		--get-all "branch.${curr_branch}.merge")
+elif test -n "$refspec" ; then
+	merge_branches=$(for ref in $refspec ; do
+		expr "z$ref" : 'z.*:' >/dev/null || ref="${ref}:"
+		echo " $(expr "z$ref" : 'z\([^:]*\):')"; done)
+elif test "$remote" == "$url" ; then
+	merge_branches=HEAD
+fi
+
+for branch in $merge_branches
+do
+	case "$branch" in
+	HEAD | refs/heads/* | refs/tags/* | refs/remotes/*) ;;
+	heads/* | tags/* | remotes/* ) branch="refs/$branch" ;;
+	*) branch="refs/heads/$branch" ;;
+	esac
+	grep "	$branch	"  "$GIT_DIR"/FETCH_HEAD | \
+		sed -e 's@	'"$branch"'	@		@'
+done > "$GIT_DIR"/FETCH_MERGE
+
+merge_head=$(sed -e 's/	.*//' "$GIT_DIR"/FETCH_MERGE | tr '\012' ' ')
 
 case "$merge_head" in
 '')
@@ -115,6 +147,6 @@ then
 	exit
 fi
 
-merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
+merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_MERGE") || exit
 exec git-merge $no_summary $no_commit $squash $strategy_args \
 	"$merge_name" HEAD $merge_head
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 3ce9446..2e196de 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -50,7 +50,7 @@ test_expect_success "fetch test" '
 	test "z$mine" = "z$his"
 '
 
-test_expect_success "fetch test for-merge" '
+test_expect_success "fetch test FETCH_HEAD" '
 	cd "$D" &&
 	cd three &&
 	git fetch &&
@@ -59,8 +59,8 @@ test_expect_success "fetch test for-merge" '
 	master_in_two=`cd ../two && git rev-parse master` &&
 	one_in_two=`cd ../two && git rev-parse one` &&
 	{
-		echo "$master_in_two	not-for-merge"
-		echo "$one_in_two	"
+		echo "$master_in_two	refs/heads/master"
+		echo "$one_in_two	refs/heads/one"
 	} >expected &&
 	cut -f -2 .git/FETCH_HEAD >actual &&
 	diff expected actual'
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 63e49f3..7776823 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -77,8 +77,9 @@ test_expect_success 'merge-msg test #1' '
 
 	git checkout master &&
 	git fetch . left &&
-
-	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	sed -e "s/	.*	/		/" \
+		.git/FETCH_HEAD >.git/FETCH_MERGE &&
+	git fmt-merge-msg <.git/FETCH_MERGE >actual &&
 	diff -u actual expected
 '
 
@@ -90,8 +91,9 @@ test_expect_success 'merge-msg test #2' '
 
 	git checkout master &&
 	git fetch ../trash left &&
-
-	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	sed -e "s/	.*	/		/" \
+		.git/FETCH_HEAD >.git/FETCH_MERGE &&
+	git fmt-merge-msg <.git/FETCH_MERGE >actual &&
 	diff -u actual expected
 '
 
@@ -113,8 +115,9 @@ test_expect_success 'merge-msg test #3' '
 	git checkout master &&
 	setdate &&
 	git fetch . left &&
-
-	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	sed -e "s/	.*	/		/" \
+		.git/FETCH_HEAD >.git/FETCH_MERGE &&
+	git fmt-merge-msg <.git/FETCH_MERGE >actual &&
 	diff -u actual expected
 '
 
@@ -143,8 +146,10 @@ test_expect_success 'merge-msg test #4' '
 	git checkout master &&
 	setdate &&
 	git fetch . left right &&
+	sed -e "s/	.*	/		/" \
+		.git/FETCH_HEAD >.git/FETCH_MERGE &&
 
-	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	git fmt-merge-msg <.git/FETCH_MERGE >actual &&
 	diff -u actual expected
 '
 
@@ -155,8 +160,10 @@ test_expect_success 'merge-msg test #5' '
 	git checkout master &&
 	setdate &&
 	git fetch . left right &&
+	sed -e "s/	.*	/		/" \
+		.git/FETCH_HEAD >.git/FETCH_MERGE &&
 
-	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	git fmt-merge-msg <.git/FETCH_MERGE >actual &&
 	diff -u actual expected
 '
 
-- 
1.5.0.rc2.g7dd4c-dirty
