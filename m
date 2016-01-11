From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 0/3] Introduce a --use-index command line argument in git grep
Date: Mon, 11 Jan 2016 18:00:45 +0100
Message-ID: <1452531648-16575-1-git-send-email-t.gummerer@gmail.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
Cc: pclouds@gmail.com, sunshine@sunshineco.com, gitster@pobox.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 18:00:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIfph-0001LU-A8
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761385AbcAKRAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 12:00:36 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33695 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759065AbcAKRAf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:00:35 -0500
Received: by mail-wm0-f67.google.com with SMTP id u188so27122052wmu.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 09:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hj4C/undvdipq6UsmtRgc86vsEbAnz3/EQ8CL1j9FLE=;
        b=TXxFdcHnUgd3Tqmmh7hDGsAWGTZIC0QkbqAAG2w6xY9YB43wQUl8OWzcfHZHlnTtSo
         dsJSwpLSR5/a4TKDgFz5y/ZX0CEeV/QYW4yo+k1jTCuuJlOJmZuWdIMmKN/1yzz8rGX1
         szIs/cqR4dhVi8zwskUMwqbfYULaY95p4ocdAFfgkdJwKsvPNlHeWzJjaDQaeEo5BCPG
         xNdquwf9QQgYl+eVtkxwpVRkWZWxrSHcV4FEDZpb0G/7dfT2mwhkSsWjluxUmIkq7fm2
         22LDMxNoauJnMIR2Os8zi4pEjuFJ7RUBsUCRO8GPHDObRe9quxu8A422OO0y0/p41A1v
         kncQ==
X-Received: by 10.28.65.85 with SMTP id o82mr15516873wma.23.1452531634058;
        Mon, 11 Jan 2016 09:00:34 -0800 (PST)
Received: from localhost (host143-106-dynamic.248-95-r.retail.telecomitalia.it. [95.248.106.143])
        by smtp.gmail.com with ESMTPSA id jo6sm120680137wjb.48.2016.01.11.09.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 09:00:32 -0800 (PST)
X-Mailer: git-send-email 2.6.0.rc0.160.g9ddbed8
In-Reply-To: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283670>

The first round is at $gmane/283619.  Thanks to Duy and Eric for the reviews.

I decided to go with Duy's suggestion, introducing a new --use-index
option, instead of modifying the behaviour of git grep outside of a
git repository, as it seems to be the safer way to go.

Changes since the last version:
01/03: Fix the && chain in this test as well.
03/03:
 - Introduced the new --no-index argument
 - fixed the test thanks to the suggestion of Eric
 - modified the test to use --use-index=optional and added a test that
   uses --use-index=never.
 - Fixed the if/else statements for the error messages to be more
   consistent.
 - Added documentation for the new option

Interdiff below:

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4a44d6d..90ff643 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -25,6 +25,7 @@ SYNOPSIS
 	   [-W | --function-context]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
+	   [--use-index=<always|optional|never>]
 	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
 
@@ -66,6 +67,18 @@ OPTIONS
 --no-index::
 	Search files in the current directory that is not managed by Git.
 
+--use-index::
+	Set the behavior of git grep when used in- or outside of a git
+	repository.  If set to always, the command can only be used
+	inside of a git repository, and will fail if it is used
+	outside of a git repository.  If set to never, it will work
+	both inside and outside of a git repository, but will not use
+	any information in the index if used inside of a repository.
+	If set to optional, it will work both inside and outside of a
+	git repository, using the information available in the index
+	if used inside a repository.  Always and optional can be
+	overridden by `--no-index`.
+
 --untracked::
 	In addition to searching in the tracked files in the working
 	tree, search also in untracked files.
diff --git a/builtin/grep.c b/builtin/grep.c
index a886af1..bb2add9 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -629,6 +629,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int i;
 	int dummy;
 	int no_index = 0;
+	const char *use_index = NULL;
 	int pattern_type_arg = GREP_PATTERN_TYPE_UNSPECIFIED;
 
 	struct option options[] = {
@@ -637,6 +638,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "no-index", &no_index,
 			N_("find in contents not managed by git"),
 			GREP_NO_INDEX_EXPLICIT),
+		OPT_STRING(0, "use-index", &use_index, N_("always|optional|never"),
+			   N_("options for using the index")),
 		OPT_BOOL(0, "untracked", &untracked,
 			N_("search in both tracked and untracked files")),
 		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
@@ -759,14 +762,29 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	grep_commit_pattern_type(pattern_type_arg, &opt);
 
-	if (!no_index && !startup_info->have_repository) {
-		int nongit = 0;
+	if (use_index) {
+		if (!strcmp(use_index, "always")) {
+			/* same as git grep without --use-index */
+		} else if (!strcmp(use_index, "optional")) {
+			if (!no_index && !startup_info->have_repository) {
+				int nongit = 0;
 
-		setup_git_directory_gently(&nongit);
-		if (nongit)
-			no_index = GREP_NO_INDEX_IMPLICIT;
+				setup_git_directory_gently(&nongit);
+				if (nongit)
+					no_index = GREP_NO_INDEX_IMPLICIT;
+			}
+		} else if (!strcmp(use_index, "never")) {
+			no_index = GREP_NO_INDEX_EXPLICIT;
+		} else {
+			die(_("invalid option \"%s\" for --use-index, expecting"
+			      " always, optional or never"), use_index);
+		}
 	}
 
+	if (!no_index && !startup_info->have_repository)
+		/* die the same way as if we did it at the beginning */
+		setup_git_directory();
+
 	/*
 	 * skip a -- separator; we know it cannot be
 	 * separating revisions from pathnames if
@@ -881,11 +899,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!show_in_pager && !opt.status_only)
 		setup_pager();
 
-	if (untracked || cached) {
-		if (no_index == GREP_NO_INDEX_EXPLICIT)
-			die(_("--cached or --untracked cannot be used with --no-index."));
-		else if (no_index == GREP_NO_INDEX_IMPLICIT)
-			die(_("--cached or --untracked cannot be used outside a git repository."));
+	if (no_index && (untracked || cached)) {
+		if (no_index == GREP_NO_INDEX_IMPLICIT)
+			die(_("--cached or --untracked cannot be used outside "
+			      "of a git repository."));
+		else
+			die(_("--cached or --untracked cannot be used with "
+			      "--no-index or --no-index=never."));
 	}
 
 	if (no_index || untracked) {
@@ -894,7 +914,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			if (no_index == GREP_NO_INDEX_IMPLICIT)
 				die(_("cannot use revs outside of a git repository."));
 			else
-				die(_("--no-index or --untracked cannot be used with revs."));
+				die(_("--no-index, --use-index=never or "
+				      "--untracked cannot be used with revs."));
 		}
 		hit = grep_directory(&opt, &pathspec, use_exclude);
 	} else if (0 <= opt_exclude) {
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 4ba955d..9776f15 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -794,9 +794,11 @@ test_expect_success 'outside of git repository' '
 		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
+		test_must_fail git grep o &&
 		git grep --no-index o >../actual.full &&
-		test_cmp ../expect.full ../actual.full
+		test_cmp ../expect.full ../actual.full &&
 		cd sub &&
+		test_must_fail git grep o &&
 		git grep --no-index o >../../actual.sub &&
 		test_cmp ../../expect.sub ../../actual.sub
 	) &&
@@ -806,11 +808,12 @@ test_expect_success 'outside of git repository' '
 		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
+		test_must_fail git grep o &&
 		git grep --no-index --exclude-standard o >../actual.full &&
 		test_cmp ../expect.full ../actual.full &&
 
 		{
-			echo ".gitignore:.*o*"
+			echo ".gitignore:.*o*" &&
 			cat ../expect.full
 		} >../expect.with.ignored &&
 		git grep --no-index --no-exclude o >../actual.full &&
@@ -818,24 +821,67 @@ test_expect_success 'outside of git repository' '
 	)
 '
 
-test_expect_success 'outside of git repository without --no-index' '
+test_expect_success 'outside of git repository with --use-index=optional' '
 	rm -fr non &&
 	mkdir -p non/git/sub &&
 	echo hello >non/git/file1 &&
 	echo world >non/git/sub/file2 &&
-	{
-		echo file1:hello &&
-		echo sub/file2:world
-	} >non/expect.full &&
+	cat <<-\EOF >non/expect.full &&
+	file1:hello
+	sub/file2:world
+	EOF
+	echo file2:world >non/expect.sub &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_must_fail git grep --use-index=always o &&
+		git grep --use-index=optional o >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+		cd sub &&
+		test_must_fail git grep --use-index=always o &&
+		git grep --use-index=optional o >../../actual.sub &&
+		test_cmp ../../expect.sub ../../actual.sub
+	) &&
+
+	echo ".*o*" >non/git/.gitignore &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_must_fail git grep --use-index=always o &&
+		git grep --use-index=optional --exclude-standard o >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+
+		{
+			echo ".gitignore:.*o*" &&
+			cat ../expect.full
+		} >../expect.with.ignored &&
+		git grep --use-index=optional --no-exclude o >../actual.full &&
+		test_cmp ../expect.with.ignored ../actual.full
+	)
+'
+
+test_expect_success 'outside of git repository with --use-index=never' '
+	rm -fr non &&
+	mkdir -p non/git/sub &&
+	echo hello >non/git/file1 &&
+	echo world >non/git/sub/file2 &&
+	cat <<-\EOF >non/expect.full &&
+	file1:hello
+	sub/file2:world
+	EOF
 	echo file2:world >non/expect.sub &&
 	(
 		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
-		git grep o >../actual.full &&
-		test_cmp ../expect.full ../actual.full
+		test_must_fail git grep --use-index=always o &&
+		git grep --use-index=never o >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
 		cd sub &&
-		git grep o >../../actual.sub &&
+		test_must_fail git grep --use-index=always o &&
+		git grep --use-index=never o >../../actual.sub &&
 		test_cmp ../../expect.sub ../../actual.sub
 	) &&
 
@@ -844,14 +890,15 @@ test_expect_success 'outside of git repository without --no-index' '
 		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
-		git grep --exclude-standard o >../actual.full &&
+		test_must_fail git grep --use-index=always o &&
+		git grep --use-index=never --exclude-standard o >../actual.full &&
 		test_cmp ../expect.full ../actual.full &&
 
 		{
-			echo ".gitignore:.*o*"
+			echo ".gitignore:.*o*" &&
 			cat ../expect.full
 		} >../expect.with.ignored &&
-		git grep --no-exclude o >../actual.full &&
+		git grep --use-index=never --no-exclude o >../actual.full &&
 		test_cmp ../expect.with.ignored ../actual.full
 	)
 '

Thomas Gummerer (3):
  t7810: correct --no-index test
  builtin/grep: rename use_index to no_index
  builtin/grep: introduce --use-index argument

 Documentation/git-grep.txt | 13 +++++++
 builtin/grep.c             | 57 +++++++++++++++++++++++------
 t/t7810-grep.sh            | 90 +++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 146 insertions(+), 14 deletions(-)

-- 
2.7.0.3.g214d8d0.dirty
