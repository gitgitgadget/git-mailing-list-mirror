Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12BE21F462
	for <e@80x24.org>; Fri, 24 May 2019 18:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbfEXSqJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 14:46:09 -0400
Received: from siwi.pair.com ([209.68.5.199]:51711 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727465AbfEXSqI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 14:46:08 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D26353F4085;
        Fri, 24 May 2019 14:46:07 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:a930:ecfb:793f:8fff] (unknown [IPv6:2001:4898:a800:1012:5a64:ecfb:793f:8fff])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4CC1E3F408C;
        Fri, 24 May 2019 14:46:07 -0400 (EDT)
Subject: Re: [RFC PATCH] list-objects-filter: disable 'sparse:path' filters
To:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20190524120318.4851-1-chriscool@tuxfamily.org>
 <87ef4of3g6.fsf@evledraar.gmail.com>
 <CAP8UFD2HJ2D9Sndud5Wu7Vyz9Jj-mVkpE4oowd3VaXoV3nugcw@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <83f6b1f6-2aba-f81c-03d2-69815e8e6cfb@jeffhostetler.com>
Date:   Fri, 24 May 2019 14:46:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2HJ2D9Sndud5Wu7Vyz9Jj-mVkpE4oowd3VaXoV3nugcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/24/2019 8:39 AM, Christian Couder wrote:
> On Fri, May 24, 2019 at 2:21 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Fri, May 24 2019, Christian Couder wrote:
>>
>>> If someone wants to use as a filter a sparse file that is in the
>>> repository, something like "--filter=sparse:oid=<ref>:<path>"
>>> already works.
>>>
>>> So 'sparse:path' is only interesting if the sparse file is not in
>>> the repository. In this case though the current implementation has
>>> a big security issue, as it makes it possible to ask the server to
>>> read any file, like for example /etc/password, and to explore the
>>> filesystem, as well as individual lines of files.
>>
>> Removing this is a good idea.
>>
>> Just to clarify, what was the attack surface in practice? We pass this
>> to add_excludes_from_file_to_list(), are there cases where it'll spew
>> out parse errors/warnings that allow you to extract content from such a
>> file?
> 
> Peff provided an example script in:
> 
> https://public-inbox.org/git/20181108050755.GA32158@sigill.intra.peff.net/
> 
>> Or does it amount to a DoS vector by pointing to some huge (binary?)
>> file on-disk, or a security issue where you could via the error or
>> timings discover whether the file exists or not, something else?
>>
>> I wonder if server operators need to be paranoid about the DoS from the
>> issue with <oid>:<path> noted int/perf/p0100-globbing.sh which this is
>> presumably vulnerable to, i.e. someone with repository write access
>> uploading pathological patterns. That might be particularly annoying for
>> e.g. GitHub where the fork network's object storage is shared.
> 
> In general servers should limit the git processes they launch, but
> yeah it might be interesting to look at that too.
> 

My original thoughts were that we could limit the sparse:path to
local use and disallow it over the wire to the server, but that
distinction is probably not worth the bother.  Removing it completely
is fine.

Thanks,
Jeff
