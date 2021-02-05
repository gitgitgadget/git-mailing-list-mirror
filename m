Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74107C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 07:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1351F64F9B
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 07:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhBEH73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 02:59:29 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:10606 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230515AbhBEH71 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 02:59:27 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4DX78g2RtSz5tlS;
        Fri,  5 Feb 2021 08:58:43 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id BF4DF4B8D;
        Fri,  5 Feb 2021 08:58:42 +0100 (CET)
Subject: Re: [PATCH v2 4/5] pager: properly log pager exit code when signalled
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20210201144921.8664-1-avarab@gmail.com>
 <20210202020001.31601-5-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5f5c5018-9fcc-6a9f-66fc-81d1c09946c3@kdbg.org>
Date:   Fri, 5 Feb 2021 08:58:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202020001.31601-5-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.02.21 um 03:00 schrieb Ævar Arnfjörð Bjarmason:
> When git invokes a pager that exits with non-zero the common case is
> that we'll already return the correct SIGPIPE failure from git itself,
> but the exit code logged in trace2 has always been incorrectly
> reported[1]. Fix that and log the correct exit code in the logs.

There's a more severe problem here, not with your patch, but with trace2
in general: it invokes async-signal-unsafe functions from a signal
handler, in particular, realloc, vsnprintf, gettimeofday, localtime_r
(and probably a lot more) via fn_child_exit_fl of trace2/tr2_tgt_normal.c

Is that something that we should care about?

-- Hannes
