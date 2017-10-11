Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 729661FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 17:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757459AbdJKRYB (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 13:24:01 -0400
Received: from ikke.info ([178.21.113.177]:34980 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757389AbdJKRYA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 13:24:00 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id 013064403A1; Wed, 11 Oct 2017 19:23:59 +0200 (CEST)
Received: from epsilon.home (unknown [10.8.0.22])
        by vps892.directvps.nl (Postfix) with ESMTP id 7AD46440393;
        Wed, 11 Oct 2017 19:23:58 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Kevin Daudt <me@ikke.info>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] column: show auto columns when pager is active
Date:   Wed, 11 Oct 2017 19:23:10 +0200
Message-Id: <20171011172310.2932-1-me@ikke.info>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171009214543.12986-1-me@ikke.info>
References: <20171009214543.12986-1-me@ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When columns are set to automatic for git tag and the output is
paginated by git, the output is a single column instead of multiple
columns.

Standard behaviour in git is to honor auto values when the pager is
active, which happens for example with commands like git log showing
colors when being paged.

Since ff1e72483 (tag: change default of `pager.tag` to "on",
2017-08-02), the pager has been enabled by default, exposing this
problem to more people.

finalize_colopts in column.c only checks whether the output is a TTY to
determine if columns should be enabled with columns set to auto. Also check
if the pager is active.

Helped-by: Rafael Ascensão <rafa.almas@gmail.com>
Signed-off-by: Kevin Daudt <me@ikke.info>
---
 column.c         |  3 ++-
 t/t7006-pager.sh | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/column.c b/column.c
index ff7bdab1a..ded50337f 100644
--- a/column.c
+++ b/column.c
@@ -5,6 +5,7 @@
 #include "parse-options.h"
 #include "run-command.h"
 #include "utf8.h"
+#include "pager.c"
 
 #define XY2LINEAR(d, x, y) (COL_LAYOUT((d)->colopts) == COL_COLUMN ? \
 			    (x) * (d)->rows + (y) : \
@@ -224,7 +225,7 @@ int finalize_colopts(unsigned int *colopts, int stdout_is_tty)
 		if (stdout_is_tty < 0)
 			stdout_is_tty = isatty(1);
 		*colopts &= ~COL_ENABLE_MASK;
-		if (stdout_is_tty)
+		if (stdout_is_tty || pager_in_use())
 			*colopts |= COL_ENABLED;
 	}
 	return 0;
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index f0f1abd1c..44c2ca5d3 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -570,4 +570,18 @@ test_expect_success 'command with underscores does not complain' '
 	test_cmp expect actual
 '
 
+test_expect_success TTY 'git tag with auto-columns ' '
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	test_commit four &&
+	test_commit five &&
+	cat >expected <<\EOF &&
+initial  one      two      three    four     five
+EOF
+	test_terminal env PAGER="cat >actual.tag" COLUMNS=80 \
+		git -p -c column.ui=auto tag --sort=authordate &&
+	test_cmp expected actual.tag
+'
+
 test_done
-- 
2.14.2

