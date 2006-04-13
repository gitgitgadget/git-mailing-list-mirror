From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] Shell utilities: Guard against expr' magic tokens.
Date: Thu, 13 Apr 2006 22:01:24 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne3tihk.1dq.mdw@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Fri Apr 14 00:01:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU9sk-0004kE-BA
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 00:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWDMWBj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 18:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWDMWBj
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 18:01:39 -0400
Received: from excessus.demon.co.uk ([83.105.60.35]:1589 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S964995AbWDMWBi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 18:01:38 -0400
Received: (qmail 8098 invoked by uid 110); 13 Apr 2006 22:01:24 -0000
To: git@vger.kernel.org
Received: (qmail 8083 invoked by uid 9); 13 Apr 2006 22:01:24 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1144965684 8081 172.29.199.2 (13 Apr 2006 22:01:24 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Thu, 13 Apr 2006 22:01:24 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18676>

From: Mark Wooding <mdw@distorted.org.uk>

Some words, e.g., `match', are special to expr(1), and cause strange
parsing effects.  Track down all uses of expr and mangle the arguments
so that this isn't a problem.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---
Amusing one, this.  I hacked on one of my projects, messing with a
simple glob matching function.  Being uncreative, I called my topic
branch `match'.  When I was ready, I switched back to my master branch
and said

  $ git pull . match
  Already up-to-date.

Oh.  I checked.  Nope, not up-to-date.  I tried 

  $ git merge fast HEAD match, and that

and that did the right thing.  But I was puzzled.  I fired up the
git-bisect machinery and tried to find a good version to no avail.  And
then, comparing `sh -x' traces of git-fetch, I noticed what had gone
wrong.

There's a line in git-parse-remote.sh, in canon_refs_list_for_fetch,
which says

  expr "$ref" : '.*:' >/dev/null || ref="${ref}:"

In my case, $ref is `match', so this expands to

  expr match : '.*:' >...

Unfortunately, GNU expr has a magic keyword `match'.  So what this does
is compare `:' to the regexp `.*:', which /succeeds/, even though POSIX
expr without the `match' keyword would do the right thing and fail.  So
$ref never has a `:' appended, which makes the later parsing fail, and
all sorts of strange things happen.

This patch puts magical extra characters in expr regexp calls
throughout the shell bits of GIT, to robustify them against this kind of
crapness.

There's a small chance I got something wrong while making this fix.  I
was fairly careful, though, and ran the test suite without any
problems.  I also checked Cogito, though that has no truck with expr.

---

 git-cherry.sh         |    2 +-
 git-clone.sh          |    6 +++---
 git-commit.sh         |    4 ++--
 git-fetch.sh          |   18 +++++++++---------
 git-format-patch.sh   |    4 ++--
 git-merge-one-file.sh |    2 +-
 git-parse-remote.sh   |   20 ++++++++++----------
 git-rebase.sh         |    2 +-
 git-tag.sh            |    2 +-
 9 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/git-cherry.sh b/git-cherry.sh
index 1a62320..f0e8831 100755
--- a/git-cherry.sh
+++ b/git-cherry.sh
@@ -20,7 +20,7 @@ case "$1" in -v) verbose=t; shift ;; esa
 
 case "$#,$1" in
 1,*..*)
-    upstream=$(expr "$1" : '\(.*\)\.\.') ours=$(expr "$1" : '.*\.\.\(.*\)$')
+    upstream=$(expr "z$1" : 'z\(.*\)\.\.') ours=$(expr "z$1" : '.*\.\.\(.*\)$')
     set x "$upstream" "$ours"
     shift ;;
 esac
diff --git a/git-clone.sh b/git-clone.sh
index c013e48..0805168 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -38,12 +38,12 @@ Perhaps git-update-server-info needs to 
 	}
 	while read sha1 refname
 	do
-		name=`expr "$refname" : 'refs/\(.*\)'` &&
+		name=`expr "z$refname" : 'zrefs/\(.*\)'` &&
 		case "$name" in
 		*^*)	continue;;
 		esac
 		if test -n "$use_separate_remote" &&
-		   branch_name=`expr "$name" : 'heads/\(.*\)'`
+		   branch_name=`expr "z$name" : 'zheads/\(.*\)'`
 		then
 			tname="remotes/$origin/$branch_name"
 		else
@@ -346,7 +346,7 @@ then
 		# new style repository with a symref HEAD).
 		# Ideally we should skip the guesswork but for now
 		# opt for minimum change.
-		head_sha1=`expr "$head_sha1" : 'ref: refs/heads/\(.*\)'`
+		head_sha1=`expr "z$head_sha1" : 'zref: refs/heads/\(.*\)'`
 		head_sha1=`cat "$GIT_DIR/$remote_top/$head_sha1"`
 		;;
 	esac
diff --git a/git-commit.sh b/git-commit.sh
index bd3dc71..01c73bd 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -549,8 +549,8 @@ fi >>"$GIT_DIR"/COMMIT_EDITMSG
 # Author
 if test '' != "$force_author"
 then
-	GIT_AUTHOR_NAME=`expr "$force_author" : '\(.*[^ ]\) *<.*'` &&
-	GIT_AUTHOR_EMAIL=`expr "$force_author" : '.*\(<.*\)'` &&
+	GIT_AUTHOR_NAME=`expr "z$force_author" : 'z\(.*[^ ]\) *<.*'` &&
+	GIT_AUTHOR_EMAIL=`expr "z$force_author" : '.*\(<.*\)'` &&
 	test '' != "$GIT_AUTHOR_NAME" &&
 	test '' != "$GIT_AUTHOR_EMAIL" ||
 	die "malformatted --author parameter"
diff --git a/git-fetch.sh b/git-fetch.sh
index 954901d..711650f 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -112,7 +112,7 @@ append_fetch_head () {
     *)
 	note_="$remote_name of " ;;
     esac
-    remote_1_=$(expr "$remote_" : '\(.*\)\.git/*$') &&
+    remote_1_=$(expr "z$remote_" : 'z\(.*\)\.git/*$') &&
 	remote_="$remote_1_"
     note_="$note_$remote_"
 
@@ -245,22 +245,22 @@ fetch_main () {
 
       # These are relative path from $GIT_DIR, typically starting at refs/
       # but may be HEAD
-      if expr "$ref" : '\.' >/dev/null
+      if expr "z$ref" : 'z\.' >/dev/null
       then
 	  not_for_merge=t
-	  ref=$(expr "$ref" : '\.\(.*\)')
+	  ref=$(expr "z$ref" : 'z\.\(.*\)')
       else
 	  not_for_merge=
       fi
-      if expr "$ref" : '\+' >/dev/null
+      if expr "z$ref" : 'z\+' >/dev/null
       then
 	  single_force=t
-	  ref=$(expr "$ref" : '\+\(.*\)')
+	  ref=$(expr "z$ref" : 'z\+\(.*\)')
       else
 	  single_force=
       fi
-      remote_name=$(expr "$ref" : '\([^:]*\):')
-      local_name=$(expr "$ref" : '[^:]*:\(.*\)')
+      remote_name=$(expr "z$ref" : 'z\([^:]*\):')
+      local_name=$(expr "z$ref" : 'z[^:]*:\(.*\)')
 
       rref="$rref$LF$remote_name"
 
@@ -276,7 +276,7 @@ fetch_main () {
 	      print "$u";
 	  ' "$remote_name")
 	  head=$(curl -nsfL $curl_extra_args "$remote/$remote_name_quoted") &&
-	  expr "$head" : "$_x40\$" >/dev/null ||
+	  expr "z$head" : "z$_x40\$" >/dev/null ||
 		  die "Failed to fetch $remote_name from $remote"
 	  echo >&2 Fetching "$remote_name from $remote" using http
 	  git-http-fetch -v -a "$head" "$remote/" || exit
@@ -362,7 +362,7 @@ fetch_main () {
 		  break ;;
 	      esac
 	  done
-	  local_name=$(expr "$found" : '[^:]*:\(.*\)')
+	  local_name=$(expr "z$found" : 'z[^:]*:\(.*\)')
 	  append_fetch_head "$sha1" "$remote" \
 		  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
       done
diff --git a/git-format-patch.sh b/git-format-patch.sh
index 2ebf7e8..c7133bc 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -126,8 +126,8 @@ for revpair
 do
 	case "$revpair" in
 	?*..?*)
-		rev1=`expr "$revpair" : '\(.*\)\.\.'`
-		rev2=`expr "$revpair" : '.*\.\.\(.*\)'`
+		rev1=`expr "z$revpair" : 'z\(.*\)\.\.'`
+		rev2=`expr "z$revpair" : 'z.*\.\.\(.*\)'`
 		;;
 	*)
 		rev1="$revpair^"
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 5349a1c..5619409 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -26,7 +26,7 @@ #
 	fi
 	if test -f "$4"; then
 		rm -f -- "$4" &&
-		rmdir -p "$(expr "$4" : '\(.*\)/')" 2>/dev/null || :
+		rmdir -p "$(expr "z$4" : 'z\(.*\)/')" 2>/dev/null || :
 	fi &&
 		exec git-update-index --remove -- "$4"
 	;;
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 63f2281..65c66d5 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -8,8 +8,8 @@ get_data_source () {
 	case "$1" in
 	*/*)
 		# Not so fast.	This could be the partial URL shorthand...
-		token=$(expr "$1" : '\([^/]*\)/')
-		remainder=$(expr "$1" : '[^/]*/\(.*\)')
+		token=$(expr "z$1" : 'z\([^/]*\)/')
+		remainder=$(expr "z$1" : 'z[^/]*/\(.*\)')
 		if test -f "$GIT_DIR/branches/$token"
 		then
 			echo branches-partial
@@ -43,8 +43,8 @@ get_remote_url () {
 	branches)
 		sed -e 's/#.*//' "$GIT_DIR/branches/$1" ;;
 	branches-partial)
-		token=$(expr "$1" : '\([^/]*\)/')
-		remainder=$(expr "$1" : '[^/]*/\(.*\)')
+		token=$(expr "z$1" : 'z\([^/]*\)/')
+		remainder=$(expr "z$1" : 'z[^/]*/\(.*\)')
 		url=$(sed -e 's/#.*//' "$GIT_DIR/branches/$token")
 		echo "$url/$remainder"
 		;;
@@ -77,13 +77,13 @@ canon_refs_list_for_fetch () {
 		force=
 		case "$ref" in
 		+*)
-			ref=$(expr "$ref" : '\+\(.*\)')
+			ref=$(expr "z$ref" : 'z\+\(.*\)')
 			force=+
 			;;
 		esac
-		expr "$ref" : '.*:' >/dev/null || ref="${ref}:"
-		remote=$(expr "$ref" : '\([^:]*\):')
-		local=$(expr "$ref" : '[^:]*:\(.*\)')
+		expr "z$ref" : 'z.*:' >/dev/null || ref="${ref}:"
+		remote=$(expr "z$ref" : 'z\([^:]*\):')
+		local=$(expr "z$ref" : 'z[^:]*:\(.*\)')
 		case "$remote" in
 		'') remote=HEAD ;;
 		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
@@ -97,7 +97,7 @@ canon_refs_list_for_fetch () {
 		*) local="refs/heads/$local" ;;
 		esac
 
-		if local_ref_name=$(expr "$local" : 'refs/\(.*\)')
+		if local_ref_name=$(expr "z$local" : 'zrefs/\(.*\)')
 		then
 		   git-check-ref-format "$local_ref_name" ||
 		   die "* refusing to create funny ref '$local_ref_name' locally"
@@ -171,7 +171,7 @@ get_remote_refs_for_fetch () {
 
 resolve_alternates () {
 	# original URL (xxx.git)
-	top_=`expr "$1" : '\([^:]*:/*[^/]*\)/'`
+	top_=`expr "z$1" : 'z\([^:]*:/*[^/]*\)/'`
 	while read path
 	do
 		case "$path" in
diff --git a/git-rebase.sh b/git-rebase.sh
index 5956f06..86dfe9c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -94,7 +94,7 @@ case "$#" in
 	;;
 *)
 	branch_name=`git symbolic-ref HEAD` || die "No current branch"
-	branch_name=`expr "$branch_name" : 'refs/heads/\(.*\)'`
+	branch_name=`expr "z$branch_name" : 'zrefs/heads/\(.*\)'`
 	;;
 esac
 branch=$(git-rev-parse --verify "${branch_name}^0") || exit
diff --git a/git-tag.sh b/git-tag.sh
index 76e51ed..dc6aa95 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -75,7 +75,7 @@ git-check-ref-format "tags/$name" ||
 object=$(git-rev-parse --verify --default HEAD "$@") || exit 1
 type=$(git-cat-file -t $object) || exit 1
 tagger=$(git-var GIT_COMMITTER_IDENT) || exit 1
-: ${username:=$(expr "$tagger" : '\(.*>\)')}
+: ${username:=$(expr "z$tagger" : 'z\(.*>\)')}
 
 trap 'rm -f "$GIT_DIR"/TAG_TMP* "$GIT_DIR"/TAG_FINALMSG "$GIT_DIR"/TAG_EDITMSG' 0
 



-- [mdw]
