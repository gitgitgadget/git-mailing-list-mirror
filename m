From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP/PATCH] status/commit: always show staged submodules regardless
 of ignore config
Date: Sun, 30 Mar 2014 12:14:52 +0200
Message-ID: <5337EE9C.4080101@web.de>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com> <5335A78C.60401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Ronald Weiss <weiss.ronald@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 12:15:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUCln-000310-1g
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 12:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbaC3KPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2014 06:15:04 -0400
Received: from mout.web.de ([212.227.15.3]:59338 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbaC3KPC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 06:15:02 -0400
Received: from [192.168.178.41] ([84.132.177.33]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MBCJd-1WJzcK454v-00AD4l; Sun, 30 Mar 2014 12:14:58
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5335A78C.60401@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:nrqh1eDV534G+8H6Zof6kn7h/iyJ3eNLTm0uHsZXlnT4YMJERGD
 MPaEVeN+ht65aSaZNAQCDHjRnPwg+g417H5i8oS2I++sWvRbGIvRQzF6VE5+RxLtqWP2CyL
 TwCZyk6WbDGC8hfRF6XWrTSl++lem++CwkffDzCxW3wljYas9fmqwCR4L8lIshYJf+zG/4I
 X+98CB+gZbai0J3ca35PA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245457>

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
struct to determine if staged changes are present.

Change t7508 to reflect this new behavior. Also mention it in the
documentation of the ignore config options.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Am 28.03.2014 17:47, schrieb Jens Lehmann:
> Am 28.03.2014 00:36, schrieb Ronald Weiss:
>> And also, I'd like to know git folks' opinion on whether it's OK that
>> git commit with ignore=all in .gitmodules ignores submodules even when
>> they are explicitely staged with git add.
> 
> No, they should be visible in status and commit when the user chose
> to add them. I see if I can hack something up (as I've been bitten
> myself by that recently ;-).

Ok, here we go! As we discussed the same issue last November I
added the people involved back then to the CC.

I still need to fix an issue with this patch: committing a single
ignored submodule sometimes exits with an error code (even though
the commit succeeds), I'm still looking into that and will provide
a test for commit too.

After this we need at least two other patches:

- git gui should show staged ignored submodules

- gitk should show staged ignored submodules

(It'd be great if someone else would tackle these two, just let me
know if you want to to avoid duplicated work)

Did I forget a git command that shows what is to be staged?


 Documentation/config.txt     |  8 ++++++--
 Documentation/gitmodules.txt |  4 +++-
 t/t7508-status.sh            | 29 +++++++++++++++++++++++++++--
 wt-status.c                  | 12 +++++++++++-
 4 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 73c8973..0a2e9ad 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2279,7 +2279,9 @@ status.submodulesummary::
 	--summary-limit option of linkgit:git-submodule[1]). Please note
 	that the summary output command will be suppressed for all
 	submodules when `diff.ignoreSubmodules` is set to 'all' or only
-	for those submodules where `submodule.<name>.ignore=all`. To
+	for those submodules where `submodule.<name>.ignore=all`. The only
+	exception to that rule is that status and commit will always show
+	submodule changes that have been staged. To
 	also view the summary for ignored submodules you can either use
 	the --ignore-submodules=dirty command line option or the 'git
 	submodule summary' command, which shows a similar output but does
@@ -2310,7 +2312,9 @@ submodule.<name>.fetchRecurseSubmodules::
 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
 	a submodule as modified. When set to "all", it will never be considered
-	modified, "dirty" will ignore all changes to the submodules work tree and
+	modified (but will nonetheless show up in the output of status and
++	commit when they have been staged), "dirty" will ignore all changes
+	to the submodules work tree and
 	takes only differences between the HEAD of the submodule and the commit
 	recorded in the superproject into account. "untracked" will additionally
 	let submodules with modified tracked files in their work tree show up.
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index f539e3f..f684963 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -71,7 +71,9 @@ submodule.<name>.fetchRecurseSubmodules::
 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
 	a submodule as modified. When set to "all", it will never be considered
-	modified, "dirty" will ignore all changes to the submodules work tree and
+	modified (but will nonetheless show up in the output of status and
+	commit when they have been staged), "dirty" will ignore all changes
+	to the submodules work tree and
 	takes only differences between the HEAD of the submodule and the commit
 	recorded in the superproject into account. "untracked" will additionally
 	let submodules with modified tracked files in their work tree show up.
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c987b5e..f2b89e8 100755
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
diff --git a/wt-status.c b/wt-status.c
index e1827fa..821d10c 100644
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
1.9.1.378.g5fbabd4
