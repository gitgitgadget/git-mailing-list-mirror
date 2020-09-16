Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384FCC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3618206CA
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lu0u4vqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgIPWOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:14:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56289 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgIPWOO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 18:14:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 963058843B;
        Wed, 16 Sep 2020 17:35:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tu5hPVR+RHcc15BwJybQbB6iH8I=; b=lu0u4v
        qZDHxnGLJ7SR873TdVLOqt7NcUoIngQuXmIrP3N7XXFzrZlilGBamH7M/L4wxh+0
        QQX8iAX5AtZuRxQ3Q6NlezNUeLPRd8lHZzJcFBbgTBG3wiBwobLu81LaZWxldEOL
        iisHye1Q+rO3oNphsBcCBjaHBfq/FyzdrDstU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QhyM60sJMjaPaUa2d1pqodBiQLeR2nSv
        UOlzCDFPcwfk6JYyDJ0C+pqLTaiH0bu+w88+YSNjyvliN1hWWrxXMuUbTUUr5IcK
        Y3UjfHdYgn6Y+T7243A840+js6MiT8a1dHevu2mtJlYc/H0/JMS7u2Za+72FIVWQ
        wiQztstRSjQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EB658843A;
        Wed, 16 Sep 2020 17:35:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1770B88439;
        Wed, 16 Sep 2020 17:35:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
References: <20200915135428.GA28038@pflmari>
        <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
Date:   Wed, 16 Sep 2020 14:35:23 -0700
In-Reply-To: <xmqqtuvxwkbz.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 16 Sep 2020 13:14:08 -0700")
Message-ID: <xmqqk0wtv204.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 877366B4-F864-11EA-8EB1-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Also, we should follow the usual "the last one wins" for a
> configuration variable like this, which is *not* a multi-valued
> variable.  So the config parsing would look more like this:
>
> 	if (!strcmp(k, "transfer.ipversion")) {
> 		if (!v)
> 			return config_error_nonbool("transfer.ipversion");
> 		if (!strcmp(v, "any"))
> 			family = 0;
> 		else if (!strcmp(v, "4") || !strcmp(v, "ipv4"))
> 			family = TRANSPORT_FAMILY_IPV4;
> 		else if (!strcmp(v, "6") || !strcmp(v, "ipv6"))
> 			family = TRANSPORT_FAMILY_IPV6;
> 		else
> 			return error("transfer.ipversion: unknown value '%s'", v);
> 	}
>
> Would we regret to choose 'ipversion' as the variable name, by the
> way?  On the command line side, --transfer-protocol-family=ipv4
> makes it clear that we leave room to support protocols outside the
> Internet protocol family, and existing --ipv4 is grandfathered in
> by making it a synonym to --transfer-protocol-family=ipv4.  Calling
> the variable "transfer.ipversion" and still allowing future protocols
> outside the Internet protocol family is rather awkward.
>
> Calling "transfer.protocolFamily" would not have such a problem,
> though.

In case it wasn't clear, I consider the current TRANSPORT_FAMILY_ALL
a misnomer.  It's not like specifying "all" will make us use both
ipv4 and ipv6 at the same time0---it just indicates our lack of
preference, i.e. "any transport protocol family would do".

I mention this because this topic starts to expose that 'lack of
preference' to the end user; I do not think we want to use "all"
as the potential value for the command line option or the
configuration variable.

Thanks.
