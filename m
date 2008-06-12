From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 06/14] Log conflicts separately
Date: Thu, 12 Jun 2008 07:34:44 +0200
Message-ID: <20080612053444.23549.59793.stgit@yoghurt>
References: <20080612052913.23549.69687.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 07:35:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6fTQ-0004xa-Cn
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 07:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbYFLFew convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2008 01:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbYFLFew
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 01:34:52 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2165 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbYFLFeu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 01:34:50 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K6fSP-00014v-00; Thu, 12 Jun 2008 06:34:45 +0100
In-Reply-To: <20080612052913.23549.69687.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84708>

This patch makes commands that produce a conflict log that final
conflicting push separately from the rest of the command's effects.
This makes it possible for the user to roll back just the final
conflicting push if she desires. (Rolling back the whole operation is
of course still possible, by resetting to the state yet another step
back in the log.)

This change only applies to the new-infrastructure commands.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/transaction.py |   47 +++++++++++++++++++++++++++++++-------=
--------
 1 files changed, 32 insertions(+), 15 deletions(-)


diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 16f5a4b..6347b14 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -79,6 +79,7 @@ class StackTransaction(object):
         self.__patches =3D _TransPatchMap(stack)
         self.__applied =3D list(self.__stack.patchorder.applied)
         self.__unapplied =3D list(self.__stack.patchorder.unapplied)
+        self.__conflicting_push =3D None
         self.__error =3D None
         self.__current_tree =3D self.__stack.head.data.tree
         self.__base =3D self.__stack.base
@@ -160,19 +161,26 @@ class StackTransaction(object):
             out.error(self.__error)
=20
         # Write patches.
-        for pn, commit in self.__patches.iteritems():
-            if self.__stack.patches.exists(pn):
-                p =3D self.__stack.patches.get(pn)
-                if commit =3D=3D None:
-                    p.delete()
+        def write(msg):
+            for pn, commit in self.__patches.iteritems():
+                if self.__stack.patches.exists(pn):
+                    p =3D self.__stack.patches.get(pn)
+                    if commit =3D=3D None:
+                        p.delete()
+                    else:
+                        p.set_commit(commit, msg)
                 else:
-                    p.set_commit(commit, self.__msg)
-            else:
-                self.__stack.patches.new(pn, commit, self.__msg)
-        _print_current_patch(self.__stack.patchorder.applied, self.__a=
pplied)
-        self.__stack.patchorder.applied =3D self.__applied
-        self.__stack.patchorder.unapplied =3D self.__unapplied
-        log.log_entry(self.__stack, self.__msg)
+                    self.__stack.patches.new(pn, commit, msg)
+            self.__stack.patchorder.applied =3D self.__applied
+            self.__stack.patchorder.unapplied =3D self.__unapplied
+            log.log_entry(self.__stack, msg)
+        old_applied =3D self.__stack.patchorder.applied
+        write(self.__msg)
+        if self.__conflicting_push !=3D None:
+            self.__patches =3D _TransPatchMap(self.__stack)
+            self.__conflicting_push()
+            write(self.__msg + ' (CONFLICT)')
+        _print_current_patch(old_applied, self.__applied)
=20
         if self.__error:
             return utils.STGIT_CONFLICT
@@ -264,18 +272,27 @@ class StackTransaction(object):
         cd =3D cd.set_tree(tree)
         if any(getattr(cd, a) !=3D getattr(orig_cd, a) for a in
                ['parent', 'tree', 'author', 'message']):
-            self.patches[pn] =3D self.__stack.repository.commit(cd)
+            comm =3D self.__stack.repository.commit(cd)
         else:
+            comm =3D None
             s =3D ' (unmodified)'
-        del self.unapplied[self.unapplied.index(pn)]
-        self.applied.append(pn)
         out.info('Pushed %s%s' % (pn, s))
+        def update():
+            if comm:
+                self.patches[pn] =3D comm
+            del self.unapplied[self.unapplied.index(pn)]
+            self.applied.append(pn)
         if merge_conflict:
             # We've just caused conflicts, so we must allow them in
             # the final checkout.
             self.__allow_conflicts =3D lambda trans: True
=20
+            # Save this update so that we can run it a little later.
+            self.__conflicting_push =3D update
             self.__halt('Merge conflict')
+        else:
+            # Update immediately.
+            update()
=20
     def reorder_patches(self, applied, unapplied, iw =3D None):
         """Push and pop patches to attain the given ordering."""
