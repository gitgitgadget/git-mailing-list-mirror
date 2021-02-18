Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2E9C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 21:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9756064EBD
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 21:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhBRVen (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 16:34:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62905 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhBRVem (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 16:34:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6401C9A49E;
        Thu, 18 Feb 2021 16:33:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6E4bZ5ThOWtOfUOjScV4vljO8H0=; b=gwFXkq
        Za3UWBpA5TxiWcP8QEMSGlYXu4kWhNat056mhCuBNkv/bsPNqEEt1vfx25lozWL3
        vCzIdyqkbxVcbXnlaln5cZ+HfxFD4h8kl3fJprvWqSh+wHAZLpp/daAH7tlekUwD
        bLf89e0Zu6qCQlFfbp6cuDQFNnVP2sv+p1o7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VJuAVZVMUgZEaAB0NsqCGVMAg1W3H53O
        w9BhC0/ID+XPwwWe1QDFoCnFG+e7icng1lYxIi+O6e9GcD0DQqwTB12gejNp4ifs
        hgoCmtErHasVlqInzguEldxqowaPKZ0vKm54ewgwURReBBhyjPkdXFR1NMfHMFZ7
        d1A1N2WaZVk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AF7C9A49D;
        Thu, 18 Feb 2021 16:33:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D95549A49C;
        Thu, 18 Feb 2021 16:33:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] push: perform negotiation before sending packfile
References: <20210218012100.928957-1-jonathantanmy@google.com>
        <xmqqwnv6gnuq.fsf@gitster.g> <xmqqy2fldsy4.fsf@gitster.g>
Date:   Thu, 18 Feb 2021 13:33:58 -0800
In-Reply-To: <xmqqy2fldsy4.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        18 Feb 2021 12:25:23 -0800")
Message-ID: <xmqqlfbldprt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02B0D1D6-7231-11EB-9886-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  - With this approach, we can cut down the initial ref advertisement
>    from the receiving end to the minimum.  The protocol with
>    negotiation could work correctly without receiving end
>    advertising no refs, but I suspect that it would be very common
>    in a publishing repository (not a shared everybody-pushes-into
>    repository) that the tip of the target repository is known by the
>    pusher, and it may help such a case to know where the ref being
>    updated with this push originally points at.  But even in such a
>    case, additional negotiation may help---the target branch may
>    have not advanced, but may of the side branches the pusher have
>    merged into the commit being pushed to the target branch may
>    already be known by the receiver.

Addendum.  The original push protocol where the pusher learns all
the tips of refs the receiver has cuts down the resulting packdata
transfer in such a "side branches already known by the receiver,
only the fact that they were merged to the target branch is new"
case.  The pain only starts happening when we try to reduce the
advertisement made by the receiver.

As the "negotiation" is more targetted for the ref that actually is
being pushed (as opposed to the blanket "here is everything I have"
that can get unreasonably big), I think the idea to introduce the
same common ancestor discovery that happens on the "fetch" side, and
to share the code with the "fetch" side that has been battle tested,
is a great one.
