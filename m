From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [RFC/PATCH] grep --no-index: allow to grep without git exclusions
Date: Wed, 20 Jul 2011 14:50:53 +0200
Message-ID: <82218b89c89f733dc0759d648b3a60bca6e20f3e.1311165328.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 14:51:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjWF3-0002st-FO
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 14:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437Ab1GTMvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 08:51:01 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45083 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab1GTMu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 08:50:59 -0400
Received: by ewy4 with SMTP id 4so498497ewy.19
        for <git@vger.kernel.org>; Wed, 20 Jul 2011 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=f1Nmew38MkjAalgMevIufT7prNntv0pxuJatWRYcKtc=;
        b=redggbFidkcA9wrThWXhnriG7WjJSNzN5spc9r2Px54UUYDWul9SKZH2GtzfoXlnbP
         kLk3nA77w9EfoysEhhGxp/c9v7VbwVQXJxltBJHa+uIbVsW0GWoXDWN4tMWCbuz/BnSf
         Mr1GSFk/sMgePQf8227nmDWqcYEBQ1Y/OdCtg=
Received: by 10.213.31.208 with SMTP id z16mr3430491ebc.116.1311166257321;
        Wed, 20 Jul 2011 05:50:57 -0700 (PDT)
Received: from localhost (p4FC3BFFC.dip.t-dialin.net [79.195.191.252])
        by mx.google.com with ESMTPS id a8sm527175een.47.2011.07.20.05.50.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jul 2011 05:50:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.588.g8d735
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177533>

It is currently not possible to grep in arbitrary files with --no-index,
because the standard git exclusions are active when using --no-index.

Suppress this when the new option --no-exclude-standard was provided.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

The name comes from git-ls-files, and I think it is worthwhile to add the full
range of exclusion flags to git-grep. Namely --exclude=<patter>,
--exclude-from=<file>, and --exclude-per-directory=<file>. Which should 
only be honored when using --no-index, obviously.

 Documentation/git-grep.txt |    7 +++++
 builtin/grep.c             |   17 ++++++++++---
 t/t7810-grep.sh            |   55 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 07b3c6a..be9cf8b 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -24,6 +24,7 @@ SYNOPSIS
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
 	   [--cached | --no-index | <tree>...]
+	   [--no-exclude-standard]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
@@ -200,6 +201,12 @@ OPTIONS
 	Do not output matched lines; instead, exit with status 0 when
 	there is a match and with non-zero status when there isn't.
 
+--exclude-standard::
+--[no-]exclude-standard::
+	Use the standard git exclusions: .git/info/exclude, .gitignore
+	in each directory, and the user's global exclusion file when
+	searching in the work tree with `--no-index`.
+
 <tree>...::
 	Instead of searching tracked files in the working tree, search
 	blobs in the given trees.
diff --git a/builtin/grep.c b/builtin/grep.c
index cccf8da..f2fce73 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -637,13 +637,15 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 	return hit;
 }
 
-static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec)
+static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
+			  int exclude_standard)
 {
 	struct dir_struct dir;
 	int i, hit = 0;
 
 	memset(&dir, 0, sizeof(dir));
-	setup_standard_excludes(&dir);
+	if (exclude_standard)
+		setup_standard_excludes(&dir);
 
 	fill_directory(&dir, pathspec->raw);
 	for (i = 0; i < dir.nr; i++) {
@@ -761,7 +763,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct string_list path_list = STRING_LIST_INIT_NODUP;
 	int i;
 	int dummy;
-	int use_index = 1;
+	int use_index = 1, exclude_standard = 1;
 	enum {
 		pattern_type_unspecified = 0,
 		pattern_type_bre,
@@ -839,6 +841,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('p', "show-function", &opt.funcname,
 			"show a line with the function name before matches"),
 		OPT_GROUP(""),
+		OPT_BOOLEAN(0, "exclude-standard", &exclude_standard,
+			"don't use standard excludes, needs --no-index"),
+		OPT_GROUP(""),
 		OPT_CALLBACK('f', NULL, &opt, "file",
 			"read patterns from file", file_callback),
 		{ OPTION_CALLBACK, 'e', NULL, &opt, "pattern",
@@ -936,6 +941,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		break; /* nothing */
 	}
 
+	/* --no-exclude-standard needs --no-index */
+	if (use_index && !exclude_standard)
+		die(_("--no-exclude-standard does not make sense without --no-index."));
+
 	if (use_index && !startup_info->have_repository)
 		/* die the same way as if we did it at the beginning */
 		setup_git_directory();
@@ -1050,7 +1059,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			die(_("--cached cannot be used with --no-index."));
 		if (list.nr)
 			die(_("--no-index cannot be used with revs."));
-		hit = grep_directory(&opt, &pathspec);
+		hit = grep_directory(&opt, &pathspec, exclude_standard);
 	} else if (!list.nr) {
 		if (!cached)
 			setup_work_tree();
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index a29ae45..15eb52b 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -587,6 +587,61 @@ test_expect_success 'inside git repository but with --no-index' '
 	)
 '
 
+test_expect_success 'outside of git repository and --no-exclude-standard' '
+	rm -fr non &&
+	mkdir -p non/git/sub &&
+	echo hello >non/git/file1 &&
+	echo world >non/git/sub/file2 &&
+	echo ".*o*" >non/git/.gitignore &&
+	echo "fi*" >>non/git/.gitignore &&
+	{
+		echo file1:hello &&
+		echo sub/file2:world
+	} >non/expect.full &&
+	: >non/expect.empty &&
+	echo file2:world >non/expect.sub &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non/git" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_must_fail git grep l &&
+		git grep --no-index --no-exclude-standard l >../actual.full &&
+		test_cmp ../expect.full ../actual.full
+		cd sub &&
+		test_must_fail git grep l &&
+		git grep --no-index l >../../actual.sub &&
+		test_cmp ../../expect.sub ../../actual.sub
+	)
+'
+
+test_expect_success 'inside git repository but with --no-index and --no-exclude-standard' '
+	rm -fr is &&
+	mkdir -p is/git/sub &&
+	echo hello >is/git/file1 &&
+	echo world >is/git/sub/file2 &&
+	echo ".*o*" >is/git/.gitignore &&
+	echo "fi*" >>is/git/.gitignore &&
+	{
+		echo file1:hello &&
+		echo sub/file2:world
+	} >is/expect.full &&
+	: >is/expect.empty &&
+	echo file2:world >is/expect.sub &&
+	(
+		cd is/git &&
+		git init &&
+		test_must_fail git grep l >../actual.empty1 &&
+		test_cmp ../expect.empty ../actual.empty1 &&
+		git grep --no-index --no-exclude-standard l >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+		cd sub &&
+		test_must_fail git grep l >../../actual.sub &&
+		test_cmp ../../expect.empty ../../actual.sub &&
+		git grep --no-index --no-exclude-standard l >../../actual.sub &&
+		test_cmp ../../expect.sub ../../actual.sub
+	)
+'
+
 test_expect_success 'setup double-dash tests' '
 cat >double-dash <<EOF &&
 --
-- 
1.7.6.588.g8d735
