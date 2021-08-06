Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4679AC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 13:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17726610FB
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 13:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbhHFNRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 09:17:53 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:6727 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhHFNRx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 09:17:53 -0400
Received: from [94.228.207.202] (helo=[192.168.2.206])
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1mBzip-0007SI-H2; Fri, 06 Aug 2021 15:17:11 +0200
Subject: Re: [BUG] Amending a shallow clone -> orphan branch
To:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
References: <64760969-1ead-2bfb-6f98-1161d385c0ca@syntevo.com>
 <b3083a15-f2da-0eae-b07b-8a641c613906@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <20d768d5-2fe2-5540-b7e7-2174db7c80cf@syntevo.com>
Date:   Fri, 6 Aug 2021 16:16:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b3083a15-f2da-0eae-b07b-8a641c613906@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A bit more details:

$ git clone --depth 1 --single-branch --branch master 
https://github.com/git/git
$ cd git

Here, a shallow clone is made with just 1 commit.

$ git show -s --pretty=%P HEAD

Outputs nothing; that's already a small bug.
Surely the commit has parents!

$ git cat-file -p HEAD | grep parent

OK, that's better, finally the true parents are shown.

$ >1.txt
$ git add 1.txt
$ git commit --amend

Here, the top (and only in our clone) commit is amended.

$ git cat-file -p HEAD | grep parent

Nothing! This is the bug I'm reporting: amending the commit orphaned it.

To give a bit more background: I have a heavy-weight repo which I was 
testing on different machines. Since it's heavy, I decided to shallow 
clone just 1 commit. Upon testing on some machine, I found a small bug 
and amended a fix. Then I force-pushed. I expected the branch to be amended.

Instead, what I got was an orphaned branch, disconnected from all repo's 
branches, containing all files at once! Clearly not the best thing.
