Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BC7F20899
	for <e@80x24.org>; Mon, 14 Aug 2017 19:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbdHNTby (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 15:31:54 -0400
Received: from avasout06.plus.net ([212.159.14.18]:37520 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdHNTbx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 15:31:53 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id x7Xq1v00W18PUFB017XrpT; Mon, 14 Aug 2017 20:31:52 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=1aMZ-g2L6TMw4t_GtbQA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/9] Convert pack-objects to size_t
To:     Junio C Hamano <gitster@pobox.com>,
        Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
 <87fc215e-b860-10f5-5c5e-60652502fae8@ramsayjones.plus.com>
 <20170813183026.GC31079@mail.zuhause>
 <627042be-ab86-e9da-8c4e-5aac3278f5c6@ramsayjones.plus.com>
 <xmqqtw1bw1v6.fsf@gitster.mtv.corp.google.com>
 <xmqqfucuw00a.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <c49628e0-6a57-34d6-6727-f8111b80cbab@ramsayjones.plus.com>
Date:   Mon, 14 Aug 2017 20:31:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqfucuw00a.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/08/17 18:08, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> One interesting question is which of these two types we should use
>> for the size of objects Git uses.  
>>
>> Most of the "interesting" operations done by Git require that the
>> thing is in core as a whole before we can do anything (e.g. compare
>> two such things to produce delta, have one in core and apply patch),
>> so it is tempting that we deal with size_t, but at the lowest level
>> to serve as a SCM, i.e. recording the state of a file at each
>> version, we actually should be able to exceed the in-core
>> limit---both "git add" of a huge file whose contents would not fit
>> in-core and "git checkout" of a huge blob whose inflated contents
>> would not fit in-core should (in theory, modulo bugs) be able to
>> exercise the streaming interface to handle such case without holding
>> everything in-core at once.  So from that point of view, even size_t
>> may not be the "correct" type to use.
> 
> A few additions to the above observations.
> 
>  - We have varint that encodes how far the location from a delta
>    representation of an object to its base object in the packfile.
>    Both encoding and decoding sides in the current code use off_t to
>    represent this offset, so we can already reference an object that
>    is far in the same packfile as a base.
> 
>  - I think it is OK in practice to limit the size of individual
>    objects to size_t (i.e. on 32-bit arch, you cannot interact with
>    a repository with an object whose size exceeds 4GB).  Using off_t
>    would allow occasional ultra-huge objects that can only be added
>    and checked in via the streaming API on such a platform, but I
>    suspect that it may become too much of a hassle to maintain.

In a previous comment, I said that (on 32-bit Linux) it was likely
that an object of > 4GB could not be handled correctly anyway. (more
likely > 2GB). This was based on the code from (quite some) years ago.
In particular, before you added the "streaming API". So, maybe a 32-bit
arch _should_ be able to handle objects as large as the LFS API allows.
(Ignoring, for the moment, that I think anybody who puts files of that
size into an SCM probably gets what they deserve. :-P ).

The two patches I commented on, however, changed the type of some
variables from off_t to size_t. In general, the patches did not
seem to make anything worse, but these type changes could potentially
do harm. Hence my comment. (I still haven't tried the patches on my
32-bit Linux system. I only boot it up about once a week, and I would
rather wait until the patches are in the 'pu' branch before testing).

ATB,
Ramsay Jones

