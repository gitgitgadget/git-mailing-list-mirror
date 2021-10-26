Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC37C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 01:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF39603E8
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 01:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbhJZBYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 21:24:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62476 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbhJZBYo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 21:24:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33D3CDF468;
        Mon, 25 Oct 2021 21:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eGGPjc7KCdMjgmUGHqPPou81VTFzb5X6j/s36z
        G7tmQ=; b=Uu7lUKnr+6CnN3hTcDaqIQyp049hGiSyXfhQojbKbmB2+gj2QE6fQB
        dByzBopRAGmK+4luVuIDFxz3Q5jAqb7I5vnf/1G0GmodfoY79447JfPVFHmWQjfR
        UsCtUJqqHiUesjSnFYLZF8EDgNTH8N4mmYjfrZDOKfYbXNGAyrGRg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C2AEDF467;
        Mon, 25 Oct 2021 21:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B327DF463;
        Mon, 25 Oct 2021 21:22:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/4] remote: use remote_state parameter internally
References: <kl6lbl3c7lsa.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqfssozk8r.fsf@gitster.g>
Date:   Mon, 25 Oct 2021 18:22:18 -0700
In-Reply-To: <xmqqfssozk8r.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        25 Oct 2021 17:45:56 -0700")
Message-ID: <xmqqbl3czik5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A59B3A4-35FB-11EC-8AC0-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> a) Represent detached HEAD with a non-NULL "struct branch". This will
>>    let us continue using the remote_state backpointer, which makes many
>>    interfaces clean, but is somewhat invasive, error-prone and it uses
>>    "struct branch" for something that is not a branch, which is itself
>>    an error-prone interface.
>
> I'd rather not to go there.

Actually, I take half of that back, as I think this would be the
best direction in the longer term, and it conceptually is sound.
After all, detached HEAD is not all that special--- when we ask for
the "current branch" and the HEAD happens to be detached, we treat
it as a perfectly valid state and behave as if we are on that
unnamed branch.  The state probably deserves to be represented as a
"struct branch" instance.

I do agree with you that this approach would involve significant
short-term pain, as a lot of existing code may say "NULL is how we
represent detached HEAD" and they have to be identified and upgraded
before the above plan calls for.

So, I tend to think that in the shorter term, perhaps a safer
variant of (c) that allows us to ask "not-current@{push}" would be a
good way to go, but when things have stabilized, we should revisit
and see if it is feasible to represent a detached HEAD state with an
instance of "struct branch" and how simpler the interface would become
when we did so.

Thanks.
