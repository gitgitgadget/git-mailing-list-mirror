From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [PATCH v2] git-sh-setup: Fix scripts whose PWD is a symlink into a git work-dir
Date: Wed, 10 Dec 2008 07:04:14 -0800
Message-ID: <1228921454-22416-1-git-send-email-marcel@oak.homeunix.org>
References: <7viqq1hghw.fsf@gitster.siamese.dyndns.org>
Cc: jnareb@gmail.com, ae@op5.se, j.sixt@viscovery.net,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 16:06:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAQd7-0002lT-N1
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 16:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbYLJPET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 10:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYLJPET
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 10:04:19 -0500
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:31628 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750967AbYLJPES (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2008 10:04:18 -0500
Received: (qmail 89499 invoked from network); 10 Dec 2008 15:04:17 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@76.231.190.99 with plain)
  by smtp121.sbc.mail.sp1.yahoo.com with SMTP; 10 Dec 2008 15:04:16 -0000
X-YMail-OSG: q7_Q6DkVM1lvN.VHJ30gPCrk5bcWErk9MwADPvybFIGSZQMcAbbPOXwXKewYAXricoC3U9q1PgZy6.BiN3Xdq3zZU_LCnoHIF55X_0hBf42cwUn4nIKNMfa9xeH7S6T8Y5OlYNDxsm5DmezlahWlJD6u3fCqdyNIWDNPT0FfSivBGAYBmnr8p7gLfUwB6b0E3Uta
X-Yahoo-Newman-Property: ymail-5
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1LAQbm-0007aq-VA; Wed, 10 Dec 2008 07:04:15 -0800
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <7viqq1hghw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102691>

* When interpretting a relative upward (../) path in cd_to_toplevel,
  prepend the cwd without symlinks, given by /bin/pwd
* Add tests for cd_to_toplevel and "git pull" in a symlinked
  directory that failed before this fix, plus constrasting
  scenarios that already worked

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---

Now /bin/pwd is only used when $cdup both is relative
and contains a ".." component, which I think is most of
the time that git didn't start out in the top-level
directory.

I can't seem to exercise the case that show-cdup prints
something other than "../" or "", even when setting
GIT_WORK_TREE in or out of the work tree.  Is it premature
to anticipate that show-cdup might print an arbitrary path
sometime in the future, given the 
"if (!is_inside_work_tree())" branch of show-cdup?  Or maybe
it does now and I just don't see the use case.

Also, the additional invocation of "cd" is now removed.


 git-sh-setup.sh           |   23 ++++++++++++++-
 t/t2300-cd-to-toplevel.sh |   37 +++++++++++++++++++++++++
 t/t5521-pull-symlink.sh   |   67 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 2 deletions(-)
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
index 0000000..293dc35
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
+TOPLEVEL="$(pwd -P)/repo"
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
index 0000000..f18fec7
--- /dev/null
+++ b/t/t5521-pull-symlink.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+test_description='pulling from symlinked subdir'
+
+. ./test-lib.sh
+
+D=`pwd`
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
+#
+test_expect_success setup '
+
+    mkdir subdir &&
+    touch subdir/bar &&
+    git add subdir/bar &&
+    git commit -m empty &&
+    git clone . clone-repo &&
+    # demonstrate that things work without the symlink
+    test_debug "cd clone-repo/subdir/ && git pull; cd ../.." &&
+    ln -s clone-repo/subdir/ subdir-link &&
+    cd subdir-link/ &&
+    test_debug "set +x"
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
+# directory.  Shell "cd" works a little different from chdir() in C.
+# Bash's "cd -P" works like chdir() in C.
+#
+test_expect_success 'pulling from symlinked subdir' '
+
+    git pull
+'
+
+# Prove that the remote end really is a repo, and other commands
+# work fine in this context.
+#
+test_debug "
+    test_expect_success 'pushing from symlinked subdir' '
+
+        git push
+    '
+"
+cd "$D"
+
+test_done
-- 
1.6.0.3
