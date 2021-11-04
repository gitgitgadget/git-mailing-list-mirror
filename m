Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7565C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 20:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5936120F
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 20:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhKDUFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 16:05:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64691 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhKDUFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 16:05:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6ED28149C31;
        Thu,  4 Nov 2021 16:03:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3vzQ5TjMwQK5QxlAEbhMcytd7uYwZ1MroaJ4SQ
        pa7xk=; b=UA4IFqbKj1gxYN4tG3s7RSCvLYKlpMintKmxHRBmmtzkBNUkMNqGWb
        lbE/U7XBWJ3Pv8nZg2itD17Ow9V39Gh8KMzqS/CfJNHZNMdnSepg4I3B621ycb7J
        9c0FVDP3/mm+ja2GIibX/XH8Jf/olwCM5vUHXXf/l8vFtwiDhw1zs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 66A21149C30;
        Thu,  4 Nov 2021 16:03:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1382D149C2B;
        Thu,  4 Nov 2021 16:03:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
References: <20211104192533.2520-1-adam@dinwoodie.org>
        <xmqq7ddn3dlt.fsf@gitster.g>
Date:   Thu, 04 Nov 2021 13:03:00 -0700
In-Reply-To: <xmqq7ddn3dlt.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        04 Nov 2021 12:49:50 -0700")
Message-ID: <xmqqzgqj1yff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 372B0810-3DAA-11EC-9C0F-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> This change is required in particular to avoid tests relating to SSH
>> signing failing in Cygwin.
>
> ... I am not quite sure how this explains "tests relating to ssh
> signing failing on Cygwin".  After all, this piece of code is
> lazy_prereq, which means that ssh-keygen in this block that fails
> (due to a less restrictive permissions) would merely mean that tests
> that are protected with GPGSSH prerequisite will be skipped without
> causing test failures.  After all that is the whole point of
> computing prereq on the fly.

The reason why I wondered about the above is that it can be an
indication of another breakage, namely, that we may have tests that
require a working ssh-keygen but are by mistake not protected with
GPGSSH prerequisite.

The test_lazy_prereq block you touched may refrain from setting the
prerequisite on your system (due to the faulty test here that you
touched), but if we had such unprotected tests, we still will run
ssh signing tests and they would fail, due to the lack of the
prerequisite.

And fixing the prereq block alone will hide that other breakage, at
least on your system.  Hence my question.

Thanks.
