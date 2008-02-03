From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 6/7] git-submodule - Allow adding a submodule in-place
Date: Sun,  3 Feb 2008 12:31:06 -0500
Message-ID: <1202059867-1184-7-git-send-email-mlevedahl@gmail.com>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com>
 <1202059867-1184-2-git-send-email-mlevedahl@gmail.com>
 <1202059867-1184-3-git-send-email-mlevedahl@gmail.com>
 <1202059867-1184-4-git-send-email-mlevedahl@gmail.com>
 <1202059867-1184-5-git-send-email-mlevedahl@gmail.com>
 <1202059867-1184-6-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 03 18:32:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLihk-0000tY-Vg
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 18:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758611AbYBCRbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 12:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758210AbYBCRbd
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 12:31:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:37993 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758005AbYBCRbc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 12:31:32 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1719736fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 09:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TG1qZ7cjjYW9FXUr2i4jCRHc+5tT1bcwQp+YvOWrMoI=;
        b=fy2pccoBuoB1q9hn3pdkKW+I0F6kUQyA7Ykk/NSiG990vY5yOjvh9z0gn7TvYjbWarE+M1bwY7y8Kf32pN6wLkVaHbmk/CwkZngNp7VT6REaE1nFEOYovS/1nAuAHvTJA7lli5FQ2G2uThZz2pyS3Bn+EKbiKSO/vqenoA3/MLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VZIHlZRZbLt+u2Z0q+7m0x/sGDIGEMWTji4jtwT01bspaXFlNasNcuSseZsbU716LpqvH5Xro8f7FUldYq6fYW8FOYga5kr6oX4zoeBzYWWGkviRLYjljlZUza7NwAl2n9j36cRiVWgAf979v9cwQsB0x1UaUHXWh83sIYll0hM=
Received: by 10.86.89.4 with SMTP id m4mr5663842fgb.45.1202059891770;
        Sun, 03 Feb 2008 09:31:31 -0800 (PST)
Received: from localhost.localdomain ( [71.191.242.88])
        by mx.google.com with ESMTPS id l19sm8463628fgb.0.2008.02.03.09.31.28
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 09:31:30 -0800 (PST)
X-Mailer: git-send-email 1.5.4.18.g43c18
In-Reply-To: <1202059867-1184-6-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72384>

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
