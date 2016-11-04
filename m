Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44B072022D
	for <e@80x24.org>; Fri,  4 Nov 2016 20:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756155AbcKDUYR (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 16:24:17 -0400
Received: from chiark.greenend.org.uk ([212.13.197.229]:36625 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754732AbcKDUWb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 16:22:31 -0400
Received: from [172.18.45.5] (helo=zealot.relativity.greenend.org.uk)
        by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with esmtp
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c2jwG-0004WX-Rm; Fri, 04 Nov 2016 19:14:08 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
To:     git@vger.kernel.org
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Subject: [PATCH 4/5] check-ref-format: New --report-errors option
Date:   Fri,  4 Nov 2016 19:13:57 +0000
Message-Id: <20161104191358.28812-5-ijackson@chiark.greenend.org.uk>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
---
 Documentation/git-check-ref-format.txt |  8 ++++++--
 builtin/check-ref-format.c             | 10 ++++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 8611a99..e9a2657 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -8,10 +8,10 @@ git-check-ref-format - Ensures that a reference name is well formed
 SYNOPSIS
 --------
 [verse]
-'git check-ref-format' [--normalize]
+'git check-ref-format' [--report-errors] [--normalize]
        [--[no-]allow-onelevel] [--refspec-pattern]
        <refname>
-'git check-ref-format' --branch <branchname-shorthand>
+'git check-ref-format' [--report-errors] --branch <branchname-shorthand>
 
 DESCRIPTION
 -----------
@@ -105,6 +105,10 @@ OPTIONS
 	with a status of 0.  (`--print` is a deprecated way to spell
 	`--normalize`.)
 
+--report-errors::
+	If any ref does not check OK, print a message to stderr.
+        (By default, git check-ref-format is silent.)
+
 
 EXAMPLES
 --------
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 020ebe8..559d5c2 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -9,7 +9,7 @@
 
 static const char builtin_check_ref_format_usage[] =
 "git check-ref-format [--normalize] [<options>] <refname>\n"
-"   or: git check-ref-format --branch <branchname-shorthand>";
+"   or: git check-ref-format [<options>] --branch <branchname-shorthand>";
 
 /*
  * Return a copy of refname but with leading slashes removed and runs
@@ -51,6 +51,7 @@ static int check_ref_format_branch(const char *arg)
 static int normalize = 0;
 static int check_branch = 0;
 static int flags = 0;
+static int report_errors = 0;
 
 static int check_one_ref_format(const char *refname)
 {
@@ -61,8 +62,11 @@ static int check_one_ref_format(const char *refname)
 	got = check_branch
 		? check_ref_format_branch(refname)
 		: check_refname_format(refname, flags);
-	if (got)
+	if (got) {
+		if (report_errors)
+			fprintf(stderr, "bad ref format: %s\n", refname);
 		return 1;
+	}
 	if (normalize) {
 		printf("%s\n", refname);
 		free((void*)refname);
@@ -87,6 +91,8 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 			flags |= REFNAME_REFSPEC_PATTERN;
 		else if (!strcmp(argv[i], "--branch"))
 			check_branch = 1;
+		else if (!strcmp(argv[i], "--report-errors"))
+			report_errors = 1;
 		else
 			usage(builtin_check_ref_format_usage);
 	}
-- 
2.10.1

