From: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 3/6] Don't touch state after conflict in push
Date: Mon, 20 Aug 2007 10:12:00 +0200
Message-ID: <11875975232606-git-send-email-davidk@lysator.liu.se>
References: <11875975232619-git-send-email-davidk@lysator.liu.se>
 <1187597523433-git-send-email-davidk@lysator.liu.se>
 <11875975232734-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 10:36:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN2ka-0000iq-Ui
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 10:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394AbXHTIgg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 04:36:36 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755721AbXHTIgf
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 04:36:35 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:52182 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210AbXHTIge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 04:36:34 -0400
X-Greylist: delayed 1468 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2007 04:36:33 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 3F14D200A205;
	Mon, 20 Aug 2007 10:12:06 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 17409-01-7; Mon, 20 Aug 2007 10:12:05 +0200 (CEST)
Received: from morpheus (c83-253-22-183.bredband.comhem.se [83.253.22.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 67E37200A215;
	Mon, 20 Aug 2007 10:12:04 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id 5BD77BFC91; Mon, 20 Aug 2007 10:12:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc3.119.g1812
In-Reply-To: <11875975232734-git-send-email-davidk@lysator.liu.se>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56192>

=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>

This leaves the index and working tree in the state that merge-recursiv=
e
left it, with unmerged files in different stages, and the non-conflicti=
ng
changes in the index.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 stgit/stack.py |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 8b77943..0e43f75 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -728,6 +728,7 @@ class Series(PatchSet):
         config.unset(self.format_version_key())
=20
     def refresh_patch(self, files =3D None, message =3D None, edit =3D=
 False,
+                      empty =3D False,
                       show_patch =3D False,
                       cache_update =3D True,
                       author_name =3D None, author_email =3D None,
@@ -777,9 +778,16 @@ class Series(PatchSet):
=20
         bottom =3D patch.get_bottom()
=20
+        if empty:
+            tree_id =3D git.get_commit(bottom).get_tree()
+        else:
+            tree_id =3D None
+
         commit_id =3D git.commit(files =3D files,
                                message =3D descr, parents =3D [bottom]=
,
                                cache_update =3D cache_update,
+                               tree_id =3D tree_id,
+                               set_head =3D True,
                                allowempty =3D True,
                                author_name =3D author_name,
                                author_email =3D author_email,
@@ -1083,11 +1091,10 @@ class Series(PatchSet):
                     log =3D 'push'
                 self.refresh_patch(cache_update =3D False, log =3D log=
)
             else:
-                # we store the correctly merged files only for
-                # tracking the conflict history. Note that the
-                # git.merge() operations should always leave the index
-                # in a valid state (i.e. only stage 0 files)
-                self.refresh_patch(cache_update =3D False, log =3D 'pu=
sh(c)')
+                # we make the patch empty, with the merged state in
+                # the working tree.
+                self.refresh_patch(cache_update =3D False, empty =3D T=
rue,
+                                   log =3D 'push(c)')
                 raise StackException, str(ex)
=20
         return modified
--=20
1.5.3.rc3.119.g1812
