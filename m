From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [PATCH v3] git-sh-setup: Fix scripts whose PWD is a symlink into a git work-dir
Date: Mon, 15 Dec 2008 09:34:37 -0800
Message-ID: <1229362477-22538-1-git-send-email-marcel@oak.homeunix.org>
References: <7v4p174diu.fsf@gitster.siamese.dyndns.org>
Cc: jnareb@gmail.com, ae@op5.se, j.sixt@viscovery.net,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 18:36:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCHMR-0000ZQ-HA
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 18:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbYLORen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 12:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755028AbYLORen
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 12:34:43 -0500
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:35735 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754846AbYLORem (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Dec 2008 12:34:42 -0500
Received: (qmail 47352 invoked from network); 15 Dec 2008 17:34:41 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@75.61.110.119 with plain)
  by smtp119.sbc.mail.sp1.yahoo.com with SMTP; 15 Dec 2008 17:34:40 -0000
X-YMail-OSG: ZJgfpTMVM1knvmBm3VohBN6p.ljSqd3fRfTALmy_lr.C1phmVdb4Mb7WsCHfK3RS1gIXZjBs8QBVHHjTf69NqARDBMoj0_PViRxhah8tHpO4IwWvLDSIkzpZokfOQIvmURvOl0nwgJB6KFxS6n2lzc1twldDOpNjtjxKjHlYco3DQX3cWhgx4ChlsKEJLg--
X-Yahoo-Newman-Property: ymail-5
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1LCHL4-00024z-2a; Mon, 15 Dec 2008 09:34:38 -0800
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <7v4p174diu.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103188>

I want directories of my working tree to be linked to from various
paths on my filesystem where third-party components expect them, both
in development and production environments.  A build system's install
step could solve this, but I develop scripts and web pages that don't
need to be built.  Git's submodule system could solve this, but we
tend to develop, branch, and test those directories all in unison, so
one big repository feels more natural.  We prefer to edit and commit
on the symlinked paths, not the canonical ones, and in that setting,
"git pull" fails to find the top-level directory of the repository
while other commands work fine.

"git pull" fails because POSIX shells have a notion of current working
directory that is different from getcwd().  The shell stores this path
in PWD.  As a result, "cd ../" can be interpreted differently in a
shell script than chdir("../") in a C program.  The shell interprets
"../" by essentially stripping the last textual path component from
PWD, whereas C chdir() follows the ".." link in the current directory
on the filesystem.  When PWD is a symlink, these are different
destinations.  As a result, Git's C commands find the correct
top-level working tree, and shell scripts do not.

Changes:

* When interpreting a relative upward (../) path in cd_to_toplevel,
  prepend the cwd without symlinks, given by /bin/pwd
* Add tests for cd_to_toplevel and "git pull" in a symlinked
  directory that failed before this fix, plus contrasting scenarios
  that already worked

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---

> > I also removed the "pwd -P" from the unit test.
>
> Hmm, really...?

Ouch.  Removing just one occurrence won't help much, will it.

> > Do you think these test cases should run all the time here?
>
> I'd say so.  Your supporting argument could be "See, push works just
> fine with this layout, but pull doesn't because it is a shell script
> that can be fooled, and this change is to fix the inconsistencies
> between them."

Ok, removed those cases from test_debug and emphasized in the first
paragraph of the commit message that other commands support this kind
of "sideways jumping."

> But whether it is inside test_debug or not, the test should check
> not just the exit status from 'git push' but also check what
> happened to the receiving repository at least to make sure it is
> pushing to the location you are expecting it to.

Ok, I did this by adding an additional file each time and checking the
same path in the other repository.


 git-sh-setup.sh           |   23 ++++++++++++-
 t/t2300-cd-to-toplevel.sh |   37 +++++++++++++++++++++
 t/t5521-pull-symlink.sh   |   78 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+), 2 deletions(-)
 create mode 100755 t/t2300-cd-to-toplevel.sh
 create mode 100755 t/t5521-pull-symlink.sh

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index dbdf209..f07d96b 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -85,8 +85,27 @@ cd_to_toplevel () {
 	cdup=$(git rev-parse --show-cdup)
 	if test ! -z "$cdup"
 	then
-		cd "$cdup" || {
-			echo >&2 "Cannot chdir to $cdup, the toplevel of the working tree"
+		case "$cdup" in
+		/*)
+			# Not quite the same as if we did "cd -P '$cdup'" when
+			# $cdup contains ".." after symlink path components.
+			# Don't fix that case at least until Git switches to
+			# "cd -P" across the board.
+			phys="$cdup"
+			;;
+		..|../*|*/..|*/../*)
+			# Interpret $cdup relative to the physical, not logical, cwd.
+			# Probably /bin/pwd is more portable than passing -P to cd or pwd.
+			phys="$(/bin/pwd)/$cdup"
+			;;
+		*)
+			# There's no "..", so no need to make things absolute.
+			phys="$cdup"
+			;;
+		esac
+
+		cd "$phys" || {
+			echo >&2 "Cannot chdir to $phys, the toplevel of the working tree"
 			exit 1
 		}
 	fi
diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
new file mode 100755
index 0000000..beddb4e
--- /dev/null
+++ b/t/t2300-cd-to-toplevel.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='cd_to_toplevel'
+
+. ./test-lib.sh
+
+test_cd_to_toplevel () {
+	test_expect_success "$2" '
+		(
+			cd '"'$1'"' &&
+			. git-sh-setup &&
+			cd_to_toplevel &&
+			[ "$(/bin/pwd)" = "$TOPLEVEL" ]
+		)
+	'
+}
+
+TOPLEVEL="$(/bin/pwd)/repo"
+mkdir -p repo/sub/dir
+mv .git repo/
+SUBDIRECTORY_OK=1
+
+test_cd_to_toplevel repo 'at physical root'
+
+test_cd_to_toplevel repo/sub/dir 'at physical subdir'
+
+ln -s repo symrepo
+test_cd_to_toplevel symrepo 'at symbolic root'
+
+ln -s repo/sub/dir subdir-link
+test_cd_to_toplevel subdir-link 'at symbolic subdir'
+
+cd repo
+ln -s sub/dir internal-link
+test_cd_to_toplevel internal-link 'at internal symbolic subdir'
+
+test_done
diff --git a/t/t5521-pull-symlink.sh b/t/t5521-pull-symlink.sh
new file mode 100755
index 0000000..5672b51
--- /dev/null
+++ b/t/t5521-pull-symlink.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description='pulling from symlinked subdir'
+
+. ./test-lib.sh
+
+# The scenario we are building:
+#
+#   trash\ directory/
+#     clone-repo/
+#       subdir/
+#         bar
+#     subdir-link -> clone-repo/subdir/
+#
+# The working directory is subdir-link.
+
+mkdir subdir
+echo file >subdir/file
+git add subdir/file
+git commit -q -m file
+git clone -q . clone-repo
+ln -s clone-repo/subdir/ subdir-link
+
+
+# Demonstrate that things work if we just avoid the symlink
+#
+test_expect_success 'pulling from real subdir' '
+	(
+		echo real >subdir/file &&
+		git commit -m real subdir/file &&
+		cd clone-repo/subdir/ &&
+		git pull &&
+		test real = $(cat file)
+	)
+'
+
+# From subdir-link, pulling should work as it does from
+# clone-repo/subdir/.
+#
+# Instead, the error pull gave was:
+#
+#   fatal: 'origin': unable to chdir or not a git archive
+#   fatal: The remote end hung up unexpectedly
+#
+# because git would find the .git/config for the "trash directory"
+# repo, not for the clone-repo repo.  The "trash directory" repo
+# had no entry for origin.  Git found the wrong .git because
+# git rev-parse --show-cdup printed a path relative to
+# clone-repo/subdir/, not subdir-link/.  Git rev-parse --show-cdup
+# used the correct .git, but when the git pull shell script did
+# "cd `git rev-parse --show-cdup`", it ended up in the wrong
+# directory.  A POSIX shell's "cd" works a little differently
+# than chdir() in C; "cd -P" is much closer to chdir().
+#
+test_expect_success 'pulling from symlinked subdir' '
+	(
+		echo link >subdir/file &&
+		git commit -m link subdir/file &&
+		cd subdir-link/ &&
+		git pull &&
+		test link = $(cat file)
+	)
+'
+
+# Prove that the remote end really is a repo, and other commands
+# work fine in this context.  It's just that "git pull" breaks.
+#
+test_expect_success 'pushing from symlinked subdir' '
+	(
+		cd subdir-link/ &&
+		echo push >file &&
+		git commit -m push ./file &&
+		git push
+	) &&
+	test push = $(git show HEAD:subdir/file)
+'
+
+test_done
-- 
1.6.0.3
