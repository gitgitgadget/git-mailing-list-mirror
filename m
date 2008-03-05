From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - Allow adding a submodule in-place
Date: Tue,  4 Mar 2008 20:15:02 -0500
Message-ID: <1204679702-304-1-git-send-email-mlevedahl@gmail.com>
References: <1204596383-4040-1-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, pkufranky@gmail.com, skimo@kotnet.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 05 02:15:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWiEY-0003KW-HE
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 02:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbYCEBPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 20:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755348AbYCEBPN
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 20:15:13 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:20778 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbYCEBPL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 20:15:11 -0500
Received: by wr-out-0506.google.com with SMTP id 50so1716179wra.13
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 17:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7NRmNgTgmK2p/Vk+5w/B6N4bNsDvgPkFW33AdVea78Q=;
        b=YL60h3oRt0uEGFJJSfqPb02GWd9mMpdZ2QAxYF7eJmE4Zv8IQqn2rwQ6uL3hwPxqFzKlyei8K4ksjWBtedpEdG/B80iP3BRgbqrP8fkRdEgX1aGI5hCWnyiDV3Rhw4PMTnrDavZdsbbwIcqH2XUx0OD3zEr/zb5rnX/vP2mD2/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CvkLBzmDp88fI7o734zFsU+I4IXGMm8/BILoBuzhSrnBlT6ulOkpvFBkGTGT1/7aHWO4onjtw8uR47yKYr9wvfStZJianJkR4J8pL++OC7QW3x0xg3Bp5ZCEDWtsXuEpK8Zy0iVI5acH5R+l8VngrK48BX+Blc+j36Gp37Ougn8=
Received: by 10.100.214.15 with SMTP id m15mr5008710ang.30.1204679709339;
        Tue, 04 Mar 2008 17:15:09 -0800 (PST)
Received: from localhost.localdomain ( [71.163.29.241])
        by mx.google.com with ESMTPS id g9sm270709wra.40.2008.03.04.17.15.06
        (version=SSLv3 cipher=OTHER);
        Tue, 04 Mar 2008 17:15:06 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.438.g4c6f8
In-Reply-To: <1204596383-4040-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76164>

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

This eliminates the extraneous documentation of the previous patch that
was for functionality unrelated to this topic.

 Documentation/git-submodule.txt |    5 ++-
 git-submodule.sh                |   50 +++++++++++++++++++++++---------------
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e818e6e..b4d0160 100644
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

