Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725DFC433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 19:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B9664E43
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 19:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhBSTN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 14:13:27 -0500
Received: from siwi.pair.com ([209.68.5.199]:15933 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhBSTNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 14:13:25 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BC0F93F40F3;
        Fri, 19 Feb 2021 14:12:43 -0500 (EST)
Received: from MININT-MG8E6GJ.fareast.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8ECFE3F40F1;
        Fri, 19 Feb 2021 14:12:43 -0500 (EST)
Subject: Re: [PATCH] read-cache: make the index write buffer size 128K
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@ntdev.microsoft.com>
References: <pull.877.git.1613616506949.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f52df30b-4ab0-fd6f-17f8-70daed81df39@jeffhostetler.com>
Date:   Fri, 19 Feb 2021 14:12:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.877.git.1613616506949.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/17/21 9:48 PM, Neeraj K. Singh via GitGitGadget wrote:
> From: Neeraj Singh <neerajsi@ntdev.microsoft.com>
> 
> Writing an index 8K at a time invokes the OS filesystem and caching code
> very frequently, introducing noticeable overhead while writing large
> indexes. When experimenting with different write buffer sizes on Windows
> writing the Windows OS repo index (260MB), most of the benefit came by
> bumping the index write buffer size to 64K. I picked 128K to ensure that
> we're past the knee of the curve.
> 
> With this change, the time under do_write_index for an index with 3M
> files goes from ~1.02s to ~0.72s.

[...]

>   
> -#define WRITE_BUFFER_SIZE 8192
> +#define WRITE_BUFFER_SIZE (128 * 1024)
>   static unsigned char write_buffer[WRITE_BUFFER_SIZE];
>   static unsigned long write_buffer_len;

[...]

Very nice.

I can confirm that this gives nice gains on Windows.  (I'm using
the Office repo which has a 188MB index file (2.1M files at HEAD).
Running "git status" shows a gain of about 200ms.

We get a smaller gain on Mac of about 50ms (again, using the Office
repo).

So, you may add my sign-off or ACK to this.
     Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>



FWIW, You might take a look at `t/perf/p0007-write-cache.sh`
Update it as follows:

```
diff --git a/t/perf/p0007-write-cache.sh b/t/perf/p0007-write-cache.sh
index 09595264f0..337280ff1c 100755
--- a/t/perf/p0007-write-cache.sh
+++ b/t/perf/p0007-write-cache.sh
@@ -4,7 +4,8 @@ test_description="Tests performance of writing the index"

  . ./perf-lib.sh

-test_perf_default_repo
+test_perf_large_repo

  test_expect_success "setup repo" '
         if git rev-parse --verify refs/heads/p0006-ballast^{commit}
```


Then you can run it like this:

     $ cd t/perf
     $ GIT_PERF_LARGE_REPO=/path/to/your/enlistment ./p0007-write-cache

Then you can run it with the small and then with the large buffer and
get times for essentially just the index write in isolation.

Hope this helps,
Jeff
