Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA05C20A26
	for <e@80x24.org>; Thu, 28 Sep 2017 14:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbdI1Odm (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 10:33:42 -0400
Received: from siwi.pair.com ([209.68.5.199]:15556 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752156AbdI1Odl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 10:33:41 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7A8AE84612;
        Thu, 28 Sep 2017 10:33:40 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3737784611;
        Thu, 28 Sep 2017 10:33:40 -0400 (EDT)
Subject: Re: [PATCH 07/13] object-filter: common declarations for object
 filtering
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20170922203017.53986-6-git@jeffhostetler.com>
 <20170922203017.53986-8-git@jeffhostetler.com>
 <20170926153950.a147c48ce62f73702eff7ebb@google.com>
 <7774ff8d-3a53-860d-9343-292938d59d12@jeffhostetler.com>
 <20170927170533.65498396e008fa148a3fda90@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3cab0259-f20e-5913-d886-e37c4da9fd04@jeffhostetler.com>
Date:   Thu, 28 Sep 2017 10:33:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170927170533.65498396e008fa148a3fda90@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/27/2017 8:05 PM, Jonathan Tan wrote:
> On Wed, 27 Sep 2017 13:09:42 -0400
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> On 9/26/2017 6:39 PM, Jonathan Tan wrote:
>>> On Fri, 22 Sep 2017 20:30:11 +0000
>>> Jeff Hostetler <git@jeffhostetler.com> wrote:
>>>
>>>>    Makefile        |   1 +
>>>>    object-filter.c | 269 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    object-filter.h | 173 ++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 443 insertions(+)
>>>>    create mode 100644 object-filter.c
>>>>    create mode 100644 object-filter.h
>>>
>>> I think these and list-objects-filter-* are multiple levels of
>>> indirection too many. Would a single file with a few implementations of
>>> filter_object_fn be sufficient?
>>
>> I did that in my first draft and I found it confusing.
>>
>> Each filter has 3 parts (some filter-specific data structures,
>> a filter callback routine, a driver to call the traverse code).
>> I found it easier to reason about each filter in isolation.
>> And it makes it easier to work on each independently and keep
>> their inclusion in separate commits.
> 
> I looked at object-filter.{c,h} a bit more. It seems that these files:
>   1) define a struct that contains all the options that we would want
>   2) supplies a way to populate this struct from code that uses parse-options
>   3) supplies a way to populate this struct from code that calculates
>      options by hand
>   4) supplies a way to populate this struct from "protocol" ("<key>" or
>      "<key> <value>" strings)
> 
> And the next commit takes the struct that object-filter.{c,h} produces
> and actually performs the traversal.
> 
> I think this can be significantly simplified, though. Would this work:
>   a) Define the object_filter_options struct, but make all fields
>      correspond to a single parameter each. Define
>      OBJECT_FILTER_OPTIONS_INIT to initialize everything to 0 except for
>      large_byte_limit to ULONG_MAX (so that we can detect if something
>      else is set to it).
>   b) Define one single OPT_PARSE_FILTER macro containing all the
>      parameters. We can use the non-callback macros here. That solves 2)
>      above.
>   c) Define a function that takes in (int *argc, char ***argv) that can
>      "massage" it to remove all filter-related arguments, storing them in
>      a object_filter_options struct. That solves 3) above. As discussed
>      in the API documentation, this means that argument lists of the form
>      "--unknown --known" (where "--unknown" takes an argument) are
>      processed differently, but then again, rev-list never supported them
>      anyway (it required "--unknown=<arg>").
>   d) Define a function that converts "<key>" into "--<key>" and "<key>
>      <value>" into "--<key>=<value>", and use the existing mechanism.
>      That solves 4) above.
> 
> This removes the need to maintain the lists of one-per-argument
> functions, including the parse_filter_* and opt_parse_filter_* functions
> declared in the header file. If we were to add a feature, we wouldn't
> need to change anything in the caller, and wouldn't need to hand-edit
> object_filter_hand_parse_arg() and object_filter_hand_parse_protocol().

Maybe.  What I have here now is the result of adding these arguments to
rev-list and pack-objects (in the current patch series), and also to
fetch-pack, fetch, clone, upload-pack, index-pack, and the transport and
protocol code (in a follow-on patch series that I've omitted for the moment).
And there will probably be a few more, such as fsck, gc, and etc.  I hesitate
to refine the macros too much further until we've agreement on the overall
approach and terms.

Thanks
Jeff


