From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - Possibly inherit parent's default remote on init/clone
Date: Thu, 10 Jan 2008 22:29:49 -0500
Message-ID: <1200022189-2400-5-git-send-email-mlevedahl@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
 <1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
 <1200022189-2400-3-git-send-email-mlevedahl@gmail.com>
 <1200022189-2400-4-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 11 04:31:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDAbk-0004i8-8f
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 04:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbYAKDaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 22:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756504AbYAKDaH
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 22:30:07 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:4592 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756192AbYAKDaB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 22:30:01 -0500
Received: by wx-out-0506.google.com with SMTP id h31so643452wxd.4
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 19:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=seG49UEfiiBRrw820K3BumPRlxK4iCZJE+DxreyUn0w=;
        b=C0XFVDTCXXsa0+PqrPDfjkYctrbd7mT4o/Da71s7OAsHjGLIing6NAb1ajPR5iT3xxJy5J9Gdq8UXnRxU9zSRrFiW2BydokXsa9nGzSC547mg0p6XeaWXEUoHBgdEkebxSwZBQd90P70DOLmXXWRnER/CAWix72gbvIuhZ0Z6BM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tORzZG2EOz/nLyjUuOI4FvrP5jV54PpRrfkwKZ1A42JnkOjtDV4eQ1VtzhM+2htz8eJYfvYZ+LDGyZbTTYZ3UX4UgtF3MmEGvYQ2GVC/aFjDTpccO4/kaQPxsHHa0cpJtF4V4LpWQyUBGV03OjcPZ63SrAX6+CYRpq70RUpNZn0=
Received: by 10.70.44.18 with SMTP id r18mr1748184wxr.76.1200022200516;
        Thu, 10 Jan 2008 19:30:00 -0800 (PST)
Received: from localhost.localdomain ( [71.163.17.196])
        by mx.google.com with ESMTPS id h8sm4363197wxd.39.2008.01.10.19.29.58
        (version=SSLv3 cipher=OTHER);
        Thu, 10 Jan 2008 19:29:59 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc2.99.g3ef7-dirty
In-Reply-To: <1200022189-2400-4-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70119>

For submodules defined relative to their parent, it is likely that the
parent's defined default remote is correct for the child as well. This
allows use of remote names other than "origin", important as managed
submodules are typically checked out on a detached head and therefore
submodule-update invokes git-fetch using the default remote. Without this
change, submodules effectively had to have a default remote of "origin."

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/git-submodule.txt |    8 +++++---
 git-submodule.sh                |   15 ++++++++++++---
 2 files changed, 17 insertions(+), 6 deletions(-)

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
index ad9fe62..30e0270 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -7,6 +7,7 @@
 USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]'
 OPTIONS_SPEC=
 . git-sh-setup
+. git-parse-remote
 require_work_tree
 
 add=
@@ -95,6 +96,7 @@ module_clone()
 {
 	path=$1
 	url=$2
+	origin=${3:-origin}
 
 	# If there already is a directory at the submodule path,
 	# expect it to be empty (since that is the default checkout
@@ -110,7 +112,7 @@ module_clone()
 	test -e "$path" &&
 	die "A file already exist at path '$path'"
 
-	git-clone -n "$url" "$path" ||
+	git-clone -n -o "$origin" "$url" "$path" ||
 	die "Clone of '$url' into submodule path '$path' failed"
 }
 
@@ -130,9 +132,11 @@ module_add()
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
@@ -157,7 +161,7 @@ module_add()
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
 	die "'$path' already exists in the index"
 
-	module_clone "$path" "$realrepo" || exit
+	module_clone "$path" "$realrepo" "$origin" || exit
 	(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
 	die "Unable to checkout submodule '$path'"
 	git add "$path" ||
@@ -189,12 +193,15 @@ modules_init()
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
 
@@ -222,10 +229,12 @@ modules_update()
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
1.5.4.rc2.99.g3ef7-dirty
