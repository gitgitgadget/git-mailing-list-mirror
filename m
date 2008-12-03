From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [PATCH] git-sh-setup: Fix scripts whose PWD is a symlink into a git work-dir
Date: Tue,  2 Dec 2008 21:27:00 -0800
Message-ID: <1228282020-2294-1-git-send-email-marcel@oak.homeunix.org>
References: <7vtz9vk6uj.fsf@gitster.siamese.dyndns.org>
Cc: jnareb@gmail.com, ae@op5.se, j.sixt@viscovery.net,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 06:28:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7kI2-0006ah-BV
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 06:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125AbYLCF1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 00:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbYLCF1G
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 00:27:06 -0500
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:30292 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755775AbYLCF1E (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 00:27:04 -0500
Received: (qmail 49831 invoked from network); 3 Dec 2008 05:27:04 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@76.231.190.99 with plain)
  by smtp120.sbc.mail.sp1.yahoo.com with SMTP; 3 Dec 2008 05:27:03 -0000
X-YMail-OSG: 4scDZ5gVM1nEOT1D_3z4jtkfXwCjj0E_oZCi9Sg2BuogzdRVJd.C18HE0HT8wSFryR.K9Fa0QZSdZkBcNoRx9mCaFeYQV5qDyM_IcgiJXRfszSoeDu99aUBLYmkgWnM1p21TOPsq.MHWZDohvj8mqIzqv5CJ418l4IhSIOyWkFiigyls
X-Yahoo-Newman-Property: ymail-5
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1L7kGL-0003ir-55; Tue, 02 Dec 2008 21:27:01 -0800
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <7vtz9vk6uj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102215>

* Before interpretting an upward path (../) in cd_to_toplevel,
  cd to a path without symlinks given by /bin/pwd
* Add tests for cd_to_toplevel and "git pull" in a symlinked
  directory that failed before this fix, plus constrasting
  scenarios that already worked

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---

I hope this patch will address concerns both about changes
to existing APIs and speed of the new behavior.

A few notes on implementation choices:

I used /bin/pwd because of this precedent for choosing it over
"cd -P" for compatibility.
http://article.gmane.org/gmane.comp.version-control.git/46918

If cd_to_toplevel had concatenated $(/bin/pwd) with $cdup to
avoid the separate "cd", it would require checking for $cdup
being an absolute path.  I wasn't sure how to check that in
a way that is both portable and clearly faster than "cd",
so cd_to_toplevel runs "cd" twice.  I'm assuming that
running an external command like expr or grep is slower than
just doing the "cd".

cd_to_toplevel doesn't check $PWD to see whether to do the
first cd, because some shells allegedly don't update it
reliably.

Since cd_to_toplevel doesn't know whether it's at a
symlinked PWD or not, I wrote it to treat the 
"cd $(/bin/pwd)" as mandatory, even when it might not
actually be.  So on systems without /bin/pwd, it will fail
even when there are no symlinks.  I thought that was better
than inconsistent behavior depending on whether /bin/pwd is
available.

The extra "cd" will be skipped when the script is already at
the top of the working tree.


 git-sh-setup.sh           |   11 +++++++
 t/t2300-cd-to-toplevel.sh |   37 +++++++++++++++++++++++++
 t/t5521-pull-symlink.sh   |   67 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100755 t/t2300-cd-to-toplevel.sh
 create mode 100755 t/t5521-pull-symlink.sh

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index dbdf209..377700b 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -85,6 +85,17 @@ cd_to_toplevel () {
 	cdup=$(git rev-parse --show-cdup)
 	if test ! -z "$cdup"
 	then
+		# Interpret $cdup relative to the physical, not logical, cwd.
+		# Probably /bin/pwd is more portable than passing -P to cd or pwd.
+		phys="$(/bin/pwd)" || {
+			echo >&2 "Cannot determine the physical path to the current dir"
+			exit 1
+		}
+		cd "$phys" || {
+			echo >&2 "Cannot chdir to the physical path to current dir: $phys"
+			exit 1
+		}
+
 		cd "$cdup" || {
 			echo >&2 "Cannot chdir to $cdup, the toplevel of the working tree"
 			exit 1
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
