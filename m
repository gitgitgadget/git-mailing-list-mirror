From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 5/5] Uncommit to a named commit
Date: Fri, 11 May 2007 03:40:27 +0200
Message-ID: <20070511014027.13161.869.stgit@yoghurt>
References: <20070511013400.13161.9160.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 03:47:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmKEK-0005NJ-Bd
	for gcvg-git@gmane.org; Fri, 11 May 2007 03:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775AbXEKBrc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 10 May 2007 21:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756185AbXEKBrc
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 21:47:32 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:41795 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754775AbXEKBrb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2007 21:47:31 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:38577 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HmKEB-00082E-9G; Fri, 11 May 2007 03:47:30 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HmK7P-0003Tm-VX; Fri, 11 May 2007 03:40:27 +0200
In-Reply-To: <20070511013400.13161.9160.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HmKEB-00082E-9G.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1HmKEB-00082E-9G 4b7e20125f5c788936b870cd0b519b62
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46924>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

Add a new flag to "stg uncommit": --to. This flag takes a committish
parameter, and uncommits everything up until that commit.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/commands/uncommit.py |   49 +++++++++++++++++++++++++++++++-----=
--------
 t/t1300-uncommit.sh        |    8 +++++++
 2 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index f86af57..de6a37c 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -25,7 +25,7 @@ from stgit.utils import *
 from stgit import stack, git
=20
 help =3D 'turn regular GIT commits into StGIT patches'
-usage =3D """%prog [<patchname1> [<patchname2> ... ] | -n [<prefix>]]
+usage =3D """%prog [<patchnames>] | -n NUM [<prefix>]] | -t <committis=
h>
=20
 Take one or more git commits at the base of the current stack and turn
 them into StGIT patches. The new patches are created as applied patche=
s
@@ -35,24 +35,34 @@ By default, the number of patches to uncommit is de=
termined by the
 number of patch names provided on the command line. First name is used
 for the first patch to uncommit, i.e. for the newest patch.
=20
-The --number option specifies the number of patches to uncommit.  In
+The -n/--number option specifies the number of patches to uncommit. In
 this case, at most one patch name may be specified. It is used as
-prefix to which the patch number is appended.
+prefix to which the patch number is appended. If no patch names are
+provided on the command line, StGIT automatically generates them based
+on the first line of the patch description.
=20
-If no patch names are provided on the command line, StGIT
-automatically generates them based on the first line of the patch
-description.
+The -t/--to option specifies that all commits up to and including the
+given commit should be uncommitted.
=20
 Only commits with exactly one parent can be uncommitted; in other
 words, you can't uncommit a merge."""
=20
 options =3D [make_option('-n', '--number', type =3D 'int',
-                       help =3D 'uncommit the specified number of comm=
its')]
+                       help =3D 'uncommit the specified number of comm=
its'),
+           make_option('-t', '--to',
+                       help =3D 'uncommit to the specified commit')]
=20
 def func(parser, options, args):
     """Uncommit a number of patches.
     """
-    if options.number:
+    if options.to:
+        if options.number:
+            parser.error('cannot give both --to and --number')
+        if len(args) !=3D 0:
+            parser.error('cannot specify patch name with --to')
+        patch_nr =3D patchnames =3D None
+        to_commit =3D git.rev_parse(options.to)
+    elif options.number:
         if options.number <=3D 0:
             parser.error('invalid value passed to --number')
=20
@@ -77,9 +87,6 @@ def func(parser, options, args):
         raise CmdException, \
               'This branch is protected. Uncommit is not permitted'
=20
-    print 'Uncommitting %d patches...' % patch_nr,
-    sys.stdout.flush()
-
     def get_commit(commit_id):
         commit =3D git.Commit(commit_id)
         try:
@@ -91,11 +98,23 @@ def func(parser, options, args):
=20
     commits =3D []
     next_commit =3D crt_series.get_base()
-    for i in xrange(patch_nr):
-        commit, commit_id, parent =3D get_commit(next_commit)
-        commits.append((commit, commit_id, parent))
-        next_commit =3D parent
+    if patch_nr:
+        print 'Uncommitting %d patches...' % patch_nr,
+        for i in xrange(patch_nr):
+            commit, commit_id, parent =3D get_commit(next_commit)
+            commits.append((commit, commit_id, parent))
+            next_commit =3D parent
+    else:
+        print 'Uncommitting to %s...' % to_commit
+        while True:
+            commit, commit_id, parent =3D get_commit(next_commit)
+            commits.append((commit, commit_id, parent))
+            if commit_id =3D=3D to_commit:
+                break
+            next_commit =3D parent
+        patch_nr =3D len(commits)
=20
+    sys.stdout.flush()
     for (commit, commit_id, parent), patchname in \
         zip(commits, patchnames or (None for i in xrange(len(commits))=
)):
         author_name, author_email, author_date =3D \
diff --git a/t/t1300-uncommit.sh b/t/t1300-uncommit.sh
index 519234e..2e7ff21 100755
--- a/t/t1300-uncommit.sh
+++ b/t/t1300-uncommit.sh
@@ -70,4 +70,12 @@ test_expect_success \
 	[ "$(stg id foo-patch//top)" =3D "$(stg id bar-patch//bottom)" ] &&
 	stg commit
 	'
+
+test_expect_success \
+    'Uncommit the patches with --to' '
+    stg uncommit --to HEAD^ &&
+    [ "$(stg id foo-patch//top)" =3D "$(stg id bar-patch//bottom)" ] &=
&
+    stg commit
+'
+
 test_done
