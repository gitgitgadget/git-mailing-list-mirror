From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 1/2] submodules: always use a relative path to gitdir
Date: Thu, 09 Feb 2012 09:18:22 +0100
Message-ID: <4F33814E.7050404@web.de>
References: <4F32F252.7050105@web.de> <4F32F2F6.6040006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 09:18:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvPD4-00075L-CE
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 09:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757221Ab2BIISZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 03:18:25 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:42993 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756791Ab2BIISY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 03:18:24 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate03.web.de (Postfix) with ESMTP id F14561B0B9442
	for <git@vger.kernel.org>; Thu,  9 Feb 2012 09:18:22 +0100 (CET)
Received: from [192.168.178.20] ([91.3.191.199]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LmuMO-1STOeA2Lgi-00gvdg; Thu, 09 Feb 2012 09:18:22
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <4F32F2F6.6040006@web.de>
X-Provags-ID: V02:K0:tv1pLVFYk6fPr+nGvcTOcSAA/CwmQSftN9LaNwAYGB1
 dtJvVy7KrSnDyBDUdxaDzkx/9cTWyfwEDXSTMKhFoBC7bDfSuk
 bfXwQKtKt7rDQu18c1CA6BnpI/2nM/fVt7OPKVQeFAbxfBRMZ4
 l2OF1VpAMdVNd7ZH+OE+HggZ6oJsYZgXNuR2gH67/P9/p3ogV8
 eLYpDbRbaZdUmHCnSLJ4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190279>

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

The first version was whitespace damaged, please use this one instead.

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
-		echo "gitdir: $rel_gitdir" >"$path/.git"
 		rm -f "$gitdir/index"
 	else
 		mkdir -p "$gitdir_base"
-		if test -n "$reference"
-		then
-			git-clone $quiet "$reference" -n "$url" "$path" --separate-git-dir "$gitdir"
-		else
-			git-clone $quiet -n "$url" "$path" --separate-git-dir "$gitdir"
-		fi ||
+		git clone $quiet -n ${reference:+"$reference"} \
+			--separate-git-dir "$gitdir" "$url" "$path" ||
 		die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' failed")"
 	fi
+
+	echo "gitdir: $rel_gitdir" >"$path/.git"
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
+		echo "gitdir: ../.git/modules/submod" >expect &&
+		test_cmp expect submod/.git &&
 		git submodule init
 	) &&

-- 
1.7.9.190.g0a6c2
