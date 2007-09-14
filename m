From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 05/13] Remove dead code from push_empty_patch
Date: Sat, 15 Sep 2007 00:31:34 +0200
Message-ID: <20070914223134.7001.98621.stgit@morpheus.local>
References: <20070914222819.7001.55921.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 15 00:31:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJhQ-0001NS-Ea
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758013AbXINWbi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2007 18:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbXINWbh
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:31:37 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:56505 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757999AbXINWbg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:31:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 033DD200A1D3;
	Sat, 15 Sep 2007 00:31:36 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06982-01-5; Sat, 15 Sep 2007 00:31:34 +0200 (CEST)
Received: from morpheus (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id DDA06200A1CE;
	Sat, 15 Sep 2007 00:31:34 +0200 (CEST)
Received: from morpheus.local (morpheus [127.0.0.1])
	by morpheus (Postfix) with ESMTP id 96613BFA59;
	Sat, 15 Sep 2007 00:31:34 +0200 (CEST)
In-Reply-To: <20070914222819.7001.55921.stgit@morpheus.local>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58195>

Since the split from push_patch, the push_empty_patch contains some
code that fills no purpose. Remove it and simplify the code.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 stgit/stack.py |   33 +++------------------------------
 1 files changed, 3 insertions(+), 30 deletions(-)


diff --git a/stgit/stack.py b/stgit/stack.py
index 79d6cf3..f31f308 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -1029,46 +1029,19 @@ class Series(PatchSet):
         assert(name in unapplied)
=20
         patch =3D self.get_patch(name)
-
         head =3D git.get_head()
-        bottom =3D patch.get_bottom()
-        top =3D patch.get_top()
-
-        ex =3D None
-        modified =3D False
=20
-        # top !=3D bottom always since we have a commit for each patch
-        # just make an empty patch (top =3D bottom =3D HEAD). This
-        # option is useful to allow undoing already merged
-        # patches. The top is updated by refresh_patch since we
-        # need an empty commit
+        # The top is updated by refresh_patch since we need an empty
+        # commit
         patch.set_bottom(head, backup =3D True)
         patch.set_top(head, backup =3D True)
-        modified =3D True
=20
         append_string(self.__applied_file, name)
=20
         unapplied.remove(name)
         write_strings(self.__unapplied_file, unapplied)
=20
-        # head =3D=3D bottom case doesn't need to refresh the patch
-        if not ex:
-            # if the merge was OK and no conflicts, just refresh the p=
atch
-            # The GIT cache was already updated by the merge operation
-            if modified:
-                log =3D 'push(m)'
-            else:
-                log =3D 'push'
-            self.refresh_patch(cache_update =3D False, log =3D log)
-        else:
-            # we store the correctly merged files only for
-            # tracking the conflict history. Note that the
-            # git.merge() operations should always leave the index
-            # in a valid state (i.e. only stage 0 files)
-            self.refresh_patch(cache_update =3D False, log =3D 'push(c=
)')
-            raise StackException, str(ex)
-
-        return modified
+        self.refresh_patch(cache_update =3D False, log =3D 'push(m)')
=20
     def push_patch(self, name):
         """Pushes a patch on the stack
