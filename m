From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v6] commit: add a commit.verbose config variable
Date: Mon, 14 Mar 2016 20:50:47 +0000
Message-ID: <0102015376e53b40-d25f7fdc-4ae1-4aae-b779-052fcf252071-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 22:02:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afZdV-0001vY-Ub
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 22:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933150AbcCNVCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 17:02:43 -0400
Received: from a6-243.smtp-out.eu-west-1.amazonses.com ([54.240.6.243]:34722
	"EHLO a6-243.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932609AbcCNVCl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2016 17:02:41 -0400
X-Greylist: delayed 712 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Mar 2016 17:02:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1457988647;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=bYdHgsInkWN/IDhFa5WeOLkxWCBwAK9Fzov7x7BjUxg=;
	b=SCvsrQ4GdGd6Zg+iafe16goGbPGy6J+FbefvoCGBxU9WIQy/FoB2a0/yX0JOLnGa
	bCaUFYANj3TdigEJXkarZDRZBSRoudmJFlvwIu4YYKOJRwflSZ/mF4YgxJ5ITD3DLnm
	RAgYtXv3t2kUhmJdZVlAM9e8rES+dYzE8Lo58QhE=
X-SES-Outgoing: 2016.03.14-54.240.6.243
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288811>

Add commit.verbose configuration variable as a convenience for those
who always prefer --verbose.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
The previous versions of this patch are:
 - [v5] $gmane/288728
 - [v4] $gmane/288652
 - [v3] $gmane/288634
 - [v2] $gmane/288569
 - [v1] $gmane/287540

The changes with respect to the last version are :
 - Use Helped-by tag instead of Mentored-by.
 - Use "^diff --git" instead of "*diff --git".
 - Add a different test to check whether the verbose option did not break status.
---
 Documentation/config.txt     |  4 ++++
 Documentation/git-commit.txt |  3 ++-
 builtin/commit.c             |  4 ++++
 t/t7507-commit-verbose.sh    | 29 +++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 01cca0a..9b93f6c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1110,6 +1110,10 @@ commit.template::
 	"`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
 	specified user's home directory.
 
+commit.verbose::
+	A boolean to specify whether to always include the verbose option
+	with `git commit`. See linkgit:git-commit[1].
+
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 9ec6b3c..d474226 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -290,7 +290,8 @@ configuration variable documented in linkgit:git-config[1].
 	what changes the commit has.
 	Note that this diff output doesn't have its
 	lines prefixed with '#'. This diff will not be a part
-	of the commit message.
+	of the commit message. See the `commit.verbose` configuration
+	variable in linkgit:git-config[1].
 +
 If specified twice, show in addition the unified diff between
 what would be committed and the worktree files, i.e. the unstaged
diff --git a/builtin/commit.c b/builtin/commit.c
index b3bd2d4..e0b96231 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1505,6 +1505,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	}
+	if (!strcmp(k, "commit.verbose")) {
+		verbose = git_config_bool(k, v);
+		return 0;
+	}
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 2ddf28c..35960b4 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -96,4 +96,33 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
 	test_i18ngrep "Aborting commit due to empty commit message." err
 '
 
+test_expect_success 'commit.verbose true and --verbose omitted' '
+	git -c commit.verbose=true commit --amend
+'
+
+test_expect_success 'commit.verbose true and --no-verbose' '
+	test_must_fail git -c commit.verbose=true commit --amend --no-verbose
+'
+
+test_expect_success 'commit.verbose false and --verbose' '
+	git -c commit.verbose=false commit --amend --verbose
+'
+
+test_expect_success 'commit.verbose false and --verbose omitted' '
+	test_must_fail git -c commit.verbose=false commit --amend
+'
+
+test_expect_success 'commit.verbose true and --verbose' '
+	git -c commit.verbose=true commit --amend --verbose
+'
+
+test_expect_success 'commit.verbose false and --no-verbose' '
+	test_must_fail git -c commit.verbose=false commit --amend --no-verbose
+'
+
+test_expect_success 'status ignores commit.verbose=true' '
+	git status >actual &&
+	! grep "^diff --git" actual
+'
+
 test_done

--
https://github.com/git/git/pull/205
