Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17509C433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 12:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEEC564DD6
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 12:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhA3MxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 07:53:24 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:11463 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhA3MxX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 07:53:23 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4DSYyc74brz5tlB;
        Sat, 30 Jan 2021 13:52:40 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6D0662137;
        Sat, 30 Jan 2021 13:52:40 +0100 (CET)
Subject: Re: [PATCH] pager: exit without error on SIGPIPE
From:   Johannes Sixt <j6t@kdbg.org>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Vincent Lefevre <vincent@vinc17.net>,
        Git Mailing List <git@vger.kernel.org>
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
 <a3e738e2-695e-cf01-5d01-50b6fea272ec@kdbg.org>
Message-ID: <869ba84b-a008-6061-be57-50ab678a154e@kdbg.org>
Date:   Sat, 30 Jan 2021 13:52:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <a3e738e2-695e-cf01-5d01-50b6fea272ec@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.01.21 um 09:29 schrieb Johannes Sixt:
> Am 30.01.21 um 00:48 schrieb Denton Liu:
>> +++ b/t/helper/test-pager.c
>> @@ -0,0 +1,12 @@
>> +#include "test-tool.h"
>> +#include "cache.h"
>> +
>> +int cmd__pager(int argc, const char **argv)
>> +{
>> +	if (argc > 1)
>> +		usage("\ttest-tool pager");
>> +
>> +	setup_pager();
>> +	for (;;)
>> +		puts("y");
>> +}
> 
> My gut feeling tells that this will end in an infinite loop on Windows.
> There are no signals on Windows that would kill the upstream of a pipe.
> This call site will only notice that the downstream of the pipe was
> closed, when it checks for write errors.
> 
> Let me test it.

The test case is protected by a TTY prerequisite; that is not satisfied
on Windows, and the test is skipped. No harm done so far.

But when I run `test-tool pager` manually and quit out of the pager, the
tool does spin in the endless loop. The following fixup helps.


diff --git a/t/helper/test-pager.c b/t/helper/test-pager.c
index feb68b8643..5f1982411f 100644
--- a/t/helper/test-pager.c
+++ b/t/helper/test-pager.c
@@ -7,6 +7,8 @@ int cmd__pager(int argc, const char **argv)
 		usage("\ttest-tool pager");
 
 	setup_pager();
-	for (;;)
-		puts("y");
+	while (write_in_full(1, "y\n", 2) > 0)
+		;
+
+	return 0;
 }
-- 
2.30.0.119.g680bcb97f5
