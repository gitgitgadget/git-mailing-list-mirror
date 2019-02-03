Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167321F453
	for <e@80x24.org>; Sun,  3 Feb 2019 01:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfBCBZ2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 20:25:28 -0500
Received: from avasout05.plus.net ([84.93.230.250]:53865 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfBCBZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 20:25:28 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id q6XDgficQyTttq6XEgDpch; Sun, 03 Feb 2019 01:25:26 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=XuzUx2N9 c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=H642gA7laEfBm65GI6kA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/1] Makefile: improve SPARSE_FLAGS customisation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <3ccf0255-8a15-effc-ce6b-eabb61625f90@ramsayjones.plus.com>
 <xmqqmunfxjve.fsf@gitster-ct.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <4a8f6b3f-3844-b4e8-2ed2-4078b592dd4b@ramsayjones.plus.com>
Date:   Sun, 3 Feb 2019 01:25:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqmunfxjve.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPX/nQUepi7EziEQ55rSKLf5icALG1dJtw3LXQxO77vZnw7JSHhzYcheCPqtMiYOJ5z+gCR/8uhasVu4X+Ge6h7whjRLD4kWI9B0cz0ndQrIUKh9wHMk
 NvhTq11+QaJVCdeU+Tog521revORCuHVcAH1rFqhICuY7Q4kJjnGtQBiWNCyt0NAO1Gdv2y7E9WrrQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/02/2019 21:46, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> In order to enable greater user customisation of the SPARSE_FLAGS
>> variable, we introduce a new SP_EXTRA_FLAGS variable to use for
>> target specific settings. Without using the new variable, setting
>> the SPARSE_FLAGS on the 'make' command-line would also override the
>> value set by the target-specific rules in the Makefile (effectively
>> making them useless). In addition, we initialise the SPARSE_FLAGS
>> to the default (empty) value using a conditional assignment (?=).
>> This allows the SPARSE_FLAGS to be set from the environment as
>> well as from the command-line.
> 
> Thanks for a detailed and clear explanation here and in the cover
> letter.  I agree with the motivation and most of the things I see in
> this patch, but one thing that stands out at me is if we still want
> to += append to SP_EXTRA_FLAGS in target specific way.  Before this
> patch, because SPARSE_FLAGS was a dual use variable, it needed +=
> appending to it in these two places, but that rationale is gone with
> this patch.

As Luc surmised, in his reply, my intention was that SP_EXTRA_FLAGS
should be used for any 'internal' settings (not just the target
specific settings), whereas SPARSE_FLAGS would now be used _only_ for
user customisation.

The commit message doesn't make that clear, (and the patch text adds
to the confusion, since only target specific settings are changed) so
I need to reword that somehow. Also, ...

> Also, don't we want to clear SP_EXTRA_FLAGS at the beginning?

... (Ahem) I just simply forgot to initialise the new variable! :(
(Yes, it actually doesn't matter, but it gives a wrong impression). ;-)

BTW, the first name I chose was SP_FLAGS, but while editing the second
hunk I decided that wasn't a good name. On several other projects I have
seen exactly this 'split' happen, where the user facing variable was
called <something>_FLAGS and the 'internal' variable was then called
<something>_EXTRA_FLAGS, so I decided to go with that instead. (Yes, I
abbreviated SPARSE). However, I have to say that I have also seen (less
often) the exact opposite: "... if some idiot user wants to add extra
flags ...". :-D

So, yes SP_EXTRA_FLAGS could be used for other 'internal' uses; for
example, look back to commit 6bc8606be3 ("config.mak.uname: remove
SPARSE_FLAGS setting for cygwin", 2018-02-12), which removed:
'SPARSE_FLAGS = -isystem /usr/include/w32api -Wno-one-bit-signed-bitfield'
from config.mak.uname. As you can see, although gcc could find the
win32 header files, sparse needed a little help. Also, the win32 system
header files had an instance of a 'one-bit signed bitfield', which caused
sparse to spew many many many errors. If I needed to do something like
that again, then I would use SP_EXTRA_FLAGS instead.

[Looking back now, I am a little shocked that it seems to have taken
me nearly 5 years to submit that patch! :-P ]

I could give quite a few examples, but ... Oh wait! ... Hmm, it seems
that I need to add a new patch to remove line 558 of config.mak.uname.
This line has a setting for SPARSE_FLAGS in the MINGW section of that
file. Back in around 2011, having ported sparse to MinGW (the original
msysgit, not MSYS2), I naturally had the same issue with the Win32
header files. Since I didn't upstream my sparse patches, I don't think
anyone can be running sparse on MinGW these days.

Anyway, its late, so I will look at redoing the patches soon.

ATB,
Ramsay Jones
