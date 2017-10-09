Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C46C20372
	for <e@80x24.org>; Mon,  9 Oct 2017 21:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754217AbdJIVqH (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 17:46:07 -0400
Received: from ikke.info ([178.21.113.177]:54762 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbdJIVqG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 17:46:06 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id E92B044039C; Mon,  9 Oct 2017 23:46:04 +0200 (CEST)
Received: from epsilon.home (unknown [10.8.0.22])
        by vps892.directvps.nl (Postfix) with ESMTP id 698F3440393;
        Mon,  9 Oct 2017 23:46:04 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Kevin Daudt <me@ikke.info>
Subject: [RFC] column: show auto columns when pager is active
Date:   Mon,  9 Oct 2017 23:45:43 +0200
Message-Id: <20171009214543.12986-1-me@ikke.info>
X-Mailer: git-send-email 2.14.2
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
determine if columns should be enabled with columns set to autol. Also check
if the pager is active.

Helped-by: Rafael Ascensão <rafa.almas@gmail.com>
Signed-off-by: Kevin Daudt <me@ikke.info>
---
This came to light when someone wondered on irc why
column.tag=[auto|always] did not work on Mac OS. Testing it myself, I
found it to work with always, but not with auto.

I could not get the test to work yet, because somehow it's not giving
any output, so feedback regarding that is welcome.


 column.c          |  3 ++-
 t/t9002-column.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

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
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index 89983527b..9441145bf 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -2,6 +2,7 @@
 
 test_description='git column'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success 'setup' '
 	cat >lista <<\EOF
@@ -177,4 +178,16 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success TTY '20 columns, mode auto, pager' '
+	cat >expected <<\EOF &&
+one    seven
+two    eight
+three  nine
+four   ten
+five   eleven
+six
+EOF
+	test_terminal env PAGER="cat|cat" git column --mode=auto <lista >actual &&
+	test_cmp expected actual
+'
 test_done
-- 
2.14.2

