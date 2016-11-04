Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999EB2022D
	for <e@80x24.org>; Fri,  4 Nov 2016 19:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbcKDTot (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 15:44:49 -0400
Received: from chiark.greenend.org.uk ([212.13.197.229]:33597 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754109AbcKDTot (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 15:44:49 -0400
Received: from [172.18.45.5] (helo=zealot.relativity.greenend.org.uk)
        by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with esmtp
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c2jwG-0004WX-D8; Fri, 04 Nov 2016 19:14:08 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
To:     git@vger.kernel.org
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Subject: [PATCH 2/5] check-ref-format: Refactor to make --branch code more common
Date:   Fri,  4 Nov 2016 19:13:55 +0000
Message-Id: <20161104191358.28812-3-ijackson@chiark.greenend.org.uk>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are going to want to permit other options with --branch.

So, replace the special case with just an entry for --branch in the
parser for ordinary options, and check for option compatibility at the
end.

No overall functional change.

Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
---
 builtin/check-ref-format.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 4d56caa..f12c19c 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -49,13 +49,19 @@ static int check_ref_format_branch(const char *arg)
 }
 
 static int normalize = 0;
+static int check_branch = 0;
 static int flags = 0;
 
 static int check_one_ref_format(const char *refname)
 {
+	int got;
+
 	if (normalize)
 		refname = collapse_slashes(refname);
-	if (check_refname_format(refname, flags))
+	got = check_branch
+		? check_ref_format_branch(refname)
+		: check_refname_format(refname, flags);
+	if (got)
 		return 1;
 	if (normalize)
 		printf("%s\n", refname);
@@ -68,9 +74,6 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_check_ref_format_usage);
 
-	if (argc == 3 && !strcmp(argv[1], "--branch"))
-		return check_ref_format_branch(argv[2]);
-
 	for (i = 1; i < argc && argv[i][0] == '-'; i++) {
 		if (!strcmp(argv[i], "--normalize") || !strcmp(argv[i], "--print"))
 			normalize = 1;
@@ -80,9 +83,15 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 			flags &= ~REFNAME_ALLOW_ONELEVEL;
 		else if (!strcmp(argv[i], "--refspec-pattern"))
 			flags |= REFNAME_REFSPEC_PATTERN;
+		else if (!strcmp(argv[i], "--branch"))
+			check_branch = 1;
 		else
 			usage(builtin_check_ref_format_usage);
 	}
+
+	if (check_branch && (flags || normalize))
+		usage(builtin_check_ref_format_usage);
+
 	if (! (i == argc - 1))
 		usage(builtin_check_ref_format_usage);
 
-- 
2.10.1

