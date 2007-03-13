From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 3/3] git-branch: Support local --track via a special remote `.'
Date: Tue, 13 Mar 2007 17:30:55 +0100
Message-ID: <877itlf6m8.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C. Hamano" <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>,
	Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 13 17:30:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR9tq-0001vC-9c
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 17:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030780AbXCMQam convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Mar 2007 12:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030773AbXCMQam
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 12:30:42 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:38138 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030780AbXCMQal (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 12:30:41 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l2DGUZq15549;
	Tue, 13 Mar 2007 17:30:35 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42132>


=46rom: Paolo Bonzini  <bonzini@gnu.org>

The patch adds --track/--no-track support, extending
it so that branch.<name>.remote items referring `.' can be created.
=46inally, it fixes a typo in git-checkout.sh.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 This is an updated patch of:

 [PATCH, fixed version] git-fetch, git-branch: Support local --track vi=
a
 a special

 builtin-branch.c        |   39 +++++++++++++++++++++++++--------------
 git-checkout.sh         |    2 +-
 t/t3200-branch.sh       |    6 ++++++
 t/t9109-git-svn-pull.sh |   31 +++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 15 deletions(-)
 create mode 100755 t/t9109-git-svn-pull.sh

diff --git a/builtin-branch.c b/builtin-branch.c
index 42b1ff1..14c4219 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -372,9 +372,26 @@ static int get_remote_config(const char *key, cons=
t char *value)
 	return 0;
 }
=20
-static void set_branch_defaults(const char *name, const char *real_ref=
)
+static void set_branch_merge (const char *name, const char *config_rem=
ote,
+			      const char *config_repo)
 {
 	char key[1024];
+	if (sizeof(key) <=3D
+	    snprintf(key, sizeof(key), "branch.%s.remote", name))
+		die("what a long branch name you have!");
+	git_config_set(key, config_remote);
+
+	/*
+	 * We do not have to check if we have enough space for
+	 * the 'merge' key, since it's shorter than the
+	 * previous 'remote' key, which we already checked.
+	 */
+	snprintf(key, sizeof(key), "branch.%s.merge", name);
+	git_config_set(key, config_repo);
+}
+
+static void set_branch_defaults(const char *name, const char *real_ref=
)
+{
 	const char *slash =3D strrchr(real_ref, '/');
=20
 	if (!slash)
@@ -384,21 +401,15 @@ static void set_branch_defaults(const char *name,=
 const char *real_ref)
 	start_len =3D strlen(real_ref);
 	base_len =3D slash - real_ref;
 	git_config(get_remote_config);
+	if (!config_repo && !config_remote &&
+	    !prefixcmp (real_ref, "refs/heads/")) {
+		set_branch_merge (name, ".", real_ref);
+		printf("Branch %s set up to track local branch %s.\n",
+		       name, real_ref);
+	}
=20
 	if (config_repo && config_remote) {
-		if (sizeof(key) <=3D
-		    snprintf(key, sizeof(key), "branch.%s.remote", name))
-			die("what a long branch name you have!");
-		git_config_set(key, config_remote);
-
-		/*
-		 * We do not have to check if we have enough space for
-		 * the 'merge' key, since it's shorter than the
-		 * previous 'remote' key, which we already checked.
-		 */
-		snprintf(key, sizeof(key), "branch.%s.merge", name);
-		git_config_set(key, config_repo);
-
+		set_branch_merge (name, config_remote, config_repo);
 		printf("Branch %s set up to track remote branch %s.\n",
 		       name, real_ref);
 	}
diff --git a/git-checkout.sh b/git-checkout.sh
index 6caa9fd..b292ff0 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -89,7 +89,7 @@ while [ "$#" !=3D "0" ]; do
     esac
 done
=20
-case "$new_branch,$track" in
+case "$newbranch,$track" in
 ,--*)
 	die "git checkout: --track and --no-track require -b"
 esac
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 75c000a..9558bdb 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -145,9 +145,15 @@ test_expect_success 'test overriding tracking setu=
p via --no-track' \
      git-config remote.local.fetch refs/heads/*:refs/remotes/local/* &=
&
      (git-show-ref -q refs/remotes/local/master || git-fetch local) &&
      git-branch --no-track my2 local/master &&
+     git-config branch.autosetupmerge false &&
      ! test $(git-config branch.my2.remote) =3D local &&
      ! test $(git-config branch.my2.merge) =3D refs/heads/master'
=20
+test_expect_success 'test local tracking setup' \
+    'git branch --track my6 s &&
+     test $(git-config branch.my6.remote) =3D . &&
+     test $(git-config branch.my6.merge) =3D refs/heads/s'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 0000000000000000000000000000000000000000 $HEAD $GIT_COMMITTER_NAME <$G=
IT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
diff --git a/t/t9109-git-svn-pull.sh b/t/t9109-git-svn-pull.sh
new file mode 100755
index 0000000..58fa7df
--- /dev/null
+++ b/t/t9109-git-svn-pull.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Paolo Bonzini
+#
+
+test_description=3D'git-svn pull test'
+. ./lib-git-svn.sh
+
+mkdir import
+
+cd import
+	echo Hello World > motd
+	svn import -m 'import for git-svn' . "$svnrepo" >/dev/null
+cd ..
+
+test_expect_success 'initialize git-svn and fetch' "
+	git-svn init $svnrepo
+	git-svn fetch"
+
+svn co $svnrepo test_wc > /dev/null
+cd test_wc
+	echo Goodbye World > motd
+	svn commit -m "another svn commit" > /dev/null
+cd ..
+
+test_expect_success 'fetch and pull latest from svn' \
+	'git-svn fetch &&
+	 git pull . remotes/git-svn &&
+	 grep Goodbye motd'
+
+test_done
--=20
1.5.0.3.1021.g5897


--=20
Buscant signatura...
Buscant signatura...fet
