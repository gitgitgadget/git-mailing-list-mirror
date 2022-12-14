Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B42C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 05:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiLNFxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 00:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLNFxs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 00:53:48 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D312251F
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 21:53:46 -0800 (PST)
Received: from Mazikeen (163.150.245.213.rev.sfr.net [213.245.150.163])
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2BE5ratu001933
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 14 Dec 2022 00:53:37 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <rsbecker@nexbridge.com>, <git@vger.kernel.org>
References: <022e01d8ceb5$c2da52c0$488ef840$@nexbridge.com>  <003501d8cf8d$21ce5ba0$656b12e0$@nexbridge.com>
In-Reply-To: <003501d8cf8d$21ce5ba0$656b12e0$@nexbridge.com>
Subject: RE: [BUG] Git 2.38.0-rc1 t1800 message text comparison
Date:   Wed, 14 Dec 2022 00:53:31 -0500
Organization: Nexbridge Inc.
Message-ID: <013701d90f80$692ba9c0$3b82fd40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFwJ678f40H0J9aM+Un1S82qzKFhgIJQNYvry5nLsA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 23, 2022 4:43 PM, I wrote:
>On September 22, 2022 3:03 PM, I wrote:
>>On September 22, 2022 3:02 PM, I wrote:
>>>Rc1 is looking good except for this test.
>>>
>>>We get a diff as follows:
>>>
>>>-fatal: cannot run bad-hooks/test-hook: ...
>>>+fatal: cannot exec 'bad-hooks/test-hook': Permission denied
>>>
>>>It looks like the pattern
>>>sed -e s/test-hook: .*/test-hook: .../
>>>
>>>needs to be a bit extended. Adding
>>>
>>>sed -e s/exec/run/ | send -e s/["']//g
>>>
>>>might help clear off the other noise.
>
>A patch that might work is as follows:
>
>diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh index 43fcb7c0bf..9a723631a2
>100755
>--- a/t/t1800-hook.sh
>+++ b/t/t1800-hook.sh
>@@ -173,7 +173,10 @@ test_expect_success 'git hook run a hook with a bad
>shebang' '
>                -c core.hooksPath=bad-hooks \
>                hook run test-hook >out 2>err &&
>        test_must_be_empty out &&
>-       sed -e "s/test-hook: .*/test-hook: .../" <err >actual &&
>+       quot=`echo "\047"` &&
>+       sed -e "s/exec/run/" <err | \
>+               sed -e "s/$quot//g" | \
>+               sed -e "s/test-hook: .*/test-hook: .../" >actual &&
>        test_cmp expect actual
> '
>
>This does not require setting up a prerequisite for NonStop and the
technique
>might make the MING code easier but adding a change from spawn to run.

This is still broken on NonStop. Is there any hope of a resolution?

Thanks,
Randall

