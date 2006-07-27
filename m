From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] Per branch properties for pull and fetch
Date: Thu, 27 Jul 2006 10:14:45 +0200
Message-ID: <87lkqfcvm2.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 27 10:15:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G611D-0004uq-D1
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 10:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWG0IOv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 04:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWG0IOv
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 04:14:51 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:15528 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1751021AbWG0IOu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 04:14:50 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k6R7G5d10217
	for <git@vger.kernel.org>; Thu, 27 Jul 2006 09:16:06 +0200
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24268>

It allows to specify on a per branch basis the following:
.- default repository to fetch
.- default branches to merge on a per repository basis
.- default pull.{octopus,twohead}

So if you have this in the config:
[branch "my"]
	remote=yours
	merge=master
	merge=our from theirs
	merge=mine from .

and you are in the branch "my":

"git pull": fetch the remote yours and merge the branch master.
"git pull theirs": fetch the remote theirs and merge the branch our.
"git pull .": merge the branch mine from the local repository.
---
 Documentation/config.txt |   14 +++++++++++
 git-fetch.sh             |   13 ++++++----
 git-parse-remote.sh      |   57 ++++++++++++++++++++++++++++++++++++++++++++++
 git-pull.sh              |   29 ++++++++++++++++++++---
 4 files changed, 104 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 465eb13..f12b595 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -116,6 +116,20 @@ apply.whitespace::
 	Tells `git-apply` how to handle whitespaces, in the same way
 	as the '--whitespace' option. See gitlink:git-apply[1].
 
+branch.<name>.remote::
+	When in branch <name>, it tells `git-fetch` which remote to fetch.
+
+branch.<name>.merge::
+	When in branch <name>, it tells `git-pull` to merge this remote
+	branch of the repository branch.<name>.remote. To specify a different
+	remote repository use the from `<branch> from <repo>`.
+
+branch.<name>.octopus::
+	When in branch <name>, the same as pull.octopus.
+
+branch.<name>.twohead::
+	When in branch <name>, the same as pull.twohead.
+
 diff.color::
 	When true (or `always`), always use colors in patch.
 	When false (or `never`), never.  When set to `auto`, use
diff --git a/git-fetch.sh b/git-fetch.sh
index c2eebee..8129d8a 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -68,11 +68,13 @@ done
 
 case "$#" in
 0)
-	test -f "$GIT_DIR/branches/origin" ||
-		test -f "$GIT_DIR/remotes/origin" ||
-			git-repo-config --get remote.origin.url >/dev/null ||
-				die "Where do you want to fetch from today?"
-	set origin ;;
+	curr_branch=$(git-symbolic-ref HEAD)
+	curr_branch=${curr_branch##refs/heads/}
+	origin=$(git-repo-config --get "branch.$curr_branch.remote")
+	origin=${origin:-origin}
+	test -n "$(get_remote_url $origin)" ||
+		die "Where do you want to fetch from today?"
+	set $origin ;;
 esac
 
 remote_nick="$1"
@@ -446,3 +448,4 @@ case ",$update_head_ok,$orig_head," in
 	fi
 	;;
 esac
+echo $remote_nick >"$GIT_DIR/FETCH_REMOTE"
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 187f088..fe6c713 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -209,3 +209,60 @@ resolve_alternates () {
 		esac
 	done
 }
+
+get_head_for_remote_branch () {
+	if [ "$1" == "." ];
+	then
+		git-rev-parse $2 2>/dev/null||
+			die "error: no such ref $2"
+		return
+	fi
+	data_source=$(get_data_source "$1")
+	case "$data_source" in
+	config)
+		refspec=$(git-repo-config --get "remote.$1.fetch" ^$2:) ;;
+	branches)
+		remote_branch=$(sed -ne '/#/s/.*#//p' "$GIT_DIR/branches/$1")
+		case "$remote_branch" in '') remote_branch=master ;; esac
+		[ $remote_branch == $2 ] &&
+		refspec="refs/heads/${remote_branch}:refs/heads/$1"
+		;;
+	remotes)
+		refspec=$(grep "^Pull: $2:" $GIT_DIR/remotes/$1)
+		refspec=${refspec##Pull: }
+		;;
+	*)
+		die "internal error: get-head_for_remote_branch" ;;
+	esac
+	[ "$refspec" ] || die "Branch $2 does not exist in the repository: $1."
+	git-rev-parse $(expr "z$refspec" : 'z[^:]*:\(.*\)')
+}
+
+get_heads_to_merge_in_branch () {
+ 	case "$#" in
+	2)
+		default=$(git repo-config --get-all "branch.$1.remote")
+		: >"$GIT_DIR/HEADS_TO_MERGE"
+		git repo-config --get-all "branch.$1.merge" |
+		while read ref ; do
+			case $ref in
+			?*' 'from' '?*)
+				remote=$(expr "z$ref" : 'z.* from \(.*\)')
+				branch=$(expr "z$ref" : 'z\(.*\) from .*');;
+			*)
+				remote=$default
+				branch=$ref;;
+			esac
+			[ "$remote" != "$2" ] && continue
+			headm=$(get_head_for_remote_branch $remote $branch) || exit 1
+			echo $headm
+			remoteurl=$(get_remote_url $remote)
+			remoteurl_1=$(expr "z$remoteurl" : 'z\(.*\)\.git/*$') &&
+				remoteurl=$remoteurl_1
+			echo "$headm		branch '$branch' of $remoteurl" \
+				>>"$GIT_DIR/HEADS_TO_MERGE"
+		done
+		;;
+	*) exit 1
+	esac
+}
diff --git a/git-pull.sh b/git-pull.sh
index f380437..467d9c0 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -7,6 +7,7 @@ # Fetch one or more remote refs and merg
 USAGE='[-n | --no-summary] [--no-commit] [-s strategy]... [<fetch-options>] <repo> <head>...'
 LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
 . git-sh-setup
+. git-parse-remote
 
 strategy_args= no_summary= no_commit= squash=
 while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
@@ -47,6 +48,8 @@ done
 orig_head=$(git-rev-parse --verify HEAD) || die "Pulling into a black hole?"
 git-fetch --update-head-ok --reflog-action=pull "$@" || exit 1
 
+curr_branch=$(git-symbolic-ref HEAD)
+curr_branch=${curr_branch##refs/heads/}
 curr_head=$(git-rev-parse --verify HEAD)
 if test "$curr_head" != "$orig_head"
 then
@@ -70,9 +73,18 @@ to recover.'
 
 fi
 
-merge_head=$(sed -e '/	not-for-merge	/d' \
-	-e 's/	.*//' "$GIT_DIR"/FETCH_HEAD | \
-	tr '\012' ' ')
+remote=$(cat "$GIT_DIR/FETCH_REMOTE")
+merge_head=$(get_heads_to_merge_in_branch "$curr_branch" "$remote" ) || exit
+
+if [ -n "$merge_head" ];
+then
+	merge_name=$(git-fmt-merge-msg <"$GIT_DIR/HEADS_TO_MERGE") || exit
+else
+	merge_head=$(sed -e '/	not-for-merge	/d' \
+		-e 's/	.*//' "$GIT_DIR"/FETCH_HEAD | \
+		tr '\012' ' ')
+	merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
+fi
 
 case "$merge_head" in
 '')
@@ -85,6 +97,11 @@ case "$merge_head" in
 	then
 		strategy_default_args="-s $var"
 	fi
+	var=`git-repo-config --get branch.$curr_branch.octopus`
+	if test -n "$var"
+	then
+		strategy_default_args="-s $var"
+	fi
 	;;
 *)
 	var=`git-repo-config --get pull.twohead`
@@ -92,6 +109,11 @@ case "$merge_head" in
         then
 		strategy_default_args="-s $var"
 	fi
+	var=`git-repo-config --get branch.$curr_branch.twohead`
+	if test -n "$var"
+        then
+		strategy_default_args="-s $var"
+	fi
 	;;
 esac
 
@@ -101,7 +123,6 @@ case "$strategy_args" in
 	;;
 esac
 
-merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
 git-merge "--reflog-action=pull $*" \
 	$no_summary $no_commit $squash $strategy_args \
 	"$merge_name" HEAD $merge_head
-- 
1.4.2.rc2.g1728
