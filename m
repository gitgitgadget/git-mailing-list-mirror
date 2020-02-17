Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D8AC34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 20:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D092072C
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 20:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Aj8Xhn9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgBQUlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 15:41:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64915 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgBQUlU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 15:41:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A30255E892;
        Mon, 17 Feb 2020 15:41:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5NR86omsZOYtIyski22WPfUGX8U=; b=Aj8Xhn
        9W29taum5z2yyACO4GjIiBHRWE0YSMri5dNJjzdcdAYoO43Rio2nQoZ+vobtnAiJ
        bAFm6oQ185sM/NjGhq8sbWAX/pO8ZQOLHoriTJcsxpWOQKR+cxU9yEpoxpTLCIvc
        nTO65TCDw9uqQUsqAdWK5hcGAv8OdWxoBt5Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gUg0lQNB9oRiGpOgWKRTSgY8vQfoZg29
        PpfMvkWMinzVFItADoGwqv4VlpRWrarPp/H5lvCuxiaVm07HXisxnAe1VFAgEFur
        coxuke83BowRIb8cjTofpqyWKmdL/mtaGwiwki6bNkUoN61nu8XWuuZdij63VbBw
        FdJ4/51d5Uo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9ABF15E891;
        Mon, 17 Feb 2020 15:41:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12D0D5E890;
        Mon, 17 Feb 2020 15:41:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] check-ignore: fix handling with negated patterns
References: <pull.711.git.git.1581956106255.gitgitgadget@gmail.com>
        <xmqqimk5ks39.fsf@gitster-ct.c.googlers.com>
        <CABPp-BEbojaeYkSMR7vntW0SkWf6dVOko5H=jqT-Yv2USRerxA@mail.gmail.com>
Date:   Mon, 17 Feb 2020 12:41:16 -0800
In-Reply-To: <CABPp-BEbojaeYkSMR7vntW0SkWf6dVOko5H=jqT-Yv2USRerxA@mail.gmail.com>
        (Elijah Newren's message of "Mon, 17 Feb 2020 10:41:47 -0800")
Message-ID: <xmqqeeutkkur.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9193F66-51C5-11EA-8244-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> I suspect that the above distorts history.  IIRC, it was meant as a
>> tool to see which exact pattern in the exclude sequence had the
>> final say for the given needle, written primarily as a debugging
>> aid.  In that context, "This rule has the final say", whether the
>> rule is a negative or positive, still means something.
>
> I can reword it; how does the following sound?
>
> check-ignore claims that it reports whether each path it is given is
> excluded.  However, it fails to do so because it did not account for
> negated patterns.

I am not sure about "claims" part.  

Isn't it more like "check-ignore has been the tool that reports the
rule that has final say on each of the paths it is given, but that
is not very useful when the user wants to see if the path is
excluded (e.g. the rule with the final say may be negative).  Let's
change the behaviour so that it reports if the path is excluded or
not"?  As I said, I tend to agree with the direction your patch
wants to go (iow, we probably are better off changing the
behaviour"); the question is if we want a transition plan and how
extensive it needs be if we do.

