From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v10 3/3] commit: add a commit.verbose config variable
Date: Sat, 26 Mar 2016 19:48:49 +0000
Message-ID: <01020153b478cfab-5309f834-7617-4a7f-a3e9-93f0dcf4a6be-000000@eu-west-1.amazonses.com>
References: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 20:48:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajuCf-0003Na-No
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 20:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466AbcCZTsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2016 15:48:53 -0400
Received: from a6-243.smtp-out.eu-west-1.amazonses.com ([54.240.6.243]:33504
	"EHLO a6-243.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753520AbcCZTsw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Mar 2016 15:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1459021729;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=ecGBKyxN6y/LZoLy5Ce5nBuXGlPhEeCeeeK9LGlQFXk=;
	b=bD3uiPT3pI5O9VXhfSHJHi89AOtbpo1upVrpBIMEK6gchoxPjaDpSSutxO1jyUOb
	HcczCZ+1ji0gOVG8E8vMXK9T+l+Mu4oySM36m/icp7+lFffS+9kBxLd9zIul35hUkiE
	Hf2KLZ2n2211bQFLR09UC1Afzyo/P4zR+zw4jR7Q=
In-Reply-To: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.26-54.240.6.243
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289986>

Add commit.verbose configuration variable as a convenience for those
who always prefer --verbose taking care of multiple levels of verbosity.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
The previous version of the patch are:
 - [v9] $gmane/288820
 - [v8] $gmane/288820
 - [v7] $gmane/288820
 - [v6] $gmane/288728
 - [v5] $gmane/288728
 - [v4] $gmane/288652
 - [v3] $gmane/288634
 - [v2] $gmane/288569
 - [v1] $gmane/287540

Changes with respect to the previous patch:
 - Fixed a status related bug pointed out by SZEDER
 - Change some tests
---
 Documentation/config.txt     |  4 ++++
 Documentation/git-commit.txt |  3 ++-
 builtin/commit.c             | 16 ++++++++++++++-
 t/t7507-commit-verbose.sh    | 48 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 2 deletions(-)

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
index b3bd2d4..6a80a38 100644
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
@@ -1355,6 +1357,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	finalize_colopts(&s.colopts, -1);
 	finalize_deferred_config(&s);
 
+	if (verbose == -1)
+		verbose = 0;
+
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
 		s.show_ignored_files = 1;
@@ -1505,6 +1510,11 @@ static int git_commit_config(const char *k, const char *v, void *cb)
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
@@ -1654,6 +1664,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
+
+	if (verbose == -1)
+		verbose = (config_verbose == -1) ? 0 : config_verbose;
+
 	if (dry_run)
 		return dry_run_commit(argc, argv, prefix, current_head, &s);
 	index_file = prepare_index(argc, argv, prefix, current_head, 0);
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index b40eb3c..569fd8b 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -101,4 +101,52 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
 	test_i18ngrep "Aborting commit due to empty commit message." err
 '
 
+test_expect_success 'commit.verbose true and --verbose omitted' '
+	echo content >file2 &&
+	echo content >>file &&
+	git add file2 &&
+	git -c commit.verbose=true commit -F message &&
+	test_line_count = 1 out
+'
+
+test_expect_success 'commit.verbose true and --verbose' '
+	git -c commit.verbose=true commit --amend --verbose &&
+	test_line_count = 1 out
+'
+
+test_expect_success 'commit.verbose true and -v -v' '
+	git -c commit.verbose=true commit --amend -v -v &&
+	test_line_count = 2 out
+'
+
+test_expect_success 'commit.verbose true and --no-verbose' '
+	git -c commit.verbose=true commit --amend --no-verbose &&
+	! test -s out
+'
+
+test_expect_success 'commit.verbose false and --verbose' '
+	git -c commit.verbose=false commit --amend --verbose &&
+	test_line_count = 1 out
+'
+
+test_expect_success 'commit.verbose false and -v -v' '
+	git -c commit.verbose=false commit --amend -v -v &&
+	test_line_count = 2 out
+'
+
+test_expect_success 'commit.verbose false and --verbose omitted' '
+	git -c commit.verbose=false commit --amend &&
+	! test -s out
+'
+
+test_expect_success 'commit.verbose false and --no-verbose' '
+	git -c commit.verbose=false commit --amend --no-verbose &&
+	! test -s out
+'
+
+test_expect_success 'status ignores commit.verbose=true' '
+	git -c commit.verbose=true status >actual &&
+	! grep "^diff --git" actual
+'
+
 test_done

--
https://github.com/git/git/pull/218
