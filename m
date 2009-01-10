From: Fabian Franz <git@fabian-franz.de>
Subject: [PATCH v4] submodule: allow tracking of the newest revision of a branch in a submodule
Date: Sat, 10 Jan 2009 00:10:06 -0200
Message-ID: <1231553410-7541-1-git-send-email-git@fabian-franz.de>
Cc: j.sixt@viscovery.net, hjemli@gmail.com, gitster@pobox.com,
	Fabian Franz <git@fabian-franz.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 03:27:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLTZ6-0000aO-Ib
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 03:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbZAJCZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 21:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbZAJCZj
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 21:25:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:56249 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751334AbZAJCZi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 21:25:38 -0500
Received: (qmail invoked by alias); 10 Jan 2009 02:25:35 -0000
Received: from unknown (EHLO localhost.localdomain) [200.142.84.36]
  by mail.gmx.net (mp048) with SMTP; 10 Jan 2009 03:25:35 +0100
X-Authenticated: #590723
X-Provags-ID: V01U2FsdGVkX1/utA1HyvTu7ETiS6PrrSj9GY4EKAugdZwX5Jirl4
	sR0k14iiQ0BkoE
X-Mailer: git-send-email 1.6.1.81.g21235
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105065>

Submodules currently only allow tracking a specific revision
and each update in a submodule leads to a new commit in the
master repository. However some users may want to always track
the newest revision of a specific (named) tag or branch or HEAD.
For example the user might want to track a staging branch in all
submodules.

To allow this the "--track|-t <branch>" parameter was added to
git-submodule.sh, which is added to .gitmodules config file as
well as "track" parameter.

Signed-off-by: Fabian Franz <git@fabian-franz.de>
---

This patch now uses the --assume-unchanged approach to be able to track any
revision in the submodule.

It adresses the issues that were in the comments for the previous patches.

And it does even more, it consists of 5 patches:

(1) allow tracking of the newest revision of a branch in a submodule
----------------------------------------------------------------

Is just handling tracked submodules the same way as if the sha1 sum
was directly in the index (i.e. detached head, checkout by sha1 id)
only that the information comes from the track parameter.
Here one can either track local branches like master or remote branches
via track = origin/master or anything else that is a pathspec. 
(like: refs/remotes/origin/master)

(2) add --no-fetch parameter to update command
----------------------------------------------
 
Junio commented that it was bad that the submodule update needed a
online connection to update. This was true even before the "tracking"
patch and for normal operation can update --no-fetch be useful as well.
This was implemented by first fetching and then checking out instead
of doing it in one step.

(3) add --use-gitmodules parameter to update command 
----------------------------------------------------

Lars correctly commented that the track parameter should be read from
.git/config and also added when init is used.

However there _are_ uses for directly reading .gitmodules and such
not using .git/config for the track parameter.

Example: I want to quickly change my tree to staging mode to test something:

$ git checkout staging
$ git submodule update -u

Now it can be that: submodule one is at master, submodule 2 at staging and
submodule3 at tagXYZ and all this was recorded in .gitmodules, which is more powerful than git submodule foreach "git checkout staging".

(4) add +<branch> syntax for track to allow automatic pulling.
--------------------------------------------------------------

As I inititially already tried, I want some branches that are automatically
pulling when I update the submodules, so I can use the submodule mechanism
to update my tree with updates, but still keep my head attached to my branch.

Syntax for the track parameter is here: +<branchname>

And it does checkout or create branch based on the origin and then do a
git-pull.

Of course conflicts arising need to be fixed manually like normal, but that
is okay, as the person adding that to .git/config or .gitmodules knows what
he/she is doing.

(5) add --recursive parameter to update command
-----------------------------------------------

I just need it. We have a fairly complex setup in the company I work for
and now that we are migrating to git, we find that we have a complex software
inside already one git repository.

And this software is going to use git submodules as well for tracking vendor
dependencies, but this can't (policy) be added to master repository as its
an component by itself.

Anyway recursive operation is lots of fun :).

Example:

$ git submodule update -r audio/
Entering submodule path 'audio/software/'
Submodule path 'dependencies/vendor1': checked out 
'8b3b8ebca95d5a7e09760916ae38e4fe494ad2a2'
Leaving submodule path 'audio/software/'

And we have more software (X11) that can have submodules
inside of submodules.

So, that is all and it works perfect for me and is suited to our
needs.

Let me know, what you think.

Best Wishes,

Fabian
        
 Documentation/git-submodule.txt |   10 +++++-
 git-submodule.sh                |   64 +++++++++++++++++++++++++++++++++++---
 2 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 2f207fb..232697d 100644
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
+If you used --track or set the "track" option this will automatically checkout
+the newest available revision instead of the commit specified in the index of
+the containing repository.
 
 summary::
 	Show commit summary between the given commit (defaults to HEAD) and
@@ -159,6 +163,10 @@ OPTIONS
 --branch::
 	Branch of repository to add as submodule.
 
+-t::
+--track::
+	Branch/Tag/HEAD (pathspec) of repository to track in a submodule.
+
 --cached::
 	This option is only valid for status and summary commands.  These
 	commands typically use the commit found in the submodule HEAD, but
diff --git a/git-submodule.sh b/git-submodule.sh
index 2f47e06..6af3d96 100755
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
@@ -201,8 +207,11 @@ cmd_add()
 	git add "$path" ||
 	die "Failed to add submodule '$path'"
 
+	test -n "$track" && git-update-index --assume-unchanged "$path"
+
 	git config -f .gitmodules submodule."$path".path "$path" &&
 	git config -f .gitmodules submodule."$path".url "$repo" &&
+	git config -f .gitmodules submodule."$path".track "$track" &&
 	git add .gitmodules ||
 	die "Failed to register submodule '$path'"
 }
@@ -277,6 +286,10 @@ cmd_init()
 		git config submodule."$name".url "$url" ||
 		die "Failed to register url for submodule path '$path'"
 
+		track=$(git config -f .gitmodules submodule."$name".track)
+		git config submodule."$name".track "$track" ||
+		die "Failed to register track for submodule path '$path'"
+
 		say "Submodule '$name' ($url) registered for path '$path'"
 	done
 }
@@ -328,6 +341,15 @@ cmd_update()
 			continue
 		fi
 
+		track=$(git config submodule."$name".track)
+		if test -n "$track"
+		then
+			git-update-index --assume-unchanged "$path"
+			sha1="NULL"
+		else
+			git-update-index --no-assume-unchanged "$path"
+		fi
+
 		if ! test -d "$path"/.git -o -f "$path"/.git
 		then
 			module_clone "$path" "$url" || exit
@@ -345,11 +367,42 @@ cmd_update()
 			then
 				force="-f"
 			fi
-			(unset GIT_DIR; cd "$path" && git-fetch &&
-				git-checkout $force -q "$sha1") ||
+
+			# First fetch ...
+
+			(unset GIT_DIR; cd "$path" &&
+				git-fetch) ||
+			die "Unable to fetch in submodule path '$path'"
+
+			if test "$sha1" = "NULL"
+			then
+				: ${track:="HEAD"}
+
+				sha1=$(unset GIT_DIR; cd "$path" &&
+					git-rev-parse --verify --quiet "$track")
+
+				# Only use $origin/$track path if the user
+				# supplied path does not work
+				if test -z "$sha1"
+				then
+					origin=$(unset GIT_DIR; cd "$path" &&
+						get_default_remote) ||
+					die "Unable to get default remote destination in submodule path '$path'."
+					track="$origin/$track"
+
+					sha1=$(unset GIT_DIR; cd "$path" &&
+						git-rev-parse --verify "$track") ||
+					die "Unable to find newest revision of '$track' in submodule path '$path'."
+				fi
+			fi
+
+			# ... then checkout
+
+			(unset GIT_DIR; cd "$path" &&
+				  git-checkout $force -q "$sha1") ||
 			die "Unable to checkout '$sha1' in submodule path '$path'"
 
-			say "Submodule path '$path': checked out '$sha1'"
+			say "Submodule path '$path': checked out '$sha1'${track:+ ($track)}"
 		fi
 	done
 }
@@ -596,7 +649,8 @@ cmd_status()
 		set_name_rev "$path" "$sha1"
 		if git diff-files --quiet -- "$path"
 		then
-			say " $sha1 $path$revname"
+			track=$(git config submodule."$name".track)
+			say " $sha1 $path$revname${track:+ (tracking "$track")}"
 		else
 			if test -z "$cached"
 			then
-- 
1.5.3.6
