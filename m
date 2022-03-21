Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FECC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 22:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiCUWuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 18:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiCUWua (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 18:50:30 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040613FE054
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:30:22 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EF24A3F481C;
        Mon, 21 Mar 2022 18:06:02 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A1E593F481B;
        Mon, 21 Mar 2022 18:06:02 -0400 (EDT)
Subject: Re: [PATCH v2 00/27] Builtin FSMonitor Part 3
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        ??var Arnfj??r?? Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
 <20220313104230.ctwbskywcq5jxv36@tb-raspi4>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2bb125d3-cef7-9d47-efa8-61a1aaba5316@jeffhostetler.com>
Date:   Mon, 21 Mar 2022 18:06:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20220313104230.ctwbskywcq5jxv36@tb-raspi4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/13/22 6:42 AM, Torsten Bögershausen wrote:
> Hej Jeff,
> 
> I tried your patch on both a newer Mac and an older machine (with HFS+)
> The older machine doesn't have
> kFSEventStreamEventFlagItemCloned
> As it is an enum, and not a #define, I ended up here:
> 
>    diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
>    index 3332d3b779..fa172a05c4 100644
>    --- a/compat/fsmonitor/fsm-listen-darwin.c
>    +++ b/compat/fsmonitor/fsm-listen-darwin.c
>    @@ -169,8 +169,6 @@ static void log_flags_set(const char *path, const FSEventStreamEventFlags flag)
>                    strbuf_addstr(&msg, "ItemXattrMod|");
>            if (flag & kFSEventStreamEventFlagOwnEvent)
>                    strbuf_addstr(&msg, "OwnEvent|");
>    -       if (flag & kFSEventStreamEventFlagItemCloned)
>    -               strbuf_addstr(&msg, "ItemCloned|");
> 
>            trace_printf_key(&trace_fsmonitor, "fsevent: '%s', flags=0x%x %s",
>                             path, flag, msg.buf);
>    @@ -221,8 +219,7 @@ static int ef_ignore_xattr(const FSEventStreamEventFlags ef)
>                    kFSEventStreamEventFlagItemModified |
>                    kFSEventStreamEventFlagItemRemoved |
>                    kFSEventStreamEventFlagItemRenamed |
>    -               kFSEventStreamEventFlagItemXattrMod |
>    -               kFSEventStreamEventFlagItemCloned;
>    +               kFSEventStreamEventFlagItemXattrMod ;

It looks like the ...Cloned bit was added to the SDK in 10.13 [1].
All the other bits were defined sometime between 10.5 and 10.10.

I'll add something in V7 to guard that bit.  I think 10.10 is old enough
that we don't need to special case those bits too.

Thanks,
Jeff

[1] /Applications/Xcode.app/Contents/Developer/Platforms/ \
     MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/ \
     Library/Frameworks/CoreServices.framework/Frameworks/ \
     FSEvents.framework/Versions/Current/Headers/FSEvents.h

