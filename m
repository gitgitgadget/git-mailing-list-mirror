From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] commit: --dry-run
Date: Sat,  8 Aug 2009 00:14:51 -0700
Message-ID: <1249715693-9715-2-git-send-email-gitster@pobox.com>
References: <1249715693-9715-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 08 09:15:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZg9K-0003p7-I6
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 09:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbZHHHPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 03:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754194AbZHHHPD
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 03:15:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111AbZHHHPA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 03:15:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 63EA921366
	for <git@vger.kernel.org>; Sat,  8 Aug 2009 03:14:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AF1DB21365 for
 <git@vger.kernel.org>; Sat,  8 Aug 2009 03:14:57 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.159.gd0d612
In-Reply-To: <1249715693-9715-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2E398E6A-83EB-11DE-BB43-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125250>

This teaches --dry-run option to "git commit".

It is the same as "git status", but in the longer term we would want to
change the semantics of "git status" not to be the preview of commit, and
this is the first step for doing so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-commit.txt |    7 ++++++-
 builtin-commit.c             |   29 ++++++++++++++++-------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b5d81be..d01ff5a 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,7 +8,7 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend]
+'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
 	   [(-c | -C) <commit>] [-F <file> | -m <msg>]
 	   [--allow-empty] [--no-verify] [-e] [--author=<author>]
 	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
@@ -198,6 +198,11 @@ specified.
 --quiet::
 	Suppress commit summary message.
 
+--dry-run::
+	Do not create a commit, but show a list of paths that are
+	to be committed, paths with local changes that will be left
+	uncommitted and paths that are untracked.
+
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/builtin-commit.c b/builtin-commit.c
index 6d12c2e..3a7e35d 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -51,7 +51,7 @@ static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
-static int quiet, verbose, no_verify, allow_empty;
+static int quiet, verbose, no_verify, allow_empty, dry_run;
 static char *untracked_files_arg;
 /*
  * The default commit message cleanup mode will remove the lines
@@ -103,6 +103,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN(0, "interactive", &interactive, "interactively add files"),
 	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
 	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
+	OPT_BOOLEAN(0, "dry-run", &dry_run, "show what would be committed"),
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
@@ -813,28 +814,28 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	return argc;
 }
 
-int cmd_status(int argc, const char **argv, const char *prefix)
+static int dry_run_commit(int argc, const char **argv, const char *prefix)
 {
-	const char *index_file;
 	int commitable;
+	const char *index_file;
 
-	git_config(git_status_config, NULL);
+	index_file = prepare_index(argc, argv, prefix, 1);
+	commitable = run_status(stdout, index_file, prefix, 0);
+	rollback_index_files();
 
+	return commitable ? 0 : 1;
+}
+
+int cmd_status(int argc, const char **argv, const char *prefix)
+{
+	git_config(git_status_config, NULL);
 	if (wt_status_use_color == -1)
 		wt_status_use_color = git_use_color_default;
-
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
 
 	argc = parse_and_validate_options(argc, argv, builtin_status_usage, prefix);
-
-	index_file = prepare_index(argc, argv, prefix, 1);
-
-	commitable = run_status(stdout, index_file, prefix, 0);
-
-	rollback_index_files();
-
-	return commitable ? 0 : 1;
+	return dry_run_commit(argc, argv, prefix);
 }
 
 static void print_summary(const char *prefix, const unsigned char *sha1)
@@ -909,6 +910,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		wt_status_use_color = git_use_color_default;
 
 	argc = parse_and_validate_options(argc, argv, builtin_commit_usage, prefix);
+	if (dry_run)
+		return dry_run_commit(argc, argv, prefix);
 
 	index_file = prepare_index(argc, argv, prefix, 0);
 
-- 
1.6.4.159.gd0d612
