Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA182C41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 17:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A6C2168B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 17:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UK2Wd0ED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgJGRio (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 13:38:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50574 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbgJGRin (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 13:38:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBAB57E5B2;
        Wed,  7 Oct 2020 13:38:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aaJdGwrMlk8mgyRu5X6++AFfJMg=; b=UK2Wd0
        ED3+IzBLgE2dXL2t/+uS7qDy3NfGdr/YpPFoFgKeWx0Ew8R/ruekylsosweCJDce
        yTdiYtpK17nki9+uqAAbbjC574nOWJ633OOY4G1pr7np0jwKzU6PEJs4MIxUrQud
        mpheOk1ADPU0Zp4/FYrtoo7+OFD7NhlC38AF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E+ZVBlQmiu7QXxYdxGZjEpCIYd0uNwUX
        XcXZ5Hi2gIQr0kcu72hzuDqyBerrPidDbcqEoRfV92n20pCQXWs76vuqcK72Jude
        FkIs87XHNiSfBEcgOEVGMjRV8SaO2Mv/JH5SpgpA6iusbZBBtgxpicchBc3WvXNH
        GHJcFz4eALE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B42CC7E5B1;
        Wed,  7 Oct 2020 13:38:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4328B7E5B0;
        Wed,  7 Oct 2020 13:38:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.29.0-rc0
References: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
        <20201007153947.GA181281@coredump.intra.peff.net>
        <20201007154533.GA186764@coredump.intra.peff.net>
Date:   Wed, 07 Oct 2020 10:38:40 -0700
In-Reply-To: <20201007154533.GA186764@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 7 Oct 2020 11:45:33 -0400")
Message-ID: <xmqqlfgi2axr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F09558E0-08C3-11EB-810B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hmm. That commit removes the call to display_progress() from the main
> loop of threaded_second_pass(), and doesn't appear to add another one
> anywhere. Is the solution really as simple as adding it back in? I.e.
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 8acd078aa0..6dbb4317e0 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1028,6 +1028,10 @@ static void *threaded_second_pass(void *data)
>  		struct object_entry *child_obj;
>  		struct base_data *child;
>  
> +		counter_lock();
> +		display_progress(progress, nr_resolved_deltas);
> +		counter_unlock();
> +
>  		work_lock();
>  		if (list_empty(&work_head)) {
>  			/*
>
> That _seems_ to work fine, but I'm not sure why it was removed in the
> first place (for a good reason, or simply as an accident when rewriting
> the variable declarations at the top of the loop?).

The above looks like an obvious and trivial fix to go back closer to
the original.

We seem to have removed find_unresolved_deltas() helper function in
that series, but there remains a mention to it in a comment, which
we would probably should rethink (it just may be the matter of
removing the mention, or if "just like in ..." may have been the
last example of doing what the comment suggests all code to do, it
may reveal a need for larger clean-up---I dunno).

Thanks.



