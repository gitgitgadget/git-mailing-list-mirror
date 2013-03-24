From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 07/15] t4202: use test_config/test_unconfig to set/unset git config variables
Date: Sun, 24 Mar 2013 22:06:06 +0100
Message-ID: <f8332db5794d0f4accc7c4a0b4c0e5b106eda493.1364158574.git.ydroneaud@opteya.com>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:07:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJs8R-0007mr-AO
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab3CXVG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:06:58 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:52153 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161Ab3CXVG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:06:57 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 6096D940182;
	Sun, 24 Mar 2013 22:06:47 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2OL6jDC007291;
	Sun, 24 Mar 2013 22:06:45 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2OL6jse007290;
	Sun, 24 Mar 2013 22:06:45 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
References: <cover.1364158574.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218984>

Instead of using construct such as:
    test_when_finished "git config --unset <key>"
    git config <key> <value>
uses
    test_config <key> <value>
The latter takes care of removing <key> at the end of the test.

Additionally, instead of
     git config <key> ""
or
     git config --unset <key>
uses
     test_unconfig <key>
The latter doesn't failed if <key> is not defined.

Tests are modified to assume correct (default) configuration at entry,
and to reset the modified configuration variables at the end.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t4202-log.sh | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index fa686b8..9243a97 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -419,8 +419,6 @@ test_expect_success 'log --graph with merge' '
 '
 
 test_expect_success 'log.decorate configuration' '
-	test_might_fail git config --unset-all log.decorate &&
-
 	git log --oneline >expect.none &&
 	git log --oneline --decorate >expect.short &&
 	git log --oneline --decorate=full >expect.full &&
@@ -429,8 +427,7 @@ test_expect_success 'log.decorate configuration' '
 	git log --oneline >actual &&
 	test_cmp expect.short actual &&
 
-	git config --unset-all log.decorate &&
-	git config log.decorate true &&
+	test_config log.decorate true &&
 	git log --oneline >actual &&
 	test_cmp expect.short actual &&
 	git log --oneline --decorate=full >actual &&
@@ -438,8 +435,7 @@ test_expect_success 'log.decorate configuration' '
 	git log --oneline --decorate=no >actual &&
 	test_cmp expect.none actual &&
 
-	git config --unset-all log.decorate &&
-	git config log.decorate no &&
+	test_config log.decorate no &&
 	git log --oneline >actual &&
 	test_cmp expect.none actual &&
 	git log --oneline --decorate >actual &&
@@ -447,8 +443,7 @@ test_expect_success 'log.decorate configuration' '
 	git log --oneline --decorate=full >actual &&
 	test_cmp expect.full actual &&
 
-	git config --unset-all log.decorate &&
-	git config log.decorate 1 &&
+	test_config log.decorate 1 &&
 	git log --oneline >actual &&
 	test_cmp expect.short actual &&
 	git log --oneline --decorate=full >actual &&
@@ -456,8 +451,7 @@ test_expect_success 'log.decorate configuration' '
 	git log --oneline --decorate=no >actual &&
 	test_cmp expect.none actual &&
 
-	git config --unset-all log.decorate &&
-	git config log.decorate short &&
+	test_config log.decorate short &&
 	git log --oneline >actual &&
 	test_cmp expect.short actual &&
 	git log --oneline --no-decorate >actual &&
@@ -465,8 +459,7 @@ test_expect_success 'log.decorate configuration' '
 	git log --oneline --decorate=full >actual &&
 	test_cmp expect.full actual &&
 
-	git config --unset-all log.decorate &&
-	git config log.decorate full &&
+	test_config log.decorate full &&
 	git log --oneline >actual &&
 	test_cmp expect.full actual &&
 	git log --oneline --no-decorate >actual &&
@@ -474,16 +467,15 @@ test_expect_success 'log.decorate configuration' '
 	git log --oneline --decorate >actual &&
 	test_cmp expect.short actual
 
-	git config --unset-all log.decorate &&
+	test_unconfig log.decorate &&
 	git log --pretty=raw >expect.raw &&
-	git config log.decorate full &&
+	test_config log.decorate full &&
 	git log --pretty=raw >actual &&
 	test_cmp expect.raw actual
 
 '
 
 test_expect_success 'reflog is expected format' '
-	test_might_fail git config --remove-section log &&
 	git log -g --abbrev-commit --pretty=oneline >expect &&
 	git reflog >actual &&
 	test_cmp expect actual
@@ -496,10 +488,6 @@ test_expect_success 'whatchanged is expected format' '
 '
 
 test_expect_success 'log.abbrevCommit configuration' '
-	test_when_finished "git config --unset log.abbrevCommit" &&
-
-	test_might_fail git config --unset log.abbrevCommit &&
-
 	git log --abbrev-commit >expect.log.abbrev &&
 	git log --no-abbrev-commit >expect.log.full &&
 	git log --pretty=raw >expect.log.raw &&
@@ -508,7 +496,7 @@ test_expect_success 'log.abbrevCommit configuration' '
 	git whatchanged --abbrev-commit >expect.whatchanged.abbrev &&
 	git whatchanged --no-abbrev-commit >expect.whatchanged.full &&
 
-	git config log.abbrevCommit true &&
+	test_config log.abbrevCommit true &&
 
 	git log >actual &&
 	test_cmp expect.log.abbrev actual &&
-- 
1.7.11.7
