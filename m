Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A4C91F404
	for <e@80x24.org>; Mon, 26 Mar 2018 17:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeCZRBx (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 13:01:53 -0400
Received: from siwi.pair.com ([209.68.5.199]:50073 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751964AbeCZRBw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 13:01:52 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C18543F4085;
        Mon, 26 Mar 2018 13:01:51 -0400 (EDT)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 775083F4017;
        Mon, 26 Mar 2018 13:01:51 -0400 (EDT)
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
To:     Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Cc:     jeffhost@microsoft.com, Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1521779249.git.wink@saville.com>
 <cover.1521839546.git.wink@saville.com>
 <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com>
 <xmqq7eq2h0wa.fsf@gitster-ct.c.googlers.com>
 <CAKk8isoJQrikitO7ezRajgphUXYR6207k4UkXP6r57WJEFBaDA@mail.gmail.com>
 <CAKk8ispSgNgZxS7KfuOyxfU53tzesvNyLRaNXFZa3K7SCbaRkQ@mail.gmail.com>
 <xmqqzi2ude4w.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9ca76d31-828d-0b6f-5069-375792c1f55d@jeffhostetler.com>
Date:   Mon, 26 Mar 2018 13:01:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqzi2ude4w.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/26/2018 11:56 AM, Junio C Hamano wrote:
> Wink Saville <wink@saville.com> writes:
> 
>> json-writer.c:123:38:  error:  format specifies type 'uintmax_t' (aka
>> 'unsigned long') but the argument has type 'uint64_t' (aka 'unsigned
>> long long') [-Werror,-Wformat]
>>
>>          strbuf_addf(&jw->json, ":%"PRIuMAX, value);
>>                                   ~~         ^~~~~
>> json-writer.c:228:37:  error:  format specifies type 'uintmax_t' (aka
>> 'unsigned long') but the argument has type 'uint64_t' (aka 'unsigned
>> long long') [-Werror,-Wformat] [0m
>>
>>          strbuf_addf(&jw->json, "%"PRIuMAX, value);
>>                                   ~~         ^~~~~
>> 2 errors generated.
>> make: *** [json-writer.o] Error 1
>> make: *** Waiting for unfinished jobs....
> 
> For whatever reason, our codebase seems to shy away from PRIu64,
> even though there are liberal uses of PRIu32.  Showing the value
> casted to uintmax_t with PRIuMAX seems to be our preferred way to
> say "We cannot say how wide this type is on different platforms, and
> are playing safe by using widest-possible int type" (e.g. showing a
> pid_t value from daemon.c).
> 
> In this codepath, the actual values are specified to be uint64_t, so
> the use of PRIu64 may be OK, but I have to wonder why the codepath
> is not dealing with uintmax_t in the first place.  When even larger
> than present archs are prevalent in N years and 64-bit starts to
> feel a tad small (like we feel for 16-bit ints these days), it will
> feel a bit silly to have a subsystem that is limited to such a
> "fixed and a tad small these days" types and pretend it to be be a
> generic seriealizer, I suspect.
> 

I defined that routine to take a uint64_t because I wanted to
pass a nanosecond value received from getnanotime() and that's
what it returns.

My preference would be to change the PRIuMAX to PRIu64, but there
aren't any other references in the code to that symbol and I didn't
want to start a new trend here.

I am concerned that the above compiler error message says that uintmax_t
is defined as an "unsigned long" (which is defined as *at least* 32 bits,
but not necessarily 64.  But a uint64_t is defined as a "unsigned long long"
and guaranteed as a 64 bit value.

So while I'm not really worried about 128 bit integers right now, I'm
more concerned about 32 bit compilers truncating that value without any
warnings.

Jeff

