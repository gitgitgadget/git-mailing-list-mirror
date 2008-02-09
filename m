From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 2/3] git-submodule - Allow adding a submodule in-place
Date: Sat,  9 Feb 2008 11:57:24 -0500
Message-ID: <1202576245-284-2-git-send-email-mlevedahl@gmail.com>
References: <1202576245-284-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 17:58:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNt1m-0008P7-BQ
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 17:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387AbYBIQ5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 11:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754290AbYBIQ5g
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 11:57:36 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:54407 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbYBIQ5e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 11:57:34 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4336359wxd.4
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 08:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=R+GJybQJzO/g7IYaj4syHsnq6pG5YZy0iK8WgCbCJlc=;
        b=BIfbBA6rJlOqV1vaTqnKMlJRgr7FP6sKb4OxiTyVLNJkBsTAJls4/BeluAOuIGE6nD9857OXnbeqV6Ngfq7TBwmBfFJeMNVFjB+oxvntHKxZ+AMCsT+0U2sKHJmU4vB8/2MNDkdHeZxoaa5WnyiHX9/P8CnrQhBqBKVCYTkLmGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VsDlOL7v9aE22wwbASWHNYKUPeIvPGM6wQdS0Gr3ow3iAKvqqzWAW6ylsJPiXSVmBeHxiaUm8NYQ8acKoTHvrl+d6wADxznRREGSY1sJQrtZNNrmYfgyCq4m0J1rq1bb6pRDF2sILwbE1uHmY8++jTb2otLExLL/UCSVZmYmkw0=
Received: by 10.70.69.1 with SMTP id r1mr9025956wxa.54.1202576253596;
        Sat, 09 Feb 2008 08:57:33 -0800 (PST)
Received: from localhost.localdomain ( [71.163.29.241])
        by mx.google.com with ESMTPS id h38sm5351828wxd.15.2008.02.09.08.57.31
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Feb 2008 08:57:31 -0800 (PST)
X-Mailer: git-send-email 1.5.4.47.gcca7b3
In-Reply-To: <1202576245-284-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73242>

When working in top-level project, it is useful to create a new submodule
as a git repo in a subdirectory, then add that submodule to top-level in
place.  This allows "git submodule add <intended url> subdir" to add the
existing subdir to the current project.  The presumption is the user will
later push / clone the subdir to the <intended url> so that future
submodule init / updates will work.

Absent this patch, "git submodule add" insists upon cloning the subdir
from a repository at the given url, which is fine for adding an existing
project in but less useful when adding a new submodule from scratch to an
existing project.  The former functionality remains, and the clone is
attempted if the subdir does not already exist as a valid git repo.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/git-submodule.txt |    5 ++-
 git-submodule.sh                |   57 +++++++++++++++++++++++---------------
 2 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 4fc17f6..85d7dd3 100644
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
index b97bf18..4c86a3c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -166,23 +166,6 @@ cmd_add()
 		usage
 	fi
 
-	case "$repo" in
-	./*|../*)
-		# dereference source url relative to parent's url
-		realremote=${remote:-$(get_default_remote)}
-		realrepo=$(resolve_relative_url $repo) || exit 1
-		;;
-	*)
-		# Turn the source into an absolute path if
-		# it is local
-		if base=$(get_repo_base "$repo"); then
-			repo="$base"
-		fi
-		realremote=origin
-		realrepo=$repo
-		;;
-	esac
-
 	# Guess path from repo if not specified or strip trailing slashes
 	if test -z "$path"; then
 		path=$(echo "$repo" | sed -e 's|/*$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
@@ -190,15 +173,43 @@ cmd_add()
 		path=$(echo "$path" | sed -e 's|/*$||')
 	fi
 
-	test -e "$path" &&
-	die "'$path' already exists"
-
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
 	die "'$path' already exists in the index"
 
-	module_clone "$path" "$realrepo" "$realremote" || exit
-	(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "$realremote/$branch"}) ||
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
+			realremote=${remote:-$(get_default_remote)}
+			realrepo=$(resolve_relative_url $repo) || exit 1
+			;;
+		*)
+			# Turn the source into an absolute path if
+			# it is local
+			if base=$(get_repo_base "$repo")
+			then
+				repo="$base"
+			fi
+			realremote=origin
+			realrepo=$repo
+			;;
+		esac
+
+		module_clone "$path" "$realrepo" "$realremote" || exit
+		(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "$realremote/$branch"}) ||
+		die "Unable to checkout submodule '$path'"
+	fi
+
 	git add "$path" ||
 	die "Failed to add submodule '$path'"
 
-- 
1.5.4.47.gcca7b3
