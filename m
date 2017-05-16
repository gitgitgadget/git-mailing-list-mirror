Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A9B01FAA8
	for <e@80x24.org>; Tue, 16 May 2017 18:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbdEPSfv (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 14:35:51 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:61952 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbdEPSfu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 14:35:50 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wS5jw2Xf4z5tlB;
        Tue, 16 May 2017 20:35:47 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D8DDD4308;
        Tue, 16 May 2017 20:35:46 +0200 (CEST)
Subject: Re: t5400 failure on Windows
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <50f6d8b7-383b-7673-22ad-9a9b80bec2d1@kdbg.org>
 <20170515222406.hxab2wrapv75ybmj@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <afca6bf5-472e-dda4-2c16-a2256080ac51@kdbg.org>
Date:   Tue, 16 May 2017 20:35:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170515222406.hxab2wrapv75ybmj@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.05.2017 um 00:24 schrieb Jeff King:
>    4. There is something racy and unportable about both programs writing
>       to the same trace file. It's opened with O_APPEND, which means that
>       each write should atomically position the pointer at the end of the
>       file. Is it possible there's a problem with that in the way
>       O_APPEND works on Windows?
> 
>       If that was the case, though, I'd generally expect a sheared write
>       or a partial overwrite. The two origin/HEAD lines from the two
>       programs are the exact same length, but I'd find it more likely for
>       the overwrite to happen with one of the follow-on lines.

Good guesswork! O_APPEND is not atomic on Windows, in particular, it is 
emulated as lseek(SEEK_END) followed by write().

I ran the test a few more times, and it fails in different ways 
(different missing lines) and also succeeds in a minority of the cases.

Windows is capable of writing atomically in the way O_APPEND requires 
(keyword: FILE_APPEND_DATA), but I do not see a way to wedge this into 
the emulation layer. For the time being, I think I have to skip the test 
case.

The question remains how endangered our uses of O_APPEND are when the 
POSIX semantics are not obeyed precisely:

* trace.c: It is about debugging. Not critical.

* sequencer.c: It writes the "done" file. No concurrent accesses are 
expected: Not critial.

* refs/files-backend.c: There are uses in functions 
open_or_create_logfile() and log_ref_setup(). Sounds like it is in 
reflogs. Sounds like this is about reflogs. If there are concurrent 
accesses, there is a danger that a reflog is not recorded correctly. 
Then reflogs may be missing and objects may be pruned earlier than 
expected. That's something to worry about, but I would not count it as 
mission critical.

-- Hannes
