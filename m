From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 01:34:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 01:35:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LShMI-0004yf-Eu
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 01:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933AbZA3AeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 19:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754201AbZA3AeJ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 19:34:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:49133 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755419AbZA3AeH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 19:34:07 -0500
Received: (qmail invoked by alias); 30 Jan 2009 00:34:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 30 Jan 2009 01:34:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AgKsjCzxA7Gy2C1wVDRQXXIvpa5RZyHIMyHvi8A
	v329d3ZMYYisXi
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233275583u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107758>

Many, many users set up non-bare repositories on their server, and are
confused that the working directory is not updated.

The reason may be that they did not read the manual, or that they found
"helpful" walk-throughs via Google, or that they did not understand the
concepts behind Git.

Or, the reason could be that we made a design mistake, and that the
number of puzzled new users should tell us something.

Granted, we wanted to have a longer grace period for old-timers, but
let's face it:

- old-timers will have to edit their configs at some stage anyway,

- for old-timers, it will be a matter of less than a minute,

- new-timers will not spend frustrated hours, and

- since there are many more new-timers now than old-timers, we should
  cater for them anyway.

To make it easier for old-timers, the error message was enhanced to
suggest how to allow updating the current branch easily.

For the tests relying on the old behavior, receive.denyCurrentBranch
was set to false, to avoid breaking them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Let's be honest here, I have not much respect for users who fail 
	to read up enough to understand what they are doing.

	But hearing from those users constantly is really unnerving.  And 
	it would be a one-time cost to old-timers.

 builtin-receive-pack.c      |    9 ++++++---
 t/t5400-send-pack.sh        |    5 ++++-
 t/t5401-update-hooks.sh     |    1 +
 t/t5405-send-pack-rewind.sh |    1 +
 t/t5516-fetch-push.sh       |    1 +
 t/t5517-push-mirror.sh      |    3 ++-
 t/t5521-pull-symlink.sh     |    1 +
 t/t5701-clone-local.sh      |    2 +-
 8 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 6564a97..e9510fc 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -19,7 +19,7 @@ enum deny_action {
 
 static int deny_deletes = 0;
 static int deny_non_fast_forwards = 0;
-static enum deny_action deny_current_branch = DENY_WARN;
+static enum deny_action deny_current_branch = DENY_REFUSE;
 static int receive_fsck_objects;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
@@ -239,9 +239,12 @@ static const char *update(struct command *cmd)
 			" that are now in HEAD.");
 		break;
 	case DENY_REFUSE:
-		if (!is_ref_checked_out(name))
+		if (is_bare_repository() || !is_ref_checked_out(name))
 			break;
-		error("refusing to update checked out branch: %s", name);
+		error("refusing to update checked out branch: %s\n"
+			"if you know what you are doing, you can allow it by "
+			"setting\n\n"
+			"\tgit config receive.denyCurrentBranch true\n", name);
 		return "branch is currently checked out";
 	}
 
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index b21317d..240380c 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -33,6 +33,7 @@ test_expect_success setup '
 	git update-ref HEAD "$commit" &&
 	git clone ./. victim &&
 	cd victim &&
+	git config receive.denyCurrentBranch false &&
 	git log &&
 	cd .. &&
 	git update-ref HEAD "$zero" &&
@@ -131,13 +132,15 @@ test_expect_success \
 	cd .. &&
 	git clone parent child && cd child && git push --all &&
 	cd ../parent &&
-	git branch -a >branches && ! grep origin/master branches
+	git branch -a >branches && ! grep origin/master branches &&
+	cd ..
 '
 
 rewound_push_setup() {
 	rm -rf parent child &&
 	mkdir parent && cd parent &&
 	git init && echo one >file && git add file && git commit -m one &&
+	git config receive.denyCurrentBranch false &&
 	echo two >file && git commit -a -m two &&
 	cd .. &&
 	git clone parent child && cd child && git reset --hard HEAD^
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 64f66c9..7f04b64 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -18,6 +18,7 @@ test_expect_success setup '
 	git update-ref refs/heads/master $commit0 &&
 	git update-ref refs/heads/tofail $commit1 &&
 	git clone ./. victim &&
+	GIT_DIR=victim/.git git config receive.denyCurrentBranch false &&
 	GIT_DIR=victim/.git git update-ref refs/heads/tofail $commit1 &&
 	git update-ref refs/heads/master $commit1 &&
 	git update-ref refs/heads/tofail $commit0
diff --git a/t/t5405-send-pack-rewind.sh b/t/t5405-send-pack-rewind.sh
index cb9aacc..37c1f23 100755
--- a/t/t5405-send-pack-rewind.sh
+++ b/t/t5405-send-pack-rewind.sh
@@ -6,6 +6,7 @@ test_description='forced push to replace commit we do not have'
 
 test_expect_success setup '
 
+	git config receive.denyCurrentBranch false &&
 	>file1 && git add file1 && test_tick &&
 	git commit -m Initial &&
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4426df9..9ca2730 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -12,6 +12,7 @@ mk_empty () {
 	(
 		cd testrepo &&
 		git init &&
+		git config receive.denyCurrentBranch false &&
 		mv .git/hooks .git/hooks-disabled
 	)
 }
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index ea49ded..0a31a4e 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -19,7 +19,8 @@ mk_repo_pair () {
 	mkdir mirror &&
 	(
 		cd mirror &&
-		git init
+		git init &&
+		git config receive.denyCurrentBranch false
 	) &&
 	mkdir master &&
 	(
diff --git a/t/t5521-pull-symlink.sh b/t/t5521-pull-symlink.sh
index 5672b51..736c24e 100755
--- a/t/t5521-pull-symlink.sh
+++ b/t/t5521-pull-symlink.sh
@@ -14,6 +14,7 @@ test_description='pulling from symlinked subdir'
 #
 # The working directory is subdir-link.
 
+git config receive.denyCurrentBranch false
 mkdir subdir
 echo file >subdir/file
 git add subdir/file
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 3559d17..06b2f13 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -119,7 +119,7 @@ test_expect_success 'bundle clone with nonexistent HEAD' '
 test_expect_success 'clone empty repository' '
 	cd "$D" &&
 	mkdir empty &&
-	(cd empty && git init) &&
+	(cd empty && git init && git config receive.denyCurrentBranch false) &&
 	git clone empty empty-clone &&
 	test_tick &&
 	(cd empty-clone
-- 
1.6.1.2.531.g6f52
