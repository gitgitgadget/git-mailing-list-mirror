From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 4/6] Simplify merge_recursive
Date: Sun, 26 Aug 2007 22:42:54 +0200
Message-ID: <20070826204254.16700.14590.stgit@yoghurt>
References: <20070826203745.16700.5655.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:43:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOwz-0002Lo-GM
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbXHZUnI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbXHZUnI
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:43:08 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2217 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbXHZUnF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:43:05 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOwg-00061S-00; Sun, 26 Aug 2007 21:42:54 +0100
In-Reply-To: <20070826203745.16700.5655.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56727>

=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>

Listing the unmerged files is unnecessary, since the information
isn't really used anyway. Just note if the merge failed or succeeded.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/git.py |   32 +-------------------------------
 1 files changed, 1 insertions(+), 31 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 82cb211..173cc4b 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -642,40 +642,10 @@ def merge_recursive(base, head1, head2):
     """
     refresh_index()
=20
-    err_output =3D None
-    # this operation tracks renames but it is slower (used in
-    # general when pushing or picking patches)
     try:
         # discard output to mask the verbose prints of the tool
         GRun('git-merge-recursive', base, '--', head1, head2).discard_=
output()
-    except GitRunException, ex:
-        err_output =3D str(ex)
-        pass
-
-    # check the index for unmerged entries
-    files =3D {}
-
-    for line in GRun('git-ls-files', '--unmerged', '--stage', '-z'
-                     ).raw_output().split('\0'):
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
+    except GitRunException:
         raise GitException, 'GIT index merging failed (possible confli=
cts)'
=20
 def merge(base, head1, head2):
