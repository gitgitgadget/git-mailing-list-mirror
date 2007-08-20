From: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 5/6] Simplify merge_recursive
Date: Mon, 20 Aug 2007 10:12:02 +0200
Message-ID: <11875975233747-git-send-email-davidk@lysator.liu.se>
References: <11875975232619-git-send-email-davidk@lysator.liu.se>
 <1187597523433-git-send-email-davidk@lysator.liu.se>
 <11875975232734-git-send-email-davidk@lysator.liu.se>
 <11875975232606-git-send-email-davidk@lysator.liu.se>
 <1187597523884-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 10:37:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN2l2-0000t4-Ei
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 10:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309AbXHTIgp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 04:36:45 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756034AbXHTIgn
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 04:36:43 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:52194 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755815AbXHTIgf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 04:36:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id D8380200A219;
	Mon, 20 Aug 2007 10:12:07 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 17409-01-8; Mon, 20 Aug 2007 10:12:06 +0200 (CEST)
Received: from morpheus (c83-253-22-183.bredband.comhem.se [83.253.22.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 986D6200A21B;
	Mon, 20 Aug 2007 10:12:04 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id 6B5B0BFC93; Mon, 20 Aug 2007 10:12:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc3.119.g1812
In-Reply-To: <1187597523884-git-send-email-davidk@lysator.liu.se>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56195>

=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>

Listing the unmerged files is unnecessary, since the information
isn't really used anyway. Just note if the merge failed or succeeded.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 stgit/git.py |   33 ++-------------------------------
 1 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 5e1548c..63798bd 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -675,39 +675,10 @@ def merge_recursive(base, head1, head2):
     """
     refresh_index()
=20
-    err_output =3D None
-    # this operation tracks renames but it is slower (used in
-    # general when pushing or picking patches)
+    # use _output() to mask the verbose prints of the tool
     try:
-        # use _output() to mask the verbose prints of the tool
         _output(['git-merge-recursive', base, '--', head1, head2])
-    except GitException, ex:
-        err_output =3D str(ex)
-        pass
-
-    # check the index for unmerged entries
-    files =3D {}
-
-    for line in _output(['git-ls-files', '--unmerged', '--stage', '-z'=
]).split('\0'):
-        if not line:
-            continue
-
-        mode, hash, stage, path =3D stages_re.findall(line)[0]
-
-        if not path in files:
-            files[path] =3D {}
-            files[path]['1'] =3D ('', '')
-            files[path]['2'] =3D ('', '')
-            files[path]['3'] =3D ('', '')
-
-        files[path][stage] =3D (mode, hash)
-
-    if err_output and not files:
-        # if no unmerged files, there was probably a different type of
-        # error and we have to abort the merge
-        raise GitException, err_output
-
-    if files:
+    except GitException:
         raise GitException, 'GIT index merging failed (possible confli=
cts)'
=20
 def merge(base, head1, head2):
--=20
1.5.3.rc3.119.g1812
