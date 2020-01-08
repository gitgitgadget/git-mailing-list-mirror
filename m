Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E14CC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 21:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255BA20720
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 21:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgAHVoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:44:02 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:50911 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgAHVoC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 16:44:02 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 5EAC43C04C0;
        Wed,  8 Jan 2020 22:43:59 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id atCaoC6pYIvF; Wed,  8 Jan 2020 22:43:53 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 543813C00B7;
        Wed,  8 Jan 2020 22:43:53 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 8 Jan 2020
 22:43:52 +0100
Date:   Wed, 8 Jan 2020 22:43:49 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     <gitster@pobox.com>, <peff@peff.net>, <avarab@gmail.com>,
        <git@vger.kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Unreliable 'git rebase --onto'
Message-ID: <20200108214349.GA17624@lxhi-065.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.72.93.66]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git community,

Below is a simple reproduction scenario for what looks to be a bug (?)
in 'git rebase --onto' (v2.25.0-rc1-19-g042ed3e048af).

I would appreciate your confirmation of the misbehavior.
If the behavior is correct/expected, I would appreciate some feedback
how to avoid it in future, since it occurs with the default parameters.

1. git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

2. ### Cherry pick an upstream commit, to contrast the results with
   'git rebase --onto':
   $ git checkout -b v4.18-cherry-pick v4.18
   $ git cherry-pick 463fa44eec2fef50
   Auto-merging drivers/input/touchscreen/atmel_mxt_ts.c
   warning: inexact rename detection was skipped due to too many files.
   warning: you may want to set your merge.renamelimit variable to at least 7216 and retry the command.
   [v4.18-cherry-pick bd142b45bf3a] Input: atmel_mxt_ts - disable IRQ across suspend
    Author: Evan Green <evgreen@chromium.org>
    Date: Wed Oct 2 14:00:21 2019 -0700
    1 file changed, 4 insertions(+)

3. ### In spite of the warning, the result matches the original commit:
   $ vimdiff <(git show 463fa44eec2fef50) <(git show v4.18-cherry-pick)

4. ### Now, backport the same commit via 'git rebase --onto'
   $ git rebase --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
   First, rewinding head to replay your work on top of it...
   Applying: Input: atmel_mxt_ts - disable IRQ across suspend

5. ### The result is different:
   $ git branch v4.18-rebase-onto
   $ git diff v4.18-cherry-pick v4.18-rebase-onto

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index b45958e89cc5..2345b587662b 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3139,8 +3139,6 @@ static int __maybe_unused mxt_suspend(struct device *dev)
 
 	mutex_unlock(&input_dev->mutex);
 
-	disable_irq(data->irq);
-
 	return 0;
 }
 
@@ -3162,6 +3160,8 @@ static int __maybe_unused mxt_resume(struct device *dev)
 
 	mutex_unlock(&input_dev->mutex);
 
+	disable_irq(data->irq);
+
 	return 0;
 }


In a nutshell, purely from user's perspective:
 - I get a warning from 'git cherry pick', with perfect results
 - I get no warning from 'git rebase --onto', with wrong results

Does git still behave expectedly? TIA!

-- 
Best Regards,
Eugeniu
