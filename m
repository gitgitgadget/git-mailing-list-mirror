Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D25C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 14:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354413AbiCYOjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 10:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353589AbiCYOjv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 10:39:51 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFCD4B1CD
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:38:14 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E82393F4114;
        Fri, 25 Mar 2022 10:38:13 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7FB613F4090;
        Fri, 25 Mar 2022 10:38:13 -0400 (EDT)
Subject: Re: [PATCH v4 26/27] t/lib-unicode-nfc-nfd: helper prereqs for
 testing unicode nfc/nfd
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
 <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
 <bc2d5a7a9306c895f4a1105c08d86f24e5ea542c.1648140680.git.gitgitgadget@gmail.com>
 <9c584888-2dd2-139a-cf41-b2974386d1f8@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ba395b67-12a9-7fbb-7b0a-610ea055fe81@jeffhostetler.com>
Date:   Fri, 25 Mar 2022 10:38:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9c584888-2dd2-139a-cf41-b2974386d1f8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/25/22 4:59 AM, Bagas Sanjaya wrote:
> On 24/03/22 23.51, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Create a set of prereqs to help understand how file names
>> are handled by the filesystem when they contain NFC and NFD
>> Unicode characters.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   t/lib-unicode-nfc-nfd.sh | 167 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 167 insertions(+)
>>   create mode 100755 t/lib-unicode-nfc-nfd.sh
>>
>> diff --git a/t/lib-unicode-nfc-nfd.sh b/t/lib-unicode-nfc-nfd.sh
>> new file mode 100755
>> index 00000000000..cf9c26d1e22
>> --- /dev/null
>> +++ b/t/lib-unicode-nfc-nfd.sh
>> @@ -0,0 +1,167 @@
>> +# Help detect how Unicode NFC and NFD are handled on the filesystem.
>> +
>> +# A simple character that has a NFD form.
>> +#
>> +# NFC:       U+00e9 LATIN SMALL LETTER E WITH ACUTE
>> +# UTF8(NFC): \xc3 \xa9
>> +#
>> +# NFD:       U+0065 LATIN SMALL LETTER E
>> +#            U+0301 COMBINING ACUTE ACCENT
>> +# UTF8(NFD): \x65  +  \xcc \x81
>> +#
>> +utf8_nfc=$(printf "\xc3\xa9")
>> +utf8_nfd=$(printf "\x65\xcc\x81")
>> +
> 
> The first nfc-nfd test subject (É) is simple case, right?

Yes, this first pair was to test basic composition sensitivity.
Something that we would expect to be munged on MacOS, but not elsewhere.

> 
>> +# Is the OS or the filesystem "Unicode composition sensitive"?
>> +#
>> +# That is, does the OS or the filesystem allow files to exist with
>> +# both the NFC and NFD spellings?  Or, does the OS/FS lie to us and
>> +# tell us that the NFC and NFD forms are equivalent.
>> +#
>> +# This is or may be independent of what type of filesystem we have,
>> +# since it might be handled by the OS at a layer above the FS.
>> +# Testing shows on MacOS using APFS, HFS+, and FAT32 reports a
>> +# collision, for example.
>> +#
>> +# This does not tell us how the Unicode pathname will be spelled
>> +# on disk, but rather only that the two spelling "collide".  We
>> +# will examine the actual on disk spelling in a later prereq.
>> +#
>> +test_lazy_prereq UNICODE_COMPOSITION_SENSITIVE '
>> +    mkdir trial_${utf8_nfc} &&
>> +    mkdir trial_${utf8_nfd}
>> +'
>> +
>> +# Is the spelling of an NFC pathname preserved on disk?
>> +#
>> +# On MacOS with HFS+ and FAT32, NFC paths are converted into NFD
>> +# and on APFS, NFC paths are preserved.  As we have established
>> +# above, this is independent of "composition sensitivity".
>> +#
>> +# 0000000 63 5f c3 a9
>> +#
>> +# (/usr/bin/od output contains different amount of whitespace
>> +# on different platforms, so we need the wildcards here.)
>> +#
>> +test_lazy_prereq UNICODE_NFC_PRESERVED '
>> +    mkdir c_${utf8_nfc} &&
>> +    ls | od -t x1 | grep "63 *5f *c3 *a9"
>> +'
>> +
>> +# Is the spelling of an NFD pathname preserved on disk?
>> +#
>> +# 0000000 64 5f 65 cc 81
>> +#
>> +test_lazy_prereq UNICODE_NFD_PRESERVED '
>> +    mkdir d_${utf8_nfd} &&
>> +    ls | od -t x1 | grep "64 *5f *65 *cc *81"
>> +'
>> +    mkdir c_${utf8_nfc} &&
>> +    mkdir d_${utf8_nfd} &&
>> +
>> +# The following _DOUBLE_ forms are more for my curiosity,
>> +# but there may be quirks lurking when there are multiple
>> +# combining characters in non-canonical order.
>> +
>> +# Unicode also allows multiple combining characters
>> +# that can be decomposed in pieces.
>> +#
>> +# NFC:        U+1f67 GREEK SMALL LETTER OMEGA WITH DASIA AND PERISPOMENI
>> +# UTF8(NFC):  \xe1 \xbd \xa7
>> +#
>> +# NFD1:       U+1f61 GREEK SMALL LETTER OMEGA WITH DASIA
>> +#             U+0342 COMBINING GREEK PERISPOMENI
>> +# UTF8(NFD1): \xe1 \xbd \xa1  +  \xcd \x82
>> +#
>> +# But U+1f61 decomposes into
>> +# NFD2:       U+03c9 GREEK SMALL LETTER OMEGA
>> +#             U+0314 COMBINING REVERSED COMMA ABOVE
>> +# UTF8(NFD2): \xcf \x89  +  \xcc \x94
>> +#
>> +# Yielding:   \xcf \x89  +  \xcc \x94  +  \xcd \x82
>> +#
>> +# Note that I've used the canonical ordering of the
>> +# combinining characters.  It is also possible to
>> +# swap them.  My testing shows that that non-standard
>> +# ordering also causes a collision in mkdir.  However,
>> +# the resulting names don't draw correctly on the
>> +# terminal (implying that the on-disk format also has
>> +# them out of order).
>> +#
>> +greek_nfc=$(printf "\xe1\xbd\xa7")
>> +greek_nfd1=$(printf "\xe1\xbd\xa1\xcd\x82")
>> +greek_nfd2=$(printf "\xcf\x89\xcc\x94\xcd\x82")
>> +
> 
> The second test subject (greek) is more complex, right?

Yes, the Greek character is more interesting because
there can be multiple combining characters for some
Greek letters.  (I don't speak Greek, so I don't know
how often these occur in practice, but Unicode defines
and allows them, so I'm testing whether these longer
sequences are also munged by the OS.

FWIW, there are other cases the we could try here,
such as putting the combining characters in the other
order.  Or testing with a partially composed/decomposed
string (nfd1).  Or testing with the partially composed
/decomposed using the swapped ordering.  But I left these
out since for now -- it seemed a bit too far off into the
weeds.

> 
>> +# See if a double decomposition also collides.
>> +#
>> +test_lazy_prereq UNICODE_DOUBLE_COMPOSITION_SENSITIVE '
>> +    mkdir trial_${greek_nfc} &&
>> +    mkdir trial_${greek_nfd2}
>> +'
>> +
>> +# See if the NFC spelling appears on the disk.
>> +#
>> +test_lazy_prereq UNICODE_DOUBLE_NFC_PRESERVED '
>> +    mkdir c_${greek_nfc} &&
>> +    ls | od -t x1 | grep "63 *5f *e1 *bd *a7"
>> +'
>> +
>> +# See if the NFD spelling appears on the disk.
>> +#
>> +test_lazy_prereq UNICODE_DOUBLE_NFD_PRESERVED '
>> +    mkdir d_${greek_nfd2} &&
>> +    ls | od -t x1 | grep "64 *5f *cf *89 *cc *94 *cd *82"
>> +'
>> +
>> +# The following is for debugging. I found it useful when
>> +# trying to understand the various (OS, FS) quirks WRT
>> +# Unicode and how composition/decomposition is handled.
>> +# For example, when trying to understand how (macOS, APFS)
>> +# and (macOS, HFS) and (macOS, FAT32) compare.
>> +#
>> +# It is rather noisy, so it is disabled by default.
>> +#
>> +if test "$unicode_debug" = "true"
>> +then
>> +    if test_have_prereq UNICODE_COMPOSITION_SENSITIVE
>> +    then
>> +        echo NFC and NFD are distinct on this OS/filesystem.
>> +    else
>> +        echo NFC and NFD are aliases on this OS/filesystem.
>> +    fi
>> +
>> +    if test_have_prereq UNICODE_NFC_PRESERVED
>> +    then
>> +        echo NFC maintains original spelling.
>> +    else
>> +        echo NFC is modified.
>> +    fi
>> +
>> +    if test_have_prereq UNICODE_NFD_PRESERVED
>> +    then
>> +        echo NFD maintains original spelling.
>> +    else
>> +        echo NFD is modified.
>> +    fi
>> +
>> +    if test_have_prereq UNICODE_DOUBLE_COMPOSITION_SENSITIVE
>> +    then
>> +        echo DOUBLE NFC and NFD are distinct on this OS/filesystem.
>> +    else
>> +        echo DOUBLE NFC and NFD are aliases on this OS/filesystem.
>> +    fi
>> +
>> +    if test_have_prereq UNICODE_DOUBLE_NFC_PRESERVED
>> +    then
>> +        echo Double NFC maintains original spelling.
>> +    else
>> +        echo Double NFC is modified.
>> +    fi
>> +
>> +    if test_have_prereq UNICODE_DOUBLE_NFD_PRESERVED
>> +    then
>> +        echo Double NFD maintains original spelling.
>> +    else
>> +        echo Double NFD is modified.
>> +    fi
>> +fi
> 
> In general, this test is written from Mac OS perspective, but since we have
> Git users also from Linux, Windows, and other OSes, I'd like to see from 
> these
> other perspective.
> 

Right, MacOS does the NFC/NFD aliasing.  What I have here proves
that they do it and how/if they alter the spelling of paths on disk.
And we can check the values of these prereqs for APFS, HFS+, and FAT32
on MacOS.

I don't know of any other OS that does similar artificial aliasing, so
yeah, these tests are somewhat Mac-specific.  However, they have also
been run on Windows and Linux confirm that they do not do such aliasing.

There are other non-Mac tests that we could do -- mainly around
malformed UTF8 paths in a commit -- Linux treats paths as just 8-bit
data, so there is no guarantee that a tree created on Linux would have
valid UTF8 paths -- just 8-bit paths.  Importing that onto Windows or
Mac could create issues, since Windows wants to use UCS2 with the *W()
routines and MacOS wants to do the UTF8 aliasing.  But all of that is
outside the scope of this patch series.

In this series, we're trying to watch the journal/event log and report
the changed paths.  We want to use the on-disk spelling of the modified
files, but augment that with the alternate alias spelling when we can.

Hope this helps,
Jeff

