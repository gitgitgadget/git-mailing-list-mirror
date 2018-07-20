Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5DD1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 13:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbeGTOBK (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 10:01:10 -0400
Received: from siwi.pair.com ([209.68.5.199]:24305 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731237AbeGTOBK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 10:01:10 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 263733F401D;
        Fri, 20 Jul 2018 09:12:56 -0400 (EDT)
Received: from [192.168.1.6] (8.sub-174-231-162.myvzw.com [174.231.162.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 10DD13F4015;
        Fri, 20 Jul 2018 09:12:54 -0400 (EDT)
Subject: Re: [RFC] push: add documentation on push v2
To:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>
References: <20180717210915.139521-1-bmwill@google.com>
 <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
 <a7c43308-a388-e307-6bea-47e6df74b65c@gmail.com>
 <CAGZ79kbLn-uwQOXfqhtO46v0EWevY43Tf4W5Rz9gDD9_qbmX=A@mail.gmail.com>
 <20180718171512.GC17137@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1dd6d9aa-0e96-bb8e-f7ae-873f619a2450@jeffhostetler.com>
Date:   Fri, 20 Jul 2018 09:12:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180718171512.GC17137@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/18/2018 1:15 PM, Brandon Williams wrote:
> On 07/18, Stefan Beller wrote:
>> On Wed, Jul 18, 2018 at 6:31 AM Derrick Stolee <stolee@gmail.com> wrote:
>>>
>>> On 7/17/2018 7:25 PM, Stefan Beller wrote:
>>>> On Tue, Jul 17, 2018 at 2:09 PM Brandon Williams <bmwill@google.com> wrote:
>>>>> Signed-off-by: Brandon Williams <bmwill@google.com>
>>>>> ---
>>>>>
>>>>> Since introducing protocol v2 and enabling fetch I've been thinking
>>>>> about what its inverse 'push' would look like.  After talking with a
>>>>> number of people I have a longish list of things that could be done to
>>>>> improve push and I think I've been able to distill the core features we
>>>>> want in push v2.
>>>> It would be nice to know which things you want to improve.
>>>
>>> Hopefully we can also get others to chime in with things they don't like
>>> about the existing protocol. What pain points exist, and what can we do
>>> to improve at the transport layer before considering new functionality?
>>
>> Another thing that I realized last night was the possibility to chunk requests.
>> The web of today is driven by lots of small http(s) requests. I know our server
>> team fights with the internal tools all the time because the communication
>> involved in git-fetch is usually a large http request (large packfile).
>> So it would be nice to have the possibility of chunking the request.
>> But I think that can be added as a capability? (Not sure how)
> 
> Fetch and push requests/responses are already "chunked" when using the
> http transport.  So I'm not sure what you mean by adding a capability
> because the protocol doesn't care about which transport you're using.
> This is of course unless you're talking about a different "chunking"
> from what it means to chunk an http request/response.
> 

Internally, we've talked about wanting to have resumable pushes and
fetches.  I realize this is difficult to do when the server is
replicated and the repeated request might be talking to a different
server instance.  And there's a problem with temp files littering the
server as it waits for the repeated attempt.  But still, the packfile
sent/received can be large and connections do get dropped.

That is, if we think about sending 1 large packfile and just using a
byte-range-like approach to resuming the transfer.

If we allowed the request to send a series of packfiles, with each
"chunk" being self-contained and usable.  So if a push connection was
dropped the server could apply the successfully received packfile(s)
(add the received objects and update the refs to the commits received so
far).  And ignore the interrupted and unreceived packfile(s) and let the
client retry later.  When/if the client retried the push, it would
renegotiate haves/wants and send a new series of packfile(s).  With the
assumption being that the server would have updated refs from the
earlier aborted push, so the packfile(s) computed for the second attempt
would not repeat the content successfully transmitted in the first
attempt.

This would require that the client build an ordered set of packfiles
from oldest to newest so that the server can apply them in-order and
the graph remain connected.  That may be outside your scope here.

Also, we might have to add a few messages to the protocol after the
negotiation, for the client to say that it is going to send the push
content in 'n' packfiles and send 'n' messages with the intermediate
ref values being updated in each packfile.

Just thinking out loud here.
Jeff
