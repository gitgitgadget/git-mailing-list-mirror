Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C376B1FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 19:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933713AbcIETAv (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 15:00:51 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:13731 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932400AbcIETAv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 15:00:51 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3sSfFX5nmHz5tlC
        for <git@vger.kernel.org>; Mon,  5 Sep 2016 21:00:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 19E02523B
        for <git@vger.kernel.org>; Mon,  5 Sep 2016 21:00:48 +0200 (CEST)
To:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t9903: fix broken && chain
Message-ID: <61de943c-df93-58e9-ca48-c469a71a1d43@kdbg.org>
Date:   Mon, 5 Sep 2016 21:00:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We might wonder why our && chain check does not catch this case:
The && chain check uses a strange exit code with the expectation that
the second or later part of a broken && chain would not exit with this
particular code.

This expectation does not work in this case because __git_ps1, being
the first command in the second part of the broken && chain, records
the current exit code, does its work, and finally returns to the caller
with the recorded exit code. This fools our && chain check.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
  t/t9903-bash-prompt.sh | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 0db4469..97c9b32 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -177,7 +177,7 @@ test_expect_success 'prompt - interactive rebase' '
  	git checkout b1 &&
  	test_when_finished "git checkout master" &&
  	git rebase -i HEAD^ &&
-	test_when_finished "git rebase --abort"
+	test_when_finished "git rebase --abort" &&
  	__git_ps1 >"$actual" &&
  	test_cmp expected "$actual"
  '
-- 
2.10.0.85.gea34e30
