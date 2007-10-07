From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 8/8] Remove the --force flag to "stg rebase" and "stg
	pull"
Date: Mon, 08 Oct 2007 01:18:30 +0200
Message-ID: <20071007231830.12626.30574.stgit@yoghurt>
References: <20071007231446.12626.14259.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:19:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefPA-0003Ze-1M
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574AbXJGXTK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757518AbXJGXTK
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:19:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1381 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757319AbXJGXTH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:19:07 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IefOJ-0000MT-00; Mon, 08 Oct 2007 00:18:31 +0100
In-Reply-To: <20071007231446.12626.14259.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60247>

Instead, always behave as if the force flag was given; that is, don't
check if rebasing would leave a dangling commit behind. Reasons:

  * The check for this was very strict and caused a lot of false
    positives.

  * Everything is recorded in the reflog, so we can't actually lose
    commits.

This fixes bug 9181.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/common.py      |    9 +--------
 stgit/commands/pull.py        |    5 +----
 stgit/commands/rebase.py      |    5 +----
 stgit/stack.py                |    1 -
 t/t2100-pull-policy-fetch.sh  |   14 --------------
 t/t2102-pull-policy-rebase.sh |   24 ------------------------
 6 files changed, 3 insertions(+), 55 deletions(-)


diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 27a616f..9815400 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -318,14 +318,7 @@ def address_or_alias(addr_str):
                  for addr in addr_str.split(',')]
     return ', '.join([addr for addr in addr_list if addr])
=20
-def prepare_rebase(force=3DNone):
-    if not force:
-        # Be sure we won't loose results of stg-(un)commit by error.
-        # Do not require an existing orig-base for compatibility with =
0.12 and earlier.
-        origbase =3D crt_series._get_field('orig-base')
-        if origbase and crt_series.get_base() !=3D origbase:
-            raise CmdException, 'Rebasing would possibly lose data'
-
+def prepare_rebase():
     # pop all patches
     applied =3D crt_series.get_applied()
     if len(applied) > 0:
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 070db99..237bdd9 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -43,9 +43,6 @@ options =3D [make_option('-n', '--nopush',
                        action =3D 'store_true'),
            make_option('-m', '--merged',
                        help =3D 'check for patches merged upstream',
-                       action =3D 'store_true'),
-           make_option('--force',
-                       help =3D 'force rebase even if the stack based =
was moved by (un)commits',
                        action =3D 'store_true')]
=20
 def func(parser, options, args):
@@ -81,7 +78,7 @@ def func(parser, options, args):
     if policy not in ['pull', 'fetch-rebase', 'rebase']:
         raise GitConfigException, 'Unsupported pull-policy "%s"' % pol=
icy
=20
-    applied =3D prepare_rebase(force=3Doptions.force)
+    applied =3D prepare_rebase()
=20
     # pull the remote changes
     if policy =3D=3D 'pull':
diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index c68f8e7..513729a 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -34,9 +34,6 @@ options =3D [make_option('-n', '--nopush',
                        action =3D 'store_true'),
            make_option('-m', '--merged',
                        help =3D 'check for patches merged upstream',
-                       action =3D 'store_true'),
-           make_option('--force',
-                       help =3D 'force rebase even if the stack based =
was moved by (un)commits',
                        action =3D 'store_true')]
=20
 def func(parser, options, args):
@@ -56,7 +53,7 @@ def func(parser, options, args):
     if git_id(args[0]) =3D=3D None:
         raise GitException, 'Unknown revision: %s' % args[0]
        =20
-    applied =3D prepare_rebase(force=3Doptions.force)
+    applied =3D prepare_rebase()
     rebase(args[0])
     post_rebase(applied, options.nopush, options.merged)
=20
diff --git a/stgit/stack.py b/stgit/stack.py
index bdb4e38..94856b8 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -623,7 +623,6 @@ class Series(PatchSet):
=20
         self.create_empty_field('applied')
         self.create_empty_field('unapplied')
-        self._set_field('orig-base', git.get_head())
=20
         config.set(self.format_version_key(), str(FORMAT_VERSION))
=20
diff --git a/t/t2100-pull-policy-fetch.sh b/t/t2100-pull-policy-fetch.s=
h
index 1f50069..28901b1 100755
--- a/t/t2100-pull-policy-fetch.sh
+++ b/t/t2100-pull-policy-fetch.sh
@@ -55,18 +55,4 @@ test_expect_success \
     test `wc -l <clone/file2` =3D 3
     '
=20
-# this one exercises the guard against commits
-# (use a new file to avoid mistaking a conflict for a success)
-test_expect_success \
-    'New upstream commit and commit a patch in clone' \
-    '
-    (cd upstream && stg new u2 -m u2 &&
-     echo a > file3 && stg add file3 && stg refresh) &&
-    (cd clone && stg commit && stg new c2 -m c2 &&
-     echo a >> file && stg refresh)
-    '
-test_expect_success \
-    'Try to  and commit a patch in clone' \
-    '(cd clone && ! stg pull)'
-
 test_done
diff --git a/t/t2102-pull-policy-rebase.sh b/t/t2102-pull-policy-rebase=
=2Esh
index b2fbfcf..ce2e32f 100755
--- a/t/t2102-pull-policy-rebase.sh
+++ b/t/t2102-pull-policy-rebase.sh
@@ -36,28 +36,4 @@ test_expect_success \
     test `wc -l <file2` =3D 2
     '
=20
-# this one exercises the guard against commits
-# (use a new file to avoid mistaking a conflict for a success)
-test_expect_success \
-    'New commit in parent and commit a patch in stack' \
-    '
-    stg branch parent && stg new u2 -m u2 &&
-     echo c > file3 && stg add file3 && stg refresh &&
-    stg branch stack && stg commit && stg new c2 -m c2 &&
-     echo a >> file && stg refresh
-    '
-test_expect_success \
-    'Try to pull/rebase now that stack base has moved' \
-    '! stg pull'
-
-test_expect_success \
-    'Force the pull/rebase, but do not push yet' \
-    'stg pull --force --nopush'
-test_expect_success \
-    '...check we lost the committed patch' \
-    '! test -e file'
-test_expect_success \
-    '...and check we get a conflict while pushing' \
-    '! stg push'
-
 test_done
