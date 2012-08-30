From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 3/3] branch: deprecate --set-upstream and show help if we detect possible mistaken use
Date: Thu, 30 Aug 2012 19:23:13 +0200
Message-ID: <1346347393-8425-4-git-send-email-cmn@elego.de>
References: <1346347393-8425-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 19:23:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T78Ss-0005nt-5E
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 19:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501Ab2H3RXY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Aug 2012 13:23:24 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:57842 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751890Ab2H3RXK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 13:23:10 -0400
Received: from cmartin.tk (p4FC5D726.dip.t-dialin.net [79.197.215.38])
	by hessy.dwim.me (Postfix) with ESMTPA id 22694805D3;
	Thu, 30 Aug 2012 19:23:09 +0200 (CEST)
Received: (nullmailer pid 8470 invoked by uid 1000);
	Thu, 30 Aug 2012 17:23:13 -0000
X-Mailer: git-send-email 1.7.12.3.g0dd8ef6
In-Reply-To: <1346347393-8425-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204555>

This interface is error prone, and a better one (--set-upstream-to)
exists. Add a message listing the alternatives and suggest how to fix
a --set-upstream invocation in case the user only gives one argument
which causes a local branch with the same name as a remote-tracking
one to be created. The typical case is

    git branch --set-upstream origin/master

when the user meant

    git branch --set-upstream master origin/master

assuming that the current branch is master. Show a message telling the
user how to undo their action and get what they wanted. For the
command above, the message would be

The --set-upstream flag is deprecated and will be removed. Consider usi=
ng --track or --set-upstream-to
Branch origin/master set up to track local branch master.

If you wanted to make 'master' track 'origin/master', do this:

    git branch -d origin/master
    git branch --set-upstream-to origin/master

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 builtin/branch.c  | 26 ++++++++++++++++++++++++++
 t/t3200-branch.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 557995d..5e95e35 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -881,10 +881,36 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
 		git_config_set_multivar(buf.buf, NULL, NULL, 1);
 		strbuf_release(&buf);
 	} else if (argc > 0 && argc <=3D 2) {
+		struct branch *branch =3D branch_get(argv[0]);
+		int branch_existed =3D 0, remote_tracking =3D 0;
+		struct strbuf buf =3D STRBUF_INIT;
+
 		if (kinds !=3D REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a b=
ranch name"));
+
+		if (track =3D=3D BRANCH_TRACK_OVERRIDE)
+			fprintf(stderr, _("The --set-upstream flag is deprecated and will b=
e removed. Consider using --track or --set-upstream-to\n"));
+
+		strbuf_addf(&buf, "refs/remotes/%s", branch->name);
+		remote_tracking =3D ref_exists(buf.buf);
+		strbuf_release(&buf);
+
+		branch_existed =3D ref_exists(branch->refname);
 		create_branch(head, argv[0], (argc =3D=3D 2) ? argv[1] : head,
 			      force_create, reflog, 0, quiet, track);
+
+		/*
+		 * We only show the instructions if the user gave us
+		 * one branch which doesn't exist locally, but is the
+		 * name of a remote-tracking branch.
+		 */
+		if (argc =3D=3D 1 && track =3D=3D BRANCH_TRACK_OVERRIDE &&
+		    !branch_existed && remote_tracking) {
+			fprintf(stderr, _("\nIf you wanted to make '%s' track '%s', do this=
:\n\n"), head, branch->name);
+			fprintf(stderr, _("    git branch -d %s\n"), branch->name);
+			fprintf(stderr, _("    git branch --set-upstream-to %s\n"), branch-=
>name);
+		}
+
 	} else
 		usage_with_options(builtin_branch_usage, options);
=20
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 1018e8b..f2a076c 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -402,6 +402,40 @@ test_expect_success 'test --unset-upstream on a pa=
rticular branch' \
      test_must_fail git config branch.my14.remote &&
      test_must_fail git config branch.my14.merge'
=20
+test_expect_success '--set-upstream shows message when creating a new =
branch that exists as remote-tracking' \
+    'git update-ref refs/remotes/origin/master HEAD &&
+     git branch --set-upstream origin/master 2>actual &&
+     test_when_finished git update-ref -d refs/remotes/origin/master &=
&
+     test_when_finished git branch -d origin/master &&
+     cat >expected <<EOF &&
+The --set-upstream flag is deprecated and will be removed. Consider us=
ing --track or --set-upstream-to
+
+If you wanted to make '"'master'"' track '"'origin/master'"', do this:
+
+    git branch -d origin/master
+    git branch --set-upstream-to origin/master
+EOF
+     test_cmp expected actual
+'
+
+test_expect_success '--set-upstream with two args only shows the depre=
cation message' \
+    'git branch --set-upstream master my13 2>actual &&
+     test_when_finished git branch --unset-upstream master &&
+     cat >expected <<EOF &&
+The --set-upstream flag is deprecated and will be removed. Consider us=
ing --track or --set-upstream-to
+EOF
+     test_cmp expected actual
+'
+
+test_expect_success '--set-upstream with one arg only shows the deprec=
ation message if the branch existed' \
+    'git branch --set-upstream my13 2>actual &&
+     test_when_finished git branch --unset-upstream my13 &&
+     cat >expected <<EOF &&
+The --set-upstream flag is deprecated and will be removed. Consider us=
ing --track or --set-upstream-to
+EOF
+     test_cmp expected actual
+'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +000=
0	branch: Created from master
--=20
1.7.12.3.g0dd8ef6
