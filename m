From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH/RESEND] git-submodule: add support for --rebase.
Date: Fri, 24 Apr 2009 09:06:38 +1000
Message-ID: <20090423230637.GE2282@dingo.bne.redhat.com>
References: <20090419233051.GA17946@dingo.bne.redhat.com> <alpine.DEB.1.00.0904201152360.6955@intel-tinevez-2-302> <20090421074540.GA7885@dingo.redhat.com> <alpine.DEB.1.00.0904211047311.10279@pacific.mpi-cbg.de> <20090423034709.GA22244@dingo.bne.redhat.com> <alpine.DEB.1.00.0904231119160.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 24 01:09:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx82O-0005JD-48
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 01:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325AbZDWXHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 19:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755598AbZDWXHW
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 19:07:22 -0400
Received: from ipx-119-252-190-80.ipxserver.de ([80.190.252.119]:44519 "EHLO
	ipx10616.ipxserver.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754524AbZDWXHU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 19:07:20 -0400
Received: from whot by ipx10616.ipxserver.de with local (Exim 4.63)
	(envelope-from <peter.hutterer@who-t.net>)
	id 1Lx80f-0007iu-CV; Fri, 24 Apr 2009 01:07:14 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904231119160.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117394>

'git submodule update --rebase' rebases your local branch on top of what
would have been checked out to a detached HEAD otherwise.

In some cases, detaching the HEAD when updating a submodule complicates
the workflow to commit to this submodule (checkout master, rebase, then
commit).  For submodules that require frequent updates but infrequent
(if any) commits, a rebase can be executed directly by the git-submodule
command, ensuring that the submodules stay on their respective branches.

git-config key: submodule.$name.rebase (bool)

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

> With this squashed in, I actually would not be too opposed to put this 
> into 1.6.3, as it _is_ an improvement.
> 
> -- snipsnap --
> [PATCH] To be squashed in
> 
> This does three things:
> 
> - add .gitmodules support for rebase,
> - use --bool for the git config calls for type checking, and
> - rename ambiguous t7404 to t7406.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Squashed in, thank you. One typo fixed in last testcase (does-not-mater ->
does-not-matter).

 Documentation/git-submodule.txt |   14 ++++-
 Documentation/gitmodules.txt    |    3 +
 git-submodule.sh                |   33 ++++++++-
 t/t7406-submodule-update.sh     |  140 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 184 insertions(+), 6 deletions(-)
 create mode 100755 t/t7406-submodule-update.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 3b8df44..0286409 100644
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
+	specified or the key `submodule.$name.rebase` is set to `true`.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
@@ -177,6 +178,15 @@ OPTIONS
 	This option is only valid for the update command.
 	Don't fetch new objects from the remote site.
 
+--rebase::
+	This option is only valid for the update command.
+	Rebase the current branch onto the commit recorded in the
+	superproject. If this option is given, the submodule's HEAD will not
+	be detached. If a a merge failure prevents this process, you will have
+	to resolve these failures with linkgit:git-rebase[1].
+	If the key `submodule.$name.rebase` is set to `true`, this option is
+	implicit.
+
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index d1a17e2..7c22c40 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -30,6 +30,9 @@ submodule.<name>.path::
 submodule.<name>.url::
 	Defines an url from where the submodule repository can be cloned.
 
+submodule.<name>.rebase::
+	Defines that the submodule should be rebased by default.
+
 
 EXAMPLES
 --------
diff --git a/git-submodule.sh b/git-submodule.sh
index 7c2e060..b7c9bdc 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -17,6 +17,7 @@ branch=
 quiet=
 cached=
 nofetch=
+rebase=
 
 #
 # print stuff on stdout unless -q was specified
@@ -287,6 +288,11 @@ cmd_init()
 		git config submodule."$name".url "$url" ||
 		die "Failed to register url for submodule path '$path'"
 
+		test true != "$(git config -f .gitmodules --bool \
+			submodule."$name".rebase)" ||
+		git config submodule."$name".rebase true ||
+		die "Failed to register submodule path '$path' as rebasing"
+
 		say "Submodule '$name' ($url) registered for path '$path'"
 	done
 }
@@ -314,6 +320,10 @@ cmd_update()
 			shift
 			nofetch=1
 			;;
+		-r|--rebase)
+			shift
+			rebase=true
+			;;
 		--)
 			shift
 			break
@@ -332,6 +342,7 @@ cmd_update()
 	do
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
+		rebase_module=$(git config --bool submodule."$name".rebase)
 		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
@@ -352,6 +363,11 @@ cmd_update()
 			die "Unable to find current revision in submodule path '$path'"
 		fi
 
+		if test true = "$rebase"
+		then
+			rebase_module=true
+		fi
+
 		if test "$subsha1" != "$sha1"
 		then
 			force=
@@ -367,11 +383,20 @@ cmd_update()
 				die "Unable to fetch in submodule path '$path'"
 			fi
 
-			(unset GIT_DIR; cd "$path" &&
-				  git-checkout $force -q "$sha1") ||
-			die "Unable to checkout '$sha1' in submodule path '$path'"
+			if test true = "$rebase_module"
+			then
+				command="git-rebase"
+				action="rebase"
+				msg="rebased onto"
+			else
+				command="git-checkout $force -q"
+				action="checkout"
+				msg="checked out"
+			fi
 
-			say "Submodule path '$path': checked out '$sha1'"
+			(unset GIT_DIR; cd "$path" && $command "$sha1") ||
+			die "Unable to $action '$sha1' in submodule path '$path'"
+			say "Submodule path '$path': $msg '$sha1'"
 		fi
 	done
 }
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
new file mode 100755
index 0000000..3442c05
--- /dev/null
+++ b/t/t7406-submodule-update.sh
@@ -0,0 +1,140 @@
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
+test_expect_success 'submodule update - rebase true in .git/config' '
+	(cd super &&
+	 git config submodule.submodule.rebase true
+	) &&
+	(cd super/submodule &&
+	  git reset --hard HEAD~1
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
+test_expect_success 'submodule update - rebase false in .git/config but --rebase given' '
+	(cd super &&
+	 git config submodule.submodule.rebase false
+	) &&
+	(cd super/submodule &&
+	  git reset --hard HEAD~1
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
+test_expect_success 'submodule update - rebase false in .git/config' '
+	(cd super &&
+	 git config submodule.submodule.rebase false
+	) &&
+	(cd super/submodule &&
+	  git reset --hard HEAD^
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
+test_expect_success 'submodule init picks up rebase' '
+	(cd super &&
+	 git config submodule.rebasing.url git://non-existing/git &&
+	 git config submodule.rebasing.path does-not-matter &&
+	 git config submodule.rebasing.rebase true &&
+	 git submodule init rebasing &&
+	 test true = $(git config --bool submodule.rebasing.rebase)
+	)
+'
+
+test_done
-- 
1.6.3.rc1.2.gfa66a
