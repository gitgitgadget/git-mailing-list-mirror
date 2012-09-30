From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 2/2] submodule add: Fail when .git/modules/<name> already
 exists unless forced
Date: Sun, 30 Sep 2012 23:01:29 +0200
Message-ID: <5068B329.7040302@web.de>
References: <BC634E06939C44239106E7A8DD229130@gmail.com> <50636C00.6080906@web.de> <50677E76.1050204@web.de> <7vtxugglqy.fsf@alter.siamese.dyndns.org> <50689B5F.3060308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Johnson <me@jondavidjohn.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 23:01:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIQe1-0005Zz-0n
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 23:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab2I3VBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 17:01:35 -0400
Received: from mout.web.de ([212.227.15.3]:61836 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334Ab2I3VBe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 17:01:34 -0400
Received: from [192.168.178.41] ([91.3.153.206]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0Ls9JH-1TQrP43soJ-013daW; Sun, 30 Sep 2012 23:01:30
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <50689B5F.3060308@web.de>
X-Provags-ID: V02:K0:tVZurKdTXPiaitZSHsbCVRpPu37dkKN41t1c1N+lGOx
 VlPHpQa6WM6cJBxWb1KsJymKgEgNsrZNIsfRQue6CKddW87QMd
 ZJFw6bjbEWIuhOoIZeMk2ttuCHYgmUh7M3uSmce7VsggqIDau8
 qfIfYoE7J3nFt4kAvVkqthe2Jj8kNcUKBPKInS0BWIZA4eXN6D
 oss/FT3Tx4LiVWlDb0srQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206698>

When adding a new submodule it can happen that .git/modules/<name> already
contains a submodule repo, e.g. when a submodule is removed from the work
tree and another submodule is added at the same path. But then the work
tree of the submodule will be populated using the existing repository and
not the one the user provided, which results in an incorrect work tree. On
the other hand the user might reactivate a submodule removed earlier, then
reusing that .git directory is the Right Thing to do.

As git can't decide what is the case, error out and tell the user she
should use either use a different name for the submodule with the "--name"
option or can reuse the .git directory for the newly added submodule by
providing the --force option (which only makes sense when the upstream
matches, so the error message lists all remotes of .git/modules/<name>).

In one test in t7406 the --force option had to be added to "git submodule
add", as that test re-adds a formerly removed submodule.

Reported-by: Jonathan Johnson <me@jondavidjohn.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 30.09.2012 21:19, schrieb Jens Lehmann:
> Am 30.09.2012 06:47, schrieb Junio C Hamano:
>> I think failing with a better error message is a good idea. It
>> should suggest to either resurrect the submodule that is stashed
>> away in "$GIT_DIR/modules/$name" if it indeed is the same, or to
>> give it a different name (perhaps "kernel" used to be pointing at
>> the Linux kernel history, then the user is replacing it with a
>> totally different implementation that is really from different
>> origin and do not share any history, perhaps BSD).  In such a case,
>> the user may want to pick bsd-kernel or something as its name, to
>> differentiate it.
> 
> Good point! I will add a more detailed error message (including
> the url of the default remote which is configured for the already
> present submodule repo) and teach --force to skip the test and
> resurrect that submodule repo.

The message when "git submodule add" finds .git/modules/<name> is:

A git directory for '<name>' is found locally with remote(s):
  origin	<url(s) from .git/modules/<name>>
If you want to reuse this local git directory instead of cloning again from
  <url given on command line>
use the '--force' option. If the local git directory is not the correct repo
or you are unsure what this means choose another name with the '--name' option.

When run with the --force option the following message is printed:

Reactivating local git directory for submodule '<name>'.


 git-submodule.sh            | 15 ++++++++++++++-
 t/t7400-submodule-basic.sh  | 30 ++++++++++++++++++++++++++++++
 t/t7406-submodule-update.sh |  2 +-
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 22febb1..e8112c8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -359,7 +359,20 @@ Use -f if you really want to add it." >&2
 		fi

 	else
-
+		if test -d ".git/modules/$sm_name"
+		then
+			if test -z "$force"
+			then
+				echo >&2 "$(eval_gettext "A git directory for '\$sm_name' is found locally with remote(s):")"
+				GIT_DIR=".git/modules/$sm_name" GIT_WORK_TREE=. git remote -v | grep '(fetch)' | sed -e s,^,"  ", -e s,' (fetch)',, >&2
+				echo >&2 "$(eval_gettext "If you want to reuse this local git directory instead of cloning again from")"
+				echo >&2 "  $realrepo"
+				echo >&2 "$(eval_gettext "use the '--force' option. If the local git directory is not the correct repo")"
+				die "$(eval_gettext "or you are unsure what this means choose another name with the '--name' option.")"
+			else
+				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
+			fi
+		fi
 		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" || exit
 		(
 			clear_local_git_env
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 78bf739..f1a94f7 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -726,4 +726,34 @@ test_expect_success 'submodule add --name allows to replace a submodule with ano
 	)
 '

+test_expect_success 'submodule add with an existing name fails unless forced' '
+	(
+		cd addtest2 &&
+		rm -rf repo &&
+		git rm repo &&
+		test_must_fail git submodule add -q --name repo_new "$submodurl/repo.git" repo &&
+		test ! -d repo &&
+		echo "repo" >expect &&
+		git config -f .gitmodules submodule.repo_new.path >actual &&
+		test_cmp expect actual&&
+		echo "$submodurl/bare.git" >expect &&
+		git config -f .gitmodules submodule.repo_new.url >actual &&
+		test_cmp expect actual &&
+		echo "$submodurl/bare.git" >expect &&
+		git config submodule.repo_new.url >actual &&
+		test_cmp expect actual &&
+		git submodule add -f -q --name repo_new "$submodurl/repo.git" repo &&
+		test -d repo &&
+		echo "repo" >expect &&
+		git config -f .gitmodules submodule.repo_new.path >actual &&
+		test_cmp expect actual&&
+		echo "$submodurl/repo.git" >expect &&
+		git config -f .gitmodules submodule.repo_new.url >actual &&
+		test_cmp expect actual &&
+		echo "$submodurl/repo.git" >expect &&
+		git config submodule.repo_new.url >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 1542653..feaec6c 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -627,7 +627,7 @@ test_expect_success 'submodule add properly re-creates deeper level submodules'
 	(cd super &&
 	 git reset --hard master &&
 	 rm -rf deeper/ &&
-	 git submodule add ../submodule deeper/submodule
+	 git submodule add --force ../submodule deeper/submodule
 	)
 '

-- 
1.7.12.1.430.gd057107
