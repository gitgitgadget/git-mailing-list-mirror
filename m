From: Jeff King <peff@peff.net>
Subject: [PATCH] setup_git_directory: delay core.bare/core.worktree errors
Date: Fri, 29 May 2015 02:49:10 -0400
Message-ID: <20150529064910.GA2987@peff.net>
References: <20150527123147.Horde.GqzoX-7JvXiOGBlB5moP4A8@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 29 08:49:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyE6Z-0005Gc-8d
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 08:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984AbbE2GtP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2015 02:49:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:37494 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752030AbbE2GtN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 02:49:13 -0400
Received: (qmail 6028 invoked by uid 102); 29 May 2015 06:49:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 May 2015 01:49:13 -0500
Received: (qmail 23311 invoked by uid 107); 29 May 2015 06:49:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 May 2015 02:49:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 May 2015 02:49:10 -0400
Content-Disposition: inline
In-Reply-To: <20150527123147.Horde.GqzoX-7JvXiOGBlB5moP4A8@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270208>

On Wed, May 27, 2015 at 12:31:47PM +0200, SZEDER G=C3=A1bor wrote:

> Some thoughts:
>=20
>    1) Perhaps 'git config' should be more careful in the first place
>       and refuse to set 'core.worktree' when 'core.bare' is already
>       true and vice versa.

Right now git-config doesn't know anything about the meaning of the
config variables; that logic is spread throughout the code, at the
actual users of the variables. So I'm a little hesitant to special-case
this one problem (especially because I think we can fix this in a
different way).

>    2) The damage was done with 'git config', so I expected that I can
>       repair it with "plain" 'git config' (i.e. without 'git -c') as
>       well.  'git config' has nothing to do with the path to the
>       worktree after all.  And 'git config --edit' should work
>       regardless of the mess that might be in the config file.

The problem is that setup_git_directory is overly eager to die in this
case (even when we use the "gentle" form to indicate we can handle bein=
g
outside of a repo). Patch is below.

>    3) 'git help <cmd>' should always work, shouldn't it?  (Though
>       that's the easiest to remedy, just cd out of the repo, or fire
>       up a new terminal window.)

It looks in the repo (gently) so that it can find repo-specific config
like help.format. And thus gets caught in the same problem as
git-config.

-- >8 --
Subject: setup_git_directory: delay core.bare/core.worktree errors

If both core.bare and core.worktree are set, we complain
about the bogus config and die. Dying is good, because it
avoids commands running and doing damage in a potentially
incorrect setup. But dying _there_ is bad, because it means
that commands which do not even care about the work tree
cannot run. This can make repairing the situation harder:

  [setup]
  $ git config core.bare true
  $ git config core.worktree /some/path

  [OK, expected.]
  $ git status
  fatal: core.bare and core.worktree do not make sense

  [Hrm...]
  $ git config --unset core.worktree
  fatal: core.bare and core.worktree do not make sense

  [Nope...]
  $ git config --edit
  fatal: core.bare and core.worktree do not make sense

  [Gaaah.]
  $ git help config
  fatal: core.bare and core.worktree do not make sense

Instead, let's issue a warning about the bogus config when
we notice it (i.e., for all commands), but only die when the
command tries to use the work tree (by calling setup_work_tree).
So we now get:

  $ git status
  warning: core.bare and core.worktree do not make sense
  fatal: unable to set up work tree using invalid config

  $ git config --unset core.worktree
  warning: core.bare and core.worktree do not make sense

We have to update t1510 to accomodate this; it uses
symbolic-ref to check whether the configuration works or
not, but of course that command does not use the working
tree. Instead, we switch it to use `git status`, as it
requires a work-tree, does not need any special setup, and
is read-only (so a failure will not adversely affect further
tests).

In addition, we add a new test that checks the desired
behavior (i.e., that running "git config" with the bogus
config does in fact work).

Reported-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Jeff King <peff@peff.net>
---
The message for "git status" is a little clunky (first we warn, then we
say "wait, that warning was important!"). I also considered dropping th=
e
warning (so you'd see nothing in the "git config" case) and then just
moving the die() to setup_work_tree().

 setup.c               | 12 ++++++++++--
 t/t1510-repo-setup.sh | 24 ++++++++++++++++--------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/setup.c b/setup.c
index 863ddfd..82c0cc2 100644
--- a/setup.c
+++ b/setup.c
@@ -4,6 +4,7 @@
=20
 static int inside_git_dir =3D -1;
 static int inside_work_tree =3D -1;
+static int work_tree_config_is_bogus;
=20
 /*
  * The input parameter must contain an absolute path, and it must alre=
ady be
@@ -327,6 +328,10 @@ void setup_work_tree(void)
=20
 	if (initialized)
 		return;
+
+	if (work_tree_config_is_bogus)
+		die("unable to set up work tree using invalid config");
+
 	work_tree =3D get_git_work_tree();
 	git_dir =3D get_git_dir();
 	if (!is_absolute_path(git_dir))
@@ -495,8 +500,11 @@ static const char *setup_explicit_git_dir(const ch=
ar *gitdirenv,
 	if (work_tree_env)
 		set_git_work_tree(work_tree_env);
 	else if (is_bare_repository_cfg > 0) {
-		if (git_work_tree_cfg) /* #22.2, #30 */
-			die("core.bare and core.worktree do not make sense");
+		if (git_work_tree_cfg) {
+			/* #22.2, #30 */
+			warning("core.bare and core.worktree do not make sense");
+			work_tree_config_is_bogus =3D 1;
+		}
=20
 		/* #18, #26 */
 		set_git_dir(gitdirenv);
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 33c1a58..13ae12d 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -599,11 +599,20 @@ test_expect_success '#20b/c: core.worktree and co=
re.bare conflict' '
 	mkdir -p 20b/.git/wt/sub &&
 	(
 		cd 20b/.git &&
-		test_must_fail git symbolic-ref HEAD >/dev/null
+		test_must_fail git status >/dev/null
 	) 2>message &&
 	grep "core.bare and core.worktree" message
 '
=20
+test_expect_success '#20d: core.worktree and core.bare OK when working=
 tree not needed' '
+	setup_repo 20d non-existent "" true &&
+	mkdir -p 20d/.git/wt/sub &&
+	(
+		cd 20d/.git &&
+		git config foo.bar value
+	)
+'
+
 # Case #21: core.worktree/GIT_WORK_TREE overrides core.bare' '
 test_expect_success '#21: setup, core.worktree warns before overriding=
 core.bare' '
 	setup_repo 21 non-existent "" unset &&
@@ -612,7 +621,7 @@ test_expect_success '#21: setup, core.worktree warn=
s before overriding core.bare
 		cd 21/.git &&
 		GIT_WORK_TREE=3D"$here/21" &&
 		export GIT_WORK_TREE &&
-		git symbolic-ref HEAD >/dev/null
+		git status >/dev/null
 	) 2>message &&
 	! test -s message
=20
@@ -701,13 +710,13 @@ test_expect_success '#22.2: core.worktree and cor=
e.bare conflict' '
 		cd 22/.git &&
 		GIT_DIR=3D. &&
 		export GIT_DIR &&
-		test_must_fail git symbolic-ref HEAD 2>result
+		test_must_fail git status 2>result
 	) &&
 	(
 		cd 22 &&
 		GIT_DIR=3D.git &&
 		export GIT_DIR &&
-		test_must_fail git symbolic-ref HEAD 2>result
+		test_must_fail git status 2>result
 	) &&
 	grep "core.bare and core.worktree" 22/.git/result &&
 	grep "core.bare and core.worktree" 22/result
@@ -753,9 +762,8 @@ test_expect_success '#28: core.worktree and core.ba=
re conflict (gitfile case)' '
 	setup_repo 28 "$here/28" gitfile true &&
 	(
 		cd 28 &&
-		test_must_fail git symbolic-ref HEAD
+		test_must_fail git status
 	) 2>message &&
-	! grep "^warning:" message &&
 	grep "core.bare and core.worktree" message
 '
=20
@@ -767,7 +775,7 @@ test_expect_success '#29: setup' '
 		cd 29 &&
 		GIT_WORK_TREE=3D"$here/29" &&
 		export GIT_WORK_TREE &&
-		git symbolic-ref HEAD >/dev/null
+		git status
 	) 2>message &&
 	! test -s message
 '
@@ -778,7 +786,7 @@ test_expect_success '#30: core.worktree and core.ba=
re conflict (gitfile version)
 	setup_repo 30 "$here/30" gitfile true &&
 	(
 		cd 30 &&
-		test_must_fail env GIT_DIR=3D.git git symbolic-ref HEAD 2>result
+		test_must_fail env GIT_DIR=3D.git git status 2>result
 	) &&
 	grep "core.bare and core.worktree" 30/result
 '
--=20
2.4.2.668.gc3b1ade.dirty
