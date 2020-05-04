Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D711EC47247
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870FB206C0
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uw7YV8Ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgEDTOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:14:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61548 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgEDTOG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 15:14:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87FE35BA47;
        Mon,  4 May 2020 15:14:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gP8yR/4AhBBlXoaMAeA/JpMJVZM=; b=Uw7YV8
        EeoOiVgqoAZZfev+jgsClYfF439PaVjUDdNPu6dYiv1QVVk31UwOCtO6BFAXHFEl
        tUMZsRGrCeE+X+gzA2cGDiU16HmCb0nuS35bqSssxRbOZ8DW50RgFnpv2HV3W5iM
        azi+htPMLY0Irpq1wm3JxZkpdZL6f8PDfWgQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=abzqFBL3yMIYLkdpT8BNOKNH1pLSgido
        bzgLXvJrTvqSIJAytmj4vWfSKcey1W3d7SlKFg/V1zqWy+EPfyohzRP9Xbsyfk8O
        G6Ju8ClMmCHHNmQETOeQhUUHhJ7/ZrfrcMEAz6E5dHEerLmoL1L0bS+vxRAMtvSN
        NMt4qHpKdlk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D33F5BA46;
        Mon,  4 May 2020 15:14:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D42215BA45;
        Mon,  4 May 2020 15:14:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        liu.denton@gmail.com
Subject: Re: [PATCH v3] submodule: port subcommand 'set-url' from shell to C
References: <20200504072705.15261-1-shouryashukla.oo@gmail.com>
        <xmqqd07jitjz.fsf@gitster.c.googlers.com>
        <20200504173936.GA8919@konoha>
Date:   Mon, 04 May 2020 12:14:01 -0700
In-Reply-To: <20200504173936.GA8919@konoha> (Shourya Shukla's message of "Mon,
        4 May 2020 23:09:36 +0530")
Message-ID: <xmqq368fh5s6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69E277B8-8E3B-11EA-B976-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> On 04/05 08:55, Junio C Hamano wrote: 
>> > +	argc = parse_options(argc, argv, prefix, set_url_options,
>> > +			     usage, 0);
>> > +
>> > +	if (quiet)
>> > +		quiet |= OPT_QUIET;
>> 
>> This is bogus.  "command --quiet --quiet" would count-up quiet twice
>> and would make it 2, and you or OPT_QUIET==1 in to make it 3, but
>> your intention is quite clear that you want to pass 1 to
>> sync_submodule() in such a case.
>
> This is a grave mistake from my side. Though I do not understand how
> will `quiet` be counted twice.

The way I read the definition of OPT__QUIET() 

    #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))

is that it is OPT_COUNTUP() in disguise, and that is designed to
yield increased quietness when "-q" is given more than once.

> The fix you suggested (quiet ? OPT_QUIET : 0), we use this because we
> want to ensure `quiet` goes into sync as either 1/0 right? Not any other
> non-zero positive integer right?

The "if (quiet) quiet |= OPT_QUIET" does not make *any* sense, if
you are expecting quiet to be set to 1 or left as 0 as initialized
by parse_options() API.  You are defeating the whole point of using
preprocessor macro OPT_QUIET, as the correctness of the construct
heavily rely on OPT_QUIET defined to be 1.  If for any reason the
preprocessor macro gets redefined to 8, writing

	quiet ? OPT_QUIET : 0

would need *no* adjustment, while "if (quiet) quiet |= OPT_QUIET"
would require fixing.

