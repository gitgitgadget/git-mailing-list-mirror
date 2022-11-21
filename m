Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB47C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 17:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKUR6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 12:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKUR6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 12:58:16 -0500
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5A5DFEF
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 09:58:15 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4NGFVY3d80z5tlG;
        Mon, 21 Nov 2022 18:58:13 +0100 (CET)
Message-ID: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
Date:   Mon, 21 Nov 2022 18:58:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t3920: don't ignore errors of more than one command with `||
 true`
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is customary to write `A || true` to ignore a potential error exit of
command A. But when we have a sequence `A && B && C || true && D`, then
a failure of any of A, B, or C skips to D right away. This is not
intended here. Turn the command whose failure is to be ignored into a
compound command to ensure it is the only one that is allowed to fail.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3920-crlf-messages.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index 4c661d4d54..a58522c163 100755
--- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -12,7 +12,7 @@ create_crlf_ref () {
 	cat >.crlf-orig-$branch.txt &&
 	cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
 	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//' | tr -d '\n' >.crlf-subject-$branch.txt &&
-	grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true &&
+	{ grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true; } &&
 	LIB_CRLF_BRANCHES="${LIB_CRLF_BRANCHES} ${branch}" &&
 	test_tick &&
 	hash=$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch}.txt) &&
-- 
2.36.0.137.geb37740430
