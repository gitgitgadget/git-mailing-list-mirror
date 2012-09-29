From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 2/2] submodule add: Fail when .git/modules/<name> already
 exists
Date: Sun, 30 Sep 2012 01:07:22 +0200
Message-ID: <50677F2A.6060807@web.de>
References: <BC634E06939C44239106E7A8DD229130@gmail.com> <50636C00.6080906@web.de> <50677E76.1050204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Johnson <me@jondavidjohn.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 01:07:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TI68D-0004Cm-TL
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 01:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab2I2XHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 19:07:25 -0400
Received: from mout.web.de ([212.227.15.4]:50856 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab2I2XHY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 19:07:24 -0400
Received: from [192.168.178.41] ([91.3.175.36]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MMW5u-1TN10u3p9y-008eif; Sun, 30 Sep 2012 01:07:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <50677E76.1050204@web.de>
X-Provags-ID: V02:K0:OUT0zsU+OGbXGROWbuLnpEb7FtVxMCmMuUEpyEV4vzF
 SNQwtl65hK/435S4WCdemgKx99/PpIWMmWqQBY3HB3foMvTn2a
 +04GKF1JTffr2ImexswsqTgvB2xd9IpDDoNgIsgirsthomr/ig
 +t0Vxa+bIQSxJoEyIWzP6MEa6ghR2hEhgqw/juBl+lhodiTgkv
 O1cAoicSYDH79diJo1gGA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206660>

When adding a new submodule it can happen that .git/modules/<name> already
contains a submodule repo, e.g. when a submodule is removed from the work
tree and another submodule is added at the same path. But then the work
tree of the submodule will be populated using the existing repository and
not the one the user provided.

Error out in that case and tell the user she should use a different name
for the submodule with the "--name" option to avoid this problem. In one
test in t7406 the --name option had to be added to "git submodule add", as
that test re-adds a formerly removed submodule.

Reported-by: Jonathan Johnson <me@jondavidjohn.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 git-submodule.sh            |  3 ++-
 t/t7400-submodule-basic.sh  | 18 ++++++++++++++++++
 t/t7406-submodule-update.sh |  2 +-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 22febb1..58cd053 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -359,7 +359,8 @@ Use -f if you really want to add it." >&2
 		fi

 	else
-
+		test ! -d ".git/modules/$sm_name" ||
+		die "$(eval_gettext "Submodule name '\$sm_name' is already used. Please choose another name with the '--name' option.")"
 		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" || exit
 		(
 			clear_local_git_env
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 78bf739..a031a27 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -726,4 +726,22 @@ test_expect_success 'submodule add --name allows to replace a submodule with ano
 	)
 '

+test_expect_success 'submodule add with an existing name fails' '
+	(
+		cd addtest2 &&
+		rm -rf repo &&
+		test_must_fail git submodule add -q --name repo_new "$submodurl/bare.git" repo &&
+		test ! -d repo &&
+		echo "repo" >expect &&
+		git config -f .gitmodules submodule.repo_new.path >actual &&
+		test_cmp expect actual&&
+		echo "$submodurl/bare.git" >expect &&
+		git config -f .gitmodules submodule.repo_new.url >actual &&
+		test_cmp expect actual &&
+		echo "$submodurl/bare.git" >expect &&
+		git config submodule.repo_new.url >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 1542653..2d44c51 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -627,7 +627,7 @@ test_expect_success 'submodule add properly re-creates deeper level submodules'
 	(cd super &&
 	 git reset --hard master &&
 	 rm -rf deeper/ &&
-	 git submodule add ../submodule deeper/submodule
+	 git submodule add --name deeper/submodule2 ../submodule deeper/submodule
 	)
 '

-- 
1.7.12.1.430.g4fd6dc4
