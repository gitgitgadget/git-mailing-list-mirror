From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v11 4/4] commit: add a commit.verbose config variable
Date: Thu, 31 Mar 2016 14:45:53 +0000
Message-ID: <01020153cd2341ec-341900e5-d186-401f-8cd2-dd213303ae4f-000000@eu-west-1.amazonses.com>
References: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 17:05:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ale9n-0005IA-R3
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 17:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756811AbcCaPFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 11:05:06 -0400
Received: from a6-246.smtp-out.eu-west-1.amazonses.com ([54.240.6.246]:39880
	"EHLO a6-246.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756677AbcCaPFF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2016 11:05:05 -0400
X-Greylist: delayed 1148 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Mar 2016 11:05:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1459435553;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=SBDhplnYHN9fEosoqp+EiXN/TFJMK3ePS1d/3958aV4=;
	b=Jy3JJroeKC5ppDo0XBcnJqFL6VmfhW0b0FM8EMPAi7DRN19W8kAhX9uyRpaDMWNW
	2W7A+kNdXDmsRciS/3FFOW44Elhz7VLHqwhGUlPgiuaww8pN/TTxYaYHdy0ujhNb6Q6
	zZXeeJQOK9Nz9cIQvEtFG7Gf7/wAXn+B/DluoYCY=
In-Reply-To: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.31-54.240.6.246
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290400>

Add commit.verbose configuration variable as a convenience for those
who always prefer --verbose.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
The previous version of the patch are:
 - [v10] $gmane/288820
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
 - Before config_verbose reacted to only -1 but henceforth it will react
   to every negative integer.
 - Use test_line_count for consistency
 - Add 1 more test for to check whether git status breaks
 - Add more tests to test whether commit.verbose works fine with all
   integers suggested by Eric Sunshine.
   Note: One might think some tests are extra but I think that it will
   be better to include them as they "complete the continuity" thus
   generalising the series which will make the patch even more clearer.

SZEDER pointed out a bug in v9 which broke status. verbose being set to
-1, returns true in the `if(verbose)` statement which gives a verbose
output. So thus, it is required to reset it to 0 if it was -1. This will
work fine when status is passed with --verbose and --no-verbose as they
both reflect non-negative values.
---
 Documentation/config.txt     |   4 +
 Documentation/git-commit.txt |   3 +-
 builtin/commit.c             |  14 +++-
 t/t7507-commit-verbose.sh    | 175 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 194 insertions(+), 2 deletions(-)

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
index b3bd2d4..96e6190 100644
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
@@ -1354,6 +1356,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			     builtin_status_usage, 0);
 	finalize_colopts(&s.colopts, -1);
 	finalize_deferred_config(&s);
+	if (verbose == -1)
+		verbose = 0;
 
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
@@ -1505,6 +1509,11 @@ static int git_commit_config(const char *k, const char *v, void *cb)
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
@@ -1654,6 +1663,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
+	if (verbose == -1)
+		verbose = (config_verbose < 0) ? 0 : config_verbose;
+
 	if (dry_run)
 		return dry_run_commit(argc, argv, prefix, current_head, &s);
 	index_file = prepare_index(argc, argv, prefix, current_head, 0);
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 0f28a86..7c79484 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -98,4 +98,179 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
 	test_i18ngrep "Aborting commit due to empty commit message." err
 '
 
+test_expect_success 'set up -v -v' '
+	echo dirty >file &&
+	echo dirty >file2 &&
+	git add file2
+'
+test_expect_success 'commit.verbose true and --verbose omitted' '
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
+	test_line_count = 0 out
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
+	test_line_count = 0 out
+'
+
+test_expect_success 'commit.verbose false and --no-verbose' '
+	git -c commit.verbose=false commit --amend --no-verbose &&
+	test_line_count = 0 out
+'
+
+test_expect_success 'commit.verbose=-2 and --verbose omitted' '
+	git -c commit.verbose=-2 commit --amend &&
+	test_line_count = 0 out
+'
+
+test_expect_success 'commit.verbose=-1 and --verbose omitted' '
+	git -c commit.verbose=-1 commit --amend &&
+	test_line_count = 0 out
+'
+
+test_expect_success 'commit.verbose=0 and --verbose omitted' '
+	git -c commit.verbose=0 commit --amend &&
+	test_line_count = 0 out
+'
+
+test_expect_success 'commit.verbose=1 and --verbose omitted' '
+	git -c commit.verbose=1 commit --amend &&
+	test_line_count = 1 out
+'
+
+test_expect_success 'commit.verbose=2 and --verbose omitted' '
+	git -c commit.verbose=2 commit --amend &&
+	test_line_count = 2 out
+'
+
+test_expect_success 'commit-verbose=3 and --verbose omitted' '
+	git -c commit.verbose=3 commit --amend &&
+	test_line_count = 2 out
+'
+
+test_expect_success 'commit.verbose=-2 and --verbose' '
+	git -c commit.verbose=-2 commit --amend --verbose &&
+	test_line_count = 1 out
+'
+
+test_expect_success 'commit.verbose=-1 and --verbose' '
+	git -c commit.verbose=-1 commit --amend --verbose &&
+	test_line_count = 1 out
+'
+
+test_expect_success 'commit.verbose=0 and --verbose' '
+	git -c commit.verbose=0 commit --amend --verbose &&
+	test_line_count = 1 out
+'
+
+test_expect_success 'commit.verbose=1 and --verbose' '
+	git -c commit.verbose=1 commit --amend --verbose &&
+	test_line_count = 1 out
+'
+
+test_expect_success 'commit.verbose=2 and --verbose' '
+	git -c commit.verbose=2 commit --amend --verbose &&
+	test_line_count = 1 out
+'
+
+test_expect_success 'commit.verbose=3 and --verbose' '
+	git -c commit.verbose=3 commit --amend --verbose &&
+	test_line_count = 1 out
+'
+
+test_expect_success 'commit.verbose=-2 and -v -v' '
+	git -c commit.verbose=-2 commit --amend -v -v &&
+	test_line_count = 2 out
+'
+
+test_expect_success 'commit.verbose=-1 and -v -v' '
+	git -c commit.verbose=-1 commit --amend -v -v &&
+	test_line_count = 2 out
+'
+
+test_expect_success 'commit.verbose=0 and -v -v' '
+	git -c commit.verbose=0 commit --amend -v -v &&
+	test_line_count = 2 out
+'
+
+test_expect_success 'commit.verbose=1 and -v -v' '
+	git -c commit.verbose=1 commit --amend -v -v &&
+	test_line_count = 2 out
+'
+
+test_expect_success 'commit.verbose=2 and -v -v' '
+	git -c commit.verbose=2 commit --amend -v -v &&
+	test_line_count = 2 out
+'
+
+test_expect_success 'commit.verbose=3 and -v -v' '
+	git -c commit.verbose=3 commit --amend -v -v &&
+	test_line_count = 2 out
+'
+
+test_expect_success 'commit.verbose=-2 and --no-verbose' '
+	git -c commit.verbose=-2 commit --amend --no-verbose &&
+	test_line_count = 0 out
+'
+
+test_expect_success 'commit.verbose=-1 and --no-verbose' '
+	git -c commit.verbose=-1 commit --amend --no-verbose &&
+	test_line_count = 0 out
+'
+
+test_expect_success 'commit.verbose=0 and --no-verbose' '
+	git -c commit.verbose=0 commit --amend --no-verbose &&
+	test_line_count = 0 out
+'
+
+test_expect_success 'commit.verbose=1 and --no-verbose' '
+	git -c commit.verbose=1 commit --amend --no-verbose &&
+	test_line_count = 0 out
+'
+
+test_expect_success 'commit.verbose=2 and --no-verbose' '
+	git -c commit.verbose=2 commit --amend --no-verbose &&
+	test_line_count = 0 out
+'
+
+test_expect_success 'commit.verbose=3 and --no-verbose' '
+	git -c commit.verbose=3 commit --amend --no-verbose &&
+	test_line_count = 0 out
+'
+
+test_expect_success 'status ignores commit.verbose=true' '
+	git -c commit.verbose=true status >actual &&
+	! grep "^diff --git" actual
+'
+
+test_expect_success 'status does not verbose without --verbose' '
+	git status >actual &&
+	! grep "^diff --git" actual
+'
+
 test_done

--
https://github.com/git/git/pull/218
