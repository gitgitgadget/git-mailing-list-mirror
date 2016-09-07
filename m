Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929AC1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 17:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754318AbcIGRKX (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 13:10:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64626 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751393AbcIGRKW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 13:10:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 489D238ED6;
        Wed,  7 Sep 2016 13:10:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1tXtoBKyLSl6g9UAJ/5T64L/Gfo=; b=Q/8bex
        b2x544dKPymPfzwyR/S04j8YsKv11hwtO4es+ymQGL5zM4GBG2V/AtUsgMSdqCt5
        XfQdYl/xlSbArWxJOG41S+teRWJhiReJMswDD9o+4fzMYFbPIX/vXIuU6CFWgtba
        LeYKwMylckWQmGs6ktG0eZSmQzRqDkmWENLGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XeQfqDah8wH1U9fvqo0QOYqs22NbChor
        45UQMk6TdBbTIuVkMYCyRPPzm7xHJY0o2ajMYqDUm2pUs9++toZ4vawYWksqrOdb
        et4mFzwFufRH+zYBq6UUQHO2l9r6/UD8lRnQjHptKMAONE7cjuhAf4ir5dwmt5Nv
        K4wOSNHAhSU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4067B38ED5;
        Wed,  7 Sep 2016 13:10:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B93E738ED4;
        Wed,  7 Sep 2016 13:10:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, spearce@spearce.org,
        sbeller@google.com, peff@peff.net
Subject: Re: [PATCH v2 2/2] connect: advertized capability is not a ref
References: <cover.1472853827.git.jonathantanmy@google.com>
        <cover.1472836026.git.jonathantanmy@google.com>
        <cover.1472853827.git.jonathantanmy@google.com>
        <174c8ca6638f1cd3145a628925e65655b56af366.1472853827.git.jonathantanmy@google.com>
Date:   Wed, 07 Sep 2016 10:10:18 -0700
In-Reply-To: <174c8ca6638f1cd3145a628925e65655b56af366.1472853827.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 2 Sep 2016 15:06:12 -0700")
Message-ID: <xmqqoa3zocud.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F51594F4-751D-11E6-B8B6-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/connect.c b/connect.c
> index 722dc3f..0c2221e 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -165,6 +165,9 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  			continue;
>  		}
>  
> +		if (!strcmp(name, "capabilities^{}"))
> +			continue;

While it is true that ignoring this line anywhere in the ref
advertisement is safe, it feels a bit strange to do so, when we know
that it can appear _only_ when there is no other ref advertised.  I
guess you can argue that it is good to be lenient to accept what
others produce, but on the other hand, it can also be argued that
having this among real ref advertisement would be a protocol
violation that we may want to diagnose and prod the other side to
fix their software (but still not fail).

> +
>  		if (!check_ref(name, flags))
>  			continue;
>  		ref = alloc_ref(buffer + GIT_SHA1_HEXSZ + 1);

