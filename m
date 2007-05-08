From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH] Fix popping on non-active branches
Date: Wed, 09 May 2007 01:32:46 +0200
Message-ID: <20070508233133.6417.24979.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 01:35:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlZDT-0008E7-8L
	for gcvg-git@gmane.org; Wed, 09 May 2007 01:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S970277AbXEHXfN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 19:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S970273AbXEHXfM
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 19:35:12 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:38261 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S970201AbXEHXfJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2007 19:35:09 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:44971 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HlZD0-0005kd-8Q; Wed, 09 May 2007 01:35:07 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HlZAk-0001gW-Mc; Wed, 09 May 2007 01:32:46 +0200
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HlZD0-0005kd-8Q.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1HlZD0-0005kd-8Q 457ba169a850335befe22ca6d8038ad1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46638>

Resetting HEAD on the current branch when popping a patch on another
branch isn't a great idea.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/git.py   |    8 ++++++--
 stgit/stack.py |   13 +++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index d7eb48e..837f927 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -298,14 +298,18 @@ def set_head_file(ref):
              [os.path.join('refs', 'heads', ref)]) !=3D 0:
         raise GitException, 'Could not set head to "%s"' % ref
=20
+def set_branch(branch, val):
+    """Point branch at a new commit object."""
+    if __run('git-update-ref', [branch, val]) !=3D 0:
+        raise GitException, 'Could not update %s to "%s".' % (branch, =
val)
+
 def __set_head(val):
     """Sets the HEAD value
     """
     global __head
=20
     if not __head or __head !=3D val:
-        if __run('git-update-ref HEAD', [val]) !=3D 0:
-            raise GitException, 'Could not update HEAD to "%s".' % val
+        set_branch('HEAD', val)
         __head =3D val
=20
     # only allow SHA1 hashes
diff --git a/stgit/stack.py b/stgit/stack.py
index 3e9fc4f..76704e8 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -1063,12 +1063,13 @@ class Series(StgitObject):
=20
         patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
=20
-        # only keep the local changes
-        if keep and not git.apply_diff(git.get_head(), patch.get_botto=
m()):
-            raise StackException, \
-                  'Failed to pop patches while preserving the local ch=
anges'
-
-        git.switch(patch.get_bottom(), keep)
+        if git.get_head_file() =3D=3D self.get_branch():
+            if keep and not git.apply_diff(git.get_head(), patch.get_b=
ottom()):
+                raise StackException(
+                    'Failed to pop patches while preserving the local =
changes')
+            git.switch(patch.get_bottom(), keep)
+        else:
+            git.set_branch(self.get_branch(), patch.get_bottom())
=20
         # save the new applied list
         idx =3D applied.index(name) + 1
