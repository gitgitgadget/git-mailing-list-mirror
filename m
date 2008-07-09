From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - make "submodule add" more strict, and document it
Date: Tue,  8 Jul 2008 23:59:25 -0400
Message-ID: <1215575965-3588-1-git-send-email-mlevedahl@gmail.com>
References: <7vhcb0x6ak.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, <sylvain.joyeux@dfki.de>, <hjemli@gmail.com>,
	<pkufranky@gmail.com>, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 09 06:00:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGQr0-0001LJ-4J
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 06:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbYGID7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 23:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753199AbYGID7c
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 23:59:32 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:58322 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbYGID7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 23:59:32 -0400
Received: by yx-out-2324.google.com with SMTP id 8so751827yxm.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 20:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fGcJAwuArZSk+K7aXQogf6k/F48R/xTou1wc1JgG7lo=;
        b=p8SdFiy1xA240cWtHjeF8rlkb/7Bz9Dp4xHeWo+pXv8XseWuJ71ilBA3yqrXrzxKNO
         M0G2To5cerRszwAK2kAv4PerpKEa8HjqfoXjo2H9g+qVIFECOx+qSZEjEFweuyNBeKlR
         GMVmp2LgKB4Ac7oLdCGsMs5DPYHSadp1xSPBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uzrng6GGSmYv+FSbanjt88am7D2XLV+Mpq2F8GJoMt0MweJQHf3PkEj0mWzX7NbTYh
         nHZYsssA/A4ZYtLpgki1nR+o0CA762/yQ8VfFYtIBf/EedpeN0FyZHSk2XnfhGvQIRxL
         qNQ5ej+Vocjx7rHbWVXZgfDkdgDG8OdmH9m/Q=
Received: by 10.151.83.12 with SMTP id k12mr11665266ybl.1.1215575970885;
        Tue, 08 Jul 2008 20:59:30 -0700 (PDT)
Received: from localhost.localdomain ( [71.246.235.165])
        by mx.google.com with ESMTPS id 4sm8063873yxq.8.2008.07.08.20.59.28
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Jul 2008 20:59:29 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.2.271.g73ad8
In-Reply-To: <7vhcb0x6ak.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87838>

This change makes "submodule add" much more strict in the arguments it
takes, and is intended to address confusion as recently noted on the
git-list. With this change, the required syntax is:
	$ git submodule add URL path

Specifically, this eliminates the form
	$git submodule add URL
which was confused by more than one person as
	$git submodule add path

The change eliminates one form of URL: a path relative to the current
working directory. This form was confusing, and does not seem to
correspond to an important use-case. Specifically, no-one has identified
the use to clone from a repository already in the tree, but if this is
needed it is easily done using an absolute URL: $(pwd)/relative-path. So,
no functionality is lost.

Following this change, there are exactly four variants of
submodule-add, as both arguments have two flavors:

URL can be absolute, or can begin with ./|../ and thus name the origin
relative to the top-level origin.

Note: With this patch, "submodule add" discerns an absolute URL as
matching /*|*:*: e.g., URL begins with /, or it contains a :. This works
for all valid URLs, an absolute path in POSIX, as well as an absolute
path on Windows).

path can either already exist as a valid git repo, or will be cloned from
the given URL. The first form here allows easy addition of a new
submodule to an existing project as the module can be added and tested
in-tree before pushing to the public repository. However, the more
usual form is the second, where the repo is cloned from the given URL.

This specifically addresses the issue of
	$ git submodule add a/b/c
attempting to clone from a repository at "a/b/c" to create a new module
in "c". This also simplifies description of "relative URL" as there is now
exactly *one* form: a URL relative to the parent's origin repo.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/git-submodule.txt |   31 +++++++++++++++------
 git-submodule.sh                |   55 ++++++++++++++------------------------
 2 files changed, 42 insertions(+), 44 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 105fc2d..6f24f92 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,7 +9,7 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] add [-b branch] [--] <repository> [<path>]
+'git submodule' [--quiet] add [-b branch] [--] <repository> <path>
 'git submodule' [--quiet] status [--cached] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [--] [<path>...]
@@ -20,14 +20,26 @@ COMMANDS
 --------
 add::
 	Add the given repository as a submodule at the given path
-	to the changeset to be committed next.  If path is a valid
-	repository within the project, it is added as is. Otherwise,
-	repository is cloned at the specified path. path is added to the
-	changeset and registered in .gitmodules.   If no path is
-	specified, the path is deduced from the repository specification.
-	If the repository url begins with ./ or ../, it is stored as
-	given but resolved as a relative path from the main project's
-	url when cloning.
+	to the changeset to be committed next. This requires two arguments,
+	<repository> and <path>. <repository> is the URL of the new
+	submodule's origin repository. This may be either an absolute URL,
+	or (if it begins with ./ or ../), the location relative
+	to the parent repository's origin.
+
+	<path> is the relative location for the cloned submodule to
+	exist in the current tree. If <path> does not exist, then the
+	module is created by cloning from the named URL. If <path> does
+	exist and is already a valid git repository, then this is added
+	to the changeset without cloning. This second form is provided
+	to ease adding a submodule to a project the first time, and presumes
+	the user will later push the new submodule to the given URL.
+
+	In either case, the given URL is recorded into .gitmodules for
+	use by subsequent users cloning the project. If the URL is given
+	relative to the parent, the presumption is the main and sub-modules
+	will be kept together in the same relative location, and only the
+	top-level URL need be provided: git-submodule will correctly
+	locat the submodules using the hint in .gitmodules.
 
 status::
 	Show the status of the submodules. This will print the SHA-1 of the
@@ -85,6 +97,7 @@ OPTIONS
 <path>::
 	Path to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
+	(This argument is required with add).
 
 FILES
 -----
diff --git a/git-submodule.sh b/git-submodule.sh
index 3eb78cc..d227907 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli
 
 USAGE="[--quiet] [--cached] \
-[add <repo> [-b branch]|status|init|update [-i|--init]|summary [-n|--summary-limit <n>] [<commit>]] \
+[add <repo> [-b branch] <path>]|[status|init|update [-i|--init]|summary [-n|--summary-limit <n>] [<commit>]] \
 [--] [<path>...]"
 OPTIONS_SPEC=
 . git-sh-setup
@@ -27,18 +27,6 @@ say()
 	fi
 }
 
-# NEEDSWORK: identical function exists in get_repo_base in clone.sh
-get_repo_base() {
-	(
-		cd "`/bin/pwd`" &&
-		cd "$1" || cd "$1.git" &&
-		{
-			cd .git
-			pwd
-		}
-	) 2>/dev/null
-}
-
 # Resolve relative url by appending to parent's url
 resolve_relative_url ()
 {
@@ -115,7 +103,7 @@ module_clone()
 #
 # Add a new submodule to the working tree, .gitmodules and the index
 #
-# $@ = repo [path]
+# $@ = repo path
 #
 # optional branch is stored in global branch variable
 #
@@ -150,16 +138,27 @@ cmd_add()
 	repo=$1
 	path=$2
 
-	if test -z "$repo"; then
+	if test -z "$repo" -o -z "$path"; then
 		usage
 	fi
 
-	# Guess path from repo if not specified or strip trailing slashes
-	if test -z "$path"; then
-		path=$(echo "$repo" | sed -e 's|/*$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
-	else
-		path=$(echo "$path" | sed -e 's|/*$||')
-	fi
+	# assure repo is absolute or relative to parent
+	case "$repo" in
+		./*|../*)
+			# dereference source url relative to parent's url
+			realrepo=$(resolve_relative_url "$repo") || exit
+			;;
+	    *:*|/*)
+			# absolute url
+			realrepo=$repo
+			;;
+		*)
+			die "repo URL: '$repo' must be absolute or begin with ./|../"
+	    ;;
+	esac
+
+	# strip trailing slashes from path
+	path=$(echo "$path" | sed -e 's|/*$||')
 
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
 	die "'$path' already exists in the index"
@@ -175,20 +174,6 @@ cmd_add()
 			die "'$path' already exists and is not a valid git repo"
 		fi
 	else
-		case "$repo" in
-		./*|../*)
-			# dereference source url relative to parent's url
-			realrepo=$(resolve_relative_url "$repo") || exit
-			;;
-		*)
-			# Turn the source into an absolute path if
-			# it is local
-			if base=$(get_repo_base "$repo"); then
-				repo="$base"
-			fi
-			realrepo=$repo
-			;;
-		esac
 
 		module_clone "$path" "$realrepo" || exit
 		(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
-- 
1.5.6.2.271.g73ad8
