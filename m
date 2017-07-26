Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B71C2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 19:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbdGZTsz (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 15:48:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60542 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750918AbdGZTsy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 15:48:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5ECC90B47;
        Wed, 26 Jul 2017 15:48:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JsqM4SEhicci/u1SeHUKpESvOa4=; b=lAEWIM
        1K/NZefqZYdR4a4dD85ljX/sie6ohA++m2W9z4qvv02rO12Y1lIAdJ702D4IMsKy
        pduLy/K/Y8VBnvbZU0W9/itUOfBV1wwMqA6Os5d4Wbz4OJkJVqv2XO/6RA+M10TY
        gvu3mhNxGL2AxkDckvWnmdX21MjMUqO5URTAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fWFQl4MWX8+wYfpQavastn9nk7GKyp69
        aP7FJfBAewOavTMJOUbdc3kckbyUn/XzMF5Kv/69s9aSOUol+VzST9Ph6u1xsimd
        K30e7Jdy9ic4mKUBePFdPNJdd/7Xyvym+thP/ljoChfGWzb7Xi+RVUx40I6/dmwy
        75njQWdV16s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE6EA90B46;
        Wed, 26 Jul 2017 15:48:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E4CD90B45;
        Wed, 26 Jul 2017 15:48:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, larsxschneider@gmail.com
Subject: Re: [PATCH for NEXT v3 0/2] sub-process: refactor handshake to common function
References: <20170724213810.29831-1-jonathantanmy@google.com>
        <cover.1501092795.git.jonathantanmy@google.com>
Date:   Wed, 26 Jul 2017 12:48:46 -0700
In-Reply-To: <cover.1501092795.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 26 Jul 2017 11:17:27 -0700")
Message-ID: <xmqqtw1zq8rl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70EE2012-723B-11E7-90F6-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks for all your comments.
>
> This is now built off "next" to include Lars's changes.
>
> About whether this is too restrictive (for example, as Junio mentions,
> this will not allow future capabilities of the form "key=???"), I think
> that this can be upgraded later if necessary. For now, both the filter
> code and the ODB (and ODB-like) proposals on the mailing list do not
> require such a thing, so I have not included that functionality.

Heh, anything can be updated later.  The real question is how much
damage such an update may incur.  If such an update ends up having
to dismantle large part of what you did, then that is not a real
consolation that it "can be" updated later.

I think subprocess_handshake() can become the lowest level helper
that takes callback function to act on the capability request that
was received, and the existing user like start_multi_file_filter_fn()
can be served by a thin-wrapper around subprocess_handshake() that
defines a standard/built-in callback that checks the capability list
for exact match and flips the bit in an unsigned, so it is possible
to limit the damage when such an enhancement happens.



>
> Changes from v2:
>  - now rebased onto next, to pick up Lars's changes
>  - split up into more functions
>  - welcome prefix does not include final dash
>  - no more gotos in expected cases (or at all)
>
> Jonathan Tan (2):
>   Documentation: migrate sub-process docs to header
>   sub-process: refactor handshake to common function
>
>  Documentation/technical/api-sub-process.txt |  59 ----------------
>  convert.c                                   |  75 ++------------------
>  pkt-line.c                                  |  19 -----
>  pkt-line.h                                  |   2 -
>  sub-process.c                               | 103 ++++++++++++++++++++++++++++
>  sub-process.h                               |  51 +++++++++++++-
>  t/t0021-conversion.sh                       |   2 +-
>  7 files changed, 160 insertions(+), 151 deletions(-)
>  delete mode 100644 Documentation/technical/api-sub-process.txt
