Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883B9C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E19F611EE
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhDGUkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:40:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58784 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhDGUk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 16:40:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4668C254C;
        Wed,  7 Apr 2021 16:40:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SWc1xDhWLAJguOhiCvNO2jzx8mA=; b=BUdI13
        jkBkEGWstJoObmWUK7tY/6EWJfv2YG1Nfurx6PJXJtezRbnJZi/83iPbeUqOa5MV
        1gUelhiv0Xw1XnD5bsqM9vlm62j8pjNG4UG0I6pRbcC54Rk0NuQKYg4w7ip9jZI2
        MPyR591cCDTNHvSqKL4LeWxqnBJpZ3P+fSJ44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cHQUxEAc/Zu0dNREXqaJEWJbxXC1RXzx
        PjID+ST1LJSSfBAISXLU7BjYKkidNnyKJ9LPreaIwdwrX89z3u0oiuhbULP9ps5V
        aFSBBs9AWG2wtjE8SixG6jk/g7vk0IPz4KxKbDUXEIjCB5nkQDBPPFgf+Ptff5FK
        txbXtLGZKbs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCD58C254A;
        Wed,  7 Apr 2021 16:40:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5667BC2549;
        Wed,  7 Apr 2021 16:40:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: There should have be git gc --repack-arguments
References: <b35a68a1-e693-5502-7a28-a1dd8222d3a0@gmail.com>
        <YG4J7vtTRVpGGLoo@coredump.intra.peff.net>
Date:   Wed, 07 Apr 2021 13:40:16 -0700
In-Reply-To: <YG4J7vtTRVpGGLoo@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 7 Apr 2021 15:37:18 -0400")
Message-ID: <xmqq8s5tzv4f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7655B072-97E1-11EB-ABF0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> ... git repack ...  --max-pack-size=<desired pack size> to create split and
>> smaller packs instead.
> ...
> You can also set pack.packSizeLimit for the latter, though I do not
> recommend it. It will not help with memory usage (neither while
> repacking nor for later commands).

In other words, passing --max-pack-size, whether it is done with a
new --repack-arguments option or it is done with the existing
pack.packSizeLimit configuration, would make things worse.

So in conclusion:

 - attempting to repack everything into one pack on a memory starved
   box would be helped with reduced window memory size.

 - on a small box, it may make sense to avoid repacking everything
   into one in the first place, but we do not want the number of
   packs to grow unbounded.

Would the new geometric repack feature help here, especially for the
latter?

