From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 1/2] status/commit: show staged submodules regardless of ignore
 config
Date: Sat, 05 Apr 2014 18:59:03 +0200
Message-ID: <53403657.1020806@web.de>
References: <53403617.7050506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Ronald Weiss <weiss.ronald@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 05 18:59:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWTw2-00033l-9I
	for gcvg-git-2@plane.gmane.org; Sat, 05 Apr 2014 18:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbaDEQ7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2014 12:59:09 -0400
Received: from mout.web.de ([212.227.17.11]:59634 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102AbaDEQ7G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2014 12:59:06 -0400
Received: from [192.168.178.41] ([84.132.155.8]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lo0V2-1XCPNw2QgK-00fzt5; Sat, 05 Apr 2014 18:59:04
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53403617.7050506@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:5+Edjzob3M6rHl6BtlJqtPg6Lf4beLyHZDNBHDVvAAhz3eLsrJH
 ha5H59nEMN+LChIyuOwlZgJ0d3p5MEVzUMkjfakWKqRsHoYnhtsSAm64WcJ9yWPFNFzhk7b
 AAz01qVsmGKPK5U22rj2WZQCyy6puVoeGlQMzJ0il08vfcIt8muM3zTynk4Qz7ucFvai6xN
 6/HjRwNpVzlXQ2U+V1Syw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245782>

Currently setting submodule.<name>.ignore and/or diff.ignoreSubmodules to
"all" suppresses all output of submodule changes for the diff family,
status and commit. For status and commit this is really confusing, as it
even when the user chooses to record a new commit for an ignored submodule
by adding it manually this change won't show up under the to-be-committed
changes. To add insult to injury, a later "git commit" will error out with
"nothing to commit" when only ignored submodules are staged.

Fix that by making wt_status always print staged submodule changes, no
matter what ignore settings are configured. The only exception is when the
user explicitly uses the "--ignore-submodules=all" command line option, in
that case the submodule output is still suppressed. This also makes "git
commit" work again when only modifications of ignored submodules are
staged, as that command uses the "commitable" member of the wt_status
struct to determine if staged changes are present. But this only happens
when the commit command uses the wt_status* functions to produce status
output for human consumption (when forking an editor or with --dry-run),
in all other cases (e.g. when run in a script with '-m') another code path
is taken which uses index_differs_from() to determine if any changes are
staged which still ignores submodules according to their configuration.
This will be fixed in a follow-up commit.

Change t7508 to reflect this new behavior and add three new tests to show
that a single staged submodule configured to be ignored will be committed
when the status output is generated and won't be if not. Also update the
documentation of the ignore config options accordingly.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/config.txt     |  8 +++--
 Documentation/gitmodules.txt |  4 ++-
 t/t7508-status.sh            | 74 ++++++++++++++++++++++++++++++++++++++++++--
 wt-status.c                  | 12 ++++++-
 4 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 84c7e3f..171a98e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2289,7 +2289,9 @@ status.submodulesummary::
 	--summary-limit option of linkgit:git-submodule[1]). Please note
 	that the summary output command will be suppressed for all
 	submodules when `diff.ignoreSubmodules` is set to 'all' or only
-	for those submodules where `submodule.<name>.ignore=all`. To
+	for those submodules where `submodule.<name>.ignore=all`. The only
+	exception to that rule is that status and commit will show staged
+	submodule changes. To
 	also view the summary for ignored submodules you can either use
 	the --ignore-submodules=dirty command line option or the 'git
 	submodule summary' command, which shows a similar output but does
@@ -2320,7 +2322,9 @@ submodule.<name>.fetchRecurseSubmodules::
 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
 	a submodule as modified. When set to "all", it will never be considered
-	modified, "dirty" will ignore all changes to the submodules work tree and
+	modified (but it will nonetheless show up in the output of status and
+	commit when it has been staged), "dirty" will ignore all changes
+	to the submodules work tree and
 	takes only differences between the HEAD of the submodule and the commit
 	recorded in the superproject into account. "untracked" will additionally
 	let submodules with modified tracked files in their work tree show up.
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 347a9f7..f6c0dfd 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -67,7 +67,9 @@ submodule.<name>.fetchRecurseSubmodules::
 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
 	a submodule as modified. When set to "all", it will never be considered
-	modified, "dirty" will ignore all changes to the submodules work tree and
+	modified (but will nonetheless show up in the output of status and
+	commit when it has been staged), "dirty" will ignore all changes
+	to the submodules work tree and
 	takes only differences between the HEAD of the submodule and the commit
 	recorded in the superproject into account. "untracked" will additionally
 	let submodules with modified tracked files in their work tree show up.
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c987b5e..e6483fc 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1380,7 +1380,32 @@ EOF
 	test_i18ncmp expect output
 '

-test_expect_success '.gitmodules ignore=all suppresses submodule summary' '
+test_expect_success '.gitmodules ignore=all suppresses unstaged submodule summary' '
+	cat > expect << EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	modified:   sm
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   dir1/modified
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	.gitmodules
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	expect
+	output
+	untracked
+
+EOF
 	git config --add -f .gitmodules submodule.subname.ignore all &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status > output &&
@@ -1388,7 +1413,7 @@ test_expect_success '.gitmodules ignore=all suppresses submodule summary' '
 	git config -f .gitmodules  --remove-section submodule.subname
 '

-test_expect_success '.git/config ignore=all suppresses submodule summary' '
+test_expect_success '.git/config ignore=all suppresses unstaged submodule summary' '
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git config --add submodule.subname.ignore all &&
@@ -1461,4 +1486,49 @@ test_expect_success 'Restore default test environment' '
 	git config --unset status.showUntrackedFiles
 '

+test_expect_success 'git commit will commit a staged but ignored submodule' '
+	git config --add -f .gitmodules submodule.subname.ignore all &&
+	git config --add -f .gitmodules submodule.subname.path sm &&
+	git config --add submodule.subname.ignore all &&
+	git status -s --ignore-submodules=dirty >output &&
+	test_i18ngrep "^M. sm" output &&
+	GIT_EDITOR="echo hello >>\"\$1\"" &&
+	export GIT_EDITOR &&
+	git commit -uno &&
+	git status -s --ignore-submodules=dirty >output &&
+	test_i18ngrep ! "^M. sm" output
+'
+
+test_expect_success 'git commit --dry-run will show a staged but ignored submodule' '
+	git reset HEAD^ &&
+	git add sm &&
+	cat >expect << EOF &&
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	modified:   sm
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   dir1/modified
+
+Untracked files not listed (use -u option to show untracked files)
+EOF
+	git commit -uno --dry-run >output &&
+	test_i18ncmp expect output &&
+	git status -s --ignore-submodules=dirty >output &&
+	test_i18ngrep "^M. sm" output
+'
+
+test_expect_failure 'git commit -m will commit a staged but ignored submodule' '
+	git commit -uno -m message &&
+	git status -s --ignore-submodules=dirty >output &&
+	 test_i18ngrep ! "^M. sm" output &&
+	git config --remove-section submodule.subname &&
+	git config -f .gitmodules  --remove-section submodule.subname
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index ec7344e..86fec89 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -519,9 +519,19 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);

+	DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
 	if (s->ignore_submodule_arg) {
-		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
+	} else {
+		/*
+		 * Unless the user did explicitly request a submodule ignore
+		 * mode by passing a command line option we do not ignore any
+		 * changed submodule SHA-1s when comparing index and HEAD, no
+		 * matter what is configured. Otherwise the user won't be
+		 * shown any submodules she manually added (and which are
+		 * staged to be committed), which would be really confusing.
+		 */
+		handle_ignore_submodules_arg(&rev.diffopt, "dirty");
 	}

 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
-- 
1.9.1.476.g510abc7
