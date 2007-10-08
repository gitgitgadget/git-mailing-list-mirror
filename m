From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/6] Refactor crt_series creation
Date: Mon, 08 Oct 2007 10:55:29 +0200
Message-ID: <20071008085529.9734.42383.stgit@yoghurt>
References: <20071008085430.9734.75797.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 10:57:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeoQ7-0003VA-J0
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 10:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbXJHIzg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 04:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079AbXJHIzf
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 04:55:35 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2226 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbXJHIze (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 04:55:34 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IeoOg-00025R-00; Mon, 08 Oct 2007 09:55:30 +0100
In-Reply-To: <20071008085430.9734.75797.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60304>

Instead of hard-coding in main.py which commands do and don't need a
current series, let them speak for themselves.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/clone.py  |    2 +-
 stgit/commands/common.py |    2 ++
 stgit/main.py            |    5 ++---
 3 files changed, 5 insertions(+), 4 deletions(-)


diff --git a/stgit/commands/clone.py b/stgit/commands/clone.py
index a150010..c3b0bbe 100644
--- a/stgit/commands/clone.py
+++ b/stgit/commands/clone.py
@@ -29,7 +29,7 @@ usage =3D """%prog [options] <repository> <dir>
 Clone a GIT <repository> into the local <dir> and initialise the
 patch stack."""
=20
-directory =3D DirectoryAnywhere()
+directory =3D DirectoryAnywhere(needs_current_series =3D False)
 options =3D []
=20
=20
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 27ef465..652039f 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -497,6 +497,8 @@ class DirectoryException(StgException):
     pass
=20
 class _Directory(object):
+    def __init__(self, needs_current_series =3D True):
+        self.needs_current_series =3D  needs_current_series
     @readonly_constant_property
     def git_dir(self):
         try:
diff --git a/stgit/main.py b/stgit/main.py
index 8e00217..db327f1 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -271,9 +271,8 @@ def main():
         directory.setup()
         config_setup()
=20
-        # 'clone' doesn't expect an already initialised GIT tree. A Se=
ries
-        # object will be created after the GIT tree is cloned
-        if cmd !=3D 'clone':
+        # Some commands don't (always) need an initialized series.
+        if directory.needs_current_series:
             if hasattr(options, 'branch') and options.branch:
                 command.crt_series =3D Series(options.branch)
             else:
