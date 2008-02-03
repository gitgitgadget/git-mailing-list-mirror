From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 4/7] git-submodule - Possibly inherit parent's default remote on init/clone
Date: Sun,  3 Feb 2008 12:31:04 -0500
Message-ID: <1202059867-1184-5-git-send-email-mlevedahl@gmail.com>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com>
 <1202059867-1184-2-git-send-email-mlevedahl@gmail.com>
 <1202059867-1184-3-git-send-email-mlevedahl@gmail.com>
 <1202059867-1184-4-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 03 18:32:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLihj-0000tY-MA
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 18:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757898AbYBCRb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 12:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757540AbYBCRb1
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 12:31:27 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:37993 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756631AbYBCRb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 12:31:26 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1719736fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 09:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NYArBQx/r67Jzv7Xe9Kwcc55RiR56RWPCjSv8fibJBA=;
        b=hypQ6Xz2fX50ZZgpVWsC7pEQ4cFDoxU+L7rXdutIRfHdGqbWQ9LJ/nG30wE5mc91HBTiyoq2Qwy8ppjxrGSDW/iW+Rqf6hKjhnSvOT7FjAeOd8uIjNFEEjHDvw2T1Kc8Oo2K3gXEyN+DqEqwFlOrJ0GRwBoaStX0D26ciwVh6/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EOtYW4KKZEA7yr0n1OoHHBnYc6CSct6eqPoZpb8Uymhcs+5BfYi+v5X2ujNuXjwfaVeMpXibkGYwkKLIBM50KSf/JGJKn0GJfQHxgrwm/YLzdN7OkG0s7oI9UwnrLOx7L/pNJEMLwpyMKxF0BeI5nIhf2HziqtNAlKlUHou7xMo=
Received: by 10.86.78.4 with SMTP id a4mr5687786fgb.3.1202059885428;
        Sun, 03 Feb 2008 09:31:25 -0800 (PST)
Received: from localhost.localdomain ( [71.191.242.88])
        by mx.google.com with ESMTPS id l19sm8463628fgb.0.2008.02.03.09.31.22
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 09:31:23 -0800 (PST)
X-Mailer: git-send-email 1.5.4.18.g43c18
In-Reply-To: <1202059867-1184-4-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72381>

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
