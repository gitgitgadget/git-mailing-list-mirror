From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH] git-help: find library man pages again
Date: Thu, 2 Sep 2010 03:16:46 -0500
Message-ID: <20100902081646.GK29713@burratino>
References: <0b8d803551f495e2494b43c6d95163daca82f62b.1283356852.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 02 10:18:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or50a-0007SQ-29
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 10:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881Ab0IBISq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 04:18:46 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34380 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab0IBISk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 04:18:40 -0400
Received: by ywh1 with SMTP id 1so77776ywh.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1v6xHi1aO99UburFuVr625m3csBWVz3d3nuUCX+Wffo=;
        b=wviqqzn4LKTMKa+fePKSWPH2zFO2SspdUVl1L3GQb/1YCQaAoXqaQl4SEJiSHMgzOF
         H+2sxqrIa+mhLyGvfSzLUniqsit5KO9xNQg84fgX7pd2kbAzEs8uvQ4q4x54qO1BObVQ
         WBEO6aubr39z/KPSdnNLUqCsAiH28SYdSh6i8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=WE80/WK6fOlRAZbyVAbRW0jd9AkFWNbrR+DtZwmw7OLxwsAVkHq1DBbHPOWTWgD5ot
         chC3HbgCcC1Ipud51K3+3+HlLC10mvi0UMHoVk5TMY2MIzBl1BXon1zQi+znFdzg8CNm
         D9pxhab8Ga83zSkVneu6KKKYrNbqsCtNtfLN4=
Received: by 10.100.235.10 with SMTP id i10mr9677428anh.1.1283415519044;
        Thu, 02 Sep 2010 01:18:39 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id k11sm286003ani.30.2010.09.02.01.18.37
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 01:18:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0b8d803551f495e2494b43c6d95163daca82f62b.1283356852.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155109>

Michael J Gruber wrote:

> 46bac90 (Do not install shell libraries executable, 2010-01-31) chang=
ed
> the executable bits of shell variables in order to avoid false report=
s
> from valgrind. As a side effect, this inhibits "git help" from findin=
g
> the corresponding man pages because list_command_in_dir() (called by
> load_command_list()) checks that bit.

Hmm.  Thanks for noticing.

Isn't the main purpose of that check to populate the list of commands
produced by "git help -a"?

> make
> list_command_in_dir() ignore the executable bit when looking in the e=
xec
> dir, so that the following man pages are found again by "git-help":
>=20
> git-mergetool--lib
> git-parse-remote
> git-sh-setup
[...]
>     This does not help with the man page for git-remote-helpers which=
 is installed
>     but not found by git-help either. That is a different issue, thou=
gh.

Therefore this seems wrong to me (except as a backward-compatibility
measure).  i.e. I think that is the same issue after all and that
builtin/help.c ought to learn another heuristic than is_git_command().

How about something like this?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/Makefile                   |   10 +++++-----
 Documentation/diff-options.txt           |    6 +++---
 Documentation/git-add.txt                |    2 +-
 Documentation/git-cat-file.txt           |    2 +-
 Documentation/git-check-ref-format.txt   |    2 +-
 Documentation/git-cherry-pick.txt        |    2 +-
 Documentation/git-cli.txt                |    6 +++---
 Documentation/git-commit.txt             |    4 ++--
 Documentation/git-core-tutorial.txt      |   20 ++++++++++----------
 Documentation/git-cvs-migration.txt      |   22 +++++++++++-----------
 Documentation/git-cvsimport.txt          |    2 +-
 Documentation/git-cvsserver.txt          |    2 +-
 Documentation/git-diff.txt               |    4 ++--
 Documentation/git-diffcore.txt           |    8 ++++----
 Documentation/git-fast-import.txt        |    2 +-
 Documentation/git-format-patch.txt       |    2 +-
 Documentation/git-gc.txt                 |    2 +-
 Documentation/git-glossary.txt           |   12 ++++++------
 Documentation/git-hooks.txt              |    6 +++---
 Documentation/git-log.txt                |    2 +-
 Documentation/git-push.txt               |    2 +-
 Documentation/git-rebase.txt             |    2 +-
 Documentation/git-reflog.txt             |    2 +-
 Documentation/git-repository-layout.txt  |   10 +++++-----
 Documentation/git-rev-parse.txt          |    2 +-
 Documentation/git-revert.txt             |    2 +-
 Documentation/git-revisions.txt          |    6 +++---
 Documentation/git-show-branch.txt        |    2 +-
 Documentation/git-show-ref.txt           |    2 +-
 Documentation/git-show.txt               |    2 +-
 Documentation/git-tutorial-2.txt         |   24 ++++++++++++----------=
--
 Documentation/git-tutorial.txt           |   24 ++++++++++++----------=
--
 Documentation/git-update-server-info.txt |    2 +-
 Documentation/git-workflows.txt          |    8 ++++----
 Documentation/git.txt                    |   28 ++++++++++++++--------=
------
 Documentation/gitk.txt                   |    2 +-
 Documentation/pt_BR/gittutorial.txt      |   14 +++++++-------
 Documentation/user-manual.txt            |   14 +++++++-------
 Makefile                                 |   22 +++++++++++-----------
 builtin/help.c                           |    4 +---
 40 files changed, 145 insertions(+), 147 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a4c4063..e0ca3dd 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -2,11 +2,11 @@ MAN1_TXT=3D \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
 	gitk.txt git.txt
-MAN5_TXT=3Dgitattributes.txt gitignore.txt gitmodules.txt githooks.txt=
 \
-	gitrepository-layout.txt
-MAN7_TXT=3Dgitcli.txt gittutorial.txt gittutorial-2.txt \
-	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt \
-	gitdiffcore.txt gitrevisions.txt gitworkflows.txt
+MAN5_TXT=3Dgitattributes.txt gitignore.txt gitmodules.txt git-hooks.tx=
t \
+	git-repository-layout.txt
+MAN7_TXT=3Dgit-cli.txt git-tutorial.txt git-tutorial-2.txt \
+	git-cvs-migration.txt git-core-tutorial.txt git-glossary.txt \
+	git-diffcore.txt git-revisions.txt git-workflows.txt
=20
 MAN_TXT =3D $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=3D$(patsubst %.txt,%.xml,$(MAN_TXT))
diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 4656a97..c483470 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -168,7 +168,7 @@ A match that contains a newline is silently truncat=
ed(!) at the
 newline.
 +
 The regex can also be set via a diff driver or configuration option, s=
ee
-linkgit:gitattributes[1] or linkgit:git-config[1].  Giving it explicit=
ly
+linkgit:gitattributes[5] or linkgit:git-config[1].  Giving it explicit=
ly
 overrides any diff driver or configuration setting.  Diff drivers
 override configuration settings.
=20
@@ -282,7 +282,7 @@ ifndef::git-format-patch[]
 	Look for differences that introduce or remove an instance of
 	<string>. Note that this is different than the string simply
 	appearing in diff output; see the 'pickaxe' entry in
-	linkgit:gitdiffcore[7] for more details.
+	linkgit:git-diffcore[7] for more details.
=20
 --pickaxe-all::
 	When `-S` finds a change, show all the changes in that
@@ -376,4 +376,4 @@ endif::git-format-patch[]
 	Do not show any source or destination prefix.
=20
 For more detailed explanation on these common options, see also
-linkgit:gitdiffcore[7].
+linkgit:git-diffcore[7].
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index e22a62f..ebe533a 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -151,7 +151,7 @@ Configuration
 The optional configuration variable `core.excludesfile` indicates a pa=
th to a
 file containing patterns of file names to exclude from git-add, simila=
r to
 $GIT_DIR/info/exclude.  Patterns in the exclude file are used in addit=
ion to
-those in info/exclude.  See linkgit:gitrepository-layout[5].
+those in info/exclude.  See linkgit:git-repository-layout[5].
=20
=20
 EXAMPLES
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-fil=
e.txt
index a3f56b0..561414f 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -27,7 +27,7 @@ OPTIONS
 <object>::
 	The name of the object to show.
 	For a more complete list of ways to spell object names, see
-	the "SPECIFYING REVISIONS" section in linkgit:gitrevisions[1].
+	the "SPECIFYING REVISIONS" section in linkgit:git-revisions[7].
=20
 -t::
 	Instead of the content, show the object type identified by
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git=
-check-ref-format.txt
index f5c2e06..a1d2e0f 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -49,7 +49,7 @@ git imposes the following rules on how references are=
 named:
 These rules make it easy for shell script based tools to parse
 reference names, pathname expansion by the shell when a reference name=
 is used
 unquoted (by mistake), and also avoids ambiguities in certain
-reference name expressions (see linkgit:gitrevisions[1]):
+reference name expressions (see linkgit:git-revisions[7]):
=20
 . A double-dot `..` is often used as in `ref1..ref2`, and in some
   contexts this notation means `{caret}ref1 ref2` (i.e. not in
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cher=
ry-pick.txt
index 2cef579..2167c46 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -21,7 +21,7 @@ OPTIONS
 <commit>...::
 	Commits to cherry-pick.
 	For a more complete list of ways to spell commits, see
-	linkgit:gitrevisions[1].
+	linkgit:git-revisions[7].
 	Sets of commits can be passed but no traversal is done by
 	default, as if the '--no-walk' option was specified, see
 	linkgit:git-rev-list[1].
diff --git a/Documentation/git-cli.txt b/Documentation/git-cli.txt
index 6928724..c490fc6 100644
--- a/Documentation/git-cli.txt
+++ b/Documentation/git-cli.txt
@@ -1,9 +1,9 @@
-gitcli(7)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
+git-cli(7)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 NAME
 ----
-gitcli - git command line interface and conventions
+git-cli - git command line interface and conventions
=20
 SYNOPSIS
 --------
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 42fb1f5..ca31b38 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -124,7 +124,7 @@ OPTIONS
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
-	See also linkgit:githooks[5].
+	See also linkgit:git-hooks[5].
=20
 --allow-empty::
 	Usually recording a commit that has the exact same tree as its
@@ -371,7 +371,7 @@ order).  See linkgit:git-var[1] for details.
 HOOKS
 -----
 This command can run `commit-msg`, `prepare-commit-msg`, `pre-commit`,
-and `post-commit` hooks.  See linkgit:githooks[5] for more
+and `post-commit` hooks.  See linkgit:git-hooks[5] for more
 information.
=20
=20
diff --git a/Documentation/git-core-tutorial.txt b/Documentation/git-co=
re-tutorial.txt
index ed3ddc9..0908438 100644
--- a/Documentation/git-core-tutorial.txt
+++ b/Documentation/git-core-tutorial.txt
@@ -1,9 +1,9 @@
-gitcore-tutorial(7)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+git-core-tutorial(7)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 NAME
 ----
-gitcore-tutorial - A git core tutorial for developers
+git-core-tutorial - A git core tutorial for developers
=20
 SYNOPSIS
 --------
@@ -16,7 +16,7 @@ This tutorial explains how to use the "core" git comm=
ands to set up and
 work with a git repository.
=20
 If you just need to use git as a revision control system you may prefe=
r
-to start with "A Tutorial Introduction to GIT" (linkgit:gittutorial[7]=
) or
+to start with "A Tutorial Introduction to GIT" (linkgit:git-tutorial[7=
]) or
 link:user-manual.html[the GIT User Manual].
=20
 However, an understanding of these low-level tools can be helpful if
@@ -116,7 +116,7 @@ references in these `refs` subdirectories when you =
actually start
 populating your tree.
=20
 [NOTE]
-An advanced user may want to take a look at linkgit:gitrepository-layo=
ut[5]
+An advanced user may want to take a look at linkgit:git-repository-lay=
out[5]
 after finishing this tutorial.
=20
 You have now created your first git repository. Of course, since it's
@@ -971,7 +971,7 @@ commits from the master branch.  The string inside =
brackets
 before the commit log message is a short name you can use to
 name the commit.  In the above example, 'master' and 'mybranch'
 are branch heads.  'master^' is the first parent of 'master'
-branch head.  Please see linkgit:gitrevisions[1] if you want to
+branch head.  Please see linkgit:git-revisions[7] if you want to
 see more complex cases.
=20
 [NOTE]
@@ -1596,7 +1596,7 @@ suggested in the previous section may be new to y=
ou. You do not
 have to worry. git supports "shared public repository" style of
 cooperation you are probably more familiar with as well.
=20
-See linkgit:gitcvs-migration[7] for the details.
+See linkgit:git-cvs-migration[7] for the details.
=20
 Bundling your work together
 ---------------------------
@@ -1697,9 +1697,9 @@ to follow, not easier.
=20
 SEE ALSO
 --------
-linkgit:gittutorial[7],
-linkgit:gittutorial-2[7],
-linkgit:gitcvs-migration[7],
+linkgit:git-tutorial[7],
+linkgit:git-tutorial-2[7],
+linkgit:git-cvs-migration[7],
 linkgit:git-help[1],
 link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
diff --git a/Documentation/git-cvs-migration.txt b/Documentation/git-cv=
s-migration.txt
index d861ec4..1568771 100644
--- a/Documentation/git-cvs-migration.txt
+++ b/Documentation/git-cvs-migration.txt
@@ -1,9 +1,9 @@
-gitcvs-migration(7)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+git-cvs-migration(7)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 NAME
 ----
-gitcvs-migration - git for CVS users
+git-cvs-migration - git for CVS users
=20
 SYNOPSIS
 --------
@@ -19,8 +19,8 @@ designating a single shared repository which people c=
an synchronize with;
 this document explains how to do that.
=20
 Some basic familiarity with git is required. Having gone through
-linkgit:gittutorial[7] and
-linkgit:gitglossary[7] should be sufficient.
+linkgit:git-tutorial[7] and
+linkgit:git-glossary[7] should be sufficient.
=20
 Developing against a shared repository
 --------------------------------------
@@ -82,7 +82,7 @@ Setting Up a Shared Repository
=20
 We assume you have already created a git repository for your project,
 possibly created from scratch or from a tarball (see
-linkgit:gittutorial[7]), or imported from an already existing CVS
+linkgit:git-tutorial[7]), or imported from an already existing CVS
 repository (see the next section).
=20
 Assume your existing repo is at /home/alice/myproject.  Create a new "=
bare"
@@ -153,7 +153,7 @@ Advanced Shared Repository Management
=20
 Git allows you to specify scripts called "hooks" to be run at certain
 points.  You can use these, for example, to send all commits to the sh=
ared
-repository to a mailing list.  See linkgit:githooks[5].
+repository to a mailing list.  See linkgit:git-hooks[5].
=20
 You can enforce finer grained permissions using update hooks.  See
 link:howto/update-hook-example.txt[Controlling access to branches usin=
g
@@ -189,10 +189,10 @@ repositories without the need for a central maint=
ainer.
=20
 SEE ALSO
 --------
-linkgit:gittutorial[7],
-linkgit:gittutorial-2[7],
-linkgit:gitcore-tutorial[7],
-linkgit:gitglossary[7],
+linkgit:git-tutorial[7],
+linkgit:git-tutorial-2[7],
+linkgit:git-core-tutorial[7],
+linkgit:git-glossary[7],
 link:everyday.html[Everyday Git],
 link:user-manual.html[The Git User's Manual]
=20
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimp=
ort.txt
index 608cd63..20feadc 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -38,7 +38,7 @@ If you intend to set up a shared public repository th=
at all developers can
 read/write, or if you want to use linkgit:git-cvsserver[1], then you
 probably want to make a bare clone of the imported repository,
 and use the clone as the shared repository.
-See linkgit:gitcvs-migration[7].
+See linkgit:git-cvs-migration[7].
=20
=20
 OPTIONS
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsser=
ver.txt
index f4472c6..ccc9e1e 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -163,7 +163,7 @@ write access to the log file and to the database (s=
ee
 SSH, the users of course also need write access to the git repository =
itself.
=20
 You also need to ensure that each repository is "bare" (without a git =
index
-file) for `cvs commit` to work. See linkgit:gitcvs-migration[7].
+file) for `cvs commit` to work. See linkgit:git-cvs-migration[7].
=20
 [[configaccessmethod]]
 All configuration variables can also be overridden for a specific meth=
od of
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 08fd409..23e2afc 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -68,11 +68,11 @@ for the last two forms that use ".." notations, can=
 be any
 <tree-ish>.
=20
 For a more complete list of ways to spell <commit>, see
-"SPECIFYING REVISIONS" section in linkgit:gitrevisions[1].
+"SPECIFYING REVISIONS" section in linkgit:git-revisions[7].
 However, "diff" is about comparing two _endpoints_, not ranges,
 and the range notations ("<commit>..<commit>" and
 "<commit>\...<commit>") do not mean a range as defined in the
-"SPECIFYING RANGES" section in linkgit:gitrevisions[1].
+"SPECIFYING RANGES" section in linkgit:git-revisions[7].
=20
 OPTIONS
 -------
diff --git a/Documentation/git-diffcore.txt b/Documentation/git-diffcor=
e.txt
index 5d91a7e..73c9d6b 100644
--- a/Documentation/git-diffcore.txt
+++ b/Documentation/git-diffcore.txt
@@ -1,9 +1,9 @@
-gitdiffcore(7)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+git-diffcore(7)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 NAME
 ----
-gitdiffcore - Tweaking diff output
+git-diffcore - Tweaking diff output
=20
 SYNOPSIS
 --------
@@ -273,7 +273,7 @@ linkgit:git-diff-index[1],
 linkgit:git-diff-tree[1],
 linkgit:git-format-patch[1],
 linkgit:git-log[1],
-linkgit:gitglossary[7],
+linkgit:git-glossary[7],
 link:user-manual.html[The Git User's Manual]
=20
 GIT
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast=
-import.txt
index 966ba4f..9229991 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -439,7 +439,7 @@ Marks must be declared (via `mark`) before they can=
 be used.
 * A complete 40 byte or abbreviated commit SHA-1 in hex.
=20
 * Any valid Git SHA-1 expression that resolves to a commit.  See
-  ``SPECIFYING REVISIONS'' in linkgit:gitrevisions[1] for details.
+  ``SPECIFYING REVISIONS'' in linkgit:git-revisions[7] for details.
=20
 The special case of restarting an incremental import from the
 current branch value should be written as:
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
index 4b3f5ba..c5711b1 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -39,7 +39,7 @@ There are two ways to specify which commits to operat=
e on.
    that leads to the <since> to be output.
=20
 2. Generic <revision range> expression (see "SPECIFYING
-   REVISIONS" section in linkgit:gitrevisions[1]) means the
+   REVISIONS" section in linkgit:git-revisions[7]) means the
    commits in the specified range.
=20
 The first rule takes precedence in the case of a single <commit>.  To
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 315f07e..f8cc38f 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -141,7 +141,7 @@ HOOKS
 -----
=20
 The 'git gc --auto' command will run the 'pre-auto-gc' hook.  See
-linkgit:githooks[5] for more information.
+linkgit:git-hooks[5] for more information.
=20
=20
 SEE ALSO
diff --git a/Documentation/git-glossary.txt b/Documentation/git-glossar=
y.txt
index d77a45a..c8157fe 100644
--- a/Documentation/git-glossary.txt
+++ b/Documentation/git-glossary.txt
@@ -1,9 +1,9 @@
-gitglossary(7)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+git-glossary(7)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 NAME
 ----
-gitglossary - A GIT Glossary
+git-glossary - A GIT Glossary
=20
 SYNOPSIS
 --------
@@ -16,9 +16,9 @@ include::glossary-content.txt[]
=20
 SEE ALSO
 --------
-linkgit:gittutorial[7],
-linkgit:gittutorial-2[7],
-linkgit:gitcvs-migration[7],
+linkgit:git-tutorial[7],
+linkgit:git-tutorial-2[7],
+linkgit:git-cvs-migration[7],
 link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
=20
diff --git a/Documentation/git-hooks.txt b/Documentation/git-hooks.txt
index 7183aa9..4eb0bac 100644
--- a/Documentation/git-hooks.txt
+++ b/Documentation/git-hooks.txt
@@ -1,9 +1,9 @@
-githooks(5)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+git-hooks(5)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 NAME
 ----
-githooks - Hooks used by git
+git-hooks - Hooks used by git
=20
 SYNOPSIS
 --------
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index c213bdb..16d60ce 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -31,7 +31,7 @@ OPTIONS
 	either <since> or <until> is omitted, it defaults to
 	`HEAD`, i.e. the tip of the current branch.
 	For a more complete list of ways to spell <since>
-	and <until>, see linkgit:gitrevisions[1].
+	and <until>, see linkgit:git-revisions[7].
=20
 --follow::
 	Continue listing the history of a file beyond renames
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 658ff2f..06c28cc 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -41,7 +41,7 @@ OPTIONS[[OPTIONS]]
 +
 The <src> is often the name of the branch you would want to push, but
 it can be any arbitrary "SHA-1 expression", such as `master~4` or
-`HEAD` (see linkgit:gitrevisions[1]).
+`HEAD` (see linkgit:git-revisions[7]).
 +
 The <dst> tells which ref on the remote side is updated with this
 push. Arbitrary expressions cannot be used here, an actual ref must
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 3b87f1a..d2b12ed 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -274,7 +274,7 @@ which makes little sense.
 	Do not show a diffstat as part of the rebase process.
=20
 --no-verify::
-	This option bypasses the pre-rebase hook.  See also linkgit:githooks[=
5].
+	This option bypasses the pre-rebase hook.  See also linkgit:git-hooks=
[5].
=20
 -C<n>::
 	Ensure at least <n> lines of surrounding context match before
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.tx=
t
index 5a0451a..7429f16 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -40,7 +40,7 @@ see linkgit:git-log[1].
 The reflog is useful in various git commands, to specify the old value
 of a reference. For example, `HEAD@\{2\}` means "where HEAD used to be
 two moves ago", `master@\{one.week.ago\}` means "where master used to
-point to one week ago", and so on. See linkgit:gitrevisions[1] for
+point to one week ago", and so on. See linkgit:git-revisions[7] for
 more details.
=20
 To delete single entries from the reflog, use the subcommand "delete"
diff --git a/Documentation/git-repository-layout.txt b/Documentation/gi=
t-repository-layout.txt
index eb3d040..c9950a2 100644
--- a/Documentation/git-repository-layout.txt
+++ b/Documentation/git-repository-layout.txt
@@ -1,9 +1,9 @@
-gitrepository-layout(5)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+git-repository-layout(5)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 NAME
 ----
-gitrepository-layout - Git Repository Layout
+git-repository-layout - Git Repository Layout
=20
 SYNOPSIS
 --------
@@ -136,7 +136,7 @@ hooks::
 	'git init' is run, but all of them are disabled by
 	default.  To enable, the `.sample` suffix has to be
 	removed from the filename by renaming.
-	Read linkgit:githooks[5] for more details about
+	Read linkgit:git-hooks[5] for more details about
 	each hook.
=20
 index::
@@ -201,7 +201,7 @@ linkgit:git-fetch[1],
 linkgit:git-pack-refs[1],
 linkgit:git-gc[1],
 linkgit:git-checkout[1],
-linkgit:gitglossary[7],
+linkgit:git-glossary[7],
 link:user-manual.html[The Git User's Manual]
=20
 GIT
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index be4c053..2c62e05 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -219,7 +219,7 @@ Each line of options has this format:
=20
 	* Use `*` to mean that this option should not be listed in the usage
 	  generated for the `-h` argument. It's shown for `--help-all` as
-	  documented in linkgit:gitcli[7].
+	  documented in linkgit:git-cli[7].
=20
 	* Use `!` to not make the corresponding negated long option available=
=2E
=20
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.tx=
t
index b7d9ef7..a4dcd2d 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -31,7 +31,7 @@ OPTIONS
 <commit>...::
 	Commits to revert.
 	For a more complete list of ways to spell commit names, see
-	linkgit:gitrevisions[1].
+	linkgit:git-revisions[7].
 	Sets of commits can also be given but no traversal is done by
 	default, see linkgit:git-rev-list[1] and its '--no-walk'
 	option.
diff --git a/Documentation/git-revisions.txt b/Documentation/git-revisi=
ons.txt
index fc4789f..cb481dd 100644
--- a/Documentation/git-revisions.txt
+++ b/Documentation/git-revisions.txt
@@ -1,13 +1,13 @@
-gitrevisions(7)
+git-revisions(7)
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 NAME
 ----
-gitrevisions - specifying revisions and ranges for git
+git-revisions - specifying revisions and ranges for git
=20
 SYNOPSIS
 --------
-gitrevisions
+<commit>, ^<commit>, <commit>^n, :<path>, <stage>:<path>, <commit>:<pa=
th>
=20
=20
 DESCRIPTION
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show=
-branch.txt
index 81ba296..115d8b6 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -32,7 +32,7 @@ no <rev> nor <glob> is given on the command line.
 OPTIONS
 -------
 <rev>::
-	Arbitrary extended SHA1 expression (see linkgit:gitrevisions[1])
+	Arbitrary extended SHA1 expression (see linkgit:git-revisions[7])
 	that typically names a branch head or a tag.
=20
 <glob>::
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-re=
f.txt
index 75780d7..f191b96 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -171,7 +171,7 @@ SEE ALSO
 --------
 linkgit:git-ls-remote[1],
 linkgit:git-update-ref[1],
-linkgit:gitrepository-layout[5]
+linkgit:git-repository-layout[5]
=20
 AUTHORS
 -------
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 0002bfb..00d1a9a 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -36,7 +36,7 @@ OPTIONS
 <object>...::
 	The names of objects to show.
 	For a more complete list of ways to spell object names, see
-	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[1].
+	"SPECIFYING REVISIONS" section in linkgit:git-revisions[7].
=20
 include::pretty-options.txt[]
=20
diff --git a/Documentation/git-tutorial-2.txt b/Documentation/git-tutor=
ial-2.txt
index ecab0c0..fe0bd51 100644
--- a/Documentation/git-tutorial-2.txt
+++ b/Documentation/git-tutorial-2.txt
@@ -1,9 +1,9 @@
-gittutorial-2(7)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+git-tutorial-2(7)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 NAME
 ----
-gittutorial-2 - A tutorial introduction to git: part two
+git-tutorial-2 - A tutorial introduction to git: part two
=20
 SYNOPSIS
 --------
@@ -12,7 +12,7 @@ git *
 DESCRIPTION
 -----------
=20
-You should work through linkgit:gittutorial[7] before reading this tut=
orial.
+You should work through linkgit:git-tutorial[7] before reading this tu=
torial.
=20
 The goal of this tutorial is to introduce two fundamental pieces of
 git's architecture--the object database and the index file--and to
@@ -394,7 +394,7 @@ in the index file is identical to the one in the wo=
rking directory.
 In addition to being the staging area for new commits, the index file
 is also populated from the object database when checking out a
 branch, and is used to hold the trees involved in a merge operation.
-See linkgit:gitcore-tutorial[7] and the relevant man
+See linkgit:git-core-tutorial[7] and the relevant man
 pages for details.
=20
 What next?
@@ -403,28 +403,28 @@ What next?
 At this point you should know everything necessary to read the man
 pages for any of the git commands; one good place to start would be
 with the commands mentioned in link:everyday.html[Everyday git].  You
-should be able to find any unknown jargon in linkgit:gitglossary[7].
+should be able to find any unknown jargon in linkgit:git-glossary[7].
=20
 The link:user-manual.html[Git User's Manual] provides a more
 comprehensive introduction to git.
=20
-linkgit:gitcvs-migration[7] explains how to
+linkgit:git-cvs-migration[7] explains how to
 import a CVS repository into git, and shows how to use git in a
 CVS-like way.
=20
 For some interesting examples of git use, see the
 link:howto-index.html[howtos].
=20
-For git developers, linkgit:gitcore-tutorial[7] goes
+For git developers, linkgit:git-core-tutorial[7] goes
 into detail on the lower-level git mechanisms involved in, for
 example, creating a new commit.
=20
 SEE ALSO
 --------
-linkgit:gittutorial[7],
-linkgit:gitcvs-migration[7],
-linkgit:gitcore-tutorial[7],
-linkgit:gitglossary[7],
+linkgit:git-tutorial[7],
+linkgit:git-cvs-migration[7],
+linkgit:git-core-tutorial[7],
+linkgit:git-glossary[7],
 linkgit:git-help[1],
 link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
diff --git a/Documentation/git-tutorial.txt b/Documentation/git-tutoria=
l.txt
index 1c16066..beedba6 100644
--- a/Documentation/git-tutorial.txt
+++ b/Documentation/git-tutorial.txt
@@ -1,9 +1,9 @@
-gittutorial(7)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+git-tutorial(7)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 NAME
 ----
-gittutorial - A tutorial introduction to git (for version 1.5.1 or new=
er)
+git-tutorial - A tutorial introduction to git (for version 1.5.1 or ne=
wer)
=20
 SYNOPSIS
 --------
@@ -452,7 +452,7 @@ see linkgit:git-pull[1] for details.
=20
 Git can also be used in a CVS-like mode, with a central repository
 that various users push changes to; see linkgit:git-push[1] and
-linkgit:gitcvs-migration[7].
+linkgit:git-cvs-migration[7].
=20
 Exploring history
 -----------------
@@ -633,7 +633,7 @@ is based:
=20
 Part two of this tutorial explains the object
 database, the index file, and a few other odds and ends that you'll
-need to make the most of git. You can find it at linkgit:gittutorial-2=
[7].
+need to make the most of git. You can find it at linkgit:git-tutorial-=
2[7].
=20
 If you don't want to continue with that right away, a few other
 digressions that may be interesting at this point are:
@@ -650,21 +650,21 @@ digressions that may be interesting at this point=
 are:
     smart enough to perform a close-to-optimal search even in the
     case of complex non-linear history with lots of merged branches.
=20
-  * linkgit:gitworkflows[7]: Gives an overview of recommended
+  * linkgit:git-workflows[7]: Gives an overview of recommended
     workflows.
=20
   * link:everyday.html[Everyday GIT with 20 Commands Or So]
=20
-  * linkgit:gitcvs-migration[7]: Git for CVS users.
+  * linkgit:git-cvs-migration[7]: Git for CVS users.
=20
 SEE ALSO
 --------
-linkgit:gittutorial-2[7],
-linkgit:gitcvs-migration[7],
-linkgit:gitcore-tutorial[7],
-linkgit:gitglossary[7],
+linkgit:git-tutorial-2[7],
+linkgit:git-cvs-migration[7],
+linkgit:git-core-tutorial[7],
+linkgit:git-glossary[7],
 linkgit:git-help[1],
-linkgit:gitworkflows[7],
+linkgit:git-workflows[7],
 link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
=20
diff --git a/Documentation/git-update-server-info.txt b/Documentation/g=
it-update-server-info.txt
index 035cc30..6f1c56f 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -31,7 +31,7 @@ OUTPUT
 ------
=20
 Currently the command updates the following files.  Please see
-linkgit:gitrepository-layout[5] for description of
+linkgit:git-repository-layout[5] for description of
 what they are for:
=20
 * objects/info/packs
diff --git a/Documentation/git-workflows.txt b/Documentation/git-workfl=
ows.txt
index 1ef55ff..01febd4 100644
--- a/Documentation/git-workflows.txt
+++ b/Documentation/git-workflows.txt
@@ -1,9 +1,9 @@
-gitworkflows(7)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+git-workflows(7)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 NAME
 ----
-gitworkflows - An overview of recommended workflows with git
+git-workflows - An overview of recommended workflows with git
=20
 SYNOPSIS
 --------
@@ -465,7 +465,7 @@ other options.
=20
 SEE ALSO
 --------
-linkgit:gittutorial[7],
+linkgit:git-tutorial[7],
 linkgit:git-push[1],
 linkgit:git-pull[1],
 linkgit:git-merge[1],
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 5317893..4fa2b70 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -21,10 +21,10 @@ Git is a fast, scalable, distributed revision contr=
ol system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
=20
-See linkgit:gittutorial[7] to get started, then see
+See linkgit:git-tutorial[7] to get started, then see
 link:everyday.html[Everyday Git] for a useful minimum set of commands,=
 and
 "man git-commandname" for documentation of each command.  CVS users ma=
y
-also want to read linkgit:gitcvs-migration[7].  See
+also want to read linkgit:git-cvs-migration[7].  See
 the link:user-manual.html[Git User's Manual] for a more in-depth
 introduction.
=20
@@ -300,10 +300,10 @@ See the references above to get started using git=
=2E  The following is
 probably more detail than necessary for a first-time user.
=20
 The link:user-manual.html#git-concepts[git concepts chapter of the
-user-manual] and linkgit:gitcore-tutorial[7] both provide
+user-manual] and linkgit:git-core-tutorial[7] both provide
 introductions to the underlying git architecture.
=20
-See linkgit:gitworkflows[7] for an overview of recommended workflows.
+See linkgit:git-workflows[7] for an overview of recommended workflows.
=20
 See also the link:howto-index.html[howto] documents for some useful
 examples.
@@ -488,15 +488,15 @@ HEAD::
 	(i.e. the contents of `$GIT_DIR/refs/heads/<head>`).
=20
 For a more complete list of ways to spell object names, see
-"SPECIFYING REVISIONS" section in linkgit:gitrevisions[1].
+"SPECIFYING REVISIONS" section in linkgit:git-revisions[7].
=20
=20
 File/Directory Structure
 ------------------------
=20
-Please see the linkgit:gitrepository-layout[5] document.
+Please see the linkgit:git-repository-layout[5] document.
=20
-Read linkgit:githooks[5] for more details about each hook.
+Read linkgit:git-hooks[5] for more details about each hook.
=20
 Higher level SCMs may provide and manage additional information in the
 `$GIT_DIR`.
@@ -504,7 +504,7 @@ Higher level SCMs may provide and manage additional=
 information in the
=20
 Terminology
 -----------
-Please see linkgit:gitglossary[7].
+Please see linkgit:git-glossary[7].
=20
=20
 Environment Variables
@@ -667,7 +667,7 @@ Discussion[[Discussion]]
=20
 More detail on the following is available from the
 link:user-manual.html#git-concepts[git concepts chapter of the
-user-manual] and linkgit:gitcore-tutorial[7].
+user-manual] and linkgit:git-core-tutorial[7].
=20
 A git project normally consists of a working directory with a ".git"
 subdirectory at the top level.  The .git directory contains, among oth=
er
@@ -737,11 +737,11 @@ subscribed to the list to send a message there.
=20
 SEE ALSO
 --------
-linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-link:everyday.html[Everyday Git], linkgit:gitcvs-migration[7],
-linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
-linkgit:gitcli[7], link:user-manual.html[The Git User's Manual],
-linkgit:gitworkflows[7]
+linkgit:git-tutorial[7], linkgit:git-tutorial-2[7],
+link:everyday.html[Everyday Git], linkgit:git-cvs-migration[7],
+linkgit:git-glossary[7], linkgit:git-core-tutorial[7],
+linkgit:git-cli[7], link:user-manual.html[The Git User's Manual],
+linkgit:git-workflows[7]
=20
 GIT
 ---
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 05ac1c7..fde793a 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -69,7 +69,7 @@ frequently used options.
 	the form "'<from>'..'<to>'" to show all revisions between '<from>' an=
d
 	back to '<to>'. Note, more advanced revision selection can be applied=
=2E
 	For a more complete list of ways to spell object names, see
-	linkgit:gitrevisions[1].
+	linkgit:git-revisions[7].
=20
 <path>...::
=20
diff --git a/Documentation/pt_BR/gittutorial.txt b/Documentation/pt_BR/=
gittutorial.txt
index beba065..5ae4b2a 100644
--- a/Documentation/pt_BR/gittutorial.txt
+++ b/Documentation/pt_BR/gittutorial.txt
@@ -457,7 +457,7 @@ http; veja linkgit:git-pull[1] para detalhes.
=20
 Git pode tamb=C3=A9m ser usado em um modo parecido com CVS, com um
 reposit=C3=B3rio central para o qual v=C3=A1rios usu=C3=A1rios empurra=
m modifica=C3=A7=C3=B5es;
-veja linkgit:git-push[1] e linkgit:gitcvs-migration[7].
+veja linkgit:git-push[1] e linkgit:git-cvs-migration[7].
=20
 Explorando hist=C3=B3ria
 -----------------
@@ -639,7 +639,7 @@ id=C3=A9ias simples nas quais ele se baseia:
=20
 A parte dois deste tutorial explica a base de objetos, o arquivo de
 =C3=ADndice, e algumas outras coisinhas que voc=C3=AA vai precisar pra=
 usar o
-m=C3=A1ximo do git. Voc=C3=AA pode encontr=C3=A1-la em linkgit:gittuto=
rial-2[7].
+m=C3=A1ximo do git. Voc=C3=AA pode encontr=C3=A1-la em linkgit:git-tut=
orial-2[7].
=20
 Se voc=C3=AA n=C3=A3o quiser continuar com o tutorial agora nesse mome=
nto, algumas
 outras digress=C3=B5es que podem ser interessantes neste ponto s=C3=A3=
o:
@@ -658,14 +658,14 @@ outras digress=C3=B5es que podem ser interessante=
s neste ponto s=C3=A3o:
=20
   * link:everyday.html[GIT diariamente com 20 e tantos comandos]
=20
-  * linkgit:gitcvs-migration[7]: Git para usu=C3=A1rios de CVS.
+  * linkgit:git-cvs-migration[7]: Git para usu=C3=A1rios de CVS.
=20
 VEJA TAMB=C3=89M
 --------
-linkgit:gittutorial-2[7],
-linkgit:gitcvs-migration[7],
-linkgit:gitcore-tutorial[7],
-linkgit:gitglossary[7],
+linkgit:git-tutorial-2[7],
+linkgit:git-cvs-migration[7],
+linkgit:git-core-tutorial[7],
+linkgit:git-glossary[7],
 linkgit:git-help[1],
 link:everyday.html[git diariamente],
 link:user-manual.html[O Manual do Usu=C3=A1rio git]
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index 22aee34..54f02e7 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -397,7 +397,7 @@ is usually a shortcut for the HEAD branch in the re=
pository "origin".
 For the complete list of paths which git checks for references, and
 the order it uses to decide which to choose when there are multiple
 references with the same shorthand name, see the "SPECIFYING
-REVISIONS" section of linkgit:gitrevisions[1].
+REVISIONS" section of linkgit:git-revisions[1].
=20
 [[Updating-a-repository-With-git-fetch]]
 Updating a repository with git fetch
@@ -568,7 +568,7 @@ We have seen several ways of naming commits already=
:
 	- HEAD: refers to the head of the current branch
=20
 There are many more; see the "SPECIFYING REVISIONS" section of the
-linkgit:gitrevisions[1] man page for the complete list of ways to
+linkgit:git-revisions[7] man page for the complete list of ways to
 name revisions.  Some examples:
=20
 -------------------------------------------------
@@ -909,7 +909,7 @@ commits reachable from some head but not from any t=
ag in the repository:
 $ gitk $( git show-ref --heads ) --not  $( git show-ref --tags )
 -------------------------------------------------
=20
-(See linkgit:gitrevisions[1] for explanations of commit-selecting
+(See linkgit:git-revisions[7] for explanations of commit-selecting
 syntax such as `--not`.)
=20
 [[making-a-release]]
@@ -1635,7 +1635,7 @@ you've checked out.
 The reflogs are kept by default for 30 days, after which they may be
 pruned.  See linkgit:git-reflog[1] and linkgit:git-gc[1] to learn
 how to control this pruning, and see the "SPECIFYING REVISIONS"
-section of linkgit:gitrevisions[1] for details.
+section of linkgit:git-revisions[7] for details.
=20
 Note that the reflog history is very different from normal git history=
=2E
 While normal history is shared by every repository that works on the
@@ -1920,7 +1920,7 @@ $ mv hooks/post-update.sample hooks/post-update
 -------------------------------------------------
=20
 (For an explanation of the last two lines, see
-linkgit:git-update-server-info[1] and linkgit:githooks[5].)
+linkgit:git-update-server-info[1] and linkgit:git-hooks[5].)
=20
 Advertise the URL of proj.git.  Anybody else should then be able to
 clone or pull from that URL, for example with a command line like:
@@ -2032,7 +2032,7 @@ the right to push to the same repository.  In tha=
t case, the correct
 solution is to retry the push after first updating your work: either b=
y a
 pull, or by a fetch followed by a rebase; see the
 <<setting-up-a-shared-repository,next section>> and
-linkgit:gitcvs-migration[7] for more.
+linkgit:git-cvs-migration[7] for more.
=20
 [[setting-up-a-shared-repository]]
 Setting up a shared repository
@@ -2041,7 +2041,7 @@ Setting up a shared repository
 Another way to collaborate is by using a model similar to that
 commonly used in CVS, where several developers with special rights
 all push to and pull from a single shared repository.  See
-linkgit:gitcvs-migration[7] for instructions on how to
+linkgit:git-cvs-migration[7] for instructions on how to
 set this up.
=20
 However, while there is nothing wrong with git's support for shared
diff --git a/Makefile b/Makefile
index b4745a5..f3c369f 100644
--- a/Makefile
+++ b/Makefile
@@ -2256,20 +2256,20 @@ check-docs::
 		documented,gitattributes | \
 		documented,gitignore | \
 		documented,gitmodules | \
-		documented,gitcli | \
+		documented,git-cli | \
 		documented,git-tools | \
-		documented,gitcore-tutorial | \
-		documented,gitcvs-migration | \
-		documented,gitdiffcore | \
-		documented,gitglossary | \
-		documented,githooks | \
-		documented,gitrepository-layout | \
-		documented,gitrevisions | \
-		documented,gittutorial | \
-		documented,gittutorial-2 | \
+		documented,git-core-tutorial | \
+		documented,git-cvs-migration | \
+		documented,git-diffcore | \
+		documented,git-glossary | \
+		documented,git-hooks | \
+		documented,git-repository-layout | \
+		documented,git-revisions | \
+		documented,git-tutorial | \
+		documented,git-tutorial-2 | \
 		documented,git-bisect-lk2009 | \
 		documented,git-remote-helpers | \
-		documented,gitworkflows | \
+		documented,git-workflows | \
 		sentinel,not,matching,is,ok ) continue ;; \
 		esac; \
 		case " $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git gitk " in \
diff --git a/builtin/help.c b/builtin/help.c
index 61ff798..d1f6736 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -310,10 +310,8 @@ static const char *cmd_to_page(const char *git_cmd=
)
 		return "git";
 	else if (!prefixcmp(git_cmd, "git"))
 		return git_cmd;
-	else if (is_git_command(git_cmd))
-		return prepend("git-", git_cmd);
 	else
-		return prepend("git", git_cmd);
+		return prepend("git-", git_cmd);
 }
=20
 static void setup_man_path(void)
--=20
