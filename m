Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEEFC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858FC60FDC
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243530AbhJHWG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 18:06:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64725 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhJHWG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 18:06:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11D63E3F01;
        Fri,  8 Oct 2021 18:04:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TbnQQfBQlYzazlX2OiCdBKd+gQ8MOXzEaSLeO1
        CZ508=; b=cGwHQSZzAO09k+hJj6uVSQvGrv/fIJYhi7HkGR5FdNIyJUqUThbly/
        L1nyZYmgLZf5jgpDmn43BlL3lAshfLau7/pKSW5hsctV4gFuJgqDV983tL+DJGFz
        yGKXJIqegg5nQ8DGUfOrQpOJHcTXcUNhxhh2VdDIwUqLzFJBbaddM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09427E3F00;
        Fri,  8 Oct 2021 18:04:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FE32E3EFE;
        Fri,  8 Oct 2021 18:04:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] cat-file: mention --unordered along with
 --batch-all-objects
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
        <YVy2DNd+XemykKE0@coredump.intra.peff.net>
        <877derjia9.fsf@evledraar.gmail.com>
        <YVzGeE1T/Kp8DDZD@coredump.intra.peff.net>
        <87tuhuikhf.fsf@evledraar.gmail.com>
        <YV3LonbeIS8DrMsN@coredump.intra.peff.net>
        <87k0ipgmbb.fsf@evledraar.gmail.com>
        <YV+tXVWVuy/rZn/l@coredump.intra.peff.net>
        <87lf34ey5a.fsf@evledraar.gmail.com> <xmqqo87zjlwt.fsf@gitster.g>
        <YWC7rF4mpU9W6CbI@coredump.intra.peff.net>
Date:   Fri, 08 Oct 2021 15:04:29 -0700
In-Reply-To: <YWC7rF4mpU9W6CbI@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 8 Oct 2021 17:44:12 -0400")
Message-ID: <xmqqlf33i36a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B63120B8-2883-11EC-85B4-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes, it would definitely need that extension. But it's also weirder than
> that. --textconv is an OPT_CMDMODE(), because it is mutually exclusive
> with "-t", etc.

Yeah, in hindsight, we should have made "--textconv" a modifier for
"-p", because it is not a true cmdmode.  It is much easier to
understand if you imagine "--textconv", without a command mode,
implies the "-p" mode, but when a command mode like "--batch" is
given, that would apply.  And it is job of other individual command
modes to notice that "--textconv" modifier does not make sense in
their context and issue a warning.

> The current code uses OPT_CMDMODE() for (1) and (2), and then manually
> enforces the exclusion between (1) and (3). But IMHO it is (2) that is
> the odd-man out, in that it can be its own mode or a modifier, and it
> probably should not be OPT_CMDMODE() (but from the end-user perspective,
> that is OK, though it may influence how we document or group things).

I guess we are exactly on the same page (see "'textconv' is a
modifier, which implies '-p' command mode unless otherwise
specified" above).
