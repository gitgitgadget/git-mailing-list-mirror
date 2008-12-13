From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [PATCH v3] git-sh-setup: Fix scripts whose PWD is a symlink into a git work-dir
Date: Sat, 13 Dec 2008 12:47:11 -0800
Message-ID: <1229201231-12586-1-git-send-email-marcel@oak.homeunix.org>
References: <7viqprzsvs.fsf@gitster.siamese.dyndns.org>
Cc: jnareb@gmail.com, ae@op5.se, j.sixt@viscovery.net,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 13 21:48:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBbPp-0005XI-SN
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 21:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbYLMUrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 15:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbYLMUrR
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 15:47:17 -0500
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:25900 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751521AbYLMUrQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Dec 2008 15:47:16 -0500
Received: (qmail 71344 invoked from network); 13 Dec 2008 20:47:14 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@75.61.110.119 with plain)
  by smtp119.sbc.mail.sp1.yahoo.com with SMTP; 13 Dec 2008 20:47:13 -0000
X-YMail-OSG: 8jZIp0AVM1kxw6ZySxNoCb23WWiYP7AiPeoWsO0l_JgH_.ieewsFIeaDj4j8T4ylklvRLfok7p.QVj6CvrUAYtgOHgudMRTTqaNx62AQ3C0i23ZTgJNRHAkKQXRN.DsR66fwnhrEOcLno4uvaOKJO6BKHhNmCXZmMJgEBYputofebu_bNcGDB5Qytr0Jxg--
X-Yahoo-Newman-Property: ymail-5
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1LBbOJ-0003dk-7b; Sat, 13 Dec 2008 12:47:11 -0800
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <7viqprzsvs.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103018>

I want directories of my working tree to be linked to from various
paths on my filesystem where third-party components expect them, both
in development and production environments.  A build system's install
step could solve this, but we develop scripts and web pages that don't
need to be built.  Git's submodule system could solve this, but we
tend to develop, branch, and test those directories all in unison, so
one big repository feels more natural.  We prefer to edit and commit
on the symlinked paths, not the canonical ones, and in that setting,
"git pull" fails to find the top-level directory of the working tree
and the .git directory in it.

"git pull" fails because POSIX shells have a notion of current working
directory that is different from getcwd().  The shell stores this path
in PWD.  As a result, "cd ../" in a shell script can be interpretted
differently in a shell than chdir("../") in a C program.  The shell
interprets "../" by essentially stripping the last textual path
component from PWD, whereas C chdir() follows the ".." link in the
current directory on the filesystem.  When PWD is a symlink, these are
different destinations.  As a result, Git's C commands find the
correct top-level working tree, and shell scripts do not.

Changes:

* When interpretting a relative upward (../) path in cd_to_toplevel,
  prepend the cwd without symlinks, given by /bin/pwd
* Add tests for cd_to_toplevel and "git pull" in a symlinked
  directory that failed before this fix, plus contrasting scenarios
  that already worked

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---

Hopefully the new commit message adequately describes the problem and
motivation for solving it without getting too long-winded or bogged down
in personal details.

I also removed the "pwd -P" from the unit test.  I originally worried
that it was little like testing an algorithm by running it twice and
checking the results against eachother.  But I guess having the unit
tests run on unusual platforms is more important.

The pull-symlink test cases should now fail independently.  I also
moved the setup out of the test_expect_success block for symetry and
since I see that other tests don't check for setup failure.  There's
no "set -e" or anything to catch a setup failure other than the
eventual test cases push/pull not working.  So is it good form in this
situation to not check the setup steps for success?  Or would it make
sense to put them in their own 'setup' test case?  Or would it be better
to just "exit 1" if they fail?

> > +ln -s repo symrepo
> > +test_cd_to_toplevel symrepo 'at symbolic root'
> > +
> > +ln -s repo/sub/dir subdir-link
> > +test_cd_to_toplevel subdir-link 'at symbolic subdir'
> > +
> > +cd repo
> > +ln -s sub/dir internal-link
> > +test_cd_to_toplevel internal-link 'at internal symbolic subdir'
> 
> To be very honest, although it is good that you made them work, I am still
> not getting why the latter two scenarios are worth supporting.  The first
> one I am Ok with, though.

The middle scenario is the one I want most.  I hope the first
paragraph of the commit message sheds more light on the reason.  

The third is really just there for completeness (although there are
other cases I didn't include...).  Since Git supports operation below
the top-level, and it supports symlinks, it seems useful to test the
cooperation of those features.  I wouldn't miss it much if you thought
it was not interesting enough.

> > +
> > +# Prove that the remote end really is a repo, and other commands
> > +# work fine in this context.
> > +#
> > +test_debug "
> > +    test_expect_success 'pushing from symlinked subdir' '
> > +
> > +        git push
> > +    '
> > +"
> 
> Why should this be hidden inside test_debug?

I'm not particularly trying to test "git push" or "git pull" in
general here.  That's also why the other "git pull" was in a
test_debug.  I thought it was really only useful to someone trying to
understand the contents of the test file.  There are other files that
cover push and pull.  Do you think these test cases should run all the
time here?


 git-sh-setup.sh           |   23 +++++++++++++-
 t/t2300-cd-to-toplevel.sh |   37 +++++++++++++++++++++++
 t/t5521-pull-symlink.sh   |   73 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 2 deletions(-)
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
index 0000000..05854b4
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
+			[ "$(pwd -P)" = "$TOPLEVEL" ]
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
index 0000000..8869262
--- /dev/null
+++ b/t/t5521-pull-symlink.sh
@@ -0,0 +1,73 @@
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
+touch subdir/bar
+git add subdir/bar
+git commit -m empty
+git clone . clone-repo
+ln -s clone-repo/subdir/ subdir-link
+
+
+# Demonstrate that things work if we just avoid the symlink
+#
+test_debug "
+	test_expect_success 'pulling from real subdir' '
+		(
+			cd clone-repo/subdir/ &&
+			git pull
+		)
+	'
+"
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
+		cd subdir-link/ &&
+		git pull
+	)
+'
+
+# Prove that the remote end really is a repo, and other commands
+# work fine in this context.  It's just that "git pull" breaks.
+#
+test_debug "
+	test_expect_success 'pushing from symlinked subdir' '
+		(
+			cd subdir-link/ &&
+			git push
+		)
+	'
+"
+
+test_done
-- 
1.6.0.3
