From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv4 4/4] parse-remote: remove unused functions
Date: Fri, 12 Jun 2009 00:39:21 +0200
Message-ID: <1244759961-4750-5-git-send-email-santi@agolina.net>
References: <1244759961-4750-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 00:39:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEsw4-00070r-Vw
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 00:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763011AbZFKWja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2009 18:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762911AbZFKWj3
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 18:39:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:24417 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762068AbZFKWj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 18:39:28 -0400
Received: by fg-out-1718.google.com with SMTP id 16so558509fgg.17
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 15:39:28 -0700 (PDT)
Received: by 10.86.30.5 with SMTP id d5mr2884778fgd.26.1244759968589;
        Thu, 11 Jun 2009 15:39:28 -0700 (PDT)
Received: from localhost (p5B0D383D.dip.t-dialin.net [91.13.56.61])
        by mx.google.com with ESMTPS id d4sm1469047fga.1.2009.06.11.15.39.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 15:39:28 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.222.g479ad6
In-Reply-To: <1244759961-4750-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121370>

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
Changes from v1:
  - Only remove the functions documentation, not the whole file
  - Do not remove git-parse-remote from .gitignore

 Documentation/git-parse-remote.txt |   20 ----
 git-parse-remote.sh                |  204 ----------------------------=
--------
 2 files changed, 0 insertions(+), 224 deletions(-)

diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-par=
se-remote.txt
index cd43069..39d9daa 100644
--- a/Documentation/git-parse-remote.txt
+++ b/Documentation/git-parse-remote.txt
@@ -17,26 +17,6 @@ routines to parse files under $GIT_DIR/remotes/ and
 $GIT_DIR/branches/ and configuration variables that are related
 to fetching, pulling and pushing.
=20
-The primary entry points are:
-
-get_remote_refs_for_fetch::
-	Given the list of user-supplied `<repo> <refspec>...`,
-	return the list of refs to fetch after canonicalizing
-	them into `$GIT_DIR` relative paths
-	(e.g. `refs/heads/foo`).  When `<refspec>...` is empty
-	the returned list of refs consists of the defaults
-	for the given `<repo>`, if specified in
-	`$GIT_DIR/remotes/`, `$GIT_DIR/branches/`, or `remote.*.fetch`
-	configuration.
-
-get_remote_refs_for_push::
-	Given the list of user-supplied `<repo> <refspec>...`,
-	return the list of refs to push in a form suitable to be
-	fed to the 'git-send-pack' command.  When `<refspec>...`
-	is empty the returned list of refs consists of the
-	defaults for the given `<repo>`, if specified in
-	`$GIT_DIR/remotes/`.
-
 Author
 ------
 Written by Junio C Hamano.
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 75e1254..5f47b18 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -60,175 +60,6 @@ get_default_remote () {
 	echo ${origin:-origin}
 }
=20
-get_remote_default_refs_for_push () {
-	data_source=3D$(get_data_source "$1")
-	case "$data_source" in
-	'' | branches | self)
-		;; # no default push mapping, just send matching refs.
-	config)
-		git config --get-all "remote.$1.push" ;;
-	remotes)
-		sed -ne '/^Push: */{
-			s///p
-		}' "$GIT_DIR/remotes/$1" ;;
-	*)
-		die "internal error: get-remote-default-ref-for-push $1" ;;
-	esac
-}
-
-# Called from canon_refs_list_for_fetch -d "$remote", which
-# is called from get_remote_default_refs_for_fetch to grok
-# refspecs that are retrieved from the configuration, but not
-# from get_remote_refs_for_fetch when it deals with refspecs
-# supplied on the command line.  $ls_remote_result has the list
-# of refs available at remote.
-#
-# The first token returned is either "explicit" or "glob"; this
-# is to help prevent randomly "globbed" ref from being chosen as
-# a merge candidate
-expand_refs_wildcard () {
-	echo "$ls_remote_result" |
-	git fetch--tool expand-refs-wildcard "-" "$@"
-}
-
-# Subroutine to canonicalize remote:local notation.
-canon_refs_list_for_fetch () {
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
-			curr_branch=3D$(git symbolic-ref -q HEAD | \
-			    sed -e 's|^refs/heads/||')
-			merge_branches=3D$(git config \
-			    --get-all "branch.${curr_branch}.merge")
-		fi
-		if test -z "$merge_branches" && test $is_explicit !=3D explicit
-		then
-			merge_branches=3D..this.will.never.match.any.ref..
-		fi
-	fi
-	for ref
-	do
-		force=3D
-		case "$ref" in
-		+*)
-			ref=3D$(expr "z$ref" : 'z+\(.*\)')
-			force=3D+
-			;;
-		esac
-		expr "z$ref" : 'z.*:' >/dev/null || ref=3D"${ref}:"
-		remote=3D$(expr "z$ref" : 'z\([^:]*\):')
-		local=3D$(expr "z$ref" : 'z[^:]*:\(.*\)')
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
-		case "$remote" in
-		'' | HEAD ) remote=3DHEAD ;;
-		refs/*) ;;
-		heads/* | tags/* | remotes/* ) remote=3D"refs/$remote" ;;
-		*) remote=3D"refs/heads/$remote" ;;
-		esac
-		case "$local" in
-		'') local=3D ;;
-		refs/*) ;;
-		heads/* | tags/* | remotes/* ) local=3D"refs/$local" ;;
-		*) local=3D"refs/heads/$local" ;;
-		esac
-
-		if local_ref_name=3D$(expr "z$local" : 'zrefs/\(.*\)')
-		then
-		   git check-ref-format "$local_ref_name" ||
-		   die "* refusing to create funny ref '$local_ref_name' locally"
-		fi
-		echo "${dot_prefix}${force}${remote}:${local}"
-	done
-}
-
-# Returns list of src: (no store), or src:dst (store)
-get_remote_default_refs_for_fetch () {
-	data_source=3D$(get_data_source "$1")
-	case "$data_source" in
-	'')
-		echo "HEAD:" ;;
-	self)
-	        canon_refs_list_for_fetch -d "$1" \
-			$(git for-each-ref --format=3D'%(refname):')
-		;;
-	config)
-		canon_refs_list_for_fetch -d "$1" \
-			$(git config --get-all "remote.$1.fetch") ;;
-	branches)
-		remote_branch=3D$(sed -ne '/#/s/.*#//p' "$GIT_DIR/branches/$1")
-		case "$remote_branch" in '') remote_branch=3Dmaster ;; esac
-		echo "refs/heads/${remote_branch}:refs/heads/$1"
-		;;
-	remotes)
-		canon_refs_list_for_fetch -d "$1" $(sed -ne '/^Pull: */{
-						s///p
-					}' "$GIT_DIR/remotes/$1")
-		;;
-	*)
-		die "internal error: get-remote-default-ref-for-fetch $1" ;;
-	esac
-}
-
-get_remote_refs_for_push () {
-	case "$#" in
-	0) die "internal error: get-remote-refs-for-push." ;;
-	1) get_remote_default_refs_for_push "$@" ;;
-	*) shift; echo "$@" ;;
-	esac
-}
-
-get_remote_refs_for_fetch () {
-	case "$#" in
-	0)
-	    die "internal error: get-remote-refs-for-fetch." ;;
-	1)
-	    get_remote_default_refs_for_fetch "$@" ;;
-	*)
-	    shift
-	    tag_just_seen=3D
-	    for ref
-	    do
-		if test "$tag_just_seen"
-		then
-		    echo "refs/tags/${ref}:refs/tags/${ref}"
-		    tag_just_seen=3D
-		    continue
-		else
-		    case "$ref" in
-		    tag)
-			tag_just_seen=3Dyes
-			continue
-			;;
-		    esac
-		fi
-		canon_refs_list_for_fetch "$ref"
-	    done
-	    ;;
-	esac
-}
-
 get_remote_merge_branch () {
 	case "$#" in
 	0|1)
@@ -262,38 +93,3 @@ get_remote_merge_branch () {
 	    [ -n "$remote" ] && echo "refs/remotes/$repo/$remote"
 	esac
 }
-
-resolve_alternates () {
-	# original URL (xxx.git)
-	top_=3D`expr "z$1" : 'z\([^:]*:/*[^/]*\)/'`
-	while read path
-	do
-		case "$path" in
-		\#* | '')
-			continue ;;
-		/*)
-			echo "$top_$path/" ;;
-		../*)
-			# relative -- ugly but seems to work.
-			echo "$1/objects/$path/" ;;
-		*)
-			# exit code may not be caught by the reader.
-			echo "bad alternate: $path"
-			exit 1 ;;
-		esac
-	done
-}
-
-get_uploadpack () {
-	data_source=3D$(get_data_source "$1")
-	case "$data_source" in
-	config)
-		uplp=3D$(git config --get "remote.$1.uploadpack")
-		echo ${uplp:-git-upload-pack}
-		;;
-	*)
-		echo "git-upload-pack"
-		;;
-	esac
-}
-
--=20
1.6.3.2.206.g417f7
