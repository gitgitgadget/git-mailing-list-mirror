Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457E9C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AA9B64DDA
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbhCDAXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241105AbhCCNJN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 08:09:13 -0500
X-Greylist: delayed 1643 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Mar 2021 05:08:29 PST
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84a3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50E9C06178C
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 05:08:29 -0800 (PST)
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lHQoJ-0001fi-R9; Wed, 03 Mar 2021 13:41:03 +0100
Subject: Re: Can I convince the diff algorithm to behave better?
To:     Tom Ritter <tom@ritter.vg>, git@vger.kernel.org
References: <CA+cU71=FfReSG411Feo=vmkw4MdK4KDgokP1jH6uwOkC_0AbYA@mail.gmail.com>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <10c330f1-b3ae-38ab-1a8b-23c0b46f1557@virtuell-zuhause.de>
Date:   Wed, 3 Mar 2021 13:41:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CA+cU71=FfReSG411Feo=vmkw4MdK4KDgokP1jH6uwOkC_0AbYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1614776909;de4d0547;
X-HE-SMSGID: 1lHQoJ-0001fi-R9
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/3/2021 3:03 AM, Tom Ritter wrote:

Hi Tom,

> (For a specific, nuanced, and personal definition of better...)
> 
> I have a frequent behavior that arises when I am copy/pasting chunks
> of code, typically in tests.  Here is an example:
> 
> My Original code:
> 
> def function():
>    line 1
>    line 2
>    line 3
>    line 4
>    line 5
>    line 6
> 
> --------------------------------
> I add, after it:
> 
> def function2():
>    line 1
>    line 2
>    line 3
>    line 4
>    line 5
>    line 6
> 
> --------------------------------
> My diff is:
> 
> +   line 3
> +   line 4
> +   line 5
> +   line 6
> +
> +def function2():
> +   line 1
> +   line 2
> 
> --------------------------------
> I'd like my diff to be
> 
> +
> +def function2():
> +   line 1
> +   line 2
> +   line 3
> +   line 4
> +   line 5
> +   line 6

I tried to reproduce and got exactly the diff you wanted to have. I need
to add a newline after the first "line 4" to get the not-sought-for diff.

Commit:

+++ b/test.py
@@ -0,0 +1,7 @@
+def function():
+    line 1
+    line 2
+    line 3
+    line 4
+    line 5
+    line 6

and then the following change:

--- a/test.py
+++ b/test.py
@@ -3,5 +3,14 @@ def function():
     line 2
     line 3
     line 4
+
+    line 5
+    line 6
+
+def function2():
+    line 1
+    line 2
+    line 3
+    line 4
     line 5
     line 6

I usually play around with --anchored when I want to solve an issue like
that.

The documentation of anchored says

If a line exists in both the source and destination, exists only once,
and starts with this text, this algorithm attempts to prevent it from
appearing as a deletion or addition in the output. It uses the "patience
diff" algorithm internally.

But I can't get it working here as the "exists only once" premise is broken.

Stepping back: It might also make sense to rethink the code as repeating
the same 6 lines in every function might not be the best possible design.

Thomas

[...]
