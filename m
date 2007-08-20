From: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 6/6] Use the output from merge-recursive to list conflicts
Date: Mon, 20 Aug 2007 10:12:03 +0200
Message-ID: <11875975231887-git-send-email-davidk@lysator.liu.se>
References: <11875975232619-git-send-email-davidk@lysator.liu.se>
 <1187597523433-git-send-email-davidk@lysator.liu.se>
 <11875975232734-git-send-email-davidk@lysator.liu.se>
 <11875975232606-git-send-email-davidk@lysator.liu.se>
 <1187597523884-git-send-email-davidk@lysator.liu.se>
 <11875975233747-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 10:37:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN2l2-0000t4-VW
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 10:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756382AbXHTIgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 04:36:47 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756257AbXHTIgq
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 04:36:46 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:52195 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460AbXHTIgf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 04:36:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id E0FA1200A21B;
	Mon, 20 Aug 2007 10:12:08 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 18059-01-3; Mon, 20 Aug 2007 10:12:06 +0200 (CEST)
Received: from morpheus (c83-253-22-183.bredband.comhem.se [83.253.22.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id D0050200A21C;
	Mon, 20 Aug 2007 10:12:04 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id 79FE7BFC94; Mon, 20 Aug 2007 10:12:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc3.119.g1812
In-Reply-To: <11875975233747-git-send-email-davidk@lysator.liu.se>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56196>

=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>

merge-recursive already has useful information about what the conflicts
were, so we reuse that when pushing.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 stgit/git.py   |   27 +++++++++++++++++++++------
 stgit/stack.py |    2 ++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 63798bd..59423ab 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -30,7 +30,14 @@ from sets import Set
 class GitException(Exception):
     pass
=20
-
+class GitConflictException(GitException):
+    def __init__(self, conflicts):
+        GitException.__init__(self)
+        self.conflicts =3D conflicts
+    def __str__(self):
+        return "%d conflicts" % len(self.conflicts)
+    def list(self):
+        out.info(*self.conflicts)
=20
 #
 # Classes
@@ -675,11 +682,19 @@ def merge_recursive(base, head1, head2):
     """
     refresh_index()
=20
-    # use _output() to mask the verbose prints of the tool
-    try:
-        _output(['git-merge-recursive', base, '--', head1, head2])
-    except GitException:
-        raise GitException, 'GIT index merging failed (possible confli=
cts)'
+    # Duplicate _output(), since we need the exit status
+    p=3Dpopen2.Popen3(['git-merge-recursive', base, '--', head1, head2=
], True)
+    output =3D p.fromchild.readlines()
+    st =3D p.wait() >> 8
+    if st =3D=3D 0:
+        # No problems
+        return
+    elif st =3D=3D 1:
+        # There were conflicts
+        conflicts =3D [l.strip() for l in output if l.startswith('CONF=
LICT')]
+        raise GitConflictException(conflicts)
+    else:
+        raise GitException, 'git-merge-recursive failed (%s)' % (p.chi=
lderr.read().strip())
=20
 def merge(base, head1, head2):
     """Perform a 3-way merge between base, head1 and head2 into the
diff --git a/stgit/stack.py b/stgit/stack.py
index 0e43f75..3b06ca5 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -1070,6 +1070,8 @@ class Series(PatchSet):
                 # merge can fail but the patch needs to be pushed
                 try:
                     git.merge_recursive(bottom, head, top)
+                except git.GitConflictException, ex:
+                    ex.list()
                 except git.GitException, ex:
                     out.error('The merge failed during "push".',
                               'Use "refresh" after fixing the conflict=
s or'
--=20
1.5.3.rc3.119.g1812
