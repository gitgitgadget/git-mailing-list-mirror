Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2818B20562
	for <e@80x24.org>; Sun, 29 Oct 2017 23:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbdJ2XOp (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 19:14:45 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50137 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbdJ2XOn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 19:14:43 -0400
X-Originating-IP: 185.104.120.3
Received: from [127.0.0.1] (exit04.brasshorncomms.uk [185.104.120.3])
        (Authenticated sender: kev@flujos.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0B3E91720B2;
        Mon, 30 Oct 2017 00:14:39 +0100 (CET)
Reply-To: kevin@ki-ai.org
Subject: Re: [PATCH 1/4] remote-mediawiki: add namespace support
To:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Antoine_Beaupr=c3=a9?= <anarcat@debian.org>
Cc:     Git List <git@vger.kernel.org>
References: <20171029160857.29460-1-anarcat@debian.org>
 <20171029160857.29460-2-anarcat@debian.org>
 <CAPig+cSmfJ2Uv21Q4DgJNoy6Ywj7GWPJa6qq0YL9Kar6Q74a_Q@mail.gmail.com>
 <87a809959p.fsf@curie.anarc.at>
 <CAPig+cTySXEWGxSUTxQXmHz7rR_nTbf+ALciZahJ2Ks6EmSqzg@mail.gmail.com>
From:   Kevin <kevin@ki-ai.org>
Message-ID: <6ed0d8d4-243a-7afc-bd37-a6f71004e195@ki-ai.org>
Date:   Sun, 29 Oct 2017 23:08:00 +0000
MIME-Version: 1.0
In-Reply-To: <CAPig+cTySXEWGxSUTxQXmHz7rR_nTbf+ALciZahJ2Ks6EmSqzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So I shared the patch some time ago (~2 years). Surprisingly its just
now getting attention. I guess some renewed interest in using mediawiki
with git. Myself, however, am no longer using mediawiki. Nor am I
completely clear on what the reasons were for using some variable or
another a couple of years ago. So... the best of luck, sorry I couldn't
be more helpful.

Eric Sunshine:
> On Sun, Oct 29, 2017 at 2:29 PM, Antoine Beaupré <anarcat@debian.org> wrote:
>> On 2017-10-29 13:24:03, Eric Sunshine wrote:
>>> On Sun, Oct 29, 2017 at 12:08 PM, Antoine Beaupré <anarcat@debian.org> wrote:
>>> So, the idea is that if the input has form "something:number", then
>>> you want to look up "something" as a namespace name. Anything else
>>> (such as "something:foobar") is not considered a valid page reference.
>>> Right?
>>
>> frankly, i have no idea what's going on here.
>>
>>> The multiple 'return's are a bit messy. Perhaps collapse the entire
>>> function to something like this:
>>>
>>>     sub get_mw_namespace_id_for_page {
>>>         my $arg = shift;
>>>         if ($arg =~ /^([^:]+):\d+$/) {
>>>             return get_mw_namespace_id($1);
>>>         }
>>>         return undef;
>>>     }
>>>
>>> In fact, it may be that the intent of the original code *was* meant to
>>> do exactly the same as shown in my example above, but that the person
>>> who wrote it accidentally typed:
>>>
>>>     return get_mw_namespace_id($namespace);
>>>
>>> instead of the intended:
>>>
>>>     return get_mw_namespace_id($1);
>>>
>>> So, a minimal fix would be simply to change $namespace to $1.
>>> Tightening the regex as I did in my example would be a bonus (though
>>> probably ought to be a separate patch).
>>
>> so while i'm happy to just copy-paste your code in there, that's kind of
>> a sensitive area of the code, as it was originally used only in the
>> upload procedure, which I haven't tested at all. so i'm hesitant in just
>> merging that in as is.
> 
> I don't think there's a need to copy/paste my example code. If you
> instead make the minimal suggested fix, then the resulting code will
> be effectively equivalent to my example (minus the tighter regex).
> 
>> i don't understand why or how this even works, to be honest: page names
>> don't necessarily look like numbers, in fact, they generally don't. i
>> don't understand why the patch submitted here even touches that function
>> at all, considering that the function is only used on uploads. I just
>> cargo-culted it from the original issue...
> 
> I, myself, am not familiar with or a user of Mediawiki or with the Git
> bridging, and I don't know what page names look like, but I'm pretty
> well convinced from reading both the existing code and this patch that
> the changes to get_mw_namespace_id_for_page() are really just a bug
> fix to that function. My interpretation is that the function really
> was intended to strip the ":id" portion of "name:id" before calling
> get_mw_namespace_id(); the fact that the original code neglects to do
> so seems just an oversight. The fact that the regex uses capturing
> parentheses implies strongly that it was indeed the intention to use
> $1 in the call to get_mw_namespace_id(). Unlike the "fix" in the patch
> you posted from Kevin, which is perhaps unnecessarily complicated, the
> fix I suggested above is about a minimal as possible. That is,
> changing:
> 
>      return get_mw_namespace_id($namespace);
> 
> to:
> 
>      return get_mw_namespace_id($1);
> 
> should achieve the same result. (It could be made more robust by
> tightening the regex as in my example, but that's a separate topic,
> not needed just to get the function to work as intended.)
> 

