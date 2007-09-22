From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/4] Properly remove all config for a deleted branch
Date: Sat, 22 Sep 2007 10:46:31 +0200
Message-ID: <20070922084630.29884.73015.stgit@yoghurt>
References: <20070922084334.29884.60506.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Aneesh Kumar <aneesh.kumar@gmail.com>,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 10:46:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ0dU-0005ZG-L8
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 10:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbXIVIqj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2007 04:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbXIVIqi
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 04:46:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4113 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbXIVIqh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 04:46:37 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IZ0dE-0001nG-00; Sat, 22 Sep 2007 09:46:32 +0100
In-Reply-To: <20070922084334.29884.60506.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58926>

This uses "git-config --remove-section", which was first released in
git 1.5.1-rc1. I'm not sure if this is later than what we used to
depend on; we already use "git-config --rename-section", but that's
been in since git 1.5.0-rc0.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/config.py |    7 +++++++
 stgit/stack.py  |    9 ++-------
 2 files changed, 9 insertions(+), 7 deletions(-)


diff --git a/stgit/config.py b/stgit/config.py
index 799e1d7..51818bd 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -76,6 +76,13 @@ class GitConfig:
             ).returns([0, 1]).run()
         self.__cache.clear()
=20
+    def remove_section(self, name):
+        """Remove a section in the config file. Silently do nothing if
+        the section doesn't exist."""
+        Run('git-repo-config', '--remove-section', name
+            ).returns([0, 1]).discard_stderr().discard_output()
+        self.__cache.clear()
+
     def set(self, name, value):
         Run('git-repo-config', name, value).run()
         self.__cache[name] =3D value
diff --git a/stgit/stack.py b/stgit/stack.py
index d6f6a6e..adfff25 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -744,13 +744,8 @@ class Series(PatchSet):
             except GitException:
                 out.warn('Could not delete branch "%s"' % self.get_nam=
e())
=20
-        # Cleanup parent informations
-        # FIXME: should one day make use of git-config --section-remov=
e,
-        # scheduled for 1.5.1
-        config.unset('branch.%s.remote' % self.get_name())
-        config.unset('branch.%s.merge' % self.get_name())
-        config.unset('branch.%s.stgit.parentbranch' % self.get_name())
-        config.unset(self.format_version_key())
+        config.remove_section('branch.%s' % self.get_name())
+        config.remove_section('branch.%s.stgit' % self.get_name())
=20
     def refresh_patch(self, files =3D None, message =3D None, edit =3D=
 False,
                       show_patch =3D False,
