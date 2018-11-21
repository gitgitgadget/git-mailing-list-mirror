Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F4E1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 20:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbeKVHcL (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 02:32:11 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:2114 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbeKVHcL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 02:32:11 -0500
Received: from [91.113.179.170] (helo=[192.168.92.26])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1gPZXe-0000tB-3M; Wed, 21 Nov 2018 21:56:10 +0100
Subject: Re: pathspec: problems with too long command line
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <c3be6eff-365b-96b8-16d2-0528612fc1fc@syntevo.com>
 <20181121132152.GA8246@sigill.intra.peff.net>
 <xmqq7eh67dqq.fsf@gitster-ct.c.googlers.com>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Message-ID: <8db810d2-5424-8833-c22f-5d9dfd77e3c5@syntevo.com>
Date:   Wed, 21 Nov 2018 21:56:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <xmqq7eh67dqq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21.11.2018 14:37, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Wed, Nov 21, 2018 at 10:23:34AM +0100, Marc Strapetz wrote:
>>
>>>  From our GUI client we are invoking git operations on a possibly large set
>>> of files. ...
>>> command line length, especially on Windows [1] and OSX [2]. To workaround
>>> this problem we are currently splitting up such operations by invoking
>>> multiple git commands. This works well for some commands (like add), but
>>> doesn't work well for others (like commit).
> 
>> Quite a few commands take --stdin, which can be used to send pathspecs
>> (and often other stuff) without size limits. I don't think either
>> "commit" or "add" does, but that might be another route.
> 
> A GUI client, like your server, should not be using end-user facing
> Porcelain commands like "add" and "commit" anyway.  In the standard
> "update-index" followed by "write-tree" followed-by "commit-tree"
> followed by "update-ref" sequence, the only thing that needs to take
> pathspec is the update-index step, and it already does take --stdin.

In our case it's a desktop client. We didn't consider using plumbing 
commands in general but only in cases where no appropriate high level 
commands exist. One reason for this decision was definitely a lack of 
our understanding in the beginning (which is no excuse anymore :). 
Another reason is that our users have quite frequently requested to see 
invoked Git commands, for their own understanding and learning. I think 
this argument remains valid. A third reason is to reduce process 
invocations. Although we are quite experienced Git users now, one final 
reason may be that it's still desirable to rely on additional validation 
in high level commands.

Summed up, I would prefer to find a solution which allows to stick with 
"git add"s, "git commit"s, "git checkout"s, ... and providing 
--stdin-paths alternatively to <pathspec> would be a good solution from 
a GUI client developer's perspective. I'm probably too biased to see 
whether it will be beneficial to standalone Git, too?

>> I'm slightly nervous at a pathspec that starts reading arbitrary files,
>> because I suspect there may be interesting ways to abuse it for services
>> which expose Git. E.g., if I have a web service which can show the
>> history of a file, I might take a $file parameter from the client and
>> run "git rev-list -- $file" (handling shell quoting, of course). That's
>> OK now, but with the proposed pathspec magic, a malicious user could ask
>> for ":(from-file=/etc/passwd)" or whatever.
> 
> In any case, I share your gut feeling that this should not be a
> magic pathspec, but should instead be "--stdin[-paths]", for command
> line parsing's sanity.  Catchng random strings that begin with
> double dash as fishy is much simpler and more robust than having to
> tell if a string that is a risky or a benign magic pathspec.

These are interesting points. Then --stdin[-paths] is definitely the 
better choice.

-Marc
