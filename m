From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/2] git-submodule: add support for --merge.
Date: Wed, 03 Jun 2009 00:59:12 +0200
Message-ID: <1243983552-24810-3-git-send-email-johan@herland.net>
References: <7v63fgpwyd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	apenwarr@gmail.com, peter.hutterer@who-t.net,
	markus.heidelberg@web.de, Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 03 01:01:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBczL-0000BG-MU
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 01:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800AbZFBXB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 19:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753588AbZFBXB0
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 19:01:26 -0400
Received: from mx.getmail.no ([84.208.15.66]:64842 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753068AbZFBXBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 19:01:25 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KKM000V4VYEA000@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 03 Jun 2009 01:01:26 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KKM00EMTVVXLQ80@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 03 Jun 2009 01:01:21 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.6.2.224626
X-Mailer: git-send-email 1.6.3.rc0.1.gf800
In-reply-to: <7v63fgpwyd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120558>

'git submodule update --merge' merges the commit referenced by the
superproject into your local branch, instead of checking it out on
a detached HEAD.

As evidenced by the addition of "git submodule update --rebase", it
is useful to provide alternatives to the default 'checkout' behaviour
of "git submodule update". One such alternative is, when updating a
submodule to a new commit, to merge that commit into the current
local branch in that submodule. This is useful in workflows where
you want to update your submodule from its upstream, but you cannot
use --rebase, because you have downstream people working on top of
your submodule branch, and you don't want to disrupt their work.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-submodule.txt |   17 +++++++++--
 Documentation/gitmodules.txt    |    6 ++-
 git-submodule.sh                |   11 ++++++-
 t/t7406-submodule-update.sh     |   60 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index cd8e861..1cbb181 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	      [--reference <repository>] [--] <repository> <path>
 'git submodule' [--quiet] status [--cached] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
+'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase|--merge]
 	      [--reference <repository>] [--] [<path>...]
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach <command>
@@ -115,8 +115,9 @@ init::
 update::
 	Update the registered submodules, i.e. clone missing submodules and
 	checkout the commit specified in the index of the containing repository.
-	This will make the submodules HEAD be detached unless '--rebase' is
-	specified or the key `submodule.$name.update` is set to	`rebase`.
+	This will make the submodules HEAD be detached unless '--rebase' or
+	'--merge' is specified or the key `submodule.$name.update` is set to
+	`rebase` or `merge`.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
@@ -189,6 +190,16 @@ OPTIONS
 	If the key `submodule.$name.update` is set to `rebase`, this option is
 	implicit.
 
+--merge::
+	This option is only valid for the update command.
+	Merge the commit recorded in the superproject into the current branch
+	of the submodule. If this option is given, the submodule's HEAD will
+	not be detached. If a merge failure prevents this process, you will
+	have to resolve the resulting conflicts within the submodule with the
+	usual conflict resolution tools.
+	If the key `submodule.$name.update` is set to `merge`, this option is
+	implicit.
+
 --reference <repository>::
 	This option is only valid for add and update commands.  These
 	commands sometimes need to clone a remote repository. In this case,
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 1b67f0a..5daf750 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -35,9 +35,11 @@ submodule.<name>.update::
 	If 'checkout' (the default), the new commit specified in the
 	superproject will be checked out in the submodule on a detached HEAD.
 	If 'rebase', the current branch of the submodule will be rebased onto
-	the commit specified in the superproject.
+	the commit specified in the superproject. If 'merge', the commit
+	specified in the superproject will be merged into the current branch
+	in the submodule.
 	This config option is overridden if 'git submodule update' is given
-	the '--rebase' option.
+	the '--merge' or '--rebase' options.
 
 
 EXAMPLES
diff --git a/git-submodule.sh b/git-submodule.sh
index 19a3a84..2a1e73c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli
 
 USAGE="[--quiet] [--cached] \
-[add [-b branch] <repo> <path>]|[status|init|update [-i|--init] [-N|--no-fetch]|summary [-n|--summary-limit <n>] [<commit>]] \
+[add [-b branch] <repo> <path>]|[status|init|update [-i|--init] [-N|--no-fetch] [--rebase|--merge]|summary [-n|--summary-limit <n>] [<commit>]] \
 [--] [<path>...]|[foreach <command>]|[sync [--] [<path>...]]"
 OPTIONS_SPEC=
 . git-sh-setup
@@ -347,6 +347,10 @@ cmd_update()
 			shift
 			update="rebase"
 			;;
+		-m|--merge)
+			shift
+			update="merge"
+			;;
 		--reference)
 			case "$2" in '') usage ;; esac
 			reference="--reference=$2"
@@ -426,6 +430,11 @@ cmd_update()
 				action="rebase"
 				msg="rebased onto"
 				;;
+			merge)
+				command="git merge"
+				action="merge"
+				msg="merged in"
+				;;
 			*)
 				command="git checkout $force -q"
 				action="checkout"
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 0773fe4..2d33d9e 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -6,7 +6,7 @@
 test_description='Test updating submodules
 
 This test verifies that "git submodule update" detaches the HEAD of the
-submodule and "git submodule update --rebase" does not detach the HEAD.
+submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
 '
 
 . ./test-lib.sh
@@ -76,6 +76,20 @@ test_expect_success 'submodule update --rebase staying on master' '
 	)
 '
 
+test_expect_success 'submodule update --merge staying on master' '
+	(cd super/submodule &&
+	  git reset --hard HEAD~1
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update --merge submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
 test_expect_success 'submodule update - rebase in .git/config' '
 	(cd super &&
 	 git config submodule.submodule.update rebase
@@ -110,6 +124,40 @@ test_expect_success 'submodule update - checkout in .git/config but --rebase giv
 	)
 '
 
+test_expect_success 'submodule update - merge in .git/config' '
+	(cd super &&
+	 git config submodule.submodule.update merge
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
+test_expect_success 'submodule update - checkout in .git/config but --merge given' '
+	(cd super &&
+	 git config submodule.submodule.update checkout
+	) &&
+	(cd super/submodule &&
+	  git reset --hard HEAD~1
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update --merge submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
 test_expect_success 'submodule update - checkout in .git/config' '
 	(cd super &&
 	 git config submodule.submodule.update checkout
@@ -137,4 +185,14 @@ test_expect_success 'submodule init picks up rebase' '
 	)
 '
 
+test_expect_success 'submodule init picks up merge' '
+	(cd super &&
+	 git config submodule.merging.url git://non-existing/git &&
+	 git config submodule.merging.path does-not-matter &&
+	 git config submodule.merging.update merge &&
+	 git submodule init merging &&
+	 test "merge" = $(git config submodule.merging.update)
+	)
+'
+
 test_done
-- 
1.6.3.rc0.1.gf800
