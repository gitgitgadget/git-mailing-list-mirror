Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD85C001DB
	for <git@archiver.kernel.org>; Sun, 13 Aug 2023 08:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjHMIWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Aug 2023 04:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHMIWn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2023 04:22:43 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFF212E
        for <git@vger.kernel.org>; Sun, 13 Aug 2023 01:22:45 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 246ED240E6;
        Sun, 13 Aug 2023 04:22:42 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qV6Mz-C4b-00; Sun, 13 Aug 2023 10:22:41 +0200
Date:   Sun, 13 Aug 2023 10:22:41 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] format-patch: add --description-file option
Message-ID: <ZNiS0TrN0mYD6N97@ugly>
References: <xmqqttta9h6a.fsf@gitster.g>
 <20230809171530.2564724-1-oswald.buddenhagen@gmx.de>
 <xmqq1qg9qmyq.fsf@gitster.g>
 <ZNa2VQQzZmaMzM4C@ugly>
 <xmqq7cq0oelh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq7cq0oelh.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 12, 2023 at 01:21:46AM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> On Fri, Aug 11, 2023 at 02:38:05PM -0700, Junio C Hamano wrote:
>>>> +	if (strbuf_read_file(buf, desc_file, 2000) < 0)
>>>
>>>You would probably want to do "2000" -> "0" here.
>>>
>> hmm, yeah, i wonder where i got it from, given that there is no
>> precedent. i suppose i simply thought that 2k is a reasonably
>> expectable max size for a description. if you think the default 8k
>> hint is a better idea, then let's go with it.
>
>The suggestion was not about 2000 vs 8kiB,
>
i know. i just mentioned the default for reference. it seems "severely" 
oversized for the task - not that it would actually matter.

>though it seems we stick
>to power of 2 everywhere we are explicit.  Unless we know the exact
>size from .st_size, that is.
>
>It was primarily about this code not having any need to express its
>own preference and go with whatever is the default.
>
arguably, just about every other instance which uses a fixed hint 
doesn't need to, yet some of them do. it's somewhat obvious in the case 
of "tiny" hints, but there are also some cases of 1k. and the 
sequencer's do_commit() uses 2k for the message file, which is "a funny 
coincidence".
so i wonder whether there is some standard to go by.

>> that's a good point. in fact, passing in the description directly
>> would probably fit my use case better ... i just happened to already
>> have the code for creating that temp file anyway (for editing), so i
>> didn't give it a second thought. i can add both options in the same
>> go, given that it's almost no code.
>
>One thing that you may have to be careful about, if you also take
>strings directly from the command line, is what to do with multiple
>of them.  "git commit -m A -m B" that makes A and B separate
>paragraphs with a break between them, I would think, would serve as
>a good model that end-users already understand well.
>
no worries about that, i'd just copy from commit anyway.

however, this points out a potential problem, which makes me have second 
thoughts about my use case ... i would want to pass the entire contents 
in one argument, newlines and quotes included. i know that this is 
inherently ok on unix, but i wonder whether it would work reliably on 
windows (the wrapper script is written in perl)?

regards

