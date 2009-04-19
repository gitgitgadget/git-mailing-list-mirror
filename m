From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH/RESEND] git-submodule: add support for --rebase.
Date: Mon, 20 Apr 2009 09:31:00 +1000
Message-ID: <20090419233051.GA17946@dingo.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 01:33:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvgVa-0003BY-Hk
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 01:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbZDSXbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 19:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbZDSXbf
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 19:31:35 -0400
Received: from ipx-119-252-190-80.ipxserver.de ([80.190.252.119]:41982 "EHLO
	ipx10616.ipxserver.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750966AbZDSXbe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 19:31:34 -0400
Received: from whot by ipx10616.ipxserver.de with local (Exim 4.63)
	(envelope-from <peter.hutterer@who-t.net>)
	id 1LvgTx-0007fp-W3; Mon, 20 Apr 2009 01:31:30 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116918>

'git submodule update --rebase' rebases your local branch on top of what would
have been checked out to a detached HEAD otherwise.

In some cases, detaching the HEAD when updating a submodule complicates the
workflow to commit to this submodule (checkout master, rebase, then commit).
For submodules that require frequent updates but infrequent (if any) commits,
a rebase can be executed directly by the git-submodule command, ensuring that
the submodules stay on their respective branches.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---

Previous thread:
http://thread.gmane.org/gmane.comp.version-control.git/115950/focus=116076

Original thread died after discussions about the wording in the man page, last
reviewer comment being:
"You can really rebase only onto a commit.  And the index is not a commit, so
I do not like the wording (not even in the rebase man page).

But let's see what other reviewers say... :-)"

I'm still unsure about whether to change the wording (it currently uses the
same terms as git-rebase and the rest of the git-submodule man page). Please
let me know what to do to get this patch done.

 Documentation/git-submodule.txt |   12 +++++-
 git-submodule.sh                |   22 +++++++++--
 t/t7404-submodule-update.sh     |   79 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 6 deletions(-)
 create mode 100755 t/t7404-submodule-update.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 3b8df44..7e0dcb1 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git submodule' [--quiet] add [-b branch] [--] <repository> <path>
 'git submodule' [--quiet] status [--cached] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--] [<path>...]
+'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase] [--] [<path>...]
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach <command>
 'git submodule' [--quiet] sync [--] [<path>...]
@@ -113,7 +113,8 @@ init::
 update::
 	Update the registered submodules, i.e. clone missing submodules and
 	checkout the commit specified in the index of the containing repository.
-	This will make the submodules HEAD be detached.
+	This will make the submodules HEAD be detached unless '--rebase' is
+	specified.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
@@ -177,6 +178,13 @@ OPTIONS
 	This option is only valid for the update command.
 	Don't fetch new objects from the remote site.
 
+--rebase::
+	This option is only valid for the update command.
+	Rebase the current branch onto the index of the containing repository
+	instead of detaching the HEAD.
+	If a a merge failure prevents this process, you will have to resolve
+	these failures with linkgit:git-rebase[1].
+
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
diff --git a/git-submodule.sh b/git-submodule.sh
index 7c2e060..e2d40ee 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -17,6 +17,7 @@ branch=
 quiet=
 cached=
 nofetch=
+rebase=
 
 #
 # print stuff on stdout unless -q was specified
@@ -314,6 +315,10 @@ cmd_update()
 			shift
 			nofetch=1
 			;;
+		-r|--rebase)
+			shift
+			rebase=1
+			;;
 		--)
 			shift
 			break
@@ -367,11 +372,20 @@ cmd_update()
 				die "Unable to fetch in submodule path '$path'"
 			fi
 
-			(unset GIT_DIR; cd "$path" &&
-				  git-checkout $force -q "$sha1") ||
-			die "Unable to checkout '$sha1' in submodule path '$path'"
+			if test -z "$rebase"
+			then
+				command="git-checkout $force -q"
+				action="checkout"
+				msg="checked out"
+			else
+				command="git-rebase"
+				action="rebase"
+				msg="rebased onto"
+			fi
 
-			say "Submodule path '$path': checked out '$sha1'"
+			(unset GIT_DIR; cd "$path" && $command "$sha1") ||
+			die "Unable to $action '$sha1' in submodule path '$path'"
+			say "Submodule path '$path': $msg '$sha1'"
 		fi
 	done
 }
diff --git a/t/t7404-submodule-update.sh b/t/t7404-submodule-update.sh
new file mode 100755
index 0000000..20cc093
--- /dev/null
+++ b/t/t7404-submodule-update.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Red Hat, Inc.
+#
+
+test_description='Test updating submodules
+
+This test verifies that "git submodule update" detaches the HEAD of the
+submodule and "git submodule update --rebase" does not detach the HEAD.
+'
+
+. ./test-lib.sh
+
+
+compare_head()
+{
+    sha_master=`git-rev-list --max-count=1 master`
+    sha_head=`git-rev-list --max-count=1 HEAD`
+
+    test "$sha_master" = "$sha_head"
+}
+
+
+test_expect_success 'setup a submodule tree' '
+	echo file > file &&
+	git add file &&
+	test_tick &&
+	git commit -m upstream
+	git clone . super &&
+	git clone super submodule &&
+	(cd super &&
+	 git submodule add ../submodule submodule &&
+	 test_tick &&
+	 git commit -m "submodule" &&
+	 git submodule init submodule
+	) &&
+	(cd submodule &&
+	echo "line2" > file &&
+	git add file &&
+	git commit -m "Commit 2"
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  git pull --rebase origin
+	 ) &&
+	 git add submodule &&
+	 git commit -m "submodule update"
+	)
+'
+
+test_expect_success 'submodule update detaching the HEAD ' '
+	(cd super/submodule &&
+	 git reset --hard HEAD~1
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update submodule &&
+	 cd submodule &&
+	 ! compare_head
+	)
+'
+
+test_expect_success 'submodule update --rebase staying on master' '
+	(cd super/submodule &&
+	  git checkout master
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update --rebase submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
+test_done
-- 
1.6.2.2.447.g4afa7
