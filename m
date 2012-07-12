From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] submodules: don't stumble over symbolic links when cloning
 recursively
Date: Thu, 12 Jul 2012 19:45:32 +0200
Message-ID: <4FFF0D3C.2060001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Bob Halley <halley@play-bow.org>,
	Phil Hord <phil.hord@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 19:45:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpNSR-0002eZ-Le
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 19:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161498Ab2GLRpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 13:45:39 -0400
Received: from mout.web.de ([212.227.17.11]:57376 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161487Ab2GLRph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 13:45:37 -0400
Received: from [192.168.178.48] ([91.3.184.233]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LvB2o-1RpTUl0qCg-010grn; Thu, 12 Jul 2012 19:45:35
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
X-Provags-ID: V02:K0:oaEkBOBw/GrONrM8Hqo9aAPkcpsfePchaAWrHlIWp3N
 cma9g7hKwj2LcajrSlPW26pkhbnvr9KHGZirGEpwk8noSiwD7t
 vxREgSD2pCr6e3UYvUP93nHkUukGdc+g4/v3PKq2158JV9/udN
 u+x6szPLQ3OBDn+oF/TAS83aC9+4ZRySK88HTQgjw7N5QevzKp
 SYVc+lN/BqFnIJ5TZVrMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201371>

Since 69c3051 (submodules: refactor computation of relative gitdir path)
cloning a submodule recursively fails for nested submodules when a
symbolic link is part of the path to the work tree of the superproject.

This happens when module_clone() tries to find the relative paths between
the work tree and the git dir. When a symbolic link in current $PWD points
to a directory that is at a different level, then determining the number
of "../" needed to traverse to the superproject's work tree leads to a
wrong result.

As there is no portable way to say "pwd -P", use cd_to_toplevel to remove
the link from $PWD, which fixes this problem.

A test for this issue has been added to t7406.

Reported-by: Bob Halley <halley@play-bow.org>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

The changes in this version are:
- the SYMLINKS prerequisite is used for the new test
- a comment explaining why cd_to_toplevel is needed has been added
- small updates to the commit message

Thanks to J6t for the input.

 git-submodule.sh            |  6 ++++--
 t/t7406-submodule-update.sh | 13 +++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5629d87..dba4d39 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -186,8 +186,10 @@ module_clone()
 		die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path' failed")"
 	fi

-	a=$(cd "$gitdir" && pwd)/
-	b=$(cd "$sm_path" && pwd)/
+	# We already are at the root of the work tree but cd_to_toplevel will
+	# resolve any symlinks that might be present in $PWD
+	a=$(cd_to_toplevel && cd "$gitdir" && pwd)/
+	b=$(cd_to_toplevel && cd "$sm_path" && pwd)/
 	# normalize Windows-style absolute paths to POSIX-style absolute paths
 	case $a in [a-zA-Z]:/*) a=/${a%%:*}${a#*:} ;; esac
 	case $b in [a-zA-Z]:/*) b=/${b%%:*}${b#*:} ;; esac
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index dcb195b..ce61d4c 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -636,4 +636,17 @@ test_expect_success 'submodule update properly revives a moved submodule' '
 	)
 '

+test_expect_success SYMLINKS 'submodule update can handle symbolic links in pwd' '
+	mkdir -p linked/dir &&
+	ln -s linked/dir linkto &&
+	(
+		cd linkto &&
+		git clone "$TRASH_DIRECTORY"/super_update_r2 super &&
+		(
+			cd super &&
+			git submodule update --init --recursive
+		)
+	)
+'
+
 test_done
-- 
1.7.11.1.166.gf56d108
