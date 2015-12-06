From: James <rouzier@gmail.com>
Subject: [PATCH v2 2/2] clean: new option --exclude-from
Date: Sun,  6 Dec 2015 09:58:26 -0500
Message-ID: <1449413906-23256-2-git-send-email-rouzier@gmail.com>
References: <CAPig+cRa31uriO4qkZUydooNx0V+dNrUgFvTUxoLL9gCjq9AHQ@mail.gmail.com>
 <1449413906-23256-1-git-send-email-rouzier@gmail.com>
Cc: James Rouzier <rouzier@gmail.com>, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 15:59:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5amX-0005kA-Gn
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 15:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbbLFO7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 09:59:12 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36654 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbbLFO7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 09:59:08 -0500
Received: by qgcc31 with SMTP id c31so125845339qgc.3
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 06:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wQ3z1t2jc36G7Lv0sCphfOqalM7+4znbkRfQ1vXQ6c4=;
        b=gmjBl1rDjg2xdqhM3sgHouCKJzr4AEBX+tHIj+BJZGTQ9NJySKDS8791H75yuf1MV+
         5fqbabalASs75cZte3qxuPBqrYf1Ri1OnGLgHo6FsGDSh1Dk+RhpGNQcrwZHLZFet9W8
         xCzaxXxvGrRrkCv1P76gvY9ebhifz8y3BFGjCdNI/XRRGN+SlLDRZWrbqeSeBSF0jiKQ
         2lK8qlN9/SVlmOTUusNOZmsmqN/Vzk6/jELgLMqULbANnN1VrJz4WDIGgNqyrSYPMWeH
         dS1BmBI594fEU4z66LlyYDqbupKHJ5wPp561LKjSXU37dd6cUgDm20jpuSgG1E1HNm0C
         Cysw==
X-Received: by 10.140.25.145 with SMTP id 17mr31779292qgt.96.1449413947272;
        Sun, 06 Dec 2015 06:59:07 -0800 (PST)
Received: from centos6-oc.jr.inverse.ca (modemcable080.32-81-70.mc.videotron.ca. [70.81.32.80])
        by smtp.gmail.com with ESMTPSA id z72sm9327588qkz.46.2015.12.06.06.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2015 06:59:06 -0800 (PST)
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1449413906-23256-1-git-send-email-rouzier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282053>

From: James Rouzier <rouzier@gmail.com>

Specify a file to read for exclude patterns.
---
 Documentation/git-clean.txt |  5 +++-
 builtin/clean.c             | 15 ++++++++++--
 t/t7300-clean.sh            | 60 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 641681f..ef5dc41 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
+'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [--exclude-from=<file>] [-x | -X] [--] <path>...
 
 DESCRIPTION
 -----------
@@ -61,6 +61,9 @@ OPTIONS
 	$GIT_DIR/info/exclude, also consider these patterns to be in the
 	set of the ignore rules in effect.
 
+--exclude-from=<file>::
+	Read exclude patterns from <file>; 1 per line.
+
 -x::
 	Don't use the standard ignore rules read from .gitignore (per
 	directory) and $GIT_DIR/info/exclude, but do still use the ignore
diff --git a/builtin/clean.c b/builtin/clean.c
index d7acb94..8e652f8 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -22,7 +22,7 @@ static struct string_list del_list = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
 
 static const char *const builtin_clean_usage[] = {
-	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
+	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [--exclude-from=<file>] [-x | -X] [--] <paths>..."),
 	NULL
 };
 
@@ -875,6 +875,14 @@ static void interactive_main_loop(void)
 	}
 }
 
+static int exclude_from_cb(const struct option *opt,
+				     const char *arg, int unset)
+{
+	struct dir_struct *dir = opt->value;
+	add_excludes_from_file(dir, arg);
+	return 0;
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i, res;
@@ -898,12 +906,16 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				N_("remove whole directories")),
 		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, N_("pattern"),
 		  N_("add <pattern> to ignore rules"), PARSE_OPT_NONEG, exclude_cb },
+		{ OPTION_CALLBACK, 0, "exclude-from", &dir, N_("file"),
+			N_("read exclude patterns from <file>"),
+			0, exclude_from_cb },
 		OPT_BOOL('x', NULL, &ignored, N_("remove ignored files, too")),
 		OPT_BOOL('X', NULL, &ignored_only,
 				N_("remove only ignored files")),
 		OPT_END()
 	};
 
+	memset(&dir, 0, sizeof(dir));
 	git_config(git_clean_config, NULL);
 	if (force < 0)
 		force = 0;
@@ -913,7 +925,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
 			     0);
 
-	memset(&dir, 0, sizeof(dir));
 	if (ignored_only)
 		dir.flags |= DIR_SHOW_IGNORED;
 
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index d555bb6..c6bfdda 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -628,6 +628,66 @@ test_expect_success 'git clean -e' '
 	test_path_is_file known
 '
 
+test_expect_success 'git clean --exclude-from' '
+	rm -fr repo &&
+	mkdir repo &&
+	cd repo &&
+	git init &&
+	touch known 1 2 3 &&
+	git add known &&
+	cat >.git/clean-exclude <<-\EOF &&
+	1
+	2
+	EOF
+	git clean -f --exclude-from=.git/clean-exclude &&
+	test_path_is_file 1 &&
+	test_path_is_file 2 &&
+	test_path_is_missing 3 &&
+	test_path_is_file known
+'
+
+test_expect_success 'git clean -e --exclude-from' '
+	rm -fr repo &&
+	mkdir repo &&
+	cd repo &&
+	git init &&
+	touch known 1 2 3 &&
+	git add known &&
+	echo 1 >> .git/clean-exclude &&
+	git clean -f -e 2 --exclude-from=.git/clean-exclude &&
+	test_path_is_file 1 &&
+	test_path_is_file 2 &&
+	test_path_is_missing 3 &&
+	test_path_is_file known
+'
+
+test_expect_success 'git clean --exclude-from --exclude-from' '
+	rm -fr repo &&
+	mkdir repo &&
+	git init &&
+	touch known 1 2 3 &&
+	git add known &&
+	cat >.git/clean-exclude1 <<-\EOF &&
+	1
+	EOF
+	cat >.git/clean-exclude2 <<-\EOF &&
+	2
+	EOF
+	git clean -f --exclude-from=.git/clean-exclude1 --exclude-from=.git/clean-exclude2 &&
+	test_path_is_file 1 &&
+	test_path_is_file 2 &&
+	test_path_is_missing 3 &&
+	test_path_is_file known
+'
+
+test_expect_success 'git clean --exclude-from=BADFILE' '
+	rm -fr repo &&
+	mkdir repo &&
+	cd repo &&
+	git init &&
+	test_expect_code 128 git clean -f --exclude-from=.git/clean-exclude-not-there
+'
+
 test_expect_success SANITY 'git clean -d with an unreadable empty directory' '
 	mkdir foo &&
 	chmod a= foo &&
-- 
2.3.6
