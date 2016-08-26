Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8BD1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 22:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752929AbcHZWxY (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 18:53:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54826 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750869AbcHZWxX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 18:53:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E39D73A533;
        Fri, 26 Aug 2016 18:53:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S5/6AsyUtnWdtTlmwR8CjcYKXns=; b=hCzCGB
        +HlPVLoRpXDOT7wVm6L0Xt8ZMejjW3+iuhiGVYqR+vM4rRf69ngV5njbM68X90V1
        jvUkmvVkNBLCzsvHhbCb+kgExWo5P8biF0ZPs9Br5uqRqV3eZ0bqcIFoW2j+qXDz
        7SUU40EEEJXhPq5Jgl7q09wYshVgOFwhMqJvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uGIbmyFdtpev+0mkbs7vt4WtGQVxJxK/
        0MOmSrp4o3+yD0sDHuZNrpBoTHIHrdtTIYGKBQtyIhQetx4ht9inZGx1xT+ApIeO
        pzDh4mjbkZ3LLmr5I2IX/1WzL7AQKyAu+cb1F9l2uy5hR8FRTeVKt1HQvyPxETiX
        +QMb+jwjjE8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D484B3A532;
        Fri, 26 Aug 2016 18:53:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C83D3A530;
        Fri, 26 Aug 2016 18:53:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Git List" <git@vger.kernel.org>
Subject: Re: Are --first-parent and --ancestry-path compatible rev-list options?
References: <2FA1998250474E76A386B82AD635E56A@PhilipOakley>
Date:   Fri, 26 Aug 2016 15:53:18 -0700
In-Reply-To: <2FA1998250474E76A386B82AD635E56A@PhilipOakley> (Philip Oakley's
        message of "Fri, 26 Aug 2016 22:23:46 +0100")
Message-ID: <xmqqfuprdtwh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E32BD4D4-6BDF-11E6-926A-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> The commit graph. We are looking for F based on knowing J.
>
> . A - B - C - D -- E -- F -- G - H    <-first parent, --merges (C,F,H)
> .  \  |  /    \        /    /
> .   ----Z     |       /    /
> .     |       |       |   /
> .      \       \     /   /
> .       I -[J]- K - L - M             <-since J, children of J
> .        \         /
> .         N - O - P

I think these two operations are fundamentally incompatible.

Because the first-parent traversal is what the name says, i.e.,
forbids the positive side of revision traversal to stray into side
branches, the positive side of a traversal that begins at H will not
see M, L and K.  The negative side would traverse in the normal way
to paint commits starting J and its ancestors as UNINTERESTING, so
the traversal over the artificial "first-parent only" history, i.e.
H, G, F, E, D, C, B, A would eventually stop before showing an
ancestor of J.

On the other hand, to compute the ancestry-path, you need to make a
full traversal of the real history to find a subgraph J..H and then
post-process it to cull paths that do not contain J.
