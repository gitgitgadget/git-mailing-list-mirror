Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5897520756
	for <e@80x24.org>; Sun, 15 Jan 2017 10:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751026AbdAOKGX (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 05:06:23 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:30961 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdAOKGW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 05:06:22 -0500
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v0FA6CpG009808
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Jan 2017 10:06:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v0FA6Bei006042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Jan 2017 10:06:12 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v0FA6Au8018091;
        Sun, 15 Jan 2017 10:06:11 GMT
Received: from [10.175.174.109] (/10.175.174.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 15 Jan 2017 02:06:10 -0800
Subject: Re: [PATCH 2/3] xdiff: -W: include immediately preceding non-empty
 lines in context
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
 <1484324112-17773-2-git-send-email-vegard.nossum@oracle.com>
 <e55dc4dd-768b-8c9b-e3b2-e850d5d521f5@web.de>
 <xmqqeg06hh6z.fsf@gitster.mtv.corp.google.com>
 <c74c260d-1a4d-39f6-a644-4f90a67d6d82@oracle.com>
 <xmqqbmvaecpl.fsf@gitster.mtv.corp.google.com>
 <48bdfd94-2fd4-bd55-d78b-2877e195fb82@web.de>
 <xmqqy3ydcaia.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <0c761135-2696-4b3d-0a4f-3d90edf5da2e@oracle.com>
Date:   Sun, 15 Jan 2017 11:06:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqy3ydcaia.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/01/2017 03:39, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
>
>>> I am also more focused on keeping the codebase maintainable in good
>>> health by making sure that we made an effort to find a solution that
>>> is general-enough before solving a single specific problem you have
>>> today.  We may end up deciding that a blank-line heuristics gives us
>>> good enough tradeoff, but I do not want us to make a decision before
>>> thinking.

You are right; I appreciate this approach.

>> How about extending the context upward only up to and excluding a line
>> that is either empty *or* a function line?  That would limit the extra
>> context to a single function in the worst case.
>>
>> Reducing context at the bottom with the aim to remove comments for the
>> next section is more tricky as it could remove part of the function
>> that we'd like to show if we get the boundary wrong.  How bad would it
>> be to keep the southern border unchanged?
>
> I personally do not think there is any robust heuristic other than
> Vegard's "a blank line may be a signal enough that lines before that
> are not part of the beginning of the function", and I think your
> "hence we look for a blank line but if there is a line that matches
> the function header, stop there as we know we came too far back"
> will be a good-enough safety measure.
>
> I also agree with you that we probably do not want to futz with the
> southern border.

You are right, trying to change the southern border in this way is not
quite reliable if there are no empty lines whatsoever and can
erroneously cause the function context to not include the bottom of the
function being changed.

I'm splitting the function boundary detection logic into separate
functions and trying to solve the above case without breaking the tests
(and adding a new test for the above case too).

I'll see if I can additionally provide some toggles (flags or config
variables) to control the new behaviour, what I had in mind was:

   -W[=preamble,=no-preamble]
   --function-context[=preamble,=no-preamble]
   diff.functionContextPreamble = <bool>

(where the new logic is controlled by the new config variable and
overridden by the presence of =preamble or =no-preamble).

Then it also shouldn't be too difficult to add

   diff.<driver>.preamble = <regex>
   diff.<driver>.xpreamble = <regex>

to override the heuristic used for function border detection in
exceptional cases.

You can argue about the naming now ;-) But I will use this for a start,
renaming/reworking it (or throwing it away) afterwards should be easy
once the code has been written.


Vegard
