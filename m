Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96166C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 19:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbiCJTJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 14:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbiCJTJg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 14:09:36 -0500
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E6BEA77B
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 11:08:35 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4KDz9s11FWz5tlB;
        Thu, 10 Mar 2022 20:08:32 +0100 (CET)
Message-ID: <571c0796-66d4-e8c7-c5a5-2e7a28132aa9@kdbg.org>
Date:   Thu, 10 Mar 2022 20:08:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: Minor regression in 2.35 with reflog expire
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since daf1d8285eeb ("reflog expire: don't use
lookup_commit_reference_gently()", 2021-12-22) we see

$ git reflog expire --all
error: Could not read 0000000000000000000000000000000000000000

that was not there before.

The problem seem to be empty reflog files. I assume they can be created
when reflogs expire completely. I have a handful of them in repository
that was quiet for a long while.

To reproduce:

git init
mkdir -p .git/logs/refs/heads
touch .git/logs/refs/heads/foo
git reflog expire --all

The "scary" aspect of the regression is that it happens as part of git
gc and alarms users, see for example
https://stackoverflow.com/questions/71364717/git-gc-error-could-not-read-0000000000000000000000000000000000000000

-- Hannes
