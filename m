From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] branch: make --set-upstream saner without an explicit starting point
Date: Thu,  5 Jul 2012 11:29:49 +0200
Message-ID: <1341480589-1890-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 11:30:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmiNp-0005wC-Mc
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 11:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467Ab2GEJ3w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jul 2012 05:29:52 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:38692 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754798Ab2GEJ3v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 05:29:51 -0400
Received: from flaca.cmartin.tk (unknown [141.23.102.101])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 6B03346057
	for <git@vger.kernel.org>; Thu,  5 Jul 2012 11:29:48 +0200 (CEST)
Received: (nullmailer pid 1925 invoked by uid 1000);
	Thu, 05 Jul 2012 09:29:49 -0000
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201040>

The branch command assumes HEAD as the starting point if none is
specified. This causes --set-upstream to behave unexpectedly if the
user types

    git branch --set-upstream origin/master

git-branch will assume a second argument of HEAD and create config
entries for a local branch origin/master to track the current
branch. This is rarely, if ever, what the user wants to do.

Catch invocations with --set-upstream and only one branch so the
command above sets up the current branch to track origin's master
branch.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

I got tired of --set-upstream biting me in the arse so I (presumably)
fixed it. I've only run the t3200 test for now. I'll check the rest of
the suite when I'm in front of a computer that's got some power, but I
don't expect other tests to be affected.

 builtin/branch.c  | 16 ++++++++++++++--
 t/t3200-branch.sh | 23 +++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0e060f2..6bbabda 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -853,10 +853,22 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
 		else
 			usage_with_options(builtin_branch_usage, options);
 	} else if (argc > 0 && argc <=3D 2) {
+		const char *branch, *upstream;
 		if (kinds !=3D REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a b=
ranch name"));
-		create_branch(head, argv[0], (argc =3D=3D 2) ? argv[1] : head,
-			      force_create, reflog, 0, quiet, track);
+
+		/* The usual way, make the branch point be HEAD of none is specified=
 */
+		branch =3D argv[0];
+		upstream =3D (argc =3D=3D 2) ? argv[1] : head;
+
+		/* If the command was 'git branch --set-upstream origin/master',
+		   make HEAD track origin/master, not the other way around */
+		if (track =3D=3D BRANCH_TRACK_OVERRIDE && argc =3D=3D 1) {
+			branch =3D head;
+			upstream =3D argv[0];
+		}
+
+		create_branch(head, branch, upstream, force_create, reflog, 0, quiet=
, track);
 	} else
 		usage_with_options(builtin_branch_usage, options);
=20
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a17f8b2..e06d642 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -369,6 +369,29 @@ test_expect_success \
     'git tag foobar &&
      test_must_fail git branch --track my11 foobar'
=20
+test_expect_success 'set upstream with both branches explicit' \
+    'git config remote.local.url . &&
+     git config remote.local.fetch refs/heads/master:refs/remotes/loca=
l/master &&
+     (git show-ref -q refs/remotes/local/master || git fetch local) &&
+     git branch --no-track my12 &&
+     git branch --set-upstream my12 local/master &&
+     test $(git config branch.my12.remote) =3D local &&
+     test $(git config branch.my12.merge) =3D refs/heads/master'
+
+# The unsets at the end is to leave the master config as we found it,
+# so later tests don't get confused
+
+test_expect_success 'set upstream with implicit HEAD as branch to modi=
fy' \
+    'git config remote.local.url . &&
+     git config remote.local.fetch refs/heads/master:refs/remotes/loca=
l/master &&
+     (git show-ref -q refs/remotes/local/master || git fetch local) &&
+     git branch --set-upstream local/master &&
+     test $(git config branch.master.remote) =3D local &&
+     test $(git config branch.master.merge) =3D refs/heads/master
+     git config --unset branch.master.remote &&
+     git config --unset branch.master.merge
+'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +000=
0	branch: Created from master
--=20
1.7.11.1.104.ge7b44f1
