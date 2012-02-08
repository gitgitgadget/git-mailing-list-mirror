From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 2/2] submodules: always use a relative path from gitdir to
 work tree
Date: Wed, 08 Feb 2012 23:17:09 +0100
Message-ID: <4F32F465.7090401@web.de>
References: <4F32F252.7050105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 23:17:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvFpF-0002ai-Os
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 23:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab2BHWRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 17:17:12 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:49560 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab2BHWRL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 17:17:11 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate03.web.de (Postfix) with ESMTP id 55FF31B0B578F
	for <git@vger.kernel.org>; Wed,  8 Feb 2012 23:17:10 +0100 (CET)
Received: from [192.168.178.20] ([91.3.188.62]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0M1Wxd-1SoKU83CZt-00tLEG; Wed, 08 Feb 2012 23:17:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <4F32F252.7050105@web.de>
X-Provags-ID: V02:K0:i6MmV2ce+ANFZIM1yhUPi9l5bDFxBIy/jbL+bAzAXp0
 zgRrqExZYPdTD74MkxObOnV1v762e8+3WdhZGIsRzlCMLxXiz/
 xuRSKIe8zQZOl4BODNAc3KL6ACgIKjvWAqEm41dw+NUWW88aiI
 SkZcP1I0svFFSYVuAHmDSDP5Rqw9EOdPTjyv5k6PE+4XqiWDcQ
 zC5nVdLjYZk8HNHHlNX0w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190261>

Since recently a submodule with name <name> has its git directory in the
.git/modules/<name> directory of the superproject while the work tree
contains a gitfile pointing there. To make that work the git directory has
the core.worktree configuration set in its config file to point back to
the work tree.

That core.worktree is an absolute path set by the initial clone of the
submodule. A relative path is preferable here because it allows the
superproject to be moved around without invalidating that setting, so
compute and set that relative path after cloning or reactivating the
submodule.

This also fixes a bug when moving a submodule around inside the
superproject, as the current code forgot to update the setting to the new
submodule work tree location.

Enhance t7400 to ensure that future versions won't re-add absolute paths
by accident and that moving a superproject won't break submodules.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 git-submodule.sh           |    9 +++++++++
 t/t7400-submodule-basic.sh |   20 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2a93c61..3463d6d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -169,6 +169,15 @@ module_clone()
     fi
 
     echo "gitdir: $rel_gitdir" >"$path/.git"
+
+    a=$(cd "$gitdir" && pwd)
+    b=$(cd "$path" && pwd)
+    while [ "$b" ] && [ "${a%%/*}" = "${b%%/*}" ]
+    do
+        a=${a#*/} b=${b#*/};
+    done
+    rel=$(echo $a | sed -e 's|[^/]*|..|g')
+    (clear_local_git_env; cd "$path" && git config core.worktree "$rel/$b")
 }
 
 #
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 2b70b22..b377a7a 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -81,6 +81,13 @@ test_expect_success 'submodule add' '
         test ! -s actual &&
         echo "gitdir: ../.git/modules/submod" >expect &&
         test_cmp expect submod/.git &&
+        (
+            cd submod &&
+            git config core.worktree >actual &&
+            echo "../../../submod" >expect &&
+            test_cmp expect actual &&
+            rm -f actual expect
+        ) &&
         git submodule init
     ) &&
 
@@ -500,4 +507,17 @@ test_expect_success 'relative path works with user@host:path' '
     )
 '
 
+test_expect_success 'moving the superproject does not break submodules' '
+    (
+        cd addtest &&
+        git submodule status >expect
+    )
+    mv addtest addtest2 &&
+    (
+        cd addtest2 &&
+        git submodule status >actual &&
+        test_cmp expect actual
+    )
+'
+
 test_done
-- 
1.7.9.190.gf8e73.dirty
