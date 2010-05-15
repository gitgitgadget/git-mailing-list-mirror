From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH] Restore the original applied patches during 'commit'
Date: Sat, 15 May 2010 12:03:05 +0100
Message-ID: <20100515110305.12922.25133.stgit@toshiba-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Jeenu Viswambharan <Jeenu.Viswambharan@arm.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 13:10:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODFGf-0002kA-OF
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 13:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054Ab0EOLKt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 May 2010 07:10:49 -0400
Received: from queueout01-winn.ispmail.ntl.com ([81.103.221.31]:3888 "EHLO
	queueout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754877Ab0EOLKs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 May 2010 07:10:48 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 May 2010 07:10:43 EDT
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100515110316.OMAB10460.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Sat, 15 May 2010 12:03:16 +0100
Received: from [127.0.1.1] (really [86.9.126.140])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100515110315.TNB13959.aamtaout02-winn.ispmail.ntl.com@[127.0.1.1]>;
          Sat, 15 May 2010 12:03:15 +0100
User-Agent: StGit/0.15-30-ged55-dirty
X-Cloudmark-Analysis: v=1.1 cv=ZtHxNT4mZm3rCuM0SmWmgWxeBwJsziC8EqOrwwVkrhA= c=1 sm=0 a=0pLjsis_KDwA:10 a=uEzv4HemXiYA:10 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8 a=hHMng47ZAAAA:8 a=doUUZnrsMVEWe_u-F8EA:9 a=WLYB7Ek4nMqnQhD-NAUA:7 a=kCreXGDYVK3sCugz57QVazmu0K4A:4 a=QEXdDO2ut3YA:10 a=MSl-tDqOz04A:10 a=ESTKKtUg-DoA:10 a=ePXRMeZs6ywA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147147>

If committing a patch in the middle of a series, the resulting stack
doesn't have any patches applied. The trans.pop_patches() function only
returns the additional patches that had to be popped rather than all
popped patches. The patch also adds some tests for the 'commit' command=
=2E

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
Reported-by: Jeenu Viswambharan <Jeenu.Viswambharan@arm.com>
Cc: Karl Hasselstr=C3=B6m <kha@treskal.com>
---
 stgit/commands/commit.py |    8 ++++++--
 t/t1303-commit.sh        |   21 +++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index 7bdd8c6..b21c85f 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -87,9 +87,13 @@ def func(parser, options, args):
         for i in xrange(min(len(stack.patchorder.applied), len(patches=
))):
             if stack.patchorder.applied[i] =3D=3D patches[i]:
                 common_prefix +=3D 1
+            else:
+                break
         if common_prefix < len(patches):
-            to_push =3D trans.pop_patches(
-                lambda pn: pn in stack.patchorder.applied[common_prefi=
x:])
+            to_push =3D [pn for pn in stack.patchorder.applied[common_=
prefix:]
+                       if pn not in patches[common_prefix:]]
+            # this pops all the applied patches from common_prefix
+            trans.pop_patches(lambda pn: pn in to_push)
             for pn in patches[common_prefix:]:
                 trans.push_patch(pn, iw)
         else:
diff --git a/t/t1303-commit.sh b/t/t1303-commit.sh
index d53b9f2..2d85078 100755
--- a/t/t1303-commit.sh
+++ b/t/t1303-commit.sh
@@ -6,6 +6,27 @@ test_expect_success 'Initialize the StGIT repository' =
'
     stg init
 '
=20
+test_expect_success 'Commit middle patch' '
+    stg new -m p1 &&
+    stg new -m p2 &&
+    stg new -m p3 &&
+    stg new -m p4 &&
+    stg pop &&
+    stg commit p2 &&
+    test "$(echo $(stg series))" =3D "+ p1 > p3 - p4"
+'
+
+test_expect_success 'Commit first patch' '
+    stg commit &&
+    test "$(echo $(stg series))" =3D "> p3 - p4"
+'
+
+test_expect_success 'Commit all patches' '
+    stg push &&
+    stg commit -a &&
+    test "$(echo $(stg series))" =3D ""
+'
+
 # stg commit with top !=3D head should not succeed, since the committe=
d
 # patches are poptentially lost.
 test_expect_success 'Commit when top !=3D head (should fail)' '
