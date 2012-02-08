From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 1/2] submodules: always use a relative path to gitdir
Date: Wed, 08 Feb 2012 23:11:02 +0100
Message-ID: <4F32F2F6.6040006@web.de>
References: <4F32F252.7050105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 23:11:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvFjM-0000LZ-PM
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 23:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631Ab2BHWLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 17:11:08 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:60543 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866Ab2BHWLG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 17:11:06 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate05.web.de (Postfix) with ESMTP id 9B0E66956263
	for <git@vger.kernel.org>; Wed,  8 Feb 2012 23:11:04 +0100 (CET)
Received: from [192.168.178.20] ([91.3.188.62]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MYNof-1Rzo8c135t-00VLG7; Wed, 08 Feb 2012 23:11:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <4F32F252.7050105@web.de>
X-Provags-ID: V02:K0:Yo7D7qEuFnCLMR/Xs1zwt/DN0Pgv9h3WPtn4IbQtdSs
 41Z/ZRPH4CQ1zA6NjHPIYcmnGB+aAkYl5cbIc5W9BAiKk/AWc8
 /r3mV2K2VF6IANEqY6ti4CaKW0K2rhSYxo7E4Qph4CmGdauQ/K
 Tk2GZ0ORbhj4A0JdM/s8VQtH4LbsoJ9evUR92LM8nck4Pcm7Ym
 Mv4BiAsLYggV5snvPaT8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190259>

Since recently a submodule with name <name> has its git directory in the
.git/modules/<name> directory of the superproject while the work tree
contains a gitfile pointing there. When the submodule git directory needs
to be cloned because it is not found in .git/modules/<name> the clone
command will write an absolute path into the gitfile. When no clone is
necessary the git directory will be reactivated by the git-submodule.sh
script by writing a relative path into the gitfile.

This is inconsistent, as the behavior depends on the submodule having been
cloned before into the .git/modules of the superproject. A relative path
is preferable here because it allows the superproject to be moved around
without invalidating the gitfile. We do that by always writing the
relative path into the gitfile, which overwrites the absolute path the
clone command may have written there.

This is only the first step to make superprojects movable again like they
were before the separate-git-dir approach was introduced. The second step
is to use a relative path in core.worktree too.

Enhance t7400 to ensure that future versions won't re-add absolute paths
by accident.

While at it also replace an if/else construct evaluating the presence
of the 'reference' option with a single line of bash code.

Reported-by: Antony Male <antony.male@gmail.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 git-submodule.sh           |   11 ++++-------
 t/t7400-submodule-basic.sh |    2 ++
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9bb2e13..2a93c61 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -160,18 +160,15 @@ module_clone()
     if test -d "$gitdir"
     then
         mkdir -p "$path"
-        echo "gitdir: $rel_gitdir" >"$path/.git"
         rm -f "$gitdir/index"
     else
         mkdir -p "$gitdir_base"
-        if test -n "$reference"
-        then
-            git-clone $quiet "$reference" -n "$url" "$path" --separate-git-dir "$gitdir"
-        else
-            git-clone $quiet -n "$url" "$path" --separate-git-dir "$gitdir"
-        fi ||
+        git clone $quiet -n ${reference:+"$reference"} \
+            --separate-git-dir "$gitdir" "$url" "$path" ||
         die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' failed")"
     fi
+
+    echo "gitdir: $rel_gitdir" >"$path/.git"
 }
 
 #
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 695f7af..2b70b22 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -79,6 +79,8 @@ test_expect_success 'submodule add' '
         cd addtest &&
         git submodule add -q "$submodurl" submod >actual &&
         test ! -s actual &&
+        echo "gitdir: ../.git/modules/submod" >expect &&
+        test_cmp expect submod/.git &&
         git submodule init
     ) &&
 
-- 
1.7.9.190.gb17a42.dirty
