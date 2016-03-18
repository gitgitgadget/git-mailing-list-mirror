From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v8 2/2] commit: add a commit.verbose config variable
Date: Fri, 18 Mar 2016 21:19:11 +0000
Message-ID: <010201538b98aaa4-ad08c159-4935-48f1-acdb-7c376da2c368-000000@eu-west-1.amazonses.com>
References: <010201538b98a7e5-ee604368-5a27-4884-b01e-027fa02bf1c6-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 22:37:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah25f-0002Gg-Up
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 22:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757611AbcCRVhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 17:37:46 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:39075
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757597AbcCRVhp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2016 17:37:45 -0400
X-Greylist: delayed 1111 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Mar 2016 17:37:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1458335951;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=BGPbX3eMNbDDwyGEmJzeHLkLId9vJNwgtcFnkZRlnr0=;
	b=J3kAgFidQ/xR3lM04rWbVtLJYyQVZpbaqLPXRG1He4mpGlma02zr6JSkSoYBrX2L
	xa/cWdI5N8jCcNyVt+0Zj/Y6+IXASqtagLw1K/jM9rc8A/xVQMKXnL5zaLCN+ivx+19
	UkoZTHVY9ZiNWbiybdZwlLueRExwZoEr0NYLp4nM=
In-Reply-To: <010201538b98a7e5-ee604368-5a27-4884-b01e-027fa02bf1c6-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.18-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289254>

Add commit.verbose configuration variable as a convenience for those
who always prefer --verbose.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
The previous version of the patch are:

 - [v7] $gmane/288820
 - [v6] $gmane/288728
 - [v5] $gmane/288728
 - [v4] $gmane/288652
 - [v3] $gmane/288634
 - [v2] $gmane/288569
 - [v1] $gmane/287540

Changes with respect to the previous patch:
 - Consider multiple verbosity as mentioned by SZEDER.
 - To implement this, change the way in which OPTION_COUNTUP() works.

Approach used: (Suggested by Junio Hamano and Eric Sunshine)
 - initialize verbose to "unspecified"
 - initialize config_verbose to "unspecified"
 - let git_config() update config_verbose
 - let parse_options() update verbose

 Then:
 - If verbose is still "unspecified", then overwrite it with
   config_verbose.
 - If verbose is still "unspecified" after that, then neither the
   command line nor the configuration gave you verbosity.
 - Otherwise verbose at this point has the verbosity level to use so set
   it to 0.
---
 Documentation/config.txt     |  4 ++++
 Documentation/git-commit.txt |  3 ++-
 builtin/commit.c             | 17 +++++++++++++-
 t/t7507-commit-verbose.sh    | 55 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..1d0ec2e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1110,6 +1110,10 @@ commit.template::
 	"`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
 	specified user's home directory.
 
+commit.verbose::
+	A boolean or int to specify the level of verbose with `git commit`.
+	See linkgit:git-commit[1].
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
index b3bd2d4..ad85be0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -113,7 +113,9 @@ static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
 static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
-static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
+static int config_verbose = -1; /* unspecified */
+static int verbose = -1; /* unspecified */
+static int quiet, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
 static char *sign_commit;
@@ -1505,6 +1507,11 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	}
+	if (!strcmp(k, "commit.verbose")) {
+		int is_bool;
+		config_verbose = git_config_bool_or_int(k, v, &is_bool);
+		return 0;
+	}
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
@@ -1654,6 +1661,14 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
+
+	if (verbose < 0) {
+		if (config_verbose > -1)
+			verbose = config_verbose;
+		else
+			verbose = 0;
+	}
+
 	if (dry_run)
 		return dry_run_commit(argc, argv, prefix, current_head, &s);
 	index_file = prepare_index(argc, argv, prefix, current_head, 0);
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 2ddf28c..dda674e 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -96,4 +96,59 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
 	test_i18ngrep "Aborting commit due to empty commit message." err
 '
 
+test_expect_success 'commit.verbose true and --verbose omitted' '
+	git -c commit.verbose=true commit --amend
+'
+
+test_expect_success 'commit.verbose true and --verbose' '
+	(
+		GIT_EDITOR=cat &&
+		export GIT_EDITOR &&
+		git -c commit.verbose=true commit --amend --verbose
+	) &&
+	grep "^diff --git" .git/COMMIT_EDITMSG >out &&
+	wc -l out | grep "1"
+'
+
+test_expect_success 'commit.verbose true and -v -v' '
+	(
+		GIT_EDITOR=cat &&
+		export GIT_EDITOR &&
+		git -c commit.verbose=true commit --amend -v -v
+	) &&
+	grep "# Changes not staged for commit" .git/COMMIT_EDITMSG >out &&
+	wc -l out | grep "2"
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
+test_expect_success 'commit.verbose false and -v -v' '
+	(
+		GIT_EDITOR=cat &&
+		export GIT_EDITOR &&
+		git -c commit.verbose=false commit --amend -v -v
+	) &&
+	grep "# Changes not staged for commit" .git/COMMIT_EDITMSG >out &&
+	wc -l out | grep "2"
+'
+
+test_expect_success 'commit.verbose false and --verbose omitted' '
+	test_must_fail git -c commit.verbose=false commit --amend
+'
+
+test_expect_success 'commit.verbose false and --no-verbose' '
+	test_must_fail git -c commit.verbose=false commit --amend --no-verbose
+'
+
+test_expect_success 'status ignores commit.verbose=true' '
+	git -c commit.verbose=true status >actual &&
+	! grep "^diff --git" actual
+'
+
 test_done

--
https://github.com/git/git/pull/213
