From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v4] commit: add a commit.verbose config variable
Date: Thu, 10 Mar 2016 22:12:07 +0000
Message-ID: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 23:30:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae96b-0002nR-8o
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 23:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbcCJWat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 17:30:49 -0500
Received: from a6-245.smtp-out.eu-west-1.amazonses.com ([54.240.6.245]:33489
	"EHLO a6-245.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752154AbcCJWas (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2016 17:30:48 -0500
X-Greylist: delayed 1120 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Mar 2016 17:30:48 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1457647927;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=9z/JSaUEE2qR3i1hf9y3FjdbS24gXIKeGUbP4OYBLCg=;
	b=gI4K1k2IxTOLLlhBC0ur/NvyqDAXvwkXK6Lp2AEg/xwhDRhWdqkCr9n2erhrAh2V
	SLkEizkffcAWofFoH1jEVfhZwucYOSQqkv/XXVtpwuL5eblT63EWfW+WfWaM+atdn86
	rcBu1KltQVc0mT0vo98VpMh589DhmB7VnTIBVjDM=
X-SES-Outgoing: 2016.03.10-54.240.6.245
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288652>

Since many people always run the command with this option, it would be
preferrable to specify it in the configuration file instead of passing
the option with `git commit` again and again.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 Documentation/config.txt     |  4 ++++
 Documentation/git-commit.txt |  3 ++-
 builtin/commit.c             |  4 ++++
 t/t7507-commit-verbose.sh    | 48 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 1 deletion(-)

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
index 9ec6b3c..3dcaac7 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -290,7 +290,8 @@ configuration variable documented in linkgit:git-config[1].
 	what changes the commit has.
 	Note that this diff output doesn't have its
 	lines prefixed with '#'. This diff will not be a part
-	of the commit message.
+	of the commit message. To activate this option permanently, the
+	configuration variable `commit.verbose` can be set to true.
 +
 If specified twice, show in addition the unified diff between
 what would be committed and the worktree files, i.e. the unstaged
diff --git a/builtin/commit.c b/builtin/commit.c
index b3bd2d4..55e9a82 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1505,6 +1505,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	}
+	if (!strcmp(k, "commit.verbose")){
+		verbose = git_config_bool(k, v);
+		return 0;
+	}
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 2ddf28c..4e123a5 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -96,4 +96,52 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
 	test_i18ngrep "Aborting commit due to empty commit message." err
 '
 
+test_expect_success 'commit with commit.verbose true and no arguments' '
+	echo content >file &&
+	git add file &&
+	test_config commit.verbose true &&
+	(
+		GIT_EDITOR=cat &&
+		export GIT_EDITOR &&
+		test_must_fail git commit >output
+	) &&
+	test_i18ngrep "diff --git" output
+'
+
+test_expect_success 'commit with commit.verbose true and --no-verbose' '
+	echo content >file &&
+	git add file &&
+	test_config commit.verbose true &&
+	(
+		GIT_EDITOR=cat &&
+		export GIT_EDITOR &&
+		test_must_fail git commit --no-verbose >output
+	) &&
+	! test_i18ngrep "diff --git" output
+'
+
+test_expect_success 'commit with commit.verbose false and -v' '
+	echo content >file &&
+	git add file &&
+	test_config commit.verbose false &&
+	(
+		GIT_EDITOR=cat &&
+		export GIT_EDITOR &&
+		test_must_fail git commit -v >output
+	) &&
+	test_i18ngrep "diff --git" output
+'
+
+test_expect_success 'commit with commit.verbose false no arguments' '
+	echo content >file &&
+	git add file &&
+	test_config commit.verbose false &&
+	(
+		GIT_EDITOR=cat &&
+		export GIT_EDITOR &&
+		test_must_fail git commit >output
+	) &&
+	! test_i18ngrep "diff --git" output
+'
+
 test_done

--
https://github.com/git/git/pull/205
