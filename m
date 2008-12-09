From: Fabian Franz <git@fabian-franz.de>
Subject: [PATCH] submodule: Allow tracking of the newest revision of a branch in a submodule
Date: Mon,  8 Dec 2008 22:57:41 -0200
Message-ID: <1228784261-18637-1-git-send-email-git@fabian-franz.de>
Cc: hjemli@gmail.com, Fabian Franz <git@fabian-franz.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 02:08:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9r57-000548-Fl
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 02:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbYLIBGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 20:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753892AbYLIBGv
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 20:06:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:57984 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753860AbYLIBGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 20:06:50 -0500
Received: (qmail invoked by alias); 09 Dec 2008 01:06:48 -0000
Received: from unknown (EHLO localhost.localdomain) [200.142.84.36]
  by mail.gmx.net (mp004) with SMTP; 09 Dec 2008 02:06:48 +0100
X-Authenticated: #590723
X-Provags-ID: V01U2FsdGVkX18jOoMyp5Ij0iaMXvekNZCqbZWId2p6ybf1M8Ak6E
	JhGuCq/x+cPaEW
X-Mailer: git-send-email 1.6.1.rc2.1.g363fe
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102592>

Submodules currently only allow tracking a specific revision
and each update in a submodule leads to a new commit in the
master repository. However some users may want to always track
the newest revision of a specific (named) tag or branch or HEAD.
For example the user might want to track a staging branch in all
submodules.

To allow this the "--track|-t <branch>" parameter was added to
git-submodule.sh, which is added to .gitmodules config file as
well as "track" parameter. This creates a new local branch on
checkout, which is tracking the remote branch in case the local
branch does not yet exist.

Technically the gitlink code was changed to read .git/HEAD.gitlink
if it exists instead of the normal HEAD. If you add 0000* as sha1
sum to .git/HEAD.gitlink the submodule code will always fetch HEAD.

The submodule code is creating this HEAD.gitlink file with 0000* on
"init" and "add".

Signed-off-by: Fabian Franz <git@fabian-franz.de>
---
 Documentation/git-submodule.txt |   10 +++++++++-
 git-submodule.sh                |   31 ++++++++++++++++++++++++++++++-
 refs.c                          |    6 ++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index babaa9b..9c29678 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,7 +9,7 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] add [-b branch] [--] <repository> <path>
+'git submodule' [--quiet] add [-b branch] [-t|--track <branch>] [--] <repository> <path>
 'git submodule' [--quiet] status [--cached] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [--] [<path>...]
@@ -118,6 +118,10 @@ update::
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
 submodule with the --init option.
++
+If you used --track or set the "track" option in .gitmodules this will
+automatically pull the newest updates from remote instead of tracking a
+specific revision.
 
 summary::
 	Show commit summary between the given commit (defaults to HEAD) and
@@ -159,6 +163,10 @@ OPTIONS
 --branch::
 	Branch of repository to add as submodule.
 
+-t::
+--track::
+	Branch/Tag/HEAD of repository to track in a submodule.
+
 --cached::
 	This option is only valid for status and summary commands.  These
 	commands typically use the commit found in the submodule HEAD, but
diff --git a/git-submodule.sh b/git-submodule.sh
index 2f47e06..9468d81 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli
 
 USAGE="[--quiet] [--cached] \
-[add <repo> [-b branch] <path>]|[status|init|update [-i|--init]|summary [-n|--summary-limit <n>] [<commit>]] \
+[add <repo> [-b branch] [--track|-t <branch>] <path>]|[status|init|update [-i|--init]|summary [-n|--summary-limit <n>] [<commit>]] \
 [--] [<path>...]|[foreach <command>]|[sync [--] [<path>...]]"
 OPTIONS_SPEC=
 . git-sh-setup
@@ -16,6 +16,7 @@ command=
 branch=
 quiet=
 cached=
+track=
 
 #
 # print stuff on stdout unless -q was specified
@@ -130,6 +131,11 @@ cmd_add()
 		-q|--quiet)
 			quiet=1
 			;;
+		-t|--track)
+			case "$2" in '') usage ;; esac
+			track=$2
+			shift
+			;;
 		--)
 			shift
 			break
@@ -197,12 +203,14 @@ cmd_add()
 		(unset GIT_DIR; cd "$path" && git checkout -f -q ${branch:+-b "$branch" "origin/$branch"}) ||
 		die "Unable to checkout submodule '$path'"
 	fi
+	[ -n "$track" ] && echo "0000000000000000000000000000000000000000" > $path/.git/HEAD.gitlink
 
 	git add "$path" ||
 	die "Failed to add submodule '$path'"
 
 	git config -f .gitmodules submodule."$path".path "$path" &&
 	git config -f .gitmodules submodule."$path".url "$repo" &&
+	git config -f .gitmodules submodule."$path".track "$track" &&
 	git add .gitmodules ||
 	die "Failed to register submodule '$path'"
 }
@@ -327,10 +335,14 @@ cmd_update()
 			say "Maybe you want to use 'update --init'?"
 			continue
 		fi
+		track=$(git config -f .gitmodules submodule."$name".track)
 
 		if ! test -d "$path"/.git -o -f "$path"/.git
 		then
 			module_clone "$path" "$url" || exit
+
+			[ -n "$track" ] && echo "0000000000000000000000000000000000000000" > $path/.git/HEAD.gitlink
+
 			subsha1=
 		else
 			subsha1=$(unset GIT_DIR; cd "$path" &&
@@ -345,11 +357,28 @@ cmd_update()
 			then
 				force="-f"
 			fi
+			pull=
+			if [ "$sha1" = "0000000000000000000000000000000000000000" ]
+			then
+				[ -z "$track" ] && track="HEAD"
+				# if the local branch does not yet exist, create it
+				( unset GIT_DIR; cd "$path"; git-show-ref --heads --tags -q "$track" || git branch --track "$track" "origin/$track" )
+				sha1="$track"
+				pull=1
+			fi
+
 			(unset GIT_DIR; cd "$path" && git-fetch &&
 				git-checkout $force -q "$sha1") ||
 			die "Unable to checkout '$sha1' in submodule path '$path'"
 
 			say "Submodule path '$path': checked out '$sha1'"
+
+			if [ "$pull" = "1" ]
+			then
+				# Now pull new updates from origin
+				( unset GIT_DIR; cd "$path"; git-pull )
+			fi
+
 		fi
 	done
 }
diff --git a/refs.c b/refs.c
index 33ced65..8246023 100644
--- a/refs.c
+++ b/refs.c
@@ -385,6 +385,12 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *re
 	}
 	gitdir[len] = '/';
 	gitdir[++len] = '\0';
+
+	// Do not update submodule if HEAD.gitlink exists
+	retval = resolve_gitlink_ref_recursive(gitdir, len, "HEAD.gitlink", result, 0);
+	if (retval == 0)
+		return retval;
+
 	retval = resolve_gitlink_ref_recursive(gitdir, len, refname, result, 0);
 	free(gitdir);
 	return retval;
-- 
1.6.1.rc2.1.g363fe
