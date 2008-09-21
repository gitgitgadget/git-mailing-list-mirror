From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Add a new flag, --spill, to stg delete
Date: Sun, 21 Sep 2008 21:07:30 +0200
Message-ID: <20080921190730.4503.52714.stgit@yoghurt>
References: <20080921190708.4503.20574.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 21:09:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhUIq-0001mK-Gc
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 21:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbYIUTHd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2008 15:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbYIUTHd
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 15:07:33 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3159 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbYIUTHd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 15:07:33 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KhUcr-0003Zl-00; Sun, 21 Sep 2008 20:29:45 +0100
In-Reply-To: <20080921190708.4503.20574.stgit@yoghurt>
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96423>

It deletes the patches as usual, but doesn't touch index+worktree.
Useful for splitting up a patch, or undoing an "stg refresh".

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/delete.py |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)


diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index 1b59cdd..015fb49 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -30,6 +30,13 @@ Delete the patches passed as arguments."""
 args =3D [argparse.patch_range(argparse.applied_patches,
                              argparse.unapplied_patches)]
 options =3D [
+    opt('--spill', action =3D 'store_true',
+        short =3D 'Spill patch contents to worktree and index', long =3D=
 """
+        Delete the patches, but do not touch the index and worktree.
+        This only works with applied patches at the top of the stack.
+        The effect is to "spill" the patch contents into the index and
+        worktree. This can be useful e.g. if you want to split a patch
+        into several smaller pieces."""),
     opt('-b', '--branch', args =3D [argparse.stg_branches],
         short =3D 'Use BRANCH instead of the default branch')]
=20
@@ -46,6 +53,12 @@ def func(parser, options, args):
         patches =3D set(common.parse_patches(args, list(stack.patchord=
er.all)))
     else:
         parser.error('No patches specified')
+
+    if options.spill:
+        if set(stack.patchorder.applied[-len(patches):]) !=3D patches:
+            parser.error('Can only spill topmost applied patches')
+        iw =3D None # don't touch index+worktree
+
     def allow_conflicts(trans):
         # Allow conflicts if the topmost patch stays the same.
         if stack.patchorder.applied:
