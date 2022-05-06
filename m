Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC04EC433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 16:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443984AbiEFRA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 13:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443979AbiEFRAz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 13:00:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63FD6A072
        for <git@vger.kernel.org>; Fri,  6 May 2022 09:57:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8887411871D;
        Fri,  6 May 2022 12:57:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LKVj5UL8QMPdspbWQi+ffzcLo3Bd6BMsPZZK6v
        qals8=; b=hXyfoDBaamB2CRXn7/SCZAoiEZbmeZnM1oGCYZ6l6iuT7DPF+0dqZU
        ptuXTpLX0N9+J4orwAXI2ilwTTYqoTqNSk2sKsjkiE0U19oM8+1fsfcmgXL77yn0
        VK++URfR0SYm/xyDyqELMB+jKpj/+64MfzmGQVBLZZb4l8WCGF6oI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F212B11871C;
        Fri,  6 May 2022 12:57:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95E5711871B;
        Fri,  6 May 2022 12:57:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Chris Down <chris@chrisdown.name>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] bisect: output bisect setup status in bisect log
References: <cover.1651796862.git.chris@chrisdown.name>
        <acab8859d02c95750fdbc691ac672c17d5be0291.1651796862.git.chris@chrisdown.name>
        <YnSQDzhNjmu5ws4f@nand.local>
Date:   Fri, 06 May 2022 09:57:03 -0700
In-Reply-To: <YnSQDzhNjmu5ws4f@nand.local> (Taylor Blau's message of "Thu, 5
        May 2022 23:03:43 -0400")
Message-ID: <xmqq7d6yoazk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EFE9208-CD5D-11EC-BF2A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, May 06, 2022 at 01:52:54AM +0100, Chris Down wrote:
>> This allows seeing the current intermediate status without adding a new
>> good or bad commit:
>>
>>     $ git bisect log | tail -1
>>     # status: waiting for bad commit, 1 good commit known
>
> Hmm. I was worried that this would make it harder to turn the output of
> "git bisect log" into something you can inject into "git bisect replay
> <log>". But it doesn't, because you prefix the status lines with a '#'
> character.

;-) 

It has always been the basic design of "git bisect replay" since the
old days back when the command was scripted.  The log is designed to
be an executable shell script and we do not need to use "replay" at
all.

> I'm not totally convinced it _needs_ to live in "git bisect log",

It is a convenient place and other "helpful" comments are also
stored there, so the existing users may already know to look into it
to reorient where they were.

The original suggestion during the previous round of this series was
to come up with a way to help those who get lost during a long
session of spelunking the history to start bisection, like so:

 * start a bisection session
 * find one end (perhaps bad end)
 * say "git bisect bad $this" and be told "now go find a good one"
 * ran around various versions with "git reset --hard $that &&
   make" to see the other end (perhaps good end).
 * forget where they were---was it their turn to feed a good
   revision or bad revision?
 * "git bisect status" can be used to remind them that they were
   told "now go find a good one".

And I actually find that "go to log and see what progress you made
so far" as implemented in this series a far easier and scalable
solution than "git bisect status".  Next time we add more "here is
an extra piece of information to help reorient yourself", we do not
have to worry about how to present it in "git bisect status" output
(and we do not have to worry about teaching "bisect status"
subcommand about it in the first place).  As long as we make sure
that everybody uses the new "bisect_log_printf()" wrapper for
informational messages, we get it for free.

Thanks.
