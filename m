Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07698C4741F
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9964A20719
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbgKEVAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:00:49 -0500
Received: from siwi.pair.com ([209.68.5.199]:11979 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgKEVAt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:00:49 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A4B643F5FB6;
        Thu,  5 Nov 2020 16:00:47 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 803C83F5FAF;
        Thu,  5 Nov 2020 16:00:47 -0500 (EST)
Subject: Re: [PATCH v2 01/11] docs: new capability to advertise trace2 SIDs
To:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
References: <cover.1604006121.git.steadmon@google.com>
 <cover.1604355792.git.steadmon@google.com>
 <d04028c3c7574e3ca0f9c1b3d711192ca756158d.1604355792.git.steadmon@google.com>
 <xmqq5z6mqg60.fsf@gitster.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <634cf106-7bc2-e8fa-5745-5e2d26b50e14@jeffhostetler.com>
Date:   Thu, 5 Nov 2020 16:00:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq5z6mqg60.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/3/20 4:33 PM, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
>> +trace2-sid=<session-id>
>> +-----------------------
>> +
>> +If trace2 tracing is enabled on the server, it may advertise its session ID via
>> +this capability. The client may choose to log the server's session ID in its
>> +trace logs, and advertise its own session ID back to the server for it to log
>> +as well. This allows for easier debugging of remote sessions when both client
>> +and server logs are available.
>> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
>> index e597b74da3..a5b9ef04f6 100644
>> --- a/Documentation/technical/protocol-v2.txt
>> +++ b/Documentation/technical/protocol-v2.txt
>> @@ -492,3 +492,12 @@ form `object-format=X`) to notify the client that the server is able to deal
>>   with objects using hash algorithm X.  If not specified, the server is assumed to
>>   only handle SHA-1.  If the client would like to use a hash algorithm other than
>>   SHA-1, it should specify its object-format string.
>> +
>> +trace2-sid=<session-id>
>> +~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +If trace2 tracing is enabled on the server, it may advertise its session ID via
>> +this capability. The client may choose to log the server's session ID in its
>> +trace logs, and advertise its own session ID back to the server for it to log
>> +as well. This allows for easier debugging of remote sessions when both client
>> +and server logs are available.
> 
> Have we documented what a session-id should look like anywhere in
> the documentation?  This document is to help third-party to write
> implementations of the protocol, but the above description leaves
> things "implementation defined" a bit too much, I am afraid.
> 
> For example, as this must fit on a single pkt-line as an advertised
> capability, there would be some length limit.  Are there other
> inherent limitations due to our protocol?  Are there some artificial
> limitations that we may want to impose to make it easier to harden
> implementations against common mistakes?  For example are bytes in
> <session-id> allowed to contain LF, CR, NUL, etc.?
> 

The computed part of trace2 SIDs are relatively safe (both for length
and funky characters).  And funky characters are protected by JSON
encoding rules when writing to the GIT_TRACE2_EVENT target.

And I think the computed part would be safe in this context.
I've not seen commands that spawn more than about 6 levels of
child processes, and those would be fine here.

However, the opportunity to introduce a prefix as I suggested earlier
does offer the opportunity to introduce funky chars that would not
have any protection, so you may want to c-quote the string when
inserting it into the wire protocol.

     $ GIT_TRACE2_EVENT=1 GIT_TRACE2_PARENT_SID=hello git version
     {"event":"version","sid":"hello/20201030T154143.660608Z-H86606a97- 
P00001d30",...}
     ...

(Allowing the user to insert a prefix like that has been useful for
tracking control/experiment testing, so I wouldn't want to disable
it.)

Jeff
