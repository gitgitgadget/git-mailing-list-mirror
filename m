Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21613C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD1660C3D
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhETPLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:11:08 -0400
Received: from siwi.pair.com ([209.68.5.199]:39349 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232020AbhETPLH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:11:07 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 849553F4139;
        Thu, 20 May 2021 11:09:45 -0400 (EDT)
Received: from MININT-MG8E6GJ.fareast.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4E4053F40B7;
        Thu, 20 May 2021 11:09:45 -0400 (EDT)
Subject: Re: RFC: error codes on exit
To:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <YKWggLGDhTOY+lcy@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <795fd316-2bb5-e382-b104-85d1aaa09a1c@jeffhostetler.com>
Date:   Thu, 20 May 2021 11:09:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YKWggLGDhTOY+lcy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/19/21 7:34 PM, Jonathan Nieder wrote:
> Hi,
> 
> (Danger, jrn is wading into error handling again...)
> 
> At $DAYJOB we are setting up some alerting for some bot fleets and
> developer workstations, using trace2 as the data source.  Having
> trace2 has been great --- combined with gradual weekly rollouts of
> "next", it helps us to understand quickly when a change is creating a
> regression for users, which hopefully improves the quality of Git for
> everyone.
> 
> One kind of signal we haven't been able to make good use of is error
> rates.  The problem is that a die() call can be an indication of
> 
>   a. the user asked to do something that isn't sensible, and we kindly
>      rebuked the user
> 
>   b. we contacted a server, and the server was not happy with our
>      request
> 
>   c. the local Git repository is corrupt
> 
>   d. we ran out of resources (e.g., disk space)
> 
>   e. we encountered an internal error in handling the user's
>      legitimate request
...

For the error event that `error()` and `die()` and friends generate,
I emit both the fully formatted error message and the format string.

The latter, if used as a dictionary key, would let you group like
events from different processes without worrying about the filename
or blob id or remote name or etc. in any one particular instance.

Would that be sufficient as an error classification and something
that you can key off of in your post-processing ?

Granted the same format message might be used in multiple places in
the source, but I also provide the source filename and line number.

If it turns out that all of the error events come from "usage.c"
(i.e. error_builtin() or die_builtin()), then maybe we need to look
at another way of wrapping those calls to pass the F/L of actual
caller.  I hesitated to do that because of the existing indirection
tricks in usage.c WRT the `set_error_routine()` and friends.
(And that assumes that the format string is a viable solution for
you problem.)

Jeff

