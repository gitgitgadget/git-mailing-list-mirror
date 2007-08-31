From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Let "stg status" ignore empty directories
Date: Fri, 31 Aug 2007 21:43:57 +0200
Message-ID: <20070831194348.18082.49366.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 21:44:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRCPY-0001To-UP
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 21:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbXHaToF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 31 Aug 2007 15:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbXHaToD
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 15:44:03 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2847 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbXHaToC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 15:44:02 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IRCPO-0000lG-00; Fri, 31 Aug 2007 20:43:58 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57200>

This was a really simple fix: just pass the right flag to
git-ls-files. Since the output has a trailing \0, split() gives us an
empty string at the end of the list that we have to throw away.
(Curiously, there was an empty string at the end before this change
too, but it disappeared somehow.)

This fixes bug 9891.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/git.py |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index f315b05..8857209 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -181,7 +181,8 @@ def tree_status(files =3D None, tree_id =3D 'HEAD',=
 unknown =3D False,
=20
     # unknown files
     if unknown:
-        cmd =3D ['git-ls-files', '-z', '--others', '--directory']
+        cmd =3D ['git-ls-files', '-z', '--others', '--directory',
+               '--no-empty-directory']
         if not noexclude:
             cmd +=3D ['--exclude=3D%s' % s for s in
                     ['*.[ao]', '*.pyc', '.*', '*~', '#*', 'TAGS', 'tag=
s']]
@@ -191,7 +192,7 @@ def tree_status(files =3D None, tree_id =3D 'HEAD',=
 unknown =3D False,
                     if os.path.exists(fn)]
=20
         lines =3D GRun(*cmd).raw_output().split('\0')
-        cache_files +=3D [('?', line) for line in lines]
+        cache_files +=3D [('?', line) for line in lines if line]
=20
     # conflicted files
     conflicts =3D get_conflicts()
