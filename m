From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - Possibly inherit parent's default remote on init/clone
Date: Sun, 13 Jan 2008 11:27:10 -0500
Message-ID: <1200241631-3300-4-git-send-email-mlevedahl@gmail.com>
References: <478A3284.1000102@gmail.com>
 <1200241631-3300-1-git-send-email-mlevedahl@gmail.com>
 <1200241631-3300-2-git-send-email-mlevedahl@gmail.com>
 <1200241631-3300-3-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.org
X-From: git-owner@vger.kernel.org Sun Jan 13 17:28:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE5h5-0001G5-2K
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 17:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbYAMQ1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 11:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbYAMQ1Y
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 11:27:24 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:56281 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbYAMQ1V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 11:27:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1501825rvb.1
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 08:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9AssYYr5Lk16zf2Fnpb+RsJcW1BpddN8uoU5ZhhBvXU=;
        b=qNESABWqfwR4ugDpieGlF7xT2El/wNzKrCDSfJ5TNng8ihzGNcXNIa9nF9VoNd0CqJwR61+hjFxq1vTZfMljK1mTRQOFIK2cu6gj2tmoS5HRKsAfSbwQ3MD7khbrtN99Ohf13VXP+rNIYpLfDR4gY4fvaRYdPAI++wRg3eTWo1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=n3jeLJdLnpfnRy16VDf50v/IK2kENrj66inplfGTA+5bImsGqGr8br4TqyWjDqvP/XRCmoTtnwNAxSEegAMMJFEkUFGMNP9LqKrMj2ZfSFP7/zu6WthO2g8bHAxc7JWR81o3J/bOS8RJW1xAv2ada5rQ7XL7bsA9vjCUJ6obkzg=
Received: by 10.141.74.17 with SMTP id b17mr3240926rvl.123.1200241640955;
        Sun, 13 Jan 2008 08:27:20 -0800 (PST)
Received: from localhost.localdomain ( [71.163.17.196])
        by mx.google.com with ESMTPS id i18sm8324960wxd.0.2008.01.13.08.27.19
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 08:27:20 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc3.14.gc50f
In-Reply-To: <1200241631-3300-3-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70395>

For submodules defined relative to their parent, it is likely that the
parent's defined default remote is correct for the child as well. This
allows use of remote names other than "origin", important as managed
submodules are typically checked out on a detached head and therefore
submodule-update invokes git-fetch using the default remote. Without this
change, submodules effectively had to have a default remote of "origin."

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/git-submodule.txt |    8 +++++---
 git-submodule.sh                |   19 +++++++++++++------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index cffc6d4..440e234 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -36,9 +36,11 @@ status::
 
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
index ad9fe62..42be4b9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -7,6 +7,7 @@
 USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]'
 OPTIONS_SPEC=
 . git-sh-setup
+. git-parse-remote
 require_work_tree
 
 add=
@@ -43,9 +44,7 @@ get_repo_base() {
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
@@ -95,6 +94,7 @@ module_clone()
 {
 	path=$1
 	url=$2
+	origin=${3:-origin}
 
 	# If there already is a directory at the submodule path,
 	# expect it to be empty (since that is the default checkout
@@ -110,7 +110,7 @@ module_clone()
 	test -e "$path" &&
 	die "A file already exist at path '$path'"
 
-	git-clone -n "$url" "$path" ||
+	git-clone -n -o "$origin" "$url" "$path" ||
 	die "Clone of '$url' into submodule path '$path' failed"
 }
 
@@ -130,9 +130,11 @@ module_add()
 		usage
 	fi
 
+	origin=origin
 	case "$repo" in
 	./*|../*)
 		# dereference source url relative to parent's url
+		origin=$(get_default_remote)
 		realrepo="$(resolve_relative_url $repo)" ;;
 	*)
 		# Turn the source into an absolute path if
@@ -157,7 +159,7 @@ module_add()
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
 	die "'$path' already exists in the index"
 
-	module_clone "$path" "$realrepo" || exit
+	module_clone "$path" "$realrepo" "$origin" || exit
 	(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
 	die "Unable to checkout submodule '$path'"
 	git add "$path" ||
@@ -189,12 +191,15 @@ modules_init()
 		die "No url found for submodule path '$path' in .gitmodules"
 
 		# Possibly a url relative to parent
+		origin=origin
 		case "$url" in
 		./*|../*)
 			url="$(resolve_relative_url "$url")"
+			origin=$(get_default_remote)
 			;;
 		esac
 
+		git config submodule."$name".origin "$origin" &&
 		git config submodule."$name".url "$url" ||
 		die "Failed to register url for submodule path '$path'"
 
@@ -222,10 +227,12 @@ modules_update()
 			say "Submodule path '$path' not initialized"
 			continue
 		fi
+		origin=$(git config submodule."$name".origin)
+		origin=${origin:-origin}
 
 		if ! test -d "$path"/.git
 		then
-			module_clone "$path" "$url" || exit
+			module_clone "$path" "$url" "$origin" || exit
 			subsha1=
 		else
 			subsha1=$(unset GIT_DIR; cd "$path" &&
-- 
1.5.4.rc3.14.gc50f
