From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - Possibly inherit parent's default remote on init/clone
Date: Sat, 12 Jan 2008 00:54:33 -0500
Message-ID: <1200117273-3524-4-git-send-email-mlevedahl@gmail.com>
References: <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <1200117273-3524-1-git-send-email-mlevedahl@gmail.com>
 <1200117273-3524-2-git-send-email-mlevedahl@gmail.com>
 <1200117273-3524-3-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 12 06:55:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDZL8-0003NW-MS
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 06:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938AbYALFyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 00:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757311AbYALFyo
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 00:54:44 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:2935 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757938AbYALFym (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 00:54:42 -0500
Received: by an-out-0708.google.com with SMTP id d31so299153and.103
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 21:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+20gIZu0/vOxkuuXuGJGkgZXZBmvZK7AzS7BtBeW1AY=;
        b=Lq18Py3ZOv59jUYaphSguTgpJgyaT84AsMpeRhCn+cstwPbuuoSbkWMrQsZccsI09Jbh4XUnlsgoqVVb4CFpt6wA/eT0HXGhmTv+Tt8E/DvosSQBXzjOfux0vRhcRLmLZ6pk5usBXi2v737qf3+zka1imvzthQ7ws0M2NglzqnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fybwXHW8u4qP015TJWUqlUv3jDNsr7OafTbr0Tj9TdlkafxfpIX7ml2f6FiRWHOvO1hVN545e2C3cPFR9pXADiTQE6lACxnyn+/qwMbeCvOB7MLIkBplAboJYrnGrYmTJz34J+REHC3XstZPbFoJfB/61tyFKMQjxwtObkBxhQE=
Received: by 10.100.252.16 with SMTP id z16mr8556178anh.93.1200117281791;
        Fri, 11 Jan 2008 21:54:41 -0800 (PST)
Received: from localhost.localdomain ( [71.163.17.196])
        by mx.google.com with ESMTPS id c37sm6069027ana.9.2008.01.11.21.54.39
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Jan 2008 21:54:40 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc2.98.g1f3d5
In-Reply-To: <1200117273-3524-3-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70272>

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
1.5.4.rc2.98.g1f3d5
