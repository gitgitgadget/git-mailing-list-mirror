Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E4231F597
	for <e@80x24.org>; Fri, 27 Jul 2018 10:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbeG0Lk4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 07:40:56 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:43433 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbeG0Lk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 07:40:56 -0400
Received: from [192.168.2.201] ([92.22.29.59])
        by smtp.talktalk.net with SMTP
        id izqUfaj86VlGZizqUfo11k; Fri, 27 Jul 2018 11:19:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1532686780;
        bh=F6luWkRnR3ccqsY4DB4SWixKchTmLmPcpDLeYzmyD7I=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Yf+6FflclVVJvUlgJjqpVHMoz26B0jDBjCW1P2V/INPAKXQUwyeXYG1xcbOnsS1Nf
         4FwXhk9wpNfomhO/A9k0cYCEwyoN4D85wrquQwBJcozw3k1LqxSghp03ubc+nZbqwk
         HUQYOOLsrHJEhtcHLTLUDMDvQjqzfCUUQe5b0UTo=
X-Originating-IP: [92.22.29.59]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=OmzqbFWWvC/aSYX+a7e/kQ==:117
 a=OmzqbFWWvC/aSYX+a7e/kQ==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=pGLkceISAAAA:8 a=jAkuZBW1sInJ30_wmu4A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v5 2/4] add -p: select modified lines correctly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180726155854.20832-1-phillip.wood@talktalk.net>
 <20180726155854.20832-3-phillip.wood@talktalk.net>
 <xmqqmuudpzfl.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <2e78e077-1801-9c92-6b53-badf588fe262@talktalk.net>
Date:   Fri, 27 Jul 2018 11:19:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqmuudpzfl.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAtLsSCbja8FDTtHYb2CH0kTSbExrro0Ghumh/jY8NdgooFyU/eWuXnHpdw7eZVg9YIS2ZySyg/7mL2Tgt/SqbtQR70vdNSAp5NacdnsNbUOaI/AFXbF
 WCSnb5R9eFC42B43v3LvHwfglCCP2dsMPv8SbtARVzDsYi18PjhfROyOf08dT2WpEvCpy6/8MfuMl+IKwVi6fOpAHjZwAXUYgOm4MhYQUvHQ/5vYLjzuazsB
 4jMywNsr2bTE2KV9shI937jOYfoTdiaQtGaCnTeRliVEZVE9pqLwR3xHCYag7l3tFMWewIP21foCdtHfKn2tuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio, thanks for the comments

On 26/07/18 20:30, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
> An interesting problem you are solving ;-)
> 
>> For example given the hunk
>>       1 -* a longer description of the
>>       2 -  first item
>>       3 -* second
>>       4 -* third
>>       5 +* first
>>       6 +  second item
>>       7 +* the third item
>>
>> If the user selects 1,2,4–5,7 then we should generate
>> 	-* a longer description of the
>> 	-  first item
>> 	+* first
>> 	 * second
>> 	-* third
>> 	+* the third item
> 
> I understood this example as "3 that is removal and 6 that is
> addition are excluded---we consider that these two lines (one in the
> pre-image and the other in the post-image) are _matching" As we> are excluding a deletion, it becomes the common context line, and
> any removal or addition that appear before that must stay to happen
> before the common context line (i.e. removal of 1 and 2, and
> addition of 5, both precede common context line "second") and any
> removal or addition that appear after that must stay after the
> common context (i.e. removal of "third" and addition of "the third
> item" come after "second").
> 
> But then it is not clear to me what you mean by "group" below.  What
> groups does the above example have?  Ones before the retained
> "second" (i.e. removal 1, 2, 4 and addition 5) form one group and
> ones after it (i.e. removal 4 and addition 7) form another group?

The code actually looks at the lines that are selected rather than
omitted. So in the example above it groups them as [1,2] (because they
are contiguous), [4],[5] (these are split because one is an insertion
and one a deletion) and [7]. It then sees that there are two groups of
deletions ([1,2],[4]) and two groups of insertions ([5],[7]) and so
pairs up the deletions in [12] with the insertion in [5] and likewise
with [4] and [7]. Lines 3 and 6 are never explicitly paired, although
they basically behave as if they were. One the insertions are all paired
up it walks over the list and creates a new hunk where the paired
insertions come immediately after their corresponding deletions,
unselected deletions are converted to context lines and unselected
additions are dropped.

> 
>> Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> 
> Is this fixing any bug?  I usually see "Reported-by" only for a
> bugfix patch but this seems to be adding a new feature (and lack of
> feature is usually not a bug).

I guess I meant that the previous series was effectively buggy as it
would give the wrong result for modified lines. I wanted to acknowledge
that Ævar spent some time testing it and pointed that out.

Best Wishes

Phillip

