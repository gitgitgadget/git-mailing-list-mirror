From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH/RESEND] git-submodule: add support for --rebase.
Date: Tue, 21 Apr 2009 17:45:41 +1000
Message-ID: <20090421074540.GA7885@dingo.redhat.com>
References: <20090419233051.GA17946@dingo.bne.redhat.com> <alpine.DEB.1.00.0904201152360.6955@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 21 09:48:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwAiY-0007Sb-Mj
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 09:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbZDUHqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 03:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbZDUHqW
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 03:46:22 -0400
Received: from ipx-119-252-190-80.ipxserver.de ([80.190.252.119]:36575 "EHLO
	ipx10616.ipxserver.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753093AbZDUHqV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 03:46:21 -0400
Received: from whot by ipx10616.ipxserver.de with local (Exim 4.63)
	(envelope-from <peter.hutterer@who-t.net>)
	id 1LwAgI-0007zg-5S; Tue, 21 Apr 2009 09:46:15 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904201152360.6955@intel-tinevez-2-302>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117099>

On Mon, Apr 20, 2009 at 11:55:54AM +0200, Johannes Schindelin wrote:
> On Mon, 20 Apr 2009, Peter Hutterer wrote:
> 
> > 'git submodule update --rebase' rebases your local branch on top of what would
> 
> This line is so long that it got wrapped in my mail program.  But it is 
> even worse: we would like to show this in an 80-column display with a 
> 4-space indent, so it would be nice if you could rewrap to 76 columns (I 
> even use 72 columns, because it looks nicer).

amended to 72 cols, see below.

> > I'm still unsure about whether to change the wording (it currently uses 
> > the same terms as git-rebase and the rest of the git-submodule man 
> > page). Please let me know what to do to get this patch done.
> 
> AFAIR I gave an alternative wording, am I wrong?

yes, but tbh. I found it a bit confusing. Your suggestion was

       "Instead of detaching the HEAD to the revision committed in the
        superproject, rebase the current branch onto that revision."

How about this one, basically the same but split up in two sentences:

+--rebase::
+	This option is only valid for the update command.
+	Rebase the current branch onto the commit recorded in the
+	superproject. If this option is given, the submodule's HEAD will not
+	be detached. If a a merge failure prevents this process, you will have
+	to resolve these failures with linkgit:git-rebase[1].
+

Cheers,
  Peter


>From f5664840db1193311054eb38c91ec762846cd00c Mon Sep 17 00:00:00 2001
From: Peter Hutterer <peter.hutterer@who-t.net>
Date: Fri, 27 Mar 2009 13:42:42 +1000
Subject: [PATCH] git-submodule: add support for --rebase.

'git submodule update --rebase' rebases your local branch on top of what
would have been checked out to a detached HEAD otherwise.

In some cases, detaching the HEAD when updating a submodule complicates
the workflow to commit to this submodule (checkout master, rebase, then
commit).  For submodules that require frequent updates but infrequent
(if any) commits, a rebase can be executed directly by the git-submodule
command, ensuring that the submodules stay on their respective branches.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 Documentation/git-submodule.txt |   12 +++++-
 git-submodule.sh                |   22 +++++++++--
 t/t7404-submodule-update.sh     |   79 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 6 deletions(-)
 create mode 100755 t/t7404-submodule-update.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 3b8df44..2935cb8 100644
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
+	Rebase the current branch onto the commit recorded in the
+	superproject. If this option is given, the submodule's HEAD will not
+	be detached. If a a merge failure prevents this process, you will have
+	to resolve these failures with linkgit:git-rebase[1].
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
