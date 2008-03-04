From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - Allow adding a submodule in-place
Date: Mon,  3 Mar 2008 21:06:23 -0500
Message-ID: <1204596383-4040-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org, pkufranky@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 04 03:07:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWMZ8-00008S-TU
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 03:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbYCDCGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 21:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754567AbYCDCGh
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 21:06:37 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:31782 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbYCDCGg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 21:06:36 -0500
Received: by an-out-0708.google.com with SMTP id d31so90713and.103
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 18:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=7WcQ3ziu/TgsaWjFbfzlzt3NgJ/fTf64yU50nhbOcRI=;
        b=NT+RAXd7EN7b6YEYqNoEFD6mLnLZ5iBB0Y9/jHfupzS10xM+4bmIY33RFBJirjoZGCitv2ajfkfnZdHFODqbssS1LBfYWm73vBsIrxz0dwkw8HgrnA0i6IH3l2ZctvTHYr7UUImnl2LFnTsRyHCIbQ8heAQBTaK3QKB/ERKpQhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TcsCJMsjrk/EWEvt1SQKyCGM5O8N+3qdCRmFFfsnpI3cZ0rh1dIk/s98LziOKHulWVgJbfaFfVALBQJs1sbFhKvNBCKrgraidnGD7UFLe8muloblPARE2jOmoU2YJKlTxBvcYiw5AtiAPfmqBNXriQNzte2RthIGMqbU57L7jkc=
Received: by 10.100.202.9 with SMTP id z9mr853428anf.93.1204596390286;
        Mon, 03 Mar 2008 18:06:30 -0800 (PST)
Received: from localhost.localdomain ( [71.163.29.241])
        by mx.google.com with ESMTPS id 33sm1205591wra.23.2008.03.03.18.06.26
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Mar 2008 18:06:27 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.438.g4c6f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76011>

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
 Documentation/git-submodule.txt |   21 +++++++++++++---
 git-submodule.sh                |   50 +++++++++++++++++++++++---------------
 2 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e818e6e..85d7dd3 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,17 +9,18 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git-submodule' [--quiet] add [-b branch] [--] <repository> [<path>]
+'git-submodule' [--quiet] add [-b branch] [-r <remote>] [--] <repository> [<path>]
 'git-submodule' [--quiet] status [--cached] [--] [<path>...]
-'git-submodule' [--quiet] [init|update] [--] [<path>...]
+'git-submodule' [--quiet] [init|update] [-r <remote>] [--] [<path>...]
 
 
 COMMANDS
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
@@ -55,6 +56,18 @@ OPTIONS
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
index 67d3224..7171cb6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -153,20 +153,6 @@ cmd_add()
 		usage
 	fi
 
-	case "$repo" in
-	./*|../*)
-		# dereference source url relative to parent's url
-		realrepo="$(resolve_relative_url $repo)" ;;
-	*)
-		# Turn the source into an absolute path if
-		# it is local
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
@@ -174,15 +160,39 @@ cmd_add()
 		path=$(echo "$path" | sed -e 's|/*$||')
 	fi
 
-	test -e "$path" &&
-	die "'$path' already exists"
-
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
 	die "'$path' already exists in the index"
 
-	module_clone "$path" "$realrepo" || exit
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
+			realrepo="$(resolve_relative_url $repo)" ;;
+		*)
+			# Turn the source into an absolute path if
+			# it is local
+			if base=$(get_repo_base "$repo"); then
+				repo="$base"
+			fi
+			realrepo=$repo
+			;;
+		esac
+
+		module_clone "$path" "$realrepo" || exit
+		(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
+		die "Unable to checkout submodule '$path'"
+	fi
+
 	git add "$path" ||
 	die "Failed to add submodule '$path'"
 
-- 
1.5.4.3.438.g4c6f8

