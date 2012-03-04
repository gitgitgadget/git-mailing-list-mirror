From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 2/4] submodules: always use a relative path from gitdir
 to work tree
Date: Sun, 04 Mar 2012 22:15:08 +0100
Message-ID: <4F53DB5C.2060104@web.de>
References: <4F53DA95.2020402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 22:15:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Ily-0001mF-Do
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 22:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261Ab2CDVPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 16:15:12 -0500
Received: from fmmailgate07.web.de ([217.72.192.248]:47268 "EHLO
	fmmailgate07.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888Ab2CDVPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 16:15:11 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate07.web.de (Postfix) with ESMTP id 989B3D5DEE9
	for <git@vger.kernel.org>; Sun,  4 Mar 2012 22:15:08 +0100 (CET)
Received: from [192.168.178.48] ([91.3.220.167]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0Lxf5f-1SRTUd16vT-016T58; Sun, 04 Mar 2012 22:15:08
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F53DA95.2020402@web.de>
X-Provags-ID: V02:K0:XldzRXgGilA5jRkW6GA8VdrmnKfgWlvVOgzIwPeRgOF
 Mp8tI658k9q46P6eMk8UB7mjFI8NYg1ut6ZLtN8wD3X6FPJZY/
 I5EsoF+TPMFvNqVOCFFqx/WXRcH6KUNNGatnbdiaKkDENhBpIo
 xzWzIl3CE73Y5OMKOtxriZLMvMjldWbaWphrqGzO/4MAM8zcaP
 i6izhCV40OvQ1GJvb6QqQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192175>

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
 git-submodule.sh           |   18 ++++++++++++++++++
 t/t7400-submodule-basic.sh |   20 ++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2a93c61..c405caa 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -169,6 +169,24 @@ module_clone()
 	fi

 	echo "gitdir: $rel_gitdir" >"$path/.git"
+
+	a=$(cd "$gitdir" && pwd)/
+	b=$(cd "$path" && pwd)/
+	# Remove all common leading directories after a sanity check
+	if test "${a#$b}" != "$a" || test "${b#$a}" != "$b"; then
+		die "$(eval_gettext "Gitdir '\$a' is part of the submodule path '\$b' or vice versa")"
+	fi
+	while test "${a%%/*}" = "${b%%/*}"
+	do
+		a=${a#*/}
+		b=${b#*/}
+	done
+	# Now chop off the trailing '/'s that were added in the beginning
+	a=${a%/}
+	b=${b%/}
+
+	rel=$(echo $a | sed -e 's|[^/]*|..|g')
+	(clear_local_git_env; cd "$path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
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
+		(
+			cd submod &&
+			git config core.worktree >actual &&
+			echo "../../../submod" >expect &&
+			test_cmp expect actual &&
+			rm -f actual expect
+		) &&
 		git submodule init
 	) &&

@@ -500,4 +507,17 @@ test_expect_success 'relative path works with user@host:path' '
 	)
 '

+test_expect_success 'moving the superproject does not break submodules' '
+	(
+		cd addtest &&
+		git submodule status >expect
+	)
+	mv addtest addtest2 &&
+	(
+		cd addtest2 &&
+		git submodule status >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
1.7.9.2.362.g684a8
