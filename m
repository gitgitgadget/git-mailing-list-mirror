Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A0F71F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 14:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389190AbfJ2OVm (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 10:21:42 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.29]:18158 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfJ2OVl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 10:21:41 -0400
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iPSNN-00014B-96; Tue, 29 Oct 2019 15:21:37 +0100
Subject: Re: [PATCH v2 1/1] vreportf(): avoid relying on stdio buffering
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com>
 <pull.428.v2.git.1572356272.gitgitgadget@gmail.com>
 <e426627e1494e31e548fe044c1c1806ff59340cf.1572356272.git.gitgitgadget@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <1a6119b4-b44f-0edd-da18-46b7d31a274f@syntevo.com>
Date:   Tue, 29 Oct 2019 15:21:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e426627e1494e31e548fe044c1c1806ff59340cf.1572356272.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.10.2019 14:37, Johannes Schindelin via GitGitGadget wrote:

 > -	vsnprintf(msg, sizeof(msg), err, params);
 > -	for (p = msg; *p; p++) {
 > +	p = msg + off < pend ? msg + off : pend - 1;

According to my understanding, this is undefined behavior:

http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2011/n3242.pdf
... Unless both pointers point to elements of the same array object, or 
one past the last element of the array object, the behavior is undefined.

 > The MSVC runtime behavior differs from glibc's with respect to
 > `fprintf(stderr, ...)` in that the former writes out the message
 > character by character.

Can you please preserve the research text about fprintf() behavior on 
different platforms that I provided before? Change formatting to what 
you think fits best.

fprintf() has problems with any buffering settings
--------------------------------------------------
1) If `stderr` is fully buffered:
    the ordering of `stdout` and `stderr` messages could be wrong,
    because `stderr` output waits for the buffer to become full.
2) If `stderr` has any type of buffering:
    buffer has fixed size, which could lead to interleaved buffer blocks
    when two threads/processes write at the same time.
3) If `stderr` is not buffered:
    Some implementations, such as VC++ and MinGW, literally disable
    buffering and `fprintf()` will output char-by-char, which leads to
    unreadable char-interleaved writes if two processes write to
    `stderr` at the same time (threads are OK because `fprintf()`
    usually locks `FILE*` in current process).
4) If stderr is line buffered: MinGW/VC++ will enable full buffering
    instead. See MSDN for `setvbuf()`.

fprintf() behavior in git, per platform
---------------------------------------
1) libc - large outputs can be block-interleaved
    fprintf() enables temporary stream buffering.
    Code references:
        buffered_vfprintf()
2) VC++ - char-interleaved
    fprintf() enables temporary stream buffering, but only if stream was
    not set to no buffering. This has no effect, because stderr is not
    buffered by default, and git takes an extra step to ensure that in
    `swap_osfhnd()`.
    Code references:
        _iob[_IOB_ENTRIES]
        __acrt_stdio_temporary_buffering_guard
        has_any_buffer()
3) MinGW - char-interleaved (console), full buffering (file)
    `fprintf()` obeys `stderr` buffering. But it uses old MSVCRT.DLL,
    which eventually calls `_flsbuf()`, which enables buffering unless
    `isatty(stderr)` or buffering is disabled. Buffering is not disabled
    by default for `stderr`. Therefore, buffering is enabled only for
    file-redirected `stderr`.
    Code references:
        __mingw_vfprintf()
        __pformat_wcputs()
        _fputc_nolock()
        _flsbuf()
        _iob[_IOB_ENTRIES]

