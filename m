Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C4DF1F406
	for <e@80x24.org>; Fri, 12 Jan 2018 18:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964994AbeALSYc (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 13:24:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50677 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964862AbeALSYb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 13:24:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0621D4465;
        Fri, 12 Jan 2018 13:24:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eZanK710sAn1EtQJYD3fPuQWdkY=; b=hcvqll
        VDw5jpNd8oUz4YirVREAgJ/hFc2ooWvzumlZ89XzTtokyL7l1/hf4v63XKLIvmvk
        c1sJGoZ4sBvqDBaDc4TfgVt/xEwv8nrkaGDQ47vjzPT6hG8oVBoEmeI4hy4QIdmj
        9sxGgwEXp/qulyJQFsvHnKm3WuBEcph75dCrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fg0kPvOZ4L5n9iEMUUOAumJmXXdwEdKN
        3lE4QWYqMHu+UCHo387XaI5RISScQiaGMOnsSefvWEwhpByOQ9f5dTwGEfMRBzJn
        OY1/L6q7hB8j4ihNV4v5djT7i9xKRephFxqB6azHwiyOtvvJeak0nIFQzEHzfWGY
        Snfh+6MMufo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5C78D4463;
        Fri, 12 Jan 2018 13:24:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 694CBD4462;
        Fri, 12 Jan 2018 13:24:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 4/4] trace.c: be smart about what env to print in trace_run_command()
References: <20180111094712.2551-1-pclouds@gmail.com>
        <20180112095607.18293-1-pclouds@gmail.com>
        <20180112095607.18293-5-pclouds@gmail.com>
        <20180112133355.GE27499@sigill.intra.peff.net>
Date:   Fri, 12 Jan 2018 10:24:28 -0800
In-Reply-To: <20180112133355.GE27499@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 12 Jan 2018 08:33:55 -0500")
Message-ID: <xmqqpo6fvstf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4890096-F7C5-11E7-8219-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +		/*
>> +		 * Do we have a sequence of "unset GIT_DIR; GIT_DIR=foo"?
>> +		 * Then don't bother with the unset thing.
>> +		 */
>> +		if (i + 1 < envs.nr &&
>> +		    !strcmp(env, envs.items[i + 1].string))
>>  			continue;
>
> Are we guaranteed that "FOO" and "FOO=bar" appear next to each other in the
> sorted list? I think "FOO123=bar" could come between.

At this point, envs is a string list whose key is FOO for both "FOO"
(unset) and "FOO=bar" (set); "FOO123=bar" would sort after these two.

But I did not see anything that attempts to guarantee that "FOO"
sorts before "FOO=bar" with string_list_sort().  If the sort used in
the function is stable, and if the case we care about is unset
followed by set, then the above would catch the case, but even if
that were the case, it is unclear what we want to do when a set of
FOO is followed by an unset of FOO.

And if the sort is not stable, then the above code is just simply
broken.

> I also think this is a special case of a more general problem. FOO could
> appear any number of times in the "env" array, as a deletion or with
> multiple values. Our prep_childenv() would treat that as "last one
> wins", I think. Could we just do the same here?

Yeah, if the last one is to set FOO=bar, then it feels sufficient to
just check if FOO is set to bar in the original and deciding to show
or hide; similarly if the last one is to unset FOO, it does not matter
if the caller sets it to some other value before unsetting, so it
feels sufficient to just check if FOO is set to anything in the
original environment.



