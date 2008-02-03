From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 6/7] git-submodule - Allow adding a submodule in-place
Date: Sun,  3 Feb 2008 12:20:48 -0500
Message-ID: <1202059249-3532-7-git-send-email-mlevedahl@gmail.com>
References: <1202059249-3532-1-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-2-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-3-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-4-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-5-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-6-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.org
X-From: git-owner@vger.kernel.org Sun Feb 03 18:22:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLiXZ-00062p-JR
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 18:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758997AbYBCRVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 12:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758887AbYBCRVS
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 12:21:18 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:26412 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758742AbYBCRVP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 12:21:15 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1624551fkz.5
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 09:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TG1qZ7cjjYW9FXUr2i4jCRHc+5tT1bcwQp+YvOWrMoI=;
        b=CQrXZic8Ra95r5WB0mb7y6L/KTVg/xA4oreU0BVHy5WnAlw3yyMLZ3Dk4teAfMEJOq1dbUcKkIaQqk5tP4rHla6H3O63PTQz7bDMsdxZl8DrJWY8m+FnYDtKPM/Vp2sIraEmp/FTKXKewtifQ/gZLTpdxVx6h+9xvhf0jNSQEfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HVqjhBxCbxSrrFWOuTbwXq+hH4YMCKywJ6mgEzSKjVbLRQYz/IX7UA+eqYvrJdMWLw1f9KEArT2TLz/5mgahPxPIZ5iECqa9Lwp5cY4mDWAFaYZr0rjvU7PrpqP4Oy7bYSzkyCQSHb6zLqYWkeE4+2xGzOdoZoCvRwwK1SBkIxI=
Received: by 10.78.201.2 with SMTP id y2mr10538139huf.56.1202059273149;
        Sun, 03 Feb 2008 09:21:13 -0800 (PST)
Received: from localhost.localdomain ( [71.191.242.88])
        by mx.google.com with ESMTPS id x6sm4293526gvf.0.2008.02.03.09.21.10
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 09:21:11 -0800 (PST)
X-Mailer: git-send-email 1.5.4.18.g43c18
In-Reply-To: <1202059249-3532-6-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72376>

When working in top-level directory, it is natural to create a new
submodule in a subdirectory, then add that submodule to top-level in
place. This allows "git submodule add <intended url> subdir" to add
the existing subdir to the current project. The presumption is the user
will later push / clone the subdir to the <intended url> so that future
submodule init / updates will work.

Absent this patch, "git submodule add" insists upon cloning the subdir
from the remote, which is fine for adding an existing project in but
less useful when adding a new submodule from scratch to an existing
project. This functionality remains, and the clone is attempted if the
subdir does not already exist as a valid git repo.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>

fix submodule again
---
 Documentation/git-submodule.txt |    5 ++-
 git-submodule.sh                |   56 +++++++++++++++++++++++---------------
 2 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index b04b107..8ea3fc3 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -18,8 +18,9 @@ COMMANDS
 --------
 add::
 	Add the given repository as a submodule at the given path
-	to the changeset to be committed next.  In particular, the
-	repository is cloned at the specified path, added to the
+	to the changeset to be committed next.  If path is a valid
+	repository within the project, it is added as is. Otherwise,
+	repository is cloned at the specified path. path is added to the
 	changeset and registered in .gitmodules.   If no path is
 	specified, the path is deduced from the repository specification.
 	If the repository url begins with ./ or ../, it is stored as
diff --git a/git-submodule.sh b/git-submodule.sh
index 8f31ebe..47b5664 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -44,6 +44,7 @@ resolve_relative_url ()
 	remote="$(get_default_remote)"
 	remoteurl="$(git config remote.$remote.url)" ||
 		die "remote ($remote) does not have a url in .git/config"
+	remoteurl="${remoteurl%/.git}"
 	url="$1"
 	while test -n "$url"
 	do
@@ -153,22 +154,6 @@ cmd_add()
 		usage
 	fi
 
-	case "$repo" in
-	./*|../*)
-		# dereference source url relative to parent's url
-		origin=$(get_default_remote)
-		realrepo="$(resolve_relative_url $repo)" ;;
-	*)
-		# Turn the source into an absolute path if
-		# it is local
-		origin=origin
-		if base=$(get_repo_base "$repo"); then
-			repo="$base"
-		fi
-		realrepo=$repo
-		;;
-	esac
-
 	# Guess path from repo if not specified or strip trailing slashes
 	if test -z "$path"; then
 		path=$(echo "$repo" | sed -e 's|/*$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
@@ -176,15 +161,42 @@ cmd_add()
 		path=$(echo "$path" | sed -e 's|/*$||')
 	fi
 
-	test -e "$path" &&
-	die "'$path' already exists"
-
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
 	die "'$path' already exists in the index"
 
-	module_clone "$path" "$realrepo" "$origin" || exit
-	(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
-	die "Unable to checkout submodule '$path'"
+	# perhaps the path exists and is already a git repo, else clone it
+	if test -e "$path"
+	then
+		if test -d "$path/.git" &&
+		test "$(unset GIT_DIR; cd $path; git rev-parse --git-dir)" = ".git"
+		then
+			echo "Adding existing repo at '$path' to the index"
+		else
+			die "'$path' already exists and is not a valid git repo"
+		fi
+	else
+		case "$repo" in
+		./*|../*)
+			# dereference source url relative to parent's url
+			origin=$(get_default_remote)
+			realrepo="$(resolve_relative_url $repo)" ;;
+		*)
+			# Turn the source into an absolute path if
+			# it is local
+			origin=origin
+			if base=$(get_repo_base "$repo")
+			then
+				repo="$base"
+			fi
+			realrepo=$repo
+			;;
+		esac
+
+		module_clone "$path" "$realrepo" "$origin" || exit
+		(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
+		die "Unable to checkout submodule '$path'"
+	fi
+
 	git add "$path" ||
 	die "Failed to add submodule '$path'"
 
-- 
1.5.4.18.g43c18
