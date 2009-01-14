From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH] Check for local changes with "goto"
Date: Wed, 14 Jan 2009 22:59:45 +0000
Message-ID: <20090114225945.11098.88671.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 00:01:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNEjZ-0006Bo-05
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 00:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758299AbZANW7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 17:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760995AbZANW7v
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 17:59:51 -0500
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:29994 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760925AbZANW7u (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 17:59:50 -0500
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20090114225947.LUTM7670.mtaout03-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Wed, 14 Jan 2009 22:59:47 +0000
Received: from localhost.localdomain ([86.9.203.187])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20090114225947.MAAE19264.aamtaout01-winn.ispmail.ntl.com@localhost.localdomain>;
          Wed, 14 Jan 2009 22:59:47 +0000
User-Agent: StGit/0.14.3.293.g03d7
X-Cloudmark-Analysis: v=1.0 c=1 a=ikxhZRSC73EA:10 a=SNtqtAhqVTYA:10 a=J8AwYs8vHxt1yloFQywA:9 a=fmLI8-Me-xRgdbgk79kA:7 a=iqwJFoqA-m55N38YLE4ab_oTJYwA:4 a=XF7b4UCPwd8A:10 a=ZCfqrk5O2kgA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105724>

This is done by default, unless the --keep option is passed, for
consistency with the "pop" command.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/common.py  |    7 +++++++
 stgit/commands/goto.py    |    8 +++++++-
 t/t2300-refresh-subdir.sh |    2 +-
 t/t2800-goto-subdir.sh    |    4 ++--
 t/t3000-dirty-merge.sh    |    2 +-
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 6bb3685..8ae43ff 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -100,6 +100,13 @@ def check_conflicts():
                            ' then use "resolve <files>" or revert the'
                            ' changes with "status --reset".')
 
+def check_clean(repository):
+    """Check whether the index is up to date.
+    """
+    if not repository.default_index.is_clean():
+        raise CmdException('Repository not clean. Use "refresh" or '
+                           '"status --reset"')
+
 def print_crt_patch(crt_series, branch = None):
     if not branch:
         patch = crt_series.get_current()
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 60a917e..6483011 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -18,6 +18,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 from stgit.commands import common
 from stgit.lib import transaction
 from stgit import argparse
+from stgit.argparse import opt
 
 help = 'Push or pop patches to the given one'
 kind = 'stack'
@@ -27,7 +28,10 @@ Push/pop patches to/from the stack until the one given on the command
 line becomes current."""
 
 args = [argparse.other_applied_patches, argparse.unapplied_patches]
-options = []
+options = [
+    opt('-k', '--keep', action = 'store_true',
+        short = 'Keep the local changes')
+]
 
 directory = common.DirectoryHasRepositoryLib()
 
@@ -38,6 +42,8 @@ def func(parser, options, args):
 
     stack = directory.repository.current_stack
     iw = stack.repository.default_iw
+    if not options.keep:
+        common.check_clean(directory.repository)
     trans = transaction.StackTransaction(stack, 'goto')
     if patch in trans.applied:
         to_pop = set(trans.applied[trans.applied.index(patch)+1:])
diff --git a/t/t2300-refresh-subdir.sh b/t/t2300-refresh-subdir.sh
index d731a11..89c95db 100755
--- a/t/t2300-refresh-subdir.sh
+++ b/t/t2300-refresh-subdir.sh
@@ -65,7 +65,7 @@ test_expect_success 'refresh -u -p <subdir>' '
 
 test_expect_success 'refresh an unapplied patch' '
     stg refresh -u &&
-    stg goto p0 &&
+    stg goto --keep p0 &&
     test "$(stg status)" = "M foo.txt" &&
     stg refresh -p p1 &&
     test "$(stg status)" = "" &&
diff --git a/t/t2800-goto-subdir.sh b/t/t2800-goto-subdir.sh
index 28b8292..855972b 100755
--- a/t/t2800-goto-subdir.sh
+++ b/t/t2800-goto-subdir.sh
@@ -25,7 +25,7 @@ cat > expected2.txt <<EOF
 bar
 EOF
 test_expect_success 'Goto in subdirectory (just pop)' '
-    (cd foo && stg goto p1) &&
+    (cd foo && stg goto --keep p1) &&
     cat foo/bar > actual.txt &&
     test_cmp expected1.txt actual.txt &&
     ls foo > actual.txt &&
@@ -48,7 +48,7 @@ cat > expected2.txt <<EOF
 bar
 EOF
 test_expect_success 'Goto in subdirectory (conflicting push)' '
-    (cd foo && stg goto p3) ;
+    (cd foo && stg goto --keep p3) ;
     [ $? -eq 3 ] &&
     cat foo/bar > actual.txt &&
     test_cmp expected1.txt actual.txt &&
diff --git a/t/t3000-dirty-merge.sh b/t/t3000-dirty-merge.sh
index f0f79d5..419d86e 100755
--- a/t/t3000-dirty-merge.sh
+++ b/t/t3000-dirty-merge.sh
@@ -26,7 +26,7 @@ test_expect_success 'Push with dirty worktree' '
     echo 4 > a &&
     [ "$(echo $(stg series --applied --noprefix))" = "p1" ] &&
     [ "$(echo $(stg series --unapplied --noprefix))" = "p2" ] &&
-    conflict stg goto p2 &&
+    conflict stg goto --keep p2 &&
     [ "$(echo $(stg series --applied --noprefix))" = "p1" ] &&
     [ "$(echo $(stg series --unapplied --noprefix))" = "p2" ] &&
     [ "$(echo $(cat a))" = "4" ]
