From: Fabian Franz <git@fabian-franz.de>
Subject: [PATCH v3] submodule: Allow tracking of the newest revision of a branch in a submodule
Date: Thu, 11 Dec 2008 13:39:42 -0200
Message-ID: <1229009982-2701-1-git-send-email-git@fabian-franz.de>
Cc: hjemli@gmail.com, j.sixt@viscovery.net,
	Fabian Franz <git@fabian-franz.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 16:51:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAnoN-0002Cw-Pd
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 16:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711AbYLKPta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 10:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755844AbYLKPta
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 10:49:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:53479 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755669AbYLKPt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 10:49:29 -0500
Received: (qmail invoked by alias); 11 Dec 2008 15:49:26 -0000
Received: from unknown (EHLO localhost.localdomain) [200.142.84.36]
  by mail.gmx.net (mp056) with SMTP; 11 Dec 2008 16:49:26 +0100
X-Authenticated: #590723
X-Provags-ID: V01U2FsdGVkX1+Y0VwQnRyY9SMLUCLuc61XCWLUmKhI/8x9VblL1y
	Ita2QwUcP5qG+m
X-Mailer: git-send-email 1.6.1.rc2.1.g16634
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102801>

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

Technically the gitlink code was changed to always compare
successful (so no changes) in case the sha1 is null. In that
case no new commit is created when there are changes in the
submodule.

The submodule code is adding the file with 0000* on
"add".

Signed-off-by: Fabian Franz <git@fabian-franz.de>
---
>
>Fabian Franz schrieb:
>> Submodules currently only allow tracking a specific revision
>> and each update in a submodule leads to a new commit in the
>> master repository. However some users may want to always track
>> the newest revision of a specific (named) tag or branch or HEAD.
>> For example the user might want to track a staging branch in all
>> submodules.
>
>Personally, I don't particularly like this feature (but then, nobody
>forces me to use it ;) In which situation do you need this?

I have a development workflow in my company where we are independently
working on many components. And for some things I just always want to 
have the newest revision without having to commit twice always.

>
>By tieing a project commit to a particular submodule commit the committer
>gives the guarantee: "I've tested this with this module version, and it
>works; all is ok." With this new feature, this guarantee vanishes, because
>the committer has no control over which version of the module will
>ultimately be used; it could be newer or it could be older.

I like this and because of that the --branch is optional. I also like that so much, that we have decided against Google Repo.

However I have both cases: Stable development, where I need one special version and "wild" development, where I always want the newest published one.
>
>I've reviewed the patch just from a shell code writer's point of view.

Okay, I added your suggestions.

Thanks for your feedback.

Best Wishes,

Fabian

 Documentation/git-submodule.txt |   10 +++++++++-
 git-submodule.sh                |   35 +++++++++++++++++++++++++++++++++--
 read-cache.c                    |    5 +++++
 3 files changed, 47 insertions(+), 3 deletions(-)

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
index 2f47e06..16df528 100755
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
+	test -n "$track" && printf '160000 0000000000000000000000000000000000000000\t%s\n' "$path" | git update-index --index-info
 
 	git add "$path" ||
 	die "Failed to add submodule '$path'"
 
 	git config -f .gitmodules submodule."$path".path "$path" &&
 	git config -f .gitmodules submodule."$path".url "$repo" &&
+	git config -f .gitmodules submodule."$path".track "$track" &&
 	git add .gitmodules ||
 	die "Failed to register submodule '$path'"
 }
@@ -277,6 +285,10 @@ cmd_init()
 		git config submodule."$name".url "$url" ||
 		die "Failed to register url for submodule path '$path'"
 
+		track=$(git config -f .gitmodules submodule."$name".track)
+		git config submodule."$name".track "$track" ||
+		die "Failed to register track for submodule path '$path'"
+
 		say "Submodule '$name' ($url) registered for path '$path'"
 	done
 }
@@ -345,11 +357,29 @@ cmd_update()
 			then
 				force="-f"
 			fi
+			pull=
+			if [ "$sha1" = "0000000000000000000000000000000000000000" ]
+			then
+				track=$(git config submodule."$name".track)
+				: ${track:="master"}
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
+				( unset GIT_DIR; cd "$path"; git-pull ) || die "Unable to pull in submodule path '$path'"
+			fi
+
 		fi
 	done
 }
@@ -596,7 +626,8 @@ cmd_status()
 		set_name_rev "$path" "$sha1"
 		if git diff-files --quiet -- "$path"
 		then
-			say " $sha1 $path$revname"
+			track=$(git config submodule."$name".track)
+			say " $sha1 $path$revname${track:+ (tracking "$track")}"
 		else
 			if test -z "$cached"
 			then
diff --git a/read-cache.c b/read-cache.c
index 8579663..0c14b68 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -137,6 +137,11 @@ static int ce_compare_gitlink(struct cache_entry *ce)
 	 */
 	if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
 		return 0;
+
+	// To be able to track newest revision
+	if (is_null_sha1(ce->sha1))
+		return 0;
+
 	return hashcmp(sha1, ce->sha1);
 }
 
-- 
1.5.3.6
