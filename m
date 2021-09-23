Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06971C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E468161090
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242678AbhIWROa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:14:30 -0400
Received: from siwi.pair.com ([209.68.5.199]:21745 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242624AbhIWROW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 13:14:22 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F2FD33F40F3;
        Thu, 23 Sep 2021 13:12:49 -0400 (EDT)
Received: from WIN10-A.eucom.mil (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B954E3F40DA;
        Thu, 23 Sep 2021 13:12:49 -0400 (EDT)
Subject: Re: [PATCH v2 0/7] Builtin FSMonitor Part 1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
 <87v92r49mt.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0ec69aff-40a9-aac1-5fca-08033c967d88@jeffhostetler.com>
Date:   Thu, 23 Sep 2021 13:12:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87v92r49mt.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/23/21 10:33 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Sep 20 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> Here is V2 of Part 1 of my Builtin FSMonitor series.
>>
>> Changes since V1 include:
>>
>>   * Drop the Trace2 memory leak.
>>   * Added a new "child_ready" event to Trace2 as an alternative to the
>>     "child_exit" event for background processes.
>>   * Convert the Trace2-related NEEDSWORK items in "start_bg_command()" to use
>>     the new "child_ready" event.
>>   * Various minor code and documentation cleanups.
> 
> I see 7/7 still has a pattern you included only to make a compiler error
> better. I noted in
> https://lore.kernel.org/git/87ilyycko3.fsf@evledraar.gmail.com/ that it
> make the error worse, on at least clang. You didn't note which compiler
> you were massaging, presumably MSVC.
> 

I've been holding my tongue for days on this issue and hoping a third
party would step in an render an opinion one way or another.

Too me, a forward declaration seemed like no big deal and it does
have value as I tried to explain.  And frankly, it felt a little bit
like bike-shedding and was trying to avoid that again.


The error message I quoted was from Clang v11.0.3.  My forward
declaration of the function prior to the actual definition of
the function causes the compiler to stop at the function definition
and complain with a short message saying that the function itself
is incorrectly defined and doesn't match the typedef that it is
associated with.

When I use MSVC I get a similar error at the function definition.

When I use GCC I get error messages at both the function definition
and the usage in the call.


Additionally, the forward declaration states that the function is
associated with that typedef (something that is otherwise implicit
and may be hard to discover (more on that in a minute)).

And it doesn't require a reference to the function pointer (either
on the right side of an assignment, a vtable initialization, or passing
it in a function call) to flag the error.  We always get the error
at the point of the definition.


The error message in your example is, I feel, worse than mine.
It splats 2 different function signatures -- only one of which has
the typedef name -- in a large, poorly wrapped brick of text.

Yes, your error message does print corresponding arg in the function
prototype of "start_bg_command()" that doesn't agree with the symbol
used at the call-site, but that is much later than where the actual
error occurred.  And if the forward declaration were present, you'd
already know that back up at the definition, right.


Let's look at this from another point of view.

Suppose for example we have two function prototypes with the same
signature.  Perhaps they describe groups of functions with different
semantics -- the fact that they have the same argument list and return
type is just a coincidence.

     typedef int(t_fn_1)(int);
     typedef int(t_fn_2)(int);

And then declare one or more instances of functions in those groups:

     int foo_a(int x) { ... }
     int foo_b(int x) { ... }
     int foo_c(int x) { ... }
     int foo_d(int x) { ... }
     int foo_e(int x) { ... }
     int foo_f(int x) { ... }
     int foo_g(int x) { ... }

Which of those functions should be associated with "t_fn_1" and which
with "t_fn_2"?   Again, they all have the same signature, but different
semantics.  The author knows when they wrote the code, but it may be
hard to automatically determine later.

If I then have a function like start_bg_command() that receives a
function pointer:

     int test(..., t_fn_1 *fn, ...) { ... }

In C -- even with the use of forward function declarations -- the
compiler won't complain if you pass test() a pointer of type t_fn_2
-- as long a t_fn_1 and t_fn_2 have the same signature.

But it does give the human a chance to catch the error.  Of if we
later change the function signature in the t_fn_1 typedef, we will
automatically get a list of which of those foo_x functions do and
do not need to be updated.


Anyway, I've soapboxed on this enough.  I think it is a worthy
feature for the price.


Jeff
