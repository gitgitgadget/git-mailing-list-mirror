Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B928AC04E69
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 13:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjHNNJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjHNNJS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 09:09:18 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6375FE77
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 06:09:17 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B6E2CCA1257;
        Mon, 14 Aug 2023 09:09:15 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:702a:e6ee:ceb9:5ed8] (unknown [IPv6:2600:1700:840:e768:702a:e6ee:ceb9:5ed8])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 584C8CC8389;
        Mon, 14 Aug 2023 09:09:15 -0400 (EDT)
Message-ID: <2a347112-aaa8-d8ef-5919-dc66730af593@jeffhostetler.com>
Date:   Mon, 14 Aug 2023 09:09:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Splitting common-main (Was: Re: [PATCH RFC v2 1/4] common-main:
 split common_exit() into a new file)
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        calvinwan@google.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        sandals@crustytoothpaste.net
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <20230517-unit-tests-v2-v2-1-21b5b60f4b32@google.com>
 <xmqqcz2xtv83.fsf@gitster.g> <ZLHcaFvvZh88TrLb@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <ZLHcaFvvZh88TrLb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/14/23 7:38 PM, Josh Steadmon wrote:
> Hi, I'd like to revisit this as it's also relevant to a non-unit-test
> issue (`make fuzz-all` is currently broken). I have some questions
> inline below:
> 
> On 2023.05.18 10:17, Junio C Hamano wrote:
>> steadmon@google.com writes:
>>
>>> It is convenient to have common_exit() in its own object file so that
>>> standalone programs may link to it (and any other object files that
>>> depend on it) while still having their own independent main() function.
>>
>> I am not so sure if this is a good direction to go in, though.  The
>> common_exit() function does two things that are very specific to and
>> dependent on what Git runtime has supposed to have done, like
>> initializing trace2 subsystem and linking with usage.c to make
>> bug_called_must_BUG exist.
> 
> True. We won't call common_exit() unless we're trying to exit() from a
> file that also includes git-compat-util.h, but I guess that's not a
> guarantee that trace2 is initialized or that usage.o is linked.
> 
>> I understand that a third-party or standalone non-Git programs may
>> want to do _more_ than what our main() does when starting up, but it
>> should be doable if make our main() call out to a hook function,
>> whose definition in Git is a no-op, that can be replaced by their
>> own implementation to do whatever they want to happen in main(), no?
>>
>> The reason why I am not comfortable with this patch is because I
>> cannot say why this split is better than other possible split.  For
>> example, we could instead split only our 'main' out to a separate
>> file, say "main.c", and put main.o together with common-main.o to
>> libgit.a to be found by the linker, and that arrangement will also
>> help your "standalone programs" having their own main() function.
>> Now with these two possible ways to split (and there may be other
>> split that may be even more convenient; I simply do not know), which
>> one is better, and what's the argument for each approach?
> 
> Sorry, I don't think I'm understanding your proposal here properly,
> please let me know where I'm going wrong: isn't this functionally
> equivalent to my patch, just with different filenames? Now main() would
> live in main.c (vs. my common-main.c), while check_bug_if_BUG() and
> common_exit() would live in common-main.c (now a misnomer, vs. my
> common-exit.c). I'm not following how that changes anything so I'm
> pretty sure I've misunderstood.
> 
> The issue I was trying to solve (whether for a unit-test framework or
> for the fuzzing engine) is that we don't have direct control over their
> main(), and so we can't rename it to avoid conflicts with our main().
> 
> I guess there may be some linker magic we could do to avoid the conflict
> and have (our) main() call (their, renamed) main()? I don't know offhand
> if that's actually possible, just speculating. Even if possible, it
> feels more complicated to me, but again that may just be due to my lack
> of linker knowledge.


I missed the original discussion and am definitely late to the party,
but an FYI there is also a `wmain()` in `compat/mingw.c` that is used
for MSVC builds on Windows.  It sets up some OS process stuff before
calling the actual `main()`.

Jeff
