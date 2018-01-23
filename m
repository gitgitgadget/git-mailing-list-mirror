Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21191F404
	for <e@80x24.org>; Tue, 23 Jan 2018 19:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeAWTNA (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 14:13:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54524 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeAWTNA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 14:13:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D023C691A;
        Tue, 23 Jan 2018 14:12:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4vfJp5hHS6mBKZbtYvjAA6/MEG4=; b=kp0aq7
        D+tWn37kxPF1DfsHEuEnNLkOisov+fSMWDU9Dq0JmQYk98WdSPQQdBoHKNpJybLt
        yUolYX+S0YrUcjMKsoh5CASjW2b/NK4R9pAvq6RiMB2O64sUzGZGcaIgNJMrYOcX
        NtNkX5KQ3uqBPtlWwMTglaP5/xCjdVnvKJfJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bG6s1XYMeL7ntbzcV3gxrLSJi32Zq5Fu
        Ztm4dwEkuvTts8ZtbS1UR1H4ax/bGQ0FG14AlbNhhXbq9QUFTOq4zILd2ni/Au/l
        WmHO8cQMzYnwtpWduZ4iO/h88N3PKppEOPkAAT2aNlshaduPXjsxor5XJXQlhGa3
        ZBpmcwMOzAQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 654BAC6919;
        Tue, 23 Jan 2018 14:12:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1D49C6916;
        Tue, 23 Jan 2018 14:12:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/8] sequencer: fast-forward merge commits, if possible
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <9878bd57cc82daf08309943305460c1e8a050518.1516225925.git.johannes.schindelin@gmx.de>
        <7e6906c9-d642-ee8d-82fd-29ee6c60e308@talktalk.net>
Date:   Tue, 23 Jan 2018 11:12:57 -0800
In-Reply-To: <7e6906c9-d642-ee8d-82fd-29ee6c60e308@talktalk.net> (Phillip
        Wood's message of "Fri, 19 Jan 2018 14:53:09 +0000")
Message-ID: <xmqqr2qggzie.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CA39040-0071-11E8-A67B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> On 18/01/18 15:35, Johannes Schindelin wrote:
>> 
>> Just like with regular `pick` commands, if we are trying to recreate a
>> merge commit, we now test whether the parents of said commit match HEAD
>> and the commits to be merged, and fast-forward if possible.
>> 
>> This is not only faster, but also avoids unnecessary proliferation of
>> new objects.
>
> I might have missed something but shouldn't this be checking opts->allow_ff?

Because the whole point of this mechanism is to recreate the
topology faithfully to the original, even if the original was a
redundant merge (which has a side parent that is an ancestor or a
descendant of the first parent), we should just point at the
original merge when the condition allows it, regardless of
opts->allow_ff.

I think it is a different matter if an insn to create a new merge
(i.e. "merge - <parent> <message>", not "merge <commit> <parent>")
should honor opts->allow_ff; because it is not about recreating an
existing history but is a way to create what did not exist before,
I think it is sensible if allow_ff option is honored.

