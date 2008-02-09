From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 1/3] git-submodule - Follow top-level remote on init/update/clone
Date: Sat,  9 Feb 2008 11:57:23 -0500
Message-ID: <1202576245-284-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 17:58:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNt1l-0008P7-LO
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 17:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbYBIQ5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 11:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754108AbYBIQ5d
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 11:57:33 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:54407 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbYBIQ5c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 11:57:32 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4336359wxd.4
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 08:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=V2/fkosemODRMeOg47DLmUK6SWz8Kar0KPIkhGZ0q3Q=;
        b=DB1UaElQ7hOZg9MI9bsLamAUHY0QklQ0l6lCfitABxsjNUTw6175uTfRwTodS4oZ53tG1KMHTvy69kH8snR31qdXj8uoyk+7uWcLbbJZ4iTwZBkuDO1LMxfoouGrwEK2gbbqhj2PpwNbCB1sSPU4WHHkPh+MS2iWzzYoUvfpAEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=n5fhVKs/7B9ZsBJQ7QI6Oz3lw2E5XpOcvgcxGXy9Uv2iqasMWrwh1YxGPkoaPFNXk7F0sHnGNXghWOTMhYsu3vAtf/+3PYOE5ZhUGMKdbY8wr+qaxvFdBSApNLIec54GOfoymvJzPdCoGUf5v1zwHJ1lXa9xvdzzeqABvIhBu/4=
Received: by 10.70.7.13 with SMTP id 13mr9044116wxg.8.1202576251054;
        Sat, 09 Feb 2008 08:57:31 -0800 (PST)
Received: from localhost.localdomain ( [71.163.29.241])
        by mx.google.com with ESMTPS id h38sm5351828wxd.15.2008.02.09.08.57.29
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Feb 2008 08:57:29 -0800 (PST)
X-Mailer: git-send-email 1.5.4.47.gcca7b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73240>

This change allows the remote used for relative submodules (those defined
using a url that is relative to their parent) to be defined by explicit
definition on the command line or through the top-level project's
branch.<name>.remote configuration.  This override is applied *only* to
submodules defined using a url relative to the top-level project's url,
under the assumption that such modules are logically part of the same
project and managed as a unit.  For relative submodules, the given remote
will be defined in each submodule using the relative url applied to the
top-level's url the first time the remote is used.  Any existing remote
definition is unaffected, so this can be changed manually by the user at
any time.

Submodules defined using an absolute url are unaffected.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/git-submodule.txt |   16 +++++++-
 git-submodule.sh                |   76 ++++++++++++++++++++++++++++++++-------
 2 files changed, 77 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e818e6e..4fc17f6 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,9 +9,9 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git-submodule' [--quiet] add [-b branch] [--] <repository> [<path>]
+'git-submodule' [--quiet] add [-b branch] [-r <remote>] [--] <repository> [<path>]
 'git-submodule' [--quiet] status [--cached] [--] [<path>...]
-'git-submodule' [--quiet] [init|update] [--] [<path>...]
+'git-submodule' [--quiet] [init|update] [-r <remote>] [--] [<path>...]
 
 
 COMMANDS
@@ -55,6 +55,18 @@ OPTIONS
 -b, --branch::
 	Branch of repository to add as submodule.
 
+-r remote::
+	Name of remote to use or define when working with relative submodules
+	(i.e., submodules whose url is given relative to the top-level
+	project). If this value is undefined, the top-level project's
+	branch.<name>.remote is used, and if that is undefined the default
+	"origin" is used. The remote will be defined in each relative
+	submodule as needed by appending the relative url to the top level
+	project's url. This option has no effect upon submodules defined
+	using an absolute url: such project's are cloned using the default
+	"origin," and are updated using the submodule's branch.<name>.remote
+	machinery and defaulting to "origin."
+
 --cached::
 	Display the SHA-1 stored in the index, not the SHA-1 of the currently
 	checked out submodule commit. This option is only valid for the
diff --git a/git-submodule.sh b/git-submodule.sh
index a6aaf40..b97bf18 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -4,15 +4,17 @@
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]'
+USAGE='[--quiet] [--cached] [add [-r remote] <repo> [-b branch]|status|init [-r remote]|update [-r remote]] [--] [<path>...]'
 OPTIONS_SPEC=
 . git-sh-setup
+. git-parse-remote
 require_work_tree
 
 command=
 branch=
 quiet=
 cached=
+remote=
 
 #
 # print stuff on stdout unless -q was specified
@@ -40,11 +42,13 @@ get_repo_base() {
 # Resolve relative url by appending to parent's url
 resolve_relative_url ()
 {
-	branch="$(git symbolic-ref HEAD 2>/dev/null)"
-	remote="$(git config branch.${branch#refs/heads/}.remote)"
-	remote="${remote:-origin}"
-	remoteurl="$(git config remote.$remote.url)" ||
-		die "remote ($remote) does not have a url in .git/config"
+	remote="${remote:-$(get_default_remote)}"
+	remoteurl=$(git config remote.$remote.url)
+	if test -z "$remoteurl" ; then
+		echo >&2 "remote ($remote) does not have a url defined in .git/config"
+		return 1
+	fi
+	remoteurl="${remoteurl%/.git}"
 	url="$1"
 	while test -n "$url"
 	do
@@ -92,6 +96,7 @@ module_clone()
 {
 	path=$1
 	url=$2
+	remote=$3
 
 	# If there already is a directory at the submodule path,
 	# expect it to be empty (since that is the default checkout
@@ -107,7 +112,7 @@ module_clone()
 	test -e "$path" &&
 	die "A file already exist at path '$path'"
 
-	git-clone -n "$url" "$path" ||
+	git-clone -n -o "$remote" "$url" "$path" ||
 	die "Clone of '$url' into submodule path '$path' failed"
 }
 
@@ -129,6 +134,14 @@ cmd_add()
 			branch=$2
 			shift
 			;;
+		-r)
+			case "$2" in
+			'')
+				usage
+				;;
+			esac
+			remote="$2"; shift
+			;;
 		-q|--quiet)
 			quiet=1
 			;;
@@ -156,13 +169,16 @@ cmd_add()
 	case "$repo" in
 	./*|../*)
 		# dereference source url relative to parent's url
-		realrepo="$(resolve_relative_url $repo)" ;;
+		realremote=${remote:-$(get_default_remote)}
+		realrepo=$(resolve_relative_url $repo) || exit 1
+		;;
 	*)
 		# Turn the source into an absolute path if
 		# it is local
 		if base=$(get_repo_base "$repo"); then
 			repo="$base"
 		fi
+		realremote=origin
 		realrepo=$repo
 		;;
 	esac
@@ -180,8 +196,8 @@ cmd_add()
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
 	die "'$path' already exists in the index"
 
-	module_clone "$path" "$realrepo" || exit
-	(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
+	module_clone "$path" "$realrepo" "$realremote" || exit
+	(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "$realremote/$branch"}) ||
 	die "Unable to checkout submodule '$path'"
 	git add "$path" ||
 	die "Failed to add submodule '$path'"
@@ -206,6 +222,14 @@ cmd_init()
 		-q|--quiet)
 			quiet=1
 			;;
+		-r)
+			case "$2" in
+			'')
+				usage
+				;;
+			esac
+			remote="$2"; shift
+			;;
 		--)
 			shift
 			break
@@ -235,7 +259,7 @@ cmd_init()
 		# Possibly a url relative to parent
 		case "$url" in
 		./*|../*)
-			url="$(resolve_relative_url "$url")"
+			url=$(resolve_relative_url "$url") || exit 1
 			;;
 		esac
 
@@ -248,6 +272,8 @@ cmd_init()
 
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
+# For relative submodules (defined using relative url), we use master project's remote
+# and define that in each submodule if not already there
 #
 # $@ = requested paths (default to all)
 #
@@ -260,6 +286,14 @@ cmd_update()
 		-q|--quiet)
 			quiet=1
 			;;
+		-r)
+			case "$2" in
+			'')
+				usage
+				;;
+			esac
+			remote="$2"; shift
+			;;
 		--)
 			shift
 			break
@@ -274,6 +308,7 @@ cmd_update()
 		shift
 	done
 
+	remote=${remote:-$(get_default_remote)}
 	git ls-files --stage -- "$@" | grep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
@@ -290,7 +325,7 @@ cmd_update()
 
 		if ! test -d "$path"/.git
 		then
-			module_clone "$path" "$url" || exit
+			module_clone "$path" "$url" "$remote" || exit
 			subsha1=
 		else
 			subsha1=$(unset GIT_DIR; cd "$path" &&
@@ -298,9 +333,24 @@ cmd_update()
 			die "Unable to find current revision in submodule path '$path'"
 		fi
 
+		baseurl="$(GIT_CONFIG=.gitmodules git config submodule."$name".url)"
+		case "$baseurl" in
+		./*|../*)
+			fetch_remote=$remote
+			absurl=$(resolve_relative_url $baseurl) || exit 1
+			(unset GIT_DIR ; cd "$path" && git config remote."$fetch_remote".url > /dev/null) ||
+			(
+				unset GIT_DIR; cd "$path" && git remote add "$fetch_remote" "$absurl"
+			) || die "Unable to define remote '$fetch_remote' in submodule path '$path'"
+			;;
+		*)
+			fetch_remote=
+			;;
+		esac
+
 		if test "$subsha1" != "$sha1"
 		then
-			(unset GIT_DIR; cd "$path" && git-fetch &&
+			(unset GIT_DIR; cd "$path" && git-fetch $fetch_remote &&
 				git-checkout -q "$sha1") ||
 			die "Unable to checkout '$sha1' in submodule path '$path'"
 
-- 
1.5.4.47.gcca7b3
