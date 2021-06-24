Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C479C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 21:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CCB6124C
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 21:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhFXVco (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 17:32:44 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:12054 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhFXVcn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 17:32:43 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4G9tb00TKvz5tl9;
        Thu, 24 Jun 2021 23:30:19 +0200 (CEST)
Subject: Re: Why the Makefile is so eager to re-build & re-link
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <874kdn1j6i.fsf@evledraar.gmail.com>
 <YNSh0CskelTwuZq0@coredump.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fb23a23e-13be-14a8-4fbe-5ca2b4bcdb52@kdbg.org>
Date:   Thu, 24 Jun 2021 23:30:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YNSh0CskelTwuZq0@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.06.21 um 17:16 schrieb Jeff King:
> On Thu, Jun 24, 2021 at 03:16:48PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>  * {command,config}-list.h (and in-flight, my hook-list.h): Every time
>>    you touch a Documentation/git-*.txt we need to re-generate these, and
>>    since their mtime changes we re-compile and re-link all the way up to
>>    libgit and our other tools.
>>
>>    I think the best solution here is to make the generate-*.sh
>>    shellscripts faster (just one takes ~300ms of nested shellscripting,
>>    just to grep out the first few lines of every git-*.txt, in e.g. Perl
>>    or a smarter awk script this would be <5ms).
> 
> Yeah, I think Eric mentioned he had looked into doing this in perl, but
> we weren't entirely happy with the dependency. Here's another really odd
> thing I noticed:
> 
>   $ time sh ./generate-cmdlist.sh command-list.txt >one
>   real	0m1.323s
>   user	0m1.531s
>   sys	0m0.834s
> 
>   $ time sh -x ./generate-cmdlist.sh command-list.txt >two
>   [a bunch of trace output]
>   real	0m0.513s
>   user	0m0.754s
>   sys	0m0.168s
> 
>   $ cmp one two
>   [no output]
> 
> Er, what? Running with "-x" makes it almost 3 times faster to generate
> the same output? I'd have said this is an anomaly, but it's repeatable
> (and swapping the order produces the same output, so it's not some weird
> priming thing). And then to top it all off, redirecting the trace is
> slow again:
> 
>   $ time sh -x ./generate-cmdlist.sh command-list.txt >two 2>/dev/null
>   real	0m1.363s
>   user	0m1.538s
>   sys	0m0.902s
> 
> A little mini-mystery that I think I may leave unsolved for now.

Strange, really. Reminds me of the case that the `read` built-in must
read input byte by byte if stdin is not connected to a (searchable) file.

I have two patches that speed up generate-cmdlist.sh a bit:

generate-cmdlist.sh: replace for loop by printf's auto-repeat feature
(https://github.com/j6t/git/commit/b6d05f653bede727bc001f299b57969f62d3bc03)
generate-cmdlist.sh: spawn fewer processes
(https://github.com/j6t/git/commit/fd8721ee8fae06d7b584fa5166f32bf5521ca304)

that I can submit (give me some time, though) or interested parties
could pick up.

-- Hannes
