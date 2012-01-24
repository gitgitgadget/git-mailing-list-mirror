From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] submodule add: fix breakage when re-adding a deep submodule
Date: Tue, 24 Jan 2012 22:49:56 +0100
Message-ID: <4F1F2784.1020904@web.de>
References: <jfmvpp$4v7$1@dough.gmane.org> <4F1F1E5F.2030509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jehan Bing <jehan@orb.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 22:50:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpoFi-0006QG-JH
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 22:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301Ab2AXVuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 16:50:00 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:47506 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab2AXVt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 16:49:59 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate03.web.de (Postfix) with ESMTP id D711B1B05E858
	for <git@vger.kernel.org>; Tue, 24 Jan 2012 22:49:57 +0100 (CET)
Received: from [192.168.178.43] ([91.3.157.14]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MEEMy-1Rs07h1hpw-00G97z; Tue, 24 Jan 2012 22:49:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4F1F1E5F.2030509@web.de>
X-Provags-ID: V02:K0:0opqAtpC1n4ylbrtStomB9FNhCCYJTuvntHrxdIH7cj
 +eXPRjDE0HwvGV1gUz1R0XGoJAmipcLFCHUYM4wJUS9AhbXj94
 AEWeFfh+sNe+Qx+h4kdGeLc+QU1YuP8zXRZLtycN3yvdbDzZqA
 ykWm0PUC4S6PyVIo0ur7PhuyQsXA0iDrNcuYBmk++JGZvXnC3D
 jLsoWudGzgC1u8/n/mS6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189073>

Since recently a submodule with name <name> has its git directory in the
.git/modules/<name> directory of the superproject while the work tree
contains a gitfile pointing there.

When the same submodule is added on a branch where it wasn't present so
far (it is not found in the .gitmodules file), the name is not initialized
from the path as it should. This leads to a wrong path entered in the
gitfile when the .git/modules/<name> directory is found, as this happily
uses the - now empty - name. It then always points only a single directory
up, even if we have a path deeper in the directory hierarchy.

Fix that by initializing the name of the submodule early in module_clone()
if module_name() returned an empty name and add a test to catch that bug.

Reported-by: Jehan Bing <jehan@orb.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 24.01.2012 22:10, schrieb Jens Lehmann:
> Am 24.01.2012 20:11, schrieb Jehan Bing:
>> I'm getting an error if I try to add a module in a subdirectory and that module is already cloned.
>> Here are the steps to reproduce (git 1.7.8.3):

...

> The reason for this bug seems to be that in module_clonse() the name is
> not properly initialized for added submodules (it gets set to the path
> later), so the correct amount of leading "../"s for the git directory
> is not computed properly. The attached diff fixes that for me, I will
> send a patch as soon as I have extended a test case for this breakage.

Which I now have.


 git-submodule.sh            |    1 +
 t/t7406-submodule-update.sh |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3adab93..9bb2e13 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -131,6 +131,7 @@ module_clone()
 	gitdir=
 	gitdir_base=
 	name=$(module_name "$path" 2>/dev/null)
+	test -n "$name" || name="$path"
 	base_path=$(dirname "$path")

 	gitdir=$(git rev-parse --git-dir)
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 33b292b..5b97222 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -611,4 +611,12 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir re
 	)
 '

+test_expect_success 'submodule add properly re-creates deeper level submodules' '
+	(cd super &&
+	 git reset --hard master &&
+	 rm -rf deeper/ &&
+	 git submodule add ../submodule deeper/submodule
+	)
+'
+
 test_done
-- 
1.7.9.rc2.3.g18574a
