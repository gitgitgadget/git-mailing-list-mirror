From: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 2/6] Don't try to merge files that merge-recursive already merged
Date: Mon, 20 Aug 2007 10:11:59 +0200
Message-ID: <11875975232734-git-send-email-davidk@lysator.liu.se>
References: <11875975232619-git-send-email-davidk@lysator.liu.se>
 <1187597523433-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 10:36:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN2kc-0000iq-3q
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 10:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033AbXHTIgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 04:36:40 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755721AbXHTIgj
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 04:36:39 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:52186 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533AbXHTIge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 04:36:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 97B1C200A215;
	Mon, 20 Aug 2007 10:12:06 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 18059-01-2; Mon, 20 Aug 2007 10:12:05 +0200 (CEST)
Received: from morpheus (c83-253-22-183.bredband.comhem.se [83.253.22.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 8790E200A219;
	Mon, 20 Aug 2007 10:12:04 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id 53B40BFC8B; Mon, 20 Aug 2007 10:12:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc3.119.g1812
In-Reply-To: <1187597523433-git-send-email-davidk@lysator.liu.se>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56193>

=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>

This avoid duplicating work, but also changes the resulting index state
so that the conflicts are left in the index in the three stages.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 stgit/git.py |   20 +-------------------
 1 files changed, 1 insertions(+), 19 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 9d8da5d..5e1548c 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -707,25 +707,7 @@ def merge_recursive(base, head1, head2):
         # error and we have to abort the merge
         raise GitException, err_output
=20
-    # merge the unmerged files
-    errors =3D False
-    for path in files:
-        # remove additional files that might be generated for some
-        # newer versions of GIT
-        for suffix in [base, head1, head2]:
-            if not suffix:
-                continue
-            fname =3D path + '~' + suffix
-            if os.path.exists(fname):
-                os.remove(fname)
-
-        stages =3D files[path]
-        if gitmergeonefile.merge(stages['1'][1], stages['2'][1],
-                                 stages['3'][1], path, stages['1'][0],
-                                 stages['2'][0], stages['3'][0]) !=3D =
0:
-            errors =3D True
-
-    if errors:
+    if files:
         raise GitException, 'GIT index merging failed (possible confli=
cts)'
=20
 def merge(base, head1, head2):
--=20
1.5.3.rc3.119.g1812
