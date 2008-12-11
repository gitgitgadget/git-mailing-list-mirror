From: Fabian Franz <git@fabian-franz.de>
Subject: [PATCH v2] submodule: Allow tracking of the newest revision of a branch in a submodule
Date: Thu, 11 Dec 2008 11:16:01 -0200
Message-ID: <1229001361-9301-1-git-send-email-git@fabian-franz.de>
Cc: hjemli@gmail.com, Fabian Franz <git@fabian-franz.de>
To: FabianFranz@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 14:27:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAlZF-0000dp-ND
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 14:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940AbYLKNZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 08:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755906AbYLKNZm
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 08:25:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:59649 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755860AbYLKNZl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 08:25:41 -0500
Received: (qmail invoked by alias); 11 Dec 2008 13:25:38 -0000
Received: from unknown (EHLO localhost.localdomain) [200.142.84.36]
  by mail.gmx.net (mp024) with SMTP; 11 Dec 2008 14:25:38 +0100
X-Authenticated: #590723
X-Provags-ID: V01U2FsdGVkX1/c36sXWRjcZ/AAQE5k2qwWP6GHqiMyAPwBNHLMTW
	QMFQEyntG3wMB7
X-Mailer: git-send-email 1.6.1.rc2.1.gc296
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102797>

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

On Tue, Dec 9, 2008 at 01:57, Fabian Franz <git@xxxxxxxxxxxxxxx> wrote:
>> Technically the gitlink code was changed to read .git/HEAD.gitlink
>> if it exists instead of the normal HEAD. If you add 0000* as sha1
>> sum to .git/HEAD.gitlink the submodule code will always fetch HEAD.

>This feels like the porcelain "fooling" the plumbing. How about
>something like this instead:
>This should make the plumbing happy no matter which commit is actually
>checked out in the submodule (not actually tested...). 

Yeah, that works, thank you very much.

>Then, cmd_update() can check if the requested sha1 is all '0' and
>fetch+checkout latest HEAD (or some branch) without playing games with
>.git/HEAD.gitlink.

Okay. I do agree that this solution is much nicer.

>Finally, cmd_add() needs to update the index in the
>containing repository with the magic '0*' sha1 if '--track' is
>specifed. This can be achieved by replacing 'git add $path' with 'echo
>$mode $sha1\t$path | git update-index --index-info'.

>What do you think?

I added that solution and it does work. However I see problems on remove (thought there is no submodule remove so far):

Neither a new git add nor a git rm nor a git-update-index --remove do work afterwards.

This can just be done by doing the above command with some non-null sha1.

>> @@ -327,10 +335,14 @@ cmd_update()
>>                        say "Maybe you want to use 'update --init'?"
>>                        continue
>>                fi
>> +               track=$(git config -f .gitmodules submodule."$name".track)

>I'm pretty certain that we don't want to use info from .gitmodules in
>cmd_update(). Instead, cmd_init() probably should move the info from
>.gitmodules into .git/config and cmd_update() should check the latter.

Okay, I did this, however now I need a flag for init to be able to specify -f or a initalways command shortcut, so I can do in script:

git checkout staging # changes track = staging in .gitmodules
git submodule init -f
git submodule update # changes all branches to staging

Should I add this in a different patch?

Talking about script: Is there a possibility for a checkout hook?

Does something like that exist? Or do I need to add this myself, too?

So my workflow really is:

git checkout master # done long before
[...]
git checkout staging
# => in submodules/client/
# Checked out submodules/client/ staging.
# => in submodules/client/component1/
# Checked out submodules/client/component/1 staging.

So I would like to have this recursively and I think a post checkout hook would be nice for that to achieve.

>Btw: cmd_status() probably also needs some modifications to handle
>this special case.

I added the special case.

Here is the new patch.

What do you think?

Or do we need a track and untrack command for the rm of a submodule to work properly?

Best Wishes,

Fabian

 Documentation/git-submodule.txt |   10 +++++++++-
 git-submodule.sh                |   38 ++++++++++++++++++++++++++++++++++++--
 read-cache.c                    |    5 +++++
 3 files changed, 50 insertions(+), 3 deletions(-)

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
index 2f47e06..f25e744 100755
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
+	[ -n "$track" ] && echo "160000 0000000000000000000000000000000000000000\t$path" | git update-index --index-info
 
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
@@ -327,10 +339,12 @@ cmd_update()
 			say "Maybe you want to use 'update --init'?"
 			continue
 		fi
+		track=$(git config submodule."$name".track)
 
 		if ! test -d "$path"/.git -o -f "$path"/.git
 		then
 			module_clone "$path" "$url" || exit
+
 			subsha1=
 		else
 			subsha1=$(unset GIT_DIR; cd "$path" &&
@@ -345,11 +359,28 @@ cmd_update()
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
@@ -596,7 +627,10 @@ cmd_status()
 		set_name_rev "$path" "$sha1"
 		if git diff-files --quiet -- "$path"
 		then
-			say " $sha1 $path$revname"
+			track=$(git config submodule."$name".track)
+			tracking=
+			[ -n "$track" ] && tracking=" (tracking $track)"
+			say " $sha1 $path$revname$tracking"
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
1.6.1.rc2.1.g4859.dirty
