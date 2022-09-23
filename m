Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D08C07E9D
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 20:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiIWUrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 16:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiIWUqW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 16:46:22 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16728923E5
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 13:43:28 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 28NKhRqg077328
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 16:43:27 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
References: <022e01d8ceb5$c2da52c0$488ef840$@nexbridge.com> 
In-Reply-To: 
Subject: RE: [BUG] Git 2.38.0-rc1 t1800 message text comparison
Date:   Fri, 23 Sep 2022 16:43:21 -0400
Organization: Nexbridge Inc.
Message-ID: <003501d8cf8d$21ce5ba0$656b12e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdjOtdo9mObKgbHpRkyfW3iShvKnNAA1wwVA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 22, 2022 3:03 PM, I wrote:
>On September 22, 2022 3:02 PM, I wrote:
>>Rc1 is looking good except for this test.
>>
>>We get a diff as follows:
>>
>>-fatal: cannot run bad-hooks/test-hook: ...
>>+fatal: cannot exec 'bad-hooks/test-hook': Permission denied
>>
>>It looks like the pattern
>>sed -e s/test-hook: .*/test-hook: .../
>>
>>needs to be a bit extended. Adding
>>
>>sed -e s/exec/run/ | send -e s/["']//g
>>
>>might help clear off the other noise.

A patch that might work is as follows:

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 43fcb7c0bf..9a723631a2 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -173,7 +173,10 @@ test_expect_success 'git hook run a hook with a bad
shebang' '
                -c core.hooksPath=bad-hooks \
                hook run test-hook >out 2>err &&
        test_must_be_empty out &&
-       sed -e "s/test-hook: .*/test-hook: .../" <err >actual &&
+       quot=`echo "\047"` &&
+       sed -e "s/exec/run/" <err | \
+               sed -e "s/$quot//g" | \
+               sed -e "s/test-hook: .*/test-hook: .../" >actual &&
        test_cmp expect actual
 '

This does not require setting up a prerequisite for NonStop and the
technique might make the MING code easier but adding a change from spawn to
run.

-Randall

