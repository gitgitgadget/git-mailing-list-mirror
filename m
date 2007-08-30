From: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 2/2] Cleanup tree_status and use -z
Date: Thu, 30 Aug 2007 13:11:10 +0200
Message-ID: <11884722703840-git-send-email-davidk@lysator.liu.se>
References: <11884722703161-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?David=20K=C3=A5gedal?= <david@virtutech.com>,
	=?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 30 13:12:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQhwK-00066q-US
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 13:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759476AbXH3LLd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 07:11:33 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755317AbXH3LLd
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 07:11:33 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:46874 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759476AbXH3LLP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 07:11:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 93F2B200A21C;
	Thu, 30 Aug 2007 13:11:14 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 04641-01-65; Thu, 30 Aug 2007 13:11:11 +0200 (CEST)
Received: from morpheus (oden.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 5E4FE200A24F;
	Thu, 30 Aug 2007 13:11:11 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id CDFB0BFA57; Thu, 30 Aug 2007 13:11:10 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc6.31.g3c3b
In-Reply-To: <11884722703161-git-send-email-davidk@lysator.liu.se>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57022>

=46rom: David K=C3=A5gedal <david@virtutech.com>

Improved the python code, eliminating temporary variables and using
destructuring binds. And use NUL-separation instead of newlines.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
There are still no good test cases for this code, though.

 stgit/commands/patches.py |    2 +-
 stgit/commands/refresh.py |    2 +-
 stgit/git.py              |   22 +++++++++++-----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/stgit/commands/patches.py b/stgit/commands/patches.py
index b3defb6..fb65b62 100644
--- a/stgit/commands/patches.py
+++ b/stgit/commands/patches.py
@@ -51,7 +51,7 @@ def func(parser, options, args):
     """Show the patches modifying a file
     """
     if not args:
-        files =3D [stat[1] for stat in git.tree_status(verbose =3D Tru=
e)]
+        files =3D [path for (stat,path) in git.tree_status(verbose =3D=
 True)]
     else:
         files =3D args
=20
diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 218075b..f44c58c 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -121,7 +121,7 @@ def func(parser, options, args):
     else:
         sign_str =3D None
=20
-    files =3D [x[1] for x in git.tree_status(verbose =3D True)]
+    files =3D [path for (stat,path) in git.tree_status(verbose =3D Tru=
e)]
     if args:
         files =3D [f for f in files if f in args]
=20
diff --git a/stgit/git.py b/stgit/git.py
index 7962cdb..f315b05 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -168,7 +168,7 @@ def exclude_files():
=20
 def tree_status(files =3D None, tree_id =3D 'HEAD', unknown =3D False,
                   noexclude =3D True, verbose =3D False, diff_flags =3D=
 []):
-    """Returns a list of pairs - [status, filename]
+    """Returns a list of pairs - (status, filename)
     """
     if verbose:
         out.start('Checking for changes in the working directory')
@@ -181,16 +181,16 @@ def tree_status(files =3D None, tree_id =3D 'HEAD=
', unknown =3D False,
=20
     # unknown files
     if unknown:
-        if noexclude:
-            exclude =3D []
-        else:
-            exclude =3D (['--exclude=3D%s' % s for s in
-                        ['*.[ao]', '*.pyc', '.*', '*~', '#*', 'TAGS', =
'tags']]
-                       + ['--exclude-per-directory=3D.gitignore']
-                       + ['--exclude-from=3D%s' % fn for fn in exclude=
_files()
-                          if os.path.exists(fn)])
-        lines =3D GRun('git-ls-files', '--others', '--directory', *exc=
lude
-                     ).output_lines()
+        cmd =3D ['git-ls-files', '-z', '--others', '--directory']
+        if not noexclude:
+            cmd +=3D ['--exclude=3D%s' % s for s in
+                    ['*.[ao]', '*.pyc', '.*', '*~', '#*', 'TAGS', 'tag=
s']]
+            cmd +=3D ['--exclude-per-directory=3D.gitignore']
+            cmd +=3D ['--exclude-from=3D%s' % fn
+                    for fn in exclude_files()
+                    if os.path.exists(fn)]
+
+        lines =3D GRun(*cmd).raw_output().split('\0')
         cache_files +=3D [('?', line) for line in lines]
=20
     # conflicted files
--=20
1.5.3.rc6.31.g3c3b
