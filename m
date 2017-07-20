Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDEC11F600
	for <e@80x24.org>; Thu, 20 Jul 2017 21:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936441AbdGTVU7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 17:20:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64553 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936434AbdGTVU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 17:20:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB2A48DCFD;
        Thu, 20 Jul 2017 17:20:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3XPj59GPGCQz+x2Bz2M7Vsyixm4=; b=NyJJIU
        AQcSUQfOCUODA2pbeR8rvXOAljp0+0GGVoswQXZhoewMfkAm5b3I8A+ooXJiDKac
        vg/xESehUz1ib+880wRp/xbKu1EPElA+1nyVeTSLqx8udNh7D38JalC0jTc54GaA
        sQ8gQtZqji5x+Ur19yUsMFpr9iNe3bZ1wE+nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uwJzLbRzRgrlaZi8b0DHQP7qwq938twA
        O1y6mdukMevhbriod9wc1eKDuasMxuKGoQN0n18spBNhUuX+P9JKoraZL0YYcig7
        xQUK+njL5sLPJQkUsSI7Tbvw0KK8J/xGsEh87EClS4r58uaEbyfROd7sTb8yQz7j
        FxmBpkxfuyk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A35568DCFC;
        Thu, 20 Jul 2017 17:20:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F347D8DCF9;
        Thu, 20 Jul 2017 17:20:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com,
        git@jeffhostetler.com, peartben@gmail.com, philipoakley@iee.org
Subject: Re: [RFC PATCH v2 1/4] object: remove "used" field from struct object
References: <cover.1500508695.git.jonathantanmy@google.com>
        <cover.1499800530.git.jonathantanmy@google.com>
        <cover.1500508695.git.jonathantanmy@google.com>
        <0eb270f40095f132bf9383f230506e45d895e5e1.1500508695.git.jonathantanmy@google.com>
Date:   Thu, 20 Jul 2017 14:20:55 -0700
In-Reply-To: <0eb270f40095f132bf9383f230506e45d895e5e1.1500508695.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 19 Jul 2017 17:21:44 -0700")
Message-ID: <xmqqk232kdoo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51F42426-6D91-11E7-9DAA-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The "used" field in struct object is only used by builtin/fsck. Remove
> that field and modify builtin/fsck to use a flag instead.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/fsck.c | 24 ++++++++++++++----------
>  object.c       |  1 -
>  object.h       |  2 +-
>  3 files changed, 15 insertions(+), 12 deletions(-)

I vaguely recall trying to do this myself a few years ago.  We can
easily spot places within this file that does things like this:

> -	obj->flags = HAS_OBJ;

and correctly update it to this:

> +	obj->flags &= ~(REACHABLE | SEEN);
> +	obj->flags |= HAS_OBJ;

but I didn't do so because I was hesitant having to validate, and
having to maintain the invariant forever, that anything called from
these codepaths is always careful not to clobber the USED bit.

Looks like a reasonable preparatory clean-up that probably should be
doable and should be done way before the main part of the series to
me.  Will queue, together with your other fsck change.

Thanks.
