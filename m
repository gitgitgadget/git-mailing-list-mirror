Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEBDC433E1
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177A0207BC
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406077AbgE1TBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:01:34 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:62652 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406018AbgE1TBb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:01:31 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 49Xxr62x7Gz5tlF;
        Thu, 28 May 2020 21:01:26 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8A04616AB;
        Thu, 28 May 2020 21:01:25 +0200 (CEST)
Subject: Re: git grep --show-function treats GOTO labels as function names
To:     Zach Riggle <zachriggle@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <CAMP9c5k=Ci8eQyOdzW7a-sssgp9g9TJ+rxAAPF3YLDCr7t6wrg@mail.gmail.com>
 <20200527224824.GA546534@coredump.intra.peff.net>
 <CAMP9c5=kRAfKqfWL4AJg1m9c-3OwG1Vv=vBaiOhsD6abjtXH=A@mail.gmail.com>
 <CAMP9c5m65hBXKgP76iUCGe79c_s5p106K6iwzJyPmm7fCsc7LA@mail.gmail.com>
 <20200527231628.GC546534@coredump.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <07f56d7a-45cc-2d28-ec48-51b95015550e@kdbg.org>
Date:   Thu, 28 May 2020 21:01:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527231628.GC546534@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.05.20 um 01:16 schrieb Jeff King:
> On Wed, May 27, 2020 at 06:04:21PM -0500, Zach Riggle wrote:
>> It looks like that does the trick for "goto" labels, but there are
>> also some issue on function name parsing with attributes when they are
>> split onto a second line.
>>
>> $ cat attr.cpp
>> int main() __attribute__ ( (no_sanitize("alignment")) )
>> {
>>     FOO
>> }
>> $ git grep --no-index --show-function -e FOO attr.cpp
>> attr.cpp=2=__attribute__ ( (no_sanitize("alignment")) )
>> attr.cpp:4:    FOO
> 
> From your output, I assume the problematic input actually splits the
> attribute onto the second line?
> 
> I agree that's not ideal. The baked-in regex we use for matching C
> function lines is:
> 
>   $ git grep -nA4 cpp userdiff.c
>   userdiff.c:173:PATTERNS("cpp",
>   userdiff.c-174-  /* Jump targets or access declarations */
>   userdiff.c-175-  "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:[[:space:]]*($|/[/*])\n"
>   userdiff.c-176-  /* functions/methods, variables, and compounds at top level */
>   userdiff.c-177-  "^((::[[:space:]]*)?[A-Za-z_].*)$",
> 
> so we mistake it for a function name. I'm not sure how easy it is to do
> better, though. We can add a line like:

C and C++ have a very versatile syntax and it turned out to be virtually
impossible to capture actual function definitions with a regex. See
8a2e8da367f7 ("userdiff: have 'cpp' hunk header pattern catch more C++
anchor points", 2014-03-21) for details.

With the current pattern, we catch probably 95% of the coding patterns
and coding styles. The style under discussion falls into the remaining
5% because continuation lines are not indented.

-- Hannes
