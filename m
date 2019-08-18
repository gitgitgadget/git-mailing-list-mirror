Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FFD71F4BB
	for <e@80x24.org>; Sun, 18 Aug 2019 10:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfHRKDC (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 06:03:02 -0400
Received: from smtp01.domein-it.com ([92.48.232.141]:43171 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHRKDB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 06:03:01 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id 58BC1807B72D; Sun, 18 Aug 2019 11:54:33 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id BFAD8807B723;
        Sun, 18 Aug 2019 11:54:28 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:58670 helo=ben.local)
        by ferret.domein-it.nl with esmtpa (Exim 4.92)
        (envelope-from <ben@wijen.net>)
        id 1hzHtK-0003zc-6O; Sun, 18 Aug 2019 11:54:26 +0200
From:   Ben Wijen <ben@wijen.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Ben Wijen <ben@wijen.net>
Subject: [PATCH 1/2] t3420: never change upstream branch
Date:   Sun, 18 Aug 2019 11:53:48 +0200
Message-Id: <20190818095349.3218-2-ben@wijen.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190818095349.3218-1-ben@wijen.net>
References: <20190818095349.3218-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1hzHtK-0003zc-6O
X-Domein-IT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using `git rebase --autostash <upstream> <branch>` and
the workarea is dirty, the active branch is incorrectly reset
to the rebase <upstream> branch.

This test will check for such behavior.

Signed-off-by: Ben Wijen <ben@wijen.net>
---
 t/t3420-rebase-autostash.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index b8f4d03467..867e4e0b17 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -306,4 +306,13 @@ test_expect_success 'branch is left alone when possible' '
 	test unchanged-branch = "$(git rev-parse --abbrev-ref HEAD)"
 '
 
+test_expect_success 'never change upstream branch' '
+	test_when_finished "git reset --hard && git branch -D upstream" &&
+	git checkout -b upstream unrelated-onto-branch &&
+	echo changed >file0 &&
+	git add file0 &&
+	git rebase --autostash upstream feature-branch &&
+	test $(git rev-parse upstream) = $(git rev-parse unrelated-onto-branch)
+'
+
 test_done
-- 
2.22.0

