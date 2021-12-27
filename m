Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC42C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 19:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhL0Tco (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 14:32:44 -0500
Received: from siwi.pair.com ([209.68.5.199]:36401 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232178AbhL0Tcn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 14:32:43 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F02B13F4163;
        Mon, 27 Dec 2021 14:32:42 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 170AA3F4107;
        Mon, 27 Dec 2021 14:32:42 -0500 (EST)
Subject: Re: [RFC PATCH 19/21] usage API: use C99 macros for
 {usage,usagef,die,error,warning,die}*()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
 <RFC-patch-19.21-0bbca8cca8e-20211115T220831Z-avarab@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <66b25f23-7349-1540-76b8-c9f0a64660ac@jeffhostetler.com>
Date:   Mon, 27 Dec 2021 14:32:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <RFC-patch-19.21-0bbca8cca8e-20211115T220831Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/15/21 5:18 PM, Ævar Arnfjörð Bjarmason wrote:
[...]
> 
> It might be a good change to remove the "fmt" key from the "error"
> events as a follow-up change. As these few examples from running the
> test suite show it's sometimes redundant (same as the "msg"), rather
> useless (just a "%s"), or something we could now mostly aggregate by
> file/line instead of the normalized printf format:
> 
>        1 file":"builtin/gc.c","line":1391,"msg":"'bogus' is not a valid task","fmt":"'%s' is not a valid task"}
>        1 file":"builtin/for-each-ref.c","line":89,"msg":"format: %(then) atom used more than once","fmt":"%s"}
>        1 file":"builtin/fast-import.c","line":411,"msg":"Garbage after mark: N :202 :302x","fmt":"Garbage after mark: %s"}
> 
> "Mostly" here assumes that it would be OK if the aggregation changed
> between git versions, which may be what all users of trace2 want. The
> change that introduced the "fmt" code was ee4512ed481 (trace2: create
> new combined trace facility, 2019-02-22), and the documentation change
> was e544221d97a (trace2: Documentation/technical/api-trace2.txt,
> 2019-02-22).
> 
> Both are rather vague on what problem "fmt" solved exactly, aside from
> the obvious one of it being impossible to do meaningful aggregations
> due to the "file" and "line" being the same everywhere, which isn't
> the case now.
> 
> In any case, let's leave "fmt" be for now, the above summary was given
> in case it's interesting to remove it in the future, e.g. to save
> space in trace2 payloads.

I added the "fmt" field so that we could do aggregations
of error messages across multiple users without regard
to what branch or filename or percentage or whatever was
formatted into the actual "msg" written to stderr.

The actual file:line wasn't useful (primarily because it
was probably something in usage.c), but even if we fix that
it might not be useful if we have users running 10 different
versions of Git (because some people don't upgrade immediately).

So I'd rather not kill it right now.

Jeff

