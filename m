From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 04/13] Split Series.push_patch in two
Date: Sat, 15 Sep 2007 00:31:29 +0200
Message-ID: <20070914223129.7001.11068.stgit@morpheus.local>
References: <20070914222819.7001.55921.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 15 00:31:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJhP-0001NS-Qw
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757762AbXINWbf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2007 18:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbXINWbe
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:31:34 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:56501 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757271AbXINWbd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:31:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id C2B27200A1CE;
	Sat, 15 Sep 2007 00:31:32 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 02165-01-80; Sat, 15 Sep 2007 00:31:29 +0200 (CEST)
Received: from morpheus (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id D6EE1200A1B8;
	Sat, 15 Sep 2007 00:31:29 +0200 (CEST)
Received: from morpheus.local (morpheus [127.0.0.1])
	by morpheus (Postfix) with ESMTP id 87D95BFA59;
	Sat, 15 Sep 2007 00:31:29 +0200 (CEST)
In-Reply-To: <20070914222819.7001.55921.stgit@morpheus.local>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58197>

The push_patch() function has a complex control flow and actually does
two different things depending on the 'empty' parameter. This patch
splits in in two functions without other code changes.

Later patches will refactor the code to simplify it.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 stgit/commands/common.py |    2 +
 stgit/stack.py           |   62 ++++++++++++++++++++++++++++++++++++++=
--------
 2 files changed, 52 insertions(+), 12 deletions(-)


diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index f3fa89d..eaaf5fc 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -184,7 +184,7 @@ def push_patches(patches, check_merged =3D False):
         out.start('Pushing patch "%s"' % p)
=20
         if p in merged:
-            crt_series.push_patch(p, empty =3D True)
+            crt_series.push_empty_patch(p)
             out.done('merged upstream')
         else:
             modified =3D crt_series.push_patch(p)
diff --git a/stgit/stack.py b/stgit/stack.py
index 906e6b1..79d6cf3 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -1022,7 +1022,55 @@ class Series(PatchSet):
=20
         return merged
=20
-    def push_patch(self, name, empty =3D False):
+    def push_empty_patch(self, name):
+        """Pushes an empty patch on the stack
+        """
+        unapplied =3D self.get_unapplied()
+        assert(name in unapplied)
+
+        patch =3D self.get_patch(name)
+
+        head =3D git.get_head()
+        bottom =3D patch.get_bottom()
+        top =3D patch.get_top()
+
+        ex =3D None
+        modified =3D False
+
+        # top !=3D bottom always since we have a commit for each patch
+        # just make an empty patch (top =3D bottom =3D HEAD). This
+        # option is useful to allow undoing already merged
+        # patches. The top is updated by refresh_patch since we
+        # need an empty commit
+        patch.set_bottom(head, backup =3D True)
+        patch.set_top(head, backup =3D True)
+        modified =3D True
+
+        append_string(self.__applied_file, name)
+
+        unapplied.remove(name)
+        write_strings(self.__unapplied_file, unapplied)
+
+        # head =3D=3D bottom case doesn't need to refresh the patch
+        if not ex:
+            # if the merge was OK and no conflicts, just refresh the p=
atch
+            # The GIT cache was already updated by the merge operation
+            if modified:
+                log =3D 'push(m)'
+            else:
+                log =3D 'push'
+            self.refresh_patch(cache_update =3D False, log =3D log)
+        else:
+            # we store the correctly merged files only for
+            # tracking the conflict history. Note that the
+            # git.merge() operations should always leave the index
+            # in a valid state (i.e. only stage 0 files)
+            self.refresh_patch(cache_update =3D False, log =3D 'push(c=
)')
+            raise StackException, str(ex)
+
+        return modified
+
+    def push_patch(self, name):
         """Pushes a patch on the stack
         """
         unapplied =3D self.get_unapplied()
@@ -1038,15 +1086,7 @@ class Series(PatchSet):
         modified =3D False
=20
         # top !=3D bottom always since we have a commit for each patch
-        if empty:
-            # just make an empty patch (top =3D bottom =3D HEAD). This
-            # option is useful to allow undoing already merged
-            # patches. The top is updated by refresh_patch since we
-            # need an empty commit
-            patch.set_bottom(head, backup =3D True)
-            patch.set_top(head, backup =3D True)
-            modified =3D True
-        elif head =3D=3D bottom:
+        if head =3D=3D bottom:
             # reset the backup information. No need for logging
             patch.set_bottom(bottom, backup =3D True)
             patch.set_top(top, backup =3D True)
@@ -1079,7 +1119,7 @@ class Series(PatchSet):
         write_strings(self.__unapplied_file, unapplied)
=20
         # head =3D=3D bottom case doesn't need to refresh the patch
-        if empty or head !=3D bottom:
+        if head !=3D bottom:
             if not ex:
                 # if the merge was OK and no conflicts, just refresh t=
he patch
                 # The GIT cache was already updated by the merge opera=
tion
