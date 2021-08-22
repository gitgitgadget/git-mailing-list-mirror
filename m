Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D49C4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 09:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A1F61242
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 09:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhHVJY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 05:24:56 -0400
Received: from mout02.posteo.de ([185.67.36.66]:57063 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhHVJY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 05:24:56 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 819CC240105
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 11:24:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1629624253; bh=FTHTI0niNH3QVVKlHq5Jiu+d0jDoW3J7KhBT9uRs/KM=;
        h=To:From:Subject:Date:From;
        b=lEuaJVyok0J6nYTFhgbfZKuV01k8fXS1Q5POrBzgRfYnpedT7ghRkTXC7MVuuFNZu
         82skJc8BSVXdxstwOw4jgVhfpp2kikUhYQo5XpHqz5Q2ueX6hruTYb162XmDrkCmCJ
         VhKDslQGpBnSvhqCGt6wa2Yx2VEL7oNeBYiXDv6uRN2zOTiLQnPwi4S3+/4rRPpnS1
         YNsn2E5lc7AcP3BMv8NbmmENMTwaw592Wi98rmW6eck0biO9fEC4rc8xu1f+PYVLHq
         KdvLbHuSaN84/j7ZVB60www/osxDJ5Y9Q8VedVb0q1MPK65oehtg+PZLpZyRMrUrzQ
         54kNTIrIhYRzw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Gsqgx0C1Cz6tmQ
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 11:24:12 +0200 (CEST)
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Marvin_H=c3=a4user?= <mhaeuser@posteo.de>
Subject: [BUG] send-email propagates "In-Reply-To"
Message-ID: <4db7759c-2123-533b-9f89-954c07f5832a@posteo.de>
Date:   Sun, 22 Aug 2021 09:24:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good day everyone,

"git send-email" propagates the "In-Reply-To" header of the last prior 
patch with such defined to subsequent patches which do not define such 
explicitly. I suspect this behaviour is incorrect as I could not find 
any documentation on this. I'm sorry if this behaviour is actually 
expected, and would be happy if someone could point me to the 
appropriate documentation. This was reproduced on Fedora 34 with git 
2.33.0 and "--no-thread".

Steps to reproduce:
1. Create two patches, one of which has an "In-Reply-To" field 
("patch-in-reply.patch") and one of which does not 
("patch-no-in-reply.patch").
2. Run "git send-email --dry-run --no-thread patch-in-reply.patch 
patch-no-in-reply.patch"
2.1. Observe the emission of an "In-Reply-To" header for 
"patch-no-in-reply.patch" with no such header.
3. Run "git send-email --dry-run --no-thread patch-no-in-reply.patch 
patch-in-reply.patch"
3.1. Observe the omission of an "In-Reply-To" header for 
"patch-no-in-reply.patch" with no such header.

Expected behaviour:
With no threading and no other sorts of explicitly defining the 
"In-Reply-To" header, I expect to always observe the behaviour of 3.1., 
and to not observe the behaviour of 2.1.

The "issue" is "in_reply_to" is overwritten here [1], which is the main 
loop worker to process all files passed to send-email [2], but it is not 
restored for subsequent patches. Unless required otherwise (e.g. 
send-email threading), it should be restored to its default value for 
each patch I believe.

I wrote a quick patch to adjust 2.1. to 3.1. [3]. I have no time right 
now to review the submission guidelines (and thus did not submit the 
patch "properly" yet), but I will try to get to that tonight or some 
time next week. If in the mean time you could provide any feedback on 
the behaviour or the patch, so that I can get things right the first 
time, that would be great!

Thank you for your time, I am looking forward to your feedback.

Best regards,
Marvin


[1] 
https://github.com/git/git/blob/225bc32a989d7a22fa6addafd4ce7dcd04675dbf/git-send-email.perl#L1800

[2] 
https://github.com/git/git/blob/225bc32a989d7a22fa6addafd4ce7dcd04675dbf/git-send-email.perl#L1952-L1956

[3] 
https://github.com/mhaeuser/git/commit/d87f49a02c0efa3084ae6c70bbf583b865744e43
