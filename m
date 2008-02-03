From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 4/7] git-submodule - Possibly inherit parent's default remote on init/clone
Date: Sun,  3 Feb 2008 12:20:46 -0500
Message-ID: <1202059249-3532-5-git-send-email-mlevedahl@gmail.com>
References: <1202059249-3532-1-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-2-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-3-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-4-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.org
X-From: git-owner@vger.kernel.org Sun Feb 03 18:22:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLiXY-00062p-A9
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 18:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758770AbYBCRVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 12:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758742AbYBCRVL
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 12:21:11 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:19931 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758651AbYBCRVH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 12:21:07 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1716391fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 09:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NYArBQx/r67Jzv7Xe9Kwcc55RiR56RWPCjSv8fibJBA=;
        b=HdCmgSd1Snze1Y+zL8Hjzcq8+1zNcTkNTstH/C3Zexb2TxrgYwGEMZm4McHaLN2LAXmKRILMf6ao1Fc0bDArBfX0eLB6r3CrLv1uhuIXAfGjl168Xcskhe5o4Argnltiuv3zSzqRyv3rYAVVNk8uQ3DzrefYennx1KYG3CwQe0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WnZPObNwnilBcpl7fLKiTAHXzSSaiGVoYhtZL8V72Fz7+fELVSLJjCg+OfEtz/LMDRHiO4QMSphdwiTs2gDonkwlcCNbu3xrbgvp4Aocvdsg8v0qR2CNwQdO7J04cmaVDBLMSX9sRvuXkTyqd6dJ+u/E5v0BlHqBqipAJ2tL++0=
Received: by 10.82.174.20 with SMTP id w20mr11184047bue.21.1202059266218;
        Sun, 03 Feb 2008 09:21:06 -0800 (PST)
Received: from localhost.localdomain ( [71.191.242.88])
        by mx.google.com with ESMTPS id x6sm4293526gvf.0.2008.02.03.09.21.03
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 09:21:04 -0800 (PST)
X-Mailer: git-send-email 1.5.4.18.g43c18
In-Reply-To: <1202059249-3532-4-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72374>

For submodules defined relative to their parent, it is likely that the
parent's defined default remote is correct for the child as well. This
allows use of remote names other than "origin", important as managed
submodules are typically checked out on a detached head and therefore
submodule-update invokes git-fetch using the default remote. Without this
change, submodules effectively had to have a default remote of "origin."

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/git-submodule.txt |    8 +++++---
 git-submodule.sh                |   20 ++++++++++++++------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e818e6e..b04b107 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -37,9 +37,11 @@ status::
 
 init::
 	Initialize the submodules, i.e. register in .git/config each submodule
-	name and url found in .gitmodules. The key used in .git/config is
-	`submodule.$name.url`. This command does not alter existing information
-	in .git/config.
+	name and url found in .gitmodules, along with the default remote origin.
+	For submodules using a relative url, the default remote is inherited
+	from the parent project, for absolute urls the default "origin" is used.
+	The key used in .git/config is submodule.$name.url`. This command does
+	not alter existing information in .git/config.
 
 update::
 	Update the registered submodules, i.e. clone missing submodules and
diff --git a/git-submodule.sh b/git-submodule.sh
index a6aaf40..bb0d265 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -7,6 +7,7 @@
 USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]'
 OPTIONS_SPEC=
 . git-sh-setup
+. git-parse-remote
 require_work_tree
 
 command=
@@ -40,9 +41,7 @@ get_repo_base() {
 # Resolve relative url by appending to parent's url
 resolve_relative_url ()
 {
-	branch="$(git symbolic-ref HEAD 2>/dev/null)"
-	remote="$(git config branch.${branch#refs/heads/}.remote)"
-	remote="${remote:-origin}"
+	remote="$(get_default_remote)"
 	remoteurl="$(git config remote.$remote.url)" ||
 		die "remote ($remote) does not have a url in .git/config"
 	url="$1"
@@ -92,6 +91,7 @@ module_clone()
 {
 	path=$1
 	url=$2
+	origin=$3
 
 	# If there already is a directory at the submodule path,
 	# expect it to be empty (since that is the default checkout
@@ -107,7 +107,7 @@ module_clone()
 	test -e "$path" &&
 	die "A file already exist at path '$path'"
 
-	git-clone -n "$url" "$path" ||
+	git-clone -n -o "$origin" "$url" "$path" ||
 	die "Clone of '$url' into submodule path '$path' failed"
 }
 
@@ -156,10 +156,12 @@ cmd_add()
 	case "$repo" in
 	./*|../*)
 		# dereference source url relative to parent's url
+		origin=$(get_default_remote)
 		realrepo="$(resolve_relative_url $repo)" ;;
 	*)
 		# Turn the source into an absolute path if
 		# it is local
+		origin=origin
 		if base=$(get_repo_base "$repo"); then
 			repo="$base"
 		fi
@@ -180,7 +182,7 @@ cmd_add()
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
 	die "'$path' already exists in the index"
 
-	module_clone "$path" "$realrepo" || exit
+	module_clone "$path" "$realrepo" "$origin" || exit
 	(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
 	die "Unable to checkout submodule '$path'"
 	git add "$path" ||
@@ -236,9 +238,14 @@ cmd_init()
 		case "$url" in
 		./*|../*)
 			url="$(resolve_relative_url "$url")"
+			origin=$(get_default_remote)
+			;;
+		*)
+			origin=origin
 			;;
 		esac
 
+		git config submodule."$name".origin "$origin" &&
 		git config submodule."$name".url "$url" ||
 		die "Failed to register url for submodule path '$path'"
 
@@ -287,10 +294,11 @@ cmd_update()
 			say "Submodule path '$path' not initialized"
 			continue
 		fi
+		origin=$(git config submodule."$name".origin || echo origin)
 
 		if ! test -d "$path"/.git
 		then
-			module_clone "$path" "$url" || exit
+			module_clone "$path" "$url" "$origin" || exit
 			subsha1=
 		else
 			subsha1=$(unset GIT_DIR; cd "$path" &&
-- 
1.5.4.18.g43c18
