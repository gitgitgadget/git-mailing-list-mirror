Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B751F404
	for <e@80x24.org>; Mon, 19 Feb 2018 01:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeBSBE6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Feb 2018 20:04:58 -0500
Received: from avasout01.plus.net ([84.93.230.227]:56826 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbeBSBE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Feb 2018 20:04:58 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id nZt1eX2fhZqItnZt2e3hYD; Mon, 19 Feb 2018 01:04:56 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=C7LHNzH+ c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=wDHDIYsj53Wx1zetVr4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 22/23] cat-file: tests for new atoms added
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Adam Dinwoodie <git@dinwoodie.org>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4388-f6427c9d-2be6-4628-afc9-bfaeb58b1ebe-000000@eu-west-1.amazonses.com>
 <CA+kUOamJowkxp0xAPf5FA+wBkiOjQeYzW1sKMwcatQBBA1qWpw@mail.gmail.com>
 <58b2bdcd-d621-fd21-ab4d-6a9478319b19@ramsayjones.plus.com>
Message-ID: <17c88c6d-c286-1857-965b-2d41f8f67bf4@ramsayjones.plus.com>
Date:   Mon, 19 Feb 2018 01:04:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <58b2bdcd-d621-fd21-ab4d-6a9478319b19@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJL09wYlHecAHfC4FooR7jl0zskUBSQAVv5QeYHmfgnLegE2eGtFRN4AP+8gJFwCn0Xe6/AGLo3rOwM3huVuMitDqvSOQo3xv8q/I05R1Le9X5754cyl
 aYJ0I1IPTvaBcWSGFpth0WKOe0tMS1QYMC4puWSrInd0so8V73A36/Lw8XHEUvUGpGJN+o71Axqb9g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 18/02/18 22:55, Ramsay Jones wrote:
> 
> 
> On 16/02/18 14:55, Adam Dinwoodie wrote:
>> On 12 February 2018 at 08:08, Olga Telezhnaya wrote:
>>> Add some tests for new formatting atoms from ref-filter.
>>> Some of new atoms are supported automatically,
>>> some of them are expanded into empty string
>>> (because they are useless for some types of objects),
>>> some of them could be supported later in other patches.
>>
>> This commit appears to be introducing failures in t1006 on Cygwin.
>> Specifically, tests 15, 36, 58 and 89, all titled "Check %(refname)
>> gives empty output", are failing on the pu branch at 21937aad4, and
>> git bisect identifies this commit, 3c1571744 ("cat-file: tests for new
>> atoms added", 2018-02-12), as the culprit.
> 
> Hi Adam, Olga,
> 
> Sparse has been complaining about this 'ot/cat-batch-format' branch for
> a while, so I had already noted (apart from a symbol which should be
> marked as static) something that looked somewhat off - namely, the on
> stack initialisation of a 'struct ref_array_item' (builtin/cat-file.c,
> line 246, in function batch_object_write()).
> 
> In particular, the 'struct ref_array_item' ends with a [FLEX_ARRAY] field
> for the refname, so it clearly isn't meant to be declared on the stack.
> The 'ref-filter' code uses a 'constructor' function called 'new_ref_array_\
> item() which, among others, takes a 'refname' parameter with which to
> initialise the refname FLEX_ARRAY field.
> 
> So, on Linux, if you build with SANITIZE=address and then run that test:

BTW, I forgot to mention that, if you run that test without -i, then
more than tests #15,36,58 and 89 will fail. In addition, tests #19-20,
#40-41, #62-63 and #93-94 failed - I did not investigate these
failures at all.

ATB,
Ramsay Jones

