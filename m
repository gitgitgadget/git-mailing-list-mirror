Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98631C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 20:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJGU4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 16:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJGU4F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 16:56:05 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B907CCC822
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 13:56:03 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 94EEACA124E;
        Fri,  7 Oct 2022 16:56:02 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 47EE2CC833E;
        Fri,  7 Oct 2022 16:56:02 -0400 (EDT)
Subject: Re: [PATCH 0/2] Fix syntax errors under clang 11.0.0 on MacOS
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
 <0f67ca77-f17f-d844-e689-ca9a9bdf7993@jeffhostetler.com>
 <xmqqpmf3frr5.fsf@gitster.g> <ec920650-4334-a6f2-6d6f-241899dd79ec@web.de>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <58d3ef47-2196-4f59-692a-fc86dfbc1252@jeffhostetler.com>
Date:   Fri, 7 Oct 2022 16:56:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ec920650-4334-a6f2-6d6f-241899dd79ec@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/7/22 4:28 PM, René Scharfe wrote:
> Am 07.10.22 um 19:49 schrieb Junio C Hamano:
>>
>> My preference is to flip the -Wno-missing-braces bit in
>> config.mak.uname only for folks who use the version of clang on
>> macOS when that clang claims to be clang11 (my understanding of
>> René's experiment[*] is that versions of (real) clang 9 or newer
>> perfectly well understand that {0} is an accpetable way to specify
>> zero initialization for any structure, with possible nesting).
>>
>> [Reference]
>>
>> * https://lore.kernel.org/git/36cd156b-edb2-062c-9422-bf39aad39a6d@web.de/
> 
> Wikipedia has a map that says Apple calls the LLVM clang 8 (i.e. the
> real one) "11.0.0" and clang 9 "11.0.3":
> 
> https://en.wikipedia.org/wiki/Xcode#Xcode_11.0_-_14.x_(since_SwiftUI_framework)_2
> 
> Perhaps like this?  (No sign-off because I'm not comfortable with that
> make function syntax, but feel free to steal salvageable parts.)
> 
> diff --git a/config.mak.dev b/config.mak.dev
> index 4fa19d361b..4d59c9044f 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -69,6 +69,14 @@ DEVELOPER_CFLAGS += -Wno-missing-braces
>   endif
>   endif
> 
> +# LLVM clang older than 9 and Apple clang older than 12 complain
> +# about initializing a struct-within-a-struct using just "{ 0 }"
> +ifneq ($(filter clang1,$(COMPILER_FEATURES)),)
> +ifeq ($(filter $(if $(filter Darwin,$(uname_S)),clang12,clang9),$(COMPILER_FEATURES)),)
> +DEVELOPER_CFLAGS += -Wno-missing-braces
> +endif
> +endif
> +

So if I understand you correctly, Apple clang 11 is broken
and Apple clang 12 is good.

I was getting ready to send (as soon as the CI finished)
the following a simple to add the -Wno... for clang 11 and
below on Darwin.

+ifeq ($(uname_S),Darwin)
+# Older versions of Apple clang complain about initializing a
+# struct-within-a-struct using just "{0}" rather than "{{0}}".
+# More recent versions do not.  This error is considered a
+# false-positive and not worth fixing, so just disable it.
+ifeq ($(filter clang12,$(COMPILER_FEATURES)),)
+DEVELOPER_CFLAGS += -Wno-missing-braces
+endif
+endif

I'm not sure I understand all of what your suggestion does.

Jeff

