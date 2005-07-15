From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] fetch/pull: support Cogito-style remote branch information.
Date: Fri, 15 Jul 2005 14:40:41 -0700
Message-ID: <7voe93rbmu.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vbr55kgq2.fsf@assigned-by-dhcp.cox.net>
	<7vzmsots7t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 23:44:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtXyS-0004yQ-RI
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 23:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVGOVnr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jul 2005 17:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVGOVlC
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jul 2005 17:41:02 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:459 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261788AbVGOVkt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2005 17:40:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050715214042.MMEQ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Jul 2005 17:40:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vzmsots7t.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Fri, 15 Jul 2005 00:59:34 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Since pull and fetch are done often against the same remote
repository, keeping the URL to pull from along with the name of
the head in $GIT_DIR/branches/$name like Cogito does makes a lot
of sense.  Adopt that and be compatible with Cogito for usability.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Although I have tested it to see the change does what it
*** advertises to do, I would like to hear comments from the
*** list if things like this would be good to have in the
*** barebone Porcelain.  I personally think this is a good
*** usability enhancement without complicating it too much.

 Documentation/git-fetch-script.txt |   40 +++++++++++++++++++++++++++
 Documentation/git-pull-script.txt  |   20 +++++++++++--
 Documentation/git.txt              |    9 +++++-
 Documentation/tutorial.txt         |   13 +++++++++
 git-fetch-script                   |   44 +++++++++++++++++++++++------
 git-pull-script                    |   54 +++++++++++++++++++++++++++---------
 6 files changed, 152 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/git-fetch-script.txt

804f1002c007106fb1aeade4b4549169e92042a2
diff --git a/Documentation/git-fetch-script.txt b/Documentation/git-fetch-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-fetch-script.txt
@@ -0,0 +1,40 @@
+git-fetch-script(1)
+===================
+v0.1, July 2005
+
+NAME
+----
+git-fetch-script - Download objects and a head from another repository.
+
+
+SYNOPSIS
+--------
+'git-fetch-script' <repository> [ <head> | tag <tag> ]
+
+'git-fetch-script' -b <name>
+
+
+DESCRIPTION
+-----------
+Fetches a named head or a tag from another repository, along
+with the objects necessary to complete that head or tag.  The
+head to pull defaults to HEAD if unspecified.
+
+When '-b' flag is specified to give a name, not an URL to the
+repository, it reads from .git/branches/<name> to get the
+repository URL, possibly immediately followed by '#' and the
+name of the head or the tag.  The latter is meant to make this
+command a bit more Cogito-user friendly.
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
diff --git a/Documentation/git-pull-script.txt b/Documentation/git-pull-script.txt
--- a/Documentation/git-pull-script.txt
+++ b/Documentation/git-pull-script.txt
@@ -4,17 +4,29 @@ v0.1, May 2005
 
 NAME
 ----
-git-pull-script - Script used by Linus to pull and merge a remote repository
+git-pull-script - Pull and merge from another repository.
 
 
 SYNOPSIS
 --------
-'git-pull-script'
+'git-pull-script' <repository> [ <head> | tag <tag> ]
+
+'git-pull-script' -b <name>
+
 
 DESCRIPTION
 -----------
-This script is used by Linus to pull from a remote repository and perform
-a merge.
+Fetches a named head or a tag from another repository, along
+with the objects necessary to complete that head or tag, and
+merges it into the current repository by running
+'git-resolve-script'.  The head to pull defaults to HEAD if
+unspecified.
+
+When '-b' flag is specified to give a name, not an URL to the
+repository, it reads from .git/branches/<name> to get the
+repository URL, possibly immediately followed by '#' and the
+name of the head or the tag.  The latter is meant to make this
+command a bit more Cogito-user friendly.
 
 
 Author
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -121,6 +121,9 @@ The interrogate commands may create file
 touch the working file set - but in general they don't
 
 
+Synching multiple repositories
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 link:git-clone-script.html[git-clone-script]::
 	Clones a repository into the current repository (user interface)
 
@@ -128,10 +131,14 @@ link:git-clone-pack.html[git-clone-pack]
 	Clones a repository into the current repository (engine
 	for ssh and local transport)
 
-link:git-pull-script.html[git-pull-script]::
+link:git-fetch-script.html[git-pull-script]::
 	Pull from a repote repository via various protocols
 	(user interface).
 
+link:git-pull-script.html[git-pull-script]::
+	Fetch from and merge with a repote repository via
+	various protocols (user interface).
+
 link:git-http-pull.html[git-http-pull]::
 	Downloads a remote GIT repository via HTTP
 
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -810,6 +810,19 @@ pull from:
   course, you will pay the price of more disk usage to hold
   multiple working trees, but disk space is cheap these days.  ]
 
+It is likely that you will be pulling from the same remote
+repository from time to time.  As a short hand, you can store
+the remote repository URL in a file under .git/branches/
+directory, like this:
+
+	mkdir -p .git/branches
+	echo rsync://rsync.kernel.org/pub/scm/git/git.git/ \
+	    >.git/branches/linus
+
+and give "-b" option to "git pull" to use that URL:
+
+	git pull -b linus
+
 
 	Publishing your work
 	--------------------
diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -1,23 +1,47 @@
 #!/bin/sh
 #
-destination=FETCH_HEAD
-
-merge_repo=$1
-merge_name=${2:-HEAD}
-if [ "$2" = "tag" ]; then
-	merge_name="refs/tags/$3"
-	destination="$merge_name"
-fi
 
 . git-sh-setup-script || die "Not a git archive"
 
+destination=FETCH_HEAD
+
+case "$1" in
+-b)
+	# Using Cogito style remote branch information.
+	# The user did not call us via git-pull, but just wants to
+	# fetch from the remote head.
+	name=$2 &&
+	destination=refs/heads/"$name" &&
+	remote_branch=$(cat "$GIT_DIR/branches/$name") ||
+	die "cannot read remote branch $name."
+	case "$remote_branch" in
+	*'#'*)
+		merge_repo=$(expr "$remote_branch" : '\(.*\)#') &&
+		merge_name=$(expr "$remote_branch" : '.*#\(.*\)$')
+		;;
+        *)
+		merge_repo="$remote_branch" &&
+		merge_name=HEAD
+		;;
+	esac
+	;;
+*)
+	merge_repo=$1
+	merge_name=${2:-HEAD}
+	if [ "$2" = "tag" ]; then
+		merge_name="refs/tags/$3"
+		destination="$merge_name"
+	fi
+	;;
+esac
+
 TMP_HEAD="$GIT_DIR/TMP_HEAD"
 
 case "$merge_repo" in
 http://*)
 	head=$(wget -q -O - "$merge_repo/$merge_name") || exit 1
-	echo Fetching $head using http
-	git-http-pull -v -a "$head" "$merge_repo/"
+	echo Fetching $merge_name using http
+	git-http-pull -v -a "$merge_name" "$merge_repo/"
 	;;
 rsync://*)
 	rsync -L "$merge_repo/$merge_name" "$TMP_HEAD" || exit 1
diff --git a/git-pull-script b/git-pull-script
--- a/git-pull-script
+++ b/git-pull-script
@@ -2,20 +2,48 @@
 #
 . git-sh-setup-script || die "Not a git archive"
 
-merge_repo=$1
+usage () {
+    echo >&2 "* git pull <repo> [ <head> | tag <tag> ]"
+    echo >&2 "* git pull -b <name>"
+    exit 1
+}
 
-merge_name=$(echo "$1" | sed 's:\.git/*$::')
-merge_head=HEAD
-type=head
-if [ "$2" = "tag" ]; then
-   type=tag
-   shift
-fi
-if [ "$2" ]
-then
-   merge_name="$type '$2' of $merge_name"
-   merge_head="refs/${type}s/$2"
-fi
+case "$1" in
+-b)
+	# Use Cogito style remote branch information.
+	name=$2 &&
+	remote_branch=$(cat "$GIT_DIR/branches/$name") ||
+	die "cannot read remote branch $name."
+	case "$remote_branch" in
+	*'#'*)
+		merge_repo=$(expr "$remote_branch" : '\(.*\)#') &&
+		merge_head=$(expr "$remote_branch" : '.*#\(.*\)$') &&
+		merge_name=$(echo "$merge_repo" | sed 's:\.git/*$::') &&
+		merge_name="'$merge_head' of $merge_name"
+		;;
+        *)
+		merge_head=HEAD &&
+		merge_repo="$remote_branch" &&
+		merge_name=$(echo "$merge_repo" | sed 's:\.git/*$::')
+		;;
+	esac
+	;;
+*)
+	merge_repo=$1
+	merge_name=$(echo "$merge_repo" | sed 's:\.git/*$::')
+	merge_head=HEAD
+	type=head
+	if [ "$2" = "tag" ]; then
+		type=tag
+		shift
+	fi
+	if [ "$2" ]
+	then
+		merge_name="$type '$2' of $merge_name"
+		merge_head="refs/${type}s/$2"
+	fi
+	;;
+esac
 
 git-fetch-script "$merge_repo" "$merge_head" || exit 1
 
