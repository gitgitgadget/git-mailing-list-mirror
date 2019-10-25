Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B681F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 12:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410366AbfJYMrh (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 08:47:37 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:63498 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfJYMrh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 08:47:37 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Oct 2019 08:47:36 EDT
Received: from [84.175.189.53] (helo=[192.168.2.6])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iNyra-0003bl-2I; Fri, 25 Oct 2019 14:38:42 +0200
Subject: Re: [PATCH v2 1/1] vreportf: Fix interleaving issues, remove 4096
 limitation
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.407.git.1571755147.gitgitgadget@gmail.com>
 <pull.407.v2.git.1571755538.gitgitgadget@gmail.com>
 <54f0d6f6b53dd4fdd6e4129c942de8002459fd88.1571755538.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910251034110.46@tvgsbejvaqbjf.bet>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <e7002f76-65d3-607f-3b5a-e242938374f7@syntevo.com>
Date:   Fri, 25 Oct 2019 14:38:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910251034110.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Maybe this could do with an example?

I myself observed results like this when running t5516:
------
fatal: git fatal: remote errouploar: upload-pack: not our ref 
64ea4c133d59fa98e86a771eda009872d6ab2886d-pack: not o
ur ref 64ea4c133d59fa98e86a771eda009872d6ab2886
------

Do you want me to add this garbled string to commit message?

>> +static void replace_control_chars(char* str, size_t size, char replacement)

> So this is just factored out from `vreportf()`, right?

Yes.

>> +	buf = malloc(buf_size);

> Why not `alloca()`?

Allocating large chunks on stack is usually not recommended. There is a 
funny test "init allows insanely long --template" in t0001 which 
demonstrates that sometimes vreportf() can attempt to print very long 
strings. Crashing due to stack overflow doesn't sound like a good thing.

> And to take a step back, I think that previous rounds of patches trying
> to essentially address the same problem made the case that it is okay to
> cut off insanely-long messages, so I am not sure we would want to open
> that can of worms again...

I draw a different conclusion here. Each author thought that "1024 must 
definitely be enough!" but then discovered that it's not enough again, 
for example due to long "usage" output. At some point, f4c3edc0 even 
tried to remove all limits after a chain of limits that were too small. 
So I would say that this is still a problem.

> Quite honestly, I would love to avoid that amount of complexity,
> certainly in a part of the code that we would like to have rock solid
> because it is usually exercised when things go very, very wrong and we
> need to provide the user who is bitten by it enough information to take
> to the Git contributors to figure out the root cause(s).

It's a choice between simpler code and trying to account for everything 
that could happen. I think we'd rather have more complex code that 
handles more cases, exactly to try and deliver output to user no matter 
what.

> Is the problem that causes those failures with VS the fact that
> `fprintf(stderr, ...)` might be interleaved with the output of another
> process that _also_ wants to write to `stderr`? I assume that this _is_
> the problem.

This is where I started. But if you look at comment in vreportf_buf, 
there are more problems, such as interleaving blocks of larger messages, 
which could happen on any platform. I tried to make it work in most 
cases possible.

> Further, I guess that the problem is compounded by the fact that we
> usually run the tests in a Git Bash on Windows, i.e. in a MinTTY that
> emulates a console (there _is_ work under way to support the newly
> introduces ptys, but that work is far from done), so the standard error
> file handle might behave in unexpected ways in that scenario.

To my knowledge, this is not related. t5516 failures are because git 
explicitly wants stderr to be unbuffered. VC++ and MinGW runtimes take 
that literally. fprintf() outputs char-by-char, and all of that results 
in char-interleaving.

> But I do wonder whether replacing that `fprintf()` by a `write()` would
> work better. After all, we could write the `prefix` into the `msg`
> already:
> 
> 	size_t off = strlcpy(msg, prefix, sizeof(msg));
> 	int ret = vsnprintf(msg + off, sizeof(msg) - off, err, params);
> 	[...]
> 	if (ret > 0)
> 		write(2, msg, off + ret);
> 
> Would that also work around the problem?

You forgot to add '\'n. But yes, that would solve many problems, except 
truncation to 4096. Then I would expect a patch to increase buffer size 
to 8192 in the next couple years. And if you also try to solve 
truncation, it will get you very close to my code.
