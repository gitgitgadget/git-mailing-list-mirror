From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Thu, 30 Aug 2012 19:23:11 +0200
Message-ID: <1346347393-8425-2-git-send-email-cmn@elego.de>
References: <1346347393-8425-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 19:23:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T78Sr-0005nt-Lt
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 19:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462Ab2H3RXR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Aug 2012 13:23:17 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:57844 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751896Ab2H3RXL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 13:23:11 -0400
Received: from cmartin.tk (p4FC5D726.dip.t-dialin.net [79.197.215.38])
	by hessy.dwim.me (Postfix) with ESMTPA id 8512F816BB;
	Thu, 30 Aug 2012 19:23:09 +0200 (CEST)
Received: (nullmailer pid 8466 invoked by uid 1000);
	Thu, 30 Aug 2012 17:23:13 -0000
X-Mailer: git-send-email 1.7.12.3.g0dd8ef6
In-Reply-To: <1346347393-8425-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204554>

The existing --set-uptream option can cause confusion, as it uses the
usual branch convention of assuming a starting point of HEAD if none
is specified, causing

    git branch --set-upstream origin/master

to create a new local branch 'origin/master' that tracks the current
branch. As --set-upstream already exists, we can't simply change its
behaviour. To work around this, introduce --set-upstream-to which
accepts a compulsory argument indicating what the new upstream branch
should be and one optinal argument indicating which branch to change,
defaulting to HEAD.

The new options allows us to type

    git branch --set-upstream-to origin/master

to set the current branch's upstream to be origin's master.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 Documentation/git-branch.txt |  9 ++++++++-
 builtin/branch.c             | 17 +++++++++++++++--
 t/t3200-branch.sh            | 14 ++++++++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 47235be..e41c4b5 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	[--column[=3D<options>] | --no-column]
 	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branch=
name> [<start-point>]
+'git branch' (--set-upstream-to=3D<upstream> | -u <upstream>) [<branch=
name>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
 'git branch' --edit-description [<branchname>]
@@ -48,7 +49,7 @@ branch so that 'git pull' will appropriately merge fr=
om
 the remote-tracking branch. This behavior may be changed via the globa=
l
 `branch.autosetupmerge` configuration flag. That setting can be
 overridden by using the `--track` and `--no-track` options, and
-changed later using `git branch --set-upstream`.
+changed later using `git branch --set-upstream-to`.
=20
 With a `-m` or `-M` option, <oldbranch> will be renamed to <newbranch>=
=2E
 If <oldbranch> had a corresponding reflog, it is renamed to match
@@ -173,6 +174,12 @@ start-point is either a local or remote-tracking b=
ranch.
 	like `--track` would when creating the branch, except that where
 	branch points to is not changed.
=20
+-u <upstream>::
+--set-upstream-to=3D<upstream>::
+	Set up <branchname>'s tracking information so <upstream> is
+	considered <branchname>'s upstream branch. If no <branchname>
+	is specified, then it defaults to the current branch.
+
 --edit-description::
 	Open an editor and edit the text to explain what the branch is
 	for, to be used by various other commands (e.g. `request-pull`).
diff --git a/builtin/branch.c b/builtin/branch.c
index 0e060f2..3c978eb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -713,6 +713,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 	int verbose =3D 0, abbrev =3D -1, detached =3D 0;
 	int reflog =3D 0, edit_description =3D 0;
 	int quiet =3D 0;
+	const char *new_upstream =3D NULL;
 	enum branch_track track;
 	int kinds =3D REF_LOCAL_BRANCH;
 	struct commit_list *with_commit =3D NULL;
@@ -726,6 +727,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 			BRANCH_TRACK_EXPLICIT),
 		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
 			BRANCH_TRACK_OVERRIDE),
+		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "chang=
e the upstream info"),
 		OPT__COLOR(&branch_use_color, "use colored output"),
 		OPT_SET_INT('r', "remotes",     &kinds, "act on remote-tracking bran=
ches",
 			REF_REMOTE_BRANCH),
@@ -794,10 +796,10 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, builtin_branch_us=
age,
 			     0);
=20
-	if (!delete && !rename && !edit_description && argc =3D=3D 0)
+	if (!delete && !rename && !edit_description && !new_upstream && argc =
=3D=3D 0)
 		list =3D 1;
=20
-	if (!!delete + !!rename + !!force_create + !!list > 1)
+	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream > =
1)
 		usage_with_options(builtin_branch_usage, options);
=20
 	if (abbrev =3D=3D -1)
@@ -852,6 +854,17 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 			rename_branch(argv[0], argv[1], rename > 1);
 		else
 			usage_with_options(builtin_branch_usage, options);
+	} else if (new_upstream) {
+		struct branch *branch =3D branch_get(argv[0]);
+
+		if (!ref_exists(branch->refname))
+			die(_("branch '%s' does not exist"), branch->name);
+
+		/*
+		 * create_branch takes care of setting up the tracking
+		 * info and making sure new_upstream is correct
+		 */
+		create_branch(head, branch->name, new_upstream, 0, 0, 0, quiet, BRAN=
CH_TRACK_OVERRIDE);
 	} else if (argc > 0 && argc <=3D 2) {
 		if (kinds !=3D REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a b=
ranch name"));
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a17f8b2..e9019ac 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -369,6 +369,20 @@ test_expect_success \
     'git tag foobar &&
      test_must_fail git branch --track my11 foobar'
=20
+test_expect_success 'use --set-upstream-to modify HEAD' \
+    'test_config branch.master.remote foo &&
+     test_config branch.master.merge foo &&
+     git branch my12
+     git branch --set-upstream-to my12 &&
+     test "$(git config branch.master.remote)" =3D "." &&
+     test "$(git config branch.master.merge)" =3D "refs/heads/my12"'
+
+test_expect_success 'use --set-upstream-to modify a particular branch'=
 \
+    'git branch my13
+     git branch --set-upstream-to master my13 &&
+     test "$(git config branch.my13.remote)" =3D "." &&
+     test "$(git config branch.my13.merge)" =3D "refs/heads/master"'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +000=
0	branch: Created from master
--=20
1.7.12.3.g0dd8ef6
