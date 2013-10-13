From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] mv: Fix spurious warning when moving a file in presence of
 submodules
Date: Sun, 13 Oct 2013 13:52:05 +0200
Message-ID: <525A8965.3040407@web.de>
References: <vpq38o7nao9.fsf@anie.imag.fr> <52583B00.8040700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 13 13:52:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVKDY-0007AB-Lf
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 13:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924Ab3JMLwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 07:52:12 -0400
Received: from mout.web.de ([212.227.15.3]:54158 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751Ab3JMLwL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 07:52:11 -0400
Received: from [192.168.178.41] ([91.3.134.25]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LZvfZ-1WCOBw2oOb-00lmx9 for <git@vger.kernel.org>;
 Sun, 13 Oct 2013 13:52:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <52583B00.8040700@web.de>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:IRPSIUlrz40JQUoEmm2ZMVdSgYIcRMnNKtXmPL54nnHiYfVrSi/
 SNFSa3RF9zNsfozlfOl/Wzyn4n4WOPIxsKBo1RLtEqqggEKx/9hOI0PFcYcYZstZHmeIHWl
 NoIWQHOg3c9eo/JCnLsmArHqi0yCcRrx3TRy+UKuHPDMZP1oH1gunSXbmrU/1GsEannZhvA
 MJC/vwEu4h4x4cSkzU0sQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236075>

In commit 0656781fa "git mv" learned to update the submodule path in the
.gitmodules file when moving a submodule in the work tree. But since that
commit update_path_in_gitmodules() gets called no matter if we moved a
submodule or a regular file, which is wrong and leads to a bogus warning
when moving a regular file in a repo containing a .gitmodules file:

    warning: Could not find section in .gitmodules where path=<filename>

Fix that by only calling update_path_in_gitmodules() when moving a
submodule. To achieve that, we introduce the special SUBMODULE_WITH_GITDIR
define to distinguish the cases where we also have to connect work tree
and git directory from those where we only need to update the .gitmodules
setting.

A test for submodules using a .git directory together with a .gitmodules
file has been added to t7001. Even though newer git versions will always
use a gitfile when cloning submodules, repositories cloned with older git
versions will still use this layout.

Reported-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 11.10.2013 19:53, schrieb Jens Lehmann:
> Am 11.10.2013 16:29, schrieb Matthieu Moy:
>> I'm getting this warning:
>>
>>   warning: Could not find section in .gitmodules where path=XXX
>>
>> whenever I use "git mv" to move a file in a repository containing a
>> submodule. The file is outside the submodule and is completely
>> unrelated, so I do not understand the intent of the warning.
>>
>> My understanding (without looking at the code in detail) is that Git
>> tries to be clever about submodule renames, hence checks whether the
>> source file is a submodule. But then if the lookup fails, it should just
>> silently move on to "normal file move" mode I guess...
> 
> Right. Thanks for reporting, I can reproduce that here and am currently
> looking into that.

And this is the fix for it, which I believe is stuff for maint.


 builtin/mv.c  | 13 +++++++++----
 t/t7001-mv.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index aec79d1..2e0e61b 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -55,6 +55,7 @@ static const char *add_slash(const char *path)
 }

 static struct lock_file lock_file;
+#define SUBMODULE_WITH_GITDIR ((const char *)1)

 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
@@ -132,6 +133,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				submodule_gitfile[i] = read_gitfile(submodule_dotgit.buf);
 				if (submodule_gitfile[i])
 					submodule_gitfile[i] = xstrdup(submodule_gitfile[i]);
+				else
+					submodule_gitfile[i] = SUBMODULE_WITH_GITDIR;
 				strbuf_release(&submodule_dotgit);
 			} else {
 				const char *src_w_slash = add_slash(src);
@@ -230,10 +233,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (!show_only && mode != INDEX) {
 			if (rename(src, dst) < 0 && !ignore_errors)
 				die_errno (_("renaming '%s' failed"), src);
-			if (submodule_gitfile[i])
-				connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
-			if (!update_path_in_gitmodules(src, dst))
-				gitmodules_modified = 1;
+			if (submodule_gitfile[i]) {
+				if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
+					connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
+				if (!update_path_in_gitmodules(src, dst))
+					gitmodules_modified = 1;
+			}
 		}

 		if (mode == WORKING_DIRECTORY)
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index d432f42..b90e985 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -293,6 +293,32 @@ test_expect_success 'git mv moves a submodule with a .git directory and no .gitm
 	git diff-files --quiet
 '

+test_expect_success 'git mv moves a submodule with a .git directory and .gitmodules' '
+	rm -rf mod &&
+	git reset --hard &&
+	git submodule update &&
+	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	(
+		cd sub &&
+		rm -f .git &&
+		cp -a ../.git/modules/sub .git &&
+		GIT_WORK_TREE=. git config --unset core.worktree
+	) &&
+	mkdir mod &&
+	git mv sub mod/sub &&
+	! test -e sub &&
+	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	(
+		cd mod/sub &&
+		git status
+	) &&
+	echo mod/sub >expected &&
+	git config -f .gitmodules submodule.sub.path >actual &&
+	test_cmp expected actual &&
+	git update-index --refresh &&
+	git diff-files --quiet
+'
+
 test_expect_success 'git mv moves a submodule with gitfile' '
 	rm -rf mod/sub &&
 	git reset --hard &&
-- 
1.8.4.474.g128a96c.dirty
