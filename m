From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 2/4] Handle changed files with non-ASCII names
Date: Mon, 02 Jun 2008 23:46:24 +0200
Message-ID: <20080602214624.18768.53465.stgit@yoghurt>
References: <20080602214212.18768.63775.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 23:47:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HsU-0004vi-61
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbYFBVqj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 17:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbYFBVqj
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:46:39 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4640 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbYFBVqi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:46:38 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K3HrF-0001Da-00; Mon, 02 Jun 2008 22:46:25 +0100
In-Reply-To: <20080602214212.18768.63775.stgit@yoghurt>
User-Agent: StGIT/0.14.2.156.gbabd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83581>

Git was quoting them for us, which was not what we wanted. So call
diff-index with the -z flag, so that it doesn't.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/git.py                   |   18 +++++++++++++-----
 t/t3200-non-ascii-filenames.sh |    2 +-
 2 files changed, 14 insertions(+), 6 deletions(-)


diff --git a/stgit/git.py b/stgit/git.py
index deb5efc..d4cd946 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -236,11 +236,19 @@ def tree_status(files =3D None, tree_id =3D 'HEAD=
', unknown =3D False,
     args =3D diff_flags + [tree_id]
     if files:
         args +=3D ['--'] + files
-    for line in GRun('diff-index', *args).output_lines():
-        fs =3D tuple(line.rstrip().split(' ',4)[-1].split('\t',1))
-        if fs[1] not in reported_files:
-            cache_files.append(fs)
-            reported_files.add(fs[1])
+    t =3D None
+    for line in GRun('diff-index', '-z', *args).raw_output().split('\0=
'):
+        if not line:
+            # There's a zero byte at the end of the output, which
+            # gives us an empty string as the last "line".
+            continue
+        if t =3D=3D None:
+            mode_a, mode_b, sha1_a, sha1_b, t =3D line.split(' ')
+        else:
+            if not line in reported_files:
+                cache_files.append((t, line))
+                reported_files.add(line)
+            t =3D None
=20
     # files in the index but changed on (or removed from) disk
     args =3D list(diff_flags)
diff --git a/t/t3200-non-ascii-filenames.sh b/t/t3200-non-ascii-filenam=
es.sh
index 1d82a9f..a04ead8 100755
--- a/t/t3200-non-ascii-filenames.sh
+++ b/t/t3200-non-ascii-filenames.sh
@@ -20,7 +20,7 @@ test_expect_success 'Setup' '
     stg push
 '
=20
-test_expect_failure 'Rebase onto changed non-ASCII file' '
+test_expect_success 'Rebase onto changed non-ASCII file' '
     stg rebase upstream
 '
=20
