From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 2/5] Have only a single command in each
	test_expect_failure
Date: Sat, 19 May 2007 02:09:56 +0200
Message-ID: <20070519000956.4906.54444.stgit@yoghurt>
References: <20070519000451.4906.87089.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 02:10:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpCWT-0002HT-Ro
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768AbXESAKE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 May 2007 20:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754953AbXESAKD
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:10:03 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:59775 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754768AbXESAKB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 20:10:01 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:54509 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HpCWF-00023a-7k; Sat, 19 May 2007 02:09:59 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HpCWC-0001KD-UH; Sat, 19 May 2007 02:09:56 +0200
In-Reply-To: <20070519000451.4906.87089.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HpCWF-00023a-7k.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1HpCWF-00023a-7k 3207c8f2afee34493c9270b68f8c6db1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47687>

Otherwise, we can't know which one failed.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 t/t1000-branch-create.sh |   71 ++++++++++++++++++++++++++++----------=
--------
 1 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/t/t1000-branch-create.sh b/t/t1000-branch-create.sh
index 58209e7..cca5504 100755
--- a/t/t1000-branch-create.sh
+++ b/t/t1000-branch-create.sh
@@ -12,57 +12,72 @@ Exercises the "stg branch" commands.
=20
 stg init
=20
+test_expect_success \
+    'Create a spurious refs/patches/ entry' '
+    find .git -name foo | xargs rm -rf &&
+    touch .git/refs/patches/foo
+'
+
 test_expect_failure \
-    'Try to create an stgit branch with a spurious refs/patches/ entry=
' \
-    'find .git -name foo | xargs rm -rf &&
-     touch .git/refs/patches/foo &&
-     stg branch -c foo
+    'Try to create an stgit branch with a spurious refs/patches/ entry=
' '
+    stg branch -c foo
+'
+
+test_expect_success \
+    'Check that no part of the branch was created' '
+    test "`find .git -name foo | tee /dev/stderr`" =3D ".git/refs/patc=
hes/foo" &&
+    ( grep foo .git/HEAD; test $? =3D 1 )
 '
=20
 test_expect_success \
-    'Check no part of the branch was created' \
-    'test "`find .git -name foo | tee /dev/stderr`" =3D ".git/refs/pat=
ches/foo" &&
-     ( grep foo .git/HEAD; test $? =3D 1 )
+    'Create a spurious patches/ entry' '
+    find .git -name foo | xargs rm -rf &&
+    touch .git/patches/foo
 '
=20
 test_expect_failure \
-    'Try to create an stgit branch with a spurious patches/ entry' \
-    'find .git -name foo | xargs rm -rf &&
-     touch .git/patches/foo &&
-     stg branch -c foo
+    'Try to create an stgit branch with a spurious patches/ entry' '
+    stg branch -c foo
 '
=20
 test_expect_success \
-    'Check no part of the branch was created' \
-    'test "`find .git -name foo | tee /dev/stderr`" =3D ".git/patches/=
foo" &&
-     ( grep foo .git/HEAD; test $? =3D 1 )
+    'Check that no part of the branch was created' '
+    test "`find .git -name foo | tee /dev/stderr`" =3D ".git/patches/f=
oo" &&
+    ( grep foo .git/HEAD; test $? =3D 1 )
+'
+
+test_expect_success \
+    'Create a git branch' '
+    find .git -name foo | xargs rm -rf &&
+    cp .git/refs/heads/master .git/refs/heads/foo
 '
=20
 test_expect_failure \
-    'Try to create an stgit branch with an existing git branch by that=
 name' \
-    'find .git -name foo | xargs rm -rf &&
-     cp .git/refs/heads/master .git/refs/heads/foo &&
-     stg branch -c foo
+    'Try to create an stgit branch with an existing git branch by that=
 name' '
+    stg branch -c foo
 '
=20
 test_expect_success \
-    'Check no part of the branch was created' \
-    'test "`find .git -name foo | tee /dev/stderr`" =3D ".git/refs/hea=
ds/foo" &&
-     ( grep foo .git/HEAD; test $? =3D 1 )
+    'Check that no part of the branch was created' '
+    test "`find .git -name foo | tee /dev/stderr`" =3D ".git/refs/head=
s/foo" &&
+    ( grep foo .git/HEAD; test $? =3D 1 )
 '
=20
+test_expect_success \
+    'Create an invalid refs/heads/ entry' '
+    find .git -name foo | xargs rm -rf &&
+    touch .git/refs/heads/foo
+'
=20
 test_expect_failure \
-    'Try to create an stgit branch with an invalid refs/heads/ entry' =
\
-    'find .git -name foo | xargs rm -rf &&
-     touch .git/refs/heads/foo &&
-     stg branch -c foo
+    'Try to create an stgit branch with an invalid refs/heads/ entry' =
'
+    stg branch -c foo
 '
=20
 test_expect_success \
-    'Check no part of the branch was created' \
-    'test "`find .git -name foo | tee /dev/stderr`" =3D ".git/refs/hea=
ds/foo" &&
-     ( grep foo .git/HEAD; test $? =3D 1 )
+    'Check that no part of the branch was created' '
+    test "`find .git -name foo | tee /dev/stderr`" =3D ".git/refs/head=
s/foo" &&
+    ( grep foo .git/HEAD; test $? =3D 1 )
 '
=20
 test_done
