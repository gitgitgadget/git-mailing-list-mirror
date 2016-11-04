Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AC142022D
	for <e@80x24.org>; Fri,  4 Nov 2016 20:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755918AbcKDUYP (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 16:24:15 -0400
Received: from chiark.greenend.org.uk ([212.13.197.229]:36625 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752944AbcKDUWX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 16:22:23 -0400
Received: from [172.18.45.5] (helo=zealot.relativity.greenend.org.uk)
        by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with esmtp
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c2jwH-0004WX-31; Fri, 04 Nov 2016 19:14:09 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
To:     git@vger.kernel.org
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Subject: [PATCH 5/5] check-ref-format: New --stdin option
Date:   Fri,  4 Nov 2016 19:13:58 +0000
Message-Id: <20161104191358.28812-6-ijackson@chiark.greenend.org.uk>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
---
 Documentation/git-check-ref-format.txt | 10 ++++++++--
 builtin/check-ref-format.c             | 34 +++++++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index e9a2657..5a213ce 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -10,8 +10,9 @@ SYNOPSIS
 [verse]
 'git check-ref-format' [--report-errors] [--normalize]
        [--[no-]allow-onelevel] [--refspec-pattern]
-       <refname>
-'git check-ref-format' [--report-errors] --branch <branchname-shorthand>
+       <refname> | --stdin
+'git check-ref-format' [--report-errors] --branch
+       <branchname-shorthand> | --stdin
 
 DESCRIPTION
 -----------
@@ -109,6 +110,11 @@ OPTIONS
 	If any ref does not check OK, print a message to stderr.
         (By default, git check-ref-format is silent.)
 
+--stdin::
+	Instead of checking on ref supplied on the command line,
+	read refs, one per line, from stdin.  The exit status is
+	0 if all the refs were OK.
+
 
 EXAMPLES
 --------
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 559d5c2..87f52fa 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -76,6 +76,7 @@ static int check_one_ref_format(const char *refname)
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
 	int i;
+	int use_stdin = 0;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_check_ref_format_usage);
@@ -93,6 +94,8 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 			check_branch = 1;
 		else if (!strcmp(argv[i], "--report-errors"))
 			report_errors = 1;
+		else if (!strcmp(argv[i], "--stdin"))
+			use_stdin = 1;
 		else
 			usage(builtin_check_ref_format_usage);
 	}
@@ -100,8 +103,33 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 	if (check_branch && (flags || normalize))
 		usage(builtin_check_ref_format_usage);
 
-	if (! (i == argc - 1))
-		usage(builtin_check_ref_format_usage);
+	if (!use_stdin) {
+		if (! (i == argc - 1))
+			usage(builtin_check_ref_format_usage);
+
+		return check_one_ref_format(argv[i]);
+	} else {
+		char buffer[2048];
+		int worst = 0;
 
-	return check_one_ref_format(argv[i]);
+		if (! (i == argc))
+			usage(builtin_check_ref_format_usage);
+
+		while (fgets(buffer, sizeof(buffer), stdin)) {
+			char *newline = strchr(buffer, '\n');
+			if (!newline) {
+				fprintf(stderr, "%s --stdin: missing final newline or line too long\n", *argv);
+				exit(127);
+			}
+			*newline = 0;
+			int got = check_one_ref_format(buffer);
+			if (got > worst)
+				worst = got;
+		}
+		if (!feof(stdin)) {
+			perror("reading from stdin");
+			exit(127);
+		}
+		return worst;
+	}
 }
-- 
2.10.1

