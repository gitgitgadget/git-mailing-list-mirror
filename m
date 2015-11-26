From: James <rouzier@gmail.com>
Subject: [PATCH] clean: new option --exclude-from
Date: Thu, 26 Nov 2015 09:44:25 -0500
Message-ID: <1448549065-16337-1-git-send-email-rouzier@gmail.com>
Cc: James Rouzier <rouzier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 15:44:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1xmw-00005X-N4
	for gcvg-git-2@plane.gmane.org; Thu, 26 Nov 2015 15:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbbKZOoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2015 09:44:46 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35870 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbbKZOoo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2015 09:44:44 -0500
Received: by qgcc31 with SMTP id c31so55122309qgc.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2015 06:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=joSa+omJt+lzf7ucYCGC90D/KBFMEGbAFN6hTU7WAfk=;
        b=isP3pwcWF2nvkBzj/f6Mo2essrB294+WEYtBdYUu1kq2d+MgohQCbRZe3kNfksoH/E
         b8onsDGG+9yHVJK2OEBYKfOIWbIgwSa4MhUu9Ipw/PiAqlO/Mzem404PH59IyxXBjiIF
         V8JmyyA4qRLY+CMkHKMFD0i4LK80/m4kF3VGsgetMYil6MNbplWv9vo2PZAM1o35Bwjm
         Du/UUJLcu2PAAT84JkfuZylWCcjTHlSPpCzp5QrA5+5ilNRf69+nCaySRajG9VjXXqRb
         UW4SQQc0qUTa3MMeMqQV+qPcE6ubOge5x+f6lQRQT/6qkwkqVgR7vTumDdofSoFr4Xtt
         cuXg==
X-Received: by 10.140.129.198 with SMTP id 189mr49966776qhb.10.1448549083603;
        Thu, 26 Nov 2015 06:44:43 -0800 (PST)
Received: from centos6-oc.jr.inverse.ca (cable-192.222.178.154.electronicbox.net. [192.222.178.154])
        by smtp.gmail.com with ESMTPSA id x83sm7149842qka.14.2015.11.26.06.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Nov 2015 06:44:42 -0800 (PST)
X-Mailer: git-send-email 2.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281762>

From: James Rouzier <rouzier@gmail.com>

Specify a file to read for exclude patterns.
---
 Documentation/git-clean.txt |  5 ++++-
 builtin/clean.c             | 15 ++++++++++++++-
 t/t7300-clean.sh            | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 641681f..ccd0aa4 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
+'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [--exclude-from <file>] [-x | -X] [--] <path>...
 
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
index d7acb94..e4995a3 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -875,6 +875,16 @@ static void interactive_main_loop(void)
 	}
 }
 
+static int option_parse_exclude_from(const struct option *opt,
+				     const char *arg, int unset)
+{
+	struct dir_struct *dir = opt->value;
+
+	add_excludes_from_file(dir, arg);
+
+	return 0;
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i, res;
@@ -898,11 +908,15 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				N_("remove whole directories")),
 		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, N_("pattern"),
 		  N_("add <pattern> to ignore rules"), PARSE_OPT_NONEG, exclude_cb },
+		{ OPTION_CALLBACK, 0, "exclude-from", &dir, N_("file"),
+			N_("exclude patterns are read from <file>"),
+			0, option_parse_exclude_from },
 		OPT_BOOL('x', NULL, &ignored, N_("remove ignored files, too")),
 		OPT_BOOL('X', NULL, &ignored_only,
 				N_("remove only ignored files")),
 		OPT_END()
 	};
+	memset(&dir, 0, sizeof(dir));
 
 	git_config(git_clean_config, NULL);
 	if (force < 0)
@@ -913,7 +927,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
 			     0);
 
-	memset(&dir, 0, sizeof(dir));
 	if (ignored_only)
 		dir.flags |= DIR_SHOW_IGNORED;
 
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 86ceb38..9b648b9 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -630,6 +630,41 @@ test_expect_success 'git clean -e' '
 	)
 '
 
+test_expect_success 'git clean --exclude-from' '
+	rm -fr repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+		touch known 1 2 3 &&
+		git add known &&
+		echo 1 >> .git/clean-exclude &&
+		echo 2 >> .git/clean-exclude &&
+		git clean -f --exclude-from=.git/clean-exclude &&
+		test -e 1 &&
+		test -e 2 &&
+		! (test -e 3) &&
+		test -e known
+	)
+'
+
+test_expect_success 'git clean -e --exclude-from' '
+	rm -fr repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+		touch known 1 2 3 &&
+		git add known &&
+		echo 1 >> .git/clean-exclude &&
+		git clean -f -e 2 --exclude-from=.git/clean-exclude &&
+		test -e 1 &&
+		test -e 2 &&
+		! (test -e 3) &&
+		test -e known
+	)
+'
+
 test_expect_success SANITY 'git clean -d with an unreadable empty directory' '
 	mkdir foo &&
 	chmod a= foo &&
-- 
2.3.6
