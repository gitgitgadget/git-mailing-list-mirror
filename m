Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6A1C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 00:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCCF206C9
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 00:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gDS3s+nA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgIQA5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 20:57:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52684 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgIQA5N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 20:57:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6600EA51B;
        Wed, 16 Sep 2020 20:57:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kLMwzz9uRYyVdjJoGtJmExe4L+8=; b=gDS3s+
        nA7a78SPx9ahmkvHkvaORI4Ax5O0oRGy0RJGwYliUgx1qYgdNlJSejDcAVPeTP3n
        IHx8bpdstfAku2ajaUzvy+xSQKIHWy5G/rNIB678NbndmzDOyTGGuixIzmJXzZxz
        sr6B0Ypp6+SsQCDuBnxRxE5p9jFHtApf/spSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HkzeaOr2DkZZonT8DnPggutfaSYmnUoM
        mPAHZntunNYq1//MeFYFwKforhCYWpiE+oflPGjeydv37QM+OLMRebZW2KL1EO4I
        +6GN/1U8FRPbneNVdfpkRaKLgQeDZ63fwvATXtMR4hhyM0BzDP9zr5jdA/G5bYQV
        iaigFsElF+I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CEDDBEA51A;
        Wed, 16 Sep 2020 20:57:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 168B4EA519;
        Wed, 16 Sep 2020 20:57:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alex Riesen <alexander.riesen@cetitec.com>, git@vger.kernel.org,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
References: <20200915135428.GA28038@pflmari>
        <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
        <20200916201830.GA44969@coredump.intra.peff.net>
        <xmqqbli5uyj4.fsf@gitster.c.googlers.com>
        <xmqq4knxuyfz.fsf@gitster.c.googlers.com>
        <20200917004828.GA2442845@coredump.intra.peff.net>
Date:   Wed, 16 Sep 2020 17:57:07 -0700
In-Reply-To: <20200917004828.GA2442845@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 16 Sep 2020 20:48:28 -0400")
Message-ID: <xmqqimcdte3g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6970A6A-F880-11EA-8388-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> My suggestion elsewhere was to have an "unset" value, and then resolve
> it at the time-of-use, something like:
>
> diff --git a/transport.c b/transport.c
> index 43e24bf1e5..6414a847ae 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -248,6 +248,9 @@ static int connect_setup(struct transport *transport, int for_push)
>  	if (data->conn)
>  		return 0;
>  
> +	if (transport->family == TRANSPORT_FAMILY_UNSET)
> +		transport->family = transport_family_config;
> +

Ah, OK, if we want to configure it the other way around, yes, we
need "the command line didn't say any" value.  The context of the
"elsewhere" discussion was wnat I was missing (I'd happily blame
vger for not delivering mails in order ;-).

