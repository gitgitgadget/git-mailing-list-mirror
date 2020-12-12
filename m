Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0090C54EC3
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 01:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B7D23770
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 01:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404757AbgLLABd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 19:01:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57044 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437538AbgLLABS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 19:01:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AB759C755;
        Fri, 11 Dec 2020 19:00:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T6XfDqowxT5ISDxCA/GbDdEaSRM=; b=MUGZgG
        ApQuMpRPa7lvKOSeJVLrLwvWi2dkNqrwarrwPC40IOBQOjnmpYcLfxBHMHijovWZ
        5bh0T+miyureSe5bhAEToJQG/elPUhmmKkX0oNYmnw38MMBMvUpPnH/TOf3Dk/xF
        LH2J7hjeSl4T2lLf49IKRMR1vdVCze8svRKqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L1p1UFR3IGqs2dhHtSRrFx1FBwHFSoPT
        buB6fzeX99W+QM4/IdTRcuYrgp39gePgh5211dIJE9GrsWYvMZ7jDII7Z7uQT0fe
        jf7mlX7AUsnAIxzm9bAfAhGzdnTTnvHug3cK8nEe8rQjG9KvCEW/juQJ0vjYCvFl
        38FGsJtyZ74=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11CEB9C754;
        Fri, 11 Dec 2020 19:00:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 616849C753;
        Fri, 11 Dec 2020 19:00:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>
Subject: Re: [PATCH v5 2/3] pull: move default warning
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
        <20201210100538.696787-3-felipe.contreras@gmail.com>
        <xmqqy2i4ltnv.fsf@gitster.c.googlers.com>
        <CAMP44s170qZuZqmh_gVLGgJJ5005HzDM0fdQKQamjHkZCOu7_Q@mail.gmail.com>
Date:   Fri, 11 Dec 2020 16:00:34 -0800
In-Reply-To: <CAMP44s170qZuZqmh_gVLGgJJ5005HzDM0fdQKQamjHkZCOu7_Q@mail.gmail.com>
        (Felipe Contreras's message of "Fri, 11 Dec 2020 01:55:45 -0600")
Message-ID: <xmqq360bj3kt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F513E08-3C0D-11EB-B9FC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>>  - correct the if() statement above, so that regardless of verbosity
>>    level, we can do _something_ common when the history does not
>>    fast-forward.  I.e.
>>
>>         if (rebase_unspecified && !opt_ff) {
>>                 if (opt_verbosity >= 0)
>>                         show_advice_pull_non_ff();
>>         }
>>
>> These would allow us to further turn the logic to
>>
>>         if (rebase_unspecified && !opt_ff) {
>>                 if (opt_verbosity >= 0 && advice_pull_non_ff)
>>                         show_advice_pull_non_ff();
>>                 die("not a fast-forward; must merge or rebase");
>>         }
>
> Should actually be something like:
>
>         if (rebase_unspecified && !can_ff)
>                 die("Not a fast-forward; must either merge or rebase");

The illustration I gave in the message you are responding to was
made in the context of patch 2/3; with patch 3/3 where can_ff
exists, it would not become like what you gave above.  It should
instead become

	if (rebase_unspecified && !opt_ff && !can_ff) {
		if (opt_verbosity >= 0 && advice_pull_non_ff)
			show_advice_pull_non_ff();
		die("not a fast-forward; must merge or rebase");
	}

i.e. when we can fast-forward, we do not trigger the "you must
specify rebase/merge" message, and we do not trigger the "not a
fast-forward" error.
