Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E33A20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 13:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeLNNF5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 08:05:57 -0500
Received: from mail.javad.com ([54.86.164.124]:53914 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729709AbeLNNF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 08:05:56 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 10AC43FC8F;
        Fri, 14 Dec 2018 12:56:20 +0000 (UTC)
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=sorganov@gmail.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <sorganov@gmail.com>)
        id 1gXn0s-0003A2-Il; Fri, 14 Dec 2018 15:56:18 +0300
Message-Id: <47bde24fd077a7f2a5a6db4c9bb9411c7255b89a.1544764226.git.sorganov@gmail.com>
In-Reply-To: <cover.1544762343.git.sorganov@gmail.com>
References: <cover.1544762343.git.sorganov@gmail.com>
From:   Sergey Organov <sorganov@gmail.com>
Date:   Fri, 14 Dec 2018 07:53:51 +0300
Subject: [PATCH v2 1/4] t3510: stop using '-m 1' to force failure mid-sequence
 of cherry-picks
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are going to allow 'git cherry-pick -m 1' for non-merge commits, so
this method to force failure will stop to work.

Use '-m 4' instead as it's very unlikely we will ever have such an
octopus in this test setup.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t3510-cherry-pick-sequence.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index c84eeef..941d502 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -61,7 +61,11 @@ test_expect_success 'cherry-pick mid-cherry-pick-sequence' '
 
 test_expect_success 'cherry-pick persists opts correctly' '
 	pristine_detach initial &&
-	test_expect_code 128 git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours initial..anotherpick &&
+	# to make sure that the session to cherry-pick a sequence
+	# gets interrupted, use a high-enough number that is larger
+	# than the number of parents of any commit we have created
+	mainline=4 &&
+	test_expect_code 128 git cherry-pick -s -m $mainline --strategy=recursive -X patience -X ours initial..anotherpick &&
 	test_path_is_dir .git/sequencer &&
 	test_path_is_file .git/sequencer/head &&
 	test_path_is_file .git/sequencer/todo &&
@@ -69,7 +73,7 @@ test_expect_success 'cherry-pick persists opts correctly' '
 	echo "true" >expect &&
 	git config --file=.git/sequencer/opts --get-all options.signoff >actual &&
 	test_cmp expect actual &&
-	echo "1" >expect &&
+	echo "$mainline" >expect &&
 	git config --file=.git/sequencer/opts --get-all options.mainline >actual &&
 	test_cmp expect actual &&
 	echo "recursive" >expect &&
-- 
2.10.0.1.g57b01a3

