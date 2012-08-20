From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 2/3] branch: add --unset-upstream option
Date: Mon, 20 Aug 2012 15:47:39 +0200
Message-ID: <1345470460-28734-3-git-send-email-cmn@elego.de>
References: <1345470460-28734-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 16:01:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3SYE-0003Og-SX
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 16:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501Ab2HTOAQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 10:00:16 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:47723 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755170Ab2HTN4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 09:56:17 -0400
Received: from flaca.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by hessy.dwim.me (Postfix) with ESMTPA id 72EF6816C3
	for <git@vger.kernel.org>; Mon, 20 Aug 2012 15:47:41 +0200 (CEST)
Received: (nullmailer pid 28777 invoked by uid 1000);
	Mon, 20 Aug 2012 13:47:40 -0000
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1345470460-28734-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203845>

We have ways of setting the upstream information, but if we want to
unset it, we need to resort to modifying the configuration manually.

Teach branch an --unset-upstream option that unsets this information.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 Documentation/git-branch.txt |  5 +++++
 builtin/branch.c             | 17 ++++++++++++++---
 t/t3200-branch.sh            | 16 ++++++++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index e41c4b5..9c1d2f1 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branch=
name> [<start-point>]
 'git branch' (--set-upstream-to=3D<upstream> | -u <upstream>) [<branch=
name>]
+'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
 'git branch' --edit-description [<branchname>]
@@ -180,6 +181,10 @@ start-point is either a local or remote-tracking b=
ranch.
 	considered <branchname>'s upstream branch. If no <branchname>
 	is specified, then it defaults to the current branch.
=20
+--unset-upstream::
+	Remove the upstream information for <branchname>. If no branch
+	is specified it defaults to the current branch.
+
 --edit-description::
 	Open an editor and edit the text to explain what the branch is
 	for, to be used by various other commands (e.g. `request-pull`).
diff --git a/builtin/branch.c b/builtin/branch.c
index 3c978eb..08068f7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -712,7 +712,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 	int delete =3D 0, rename =3D 0, force_create =3D 0, list =3D 0;
 	int verbose =3D 0, abbrev =3D -1, detached =3D 0;
 	int reflog =3D 0, edit_description =3D 0;
-	int quiet =3D 0;
+	int quiet =3D 0, unset_upstream =3D 0;
 	const char *new_upstream =3D NULL;
 	enum branch_track track;
 	int kinds =3D REF_LOCAL_BRANCH;
@@ -728,6 +728,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
 			BRANCH_TRACK_OVERRIDE),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "chang=
e the upstream info"),
+		OPT_BOOLEAN(0, "unset-upstream", &unset_upstream, "Unset the upstrea=
m info"),
 		OPT__COLOR(&branch_use_color, "use colored output"),
 		OPT_SET_INT('r', "remotes",     &kinds, "act on remote-tracking bran=
ches",
 			REF_REMOTE_BRANCH),
@@ -796,10 +797,10 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, builtin_branch_us=
age,
 			     0);
=20
-	if (!delete && !rename && !edit_description && !new_upstream && argc =
=3D=3D 0)
+	if (!delete && !rename && !edit_description && !new_upstream && !unse=
t_upstream && argc =3D=3D 0)
 		list =3D 1;
=20
-	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream > =
1)
+	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream + =
!!unset_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);
=20
 	if (abbrev =3D=3D -1)
@@ -865,6 +866,16 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 		 * info and making sure new_upstream is correct
 		 */
 		create_branch(head, branch->name, new_upstream, 0, 0, 0, quiet, BRAN=
CH_TRACK_OVERRIDE);
+	} else if (unset_upstream) {
+		struct branch *branch =3D branch_get(argv[0]);
+		struct strbuf buf =3D STRBUF_INIT;
+
+		strbuf_addf(&buf, "branch.%s.remote", branch->name);
+		git_config_set_multivar(buf.buf, NULL, NULL, 1);
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "branch.%s.merge", branch->name);
+		git_config_set_multivar(buf.buf, NULL, NULL, 1);
+		strbuf_release(&buf);
 	} else if (argc > 0 && argc <=3D 2) {
 		if (kinds !=3D REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a b=
ranch name"));
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e9019ac..93e5d6e 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -383,6 +383,22 @@ test_expect_success 'use --set-upstream-to modify =
a particular branch' \
      test "$(git config branch.my13.remote)" =3D "." &&
      test "$(git config branch.my13.merge)" =3D "refs/heads/master"'
=20
+test_expect_success 'test --unset-upstream on HEAD' \
+    'git branch my14
+     test_config branch.master.remote foo &&
+     test_config branch.master.merge foo &&
+     git branch --set-upstream-to my14 &&
+     git branch --unset-upstream &&
+     test_must_fail git config branch.master.remote &&
+     test_must_fail git config branch.master.merge'
+
+test_expect_success 'test --unset-upstream on a particular branch' \
+    'git branch my15
+     git branch --set-upstream-to master my14 &&
+     git branch --unset-upstream my14 &&
+     test_must_fail git config branch.my14.remote &&
+     test_must_fail git config branch.my14.merge'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +000=
0	branch: Created from master
--=20
1.7.11.1.104.ge7b44f1
