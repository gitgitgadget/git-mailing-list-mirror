Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC13C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiCUXLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbiCUXJe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:09:34 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816C33FF252
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:00:47 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 491BA3F4816;
        Mon, 21 Mar 2022 18:59:10 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1398C3F47FB;
        Mon, 21 Mar 2022 18:59:10 -0400 (EDT)
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
Message-ID: <1a64c0f7-ef54-9d61-f7fd-bd192c408ca0@jeffhostetler.com>
Date:   Mon, 21 Mar 2022 18:59:09 -0400
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
[...]
> 
> One other thing, I just add it here:
> There is a new file, t/lib-unicode-nfc-nfd.sh, which helps us with this code:
> test_lazy_prereq UNICODE_NFC_PRESERVED
> 
> The existing code uses a construct called
> UTF8_NFD_TO_NFC
> 
> And now I have 2 questions:
> - Do we need the UNICODE_NFC_PRESERVED at all ?
> - And should the UTF8_NFD_TO_NFC better be called UTF8_NFC_TO_NFD,
>    because that is what it checks.
> - Do we need the UNICODE_NFD_PRESERVED at all ?
> 
> As there are no non-UNICODE_NFD_PRESERVED filesystems, as far as I know.
> And the current code does no tests, just debug prints.
> I dunno.

I created t/lib-unicode-nfc-nfd.sh to help me understand
the issues.  I found the existing UTF8_NFD_TO_NFC prereq
confusing (and yes it seemed poorly named).

The existing prereq returned the same answer on APFS, HFS+,
and FAT32 (a thumbdrive).  I know they behave differently
and I found it odd that the prereq did not make any distinction.

I was hesitant to rename the existing prereq because it is
currently used by 5+ different tests and I didn't want to
expand the scope of my two already very large series.

Also, the existing prereq feels a little sloppy.  It creates
a file in NFC and does a lstat in the NFD spelling.  There
are several ways that the OS and/or FS can lie to us.  For
example, the prereq is satisfied on a FAT32 thumbdrive and
we know FAT32 doesn't do NFC-->NFD conversions.  So I'd like
to move away from that prereq definition at some point.


My new prereqs try to:

(1) independently confirm whether there is aliasing happening
     at all (whether at the FS or OS layer).

(2) determine if the actual on-disk spelling is altered by the
     FS (in both NFC and NFD cases).


We know that HFS+ does not preserve NFC spellings, but APFS
does.  (FAT32 also preserves NFC spelling under MacOS.)
So the UNICODE_NFC_PRESERVED lets me distinguish between HFS+
and APFS/FAT32.

I have not heard of any filesystems that convert NFD to NFC,
so technically we don't need the UNICODE_NFD_PRESERVED prereq,
but then again until I tested that, it was unclear how MacOS
did the aliasing on APFS (and FAT32).  On the basis of that
testing, we can say that MacOS -- at the MacOS layer -- is
responsible for the aliasing and that both NFC and NFD spellings
are preserved on APFS and FAT32.

So I'd rather keep the 3 prereqs that I have now.

The ones marked _DOUBLE_ are currently extra.  I have them to
help study how code points with multiple combining characters
are handled.  I have prereqs for the basic double chars, but
there are several opportunities for weird edge cases (non-
canonical ordering and other collisions) that I don't want to
get stuck on right now.  So we might make more use of them in
the future.


That's too long of an answer, but hopefully that explains
some of my paranoia. :-)

Jeff

> 
> On Tue, Mar 08, 2022 at 10:15:00PM +0000, Jeff Hostetler via GitGitGadget wrote:
>> Here is V2 of part 3 of my builtin FSMonitor series.
[...]
