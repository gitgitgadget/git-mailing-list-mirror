Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91796C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E4A5619FF
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbhCXU2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 16:28:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55303 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbhCXU2h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 16:28:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0712C1352A2;
        Wed, 24 Mar 2021 16:28:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Hd/ROxXYMw5aLqxaUJ+C9/km7U=; b=XFpelq
        zGezuO6aY+SMCVIE+jHQp3xpyoAxjCu61lMI8rpcdCo+MVLWhcgSmV071FxI121C
        xbzzvqfjnSZVVcToARQQajPMNe67rzeUKp6oATs5i84blJ8ZNR/0qx+LJBtkmTEq
        xwhkDsaeU0OniLZRxMj8R2NcKKHoGu9cVWlDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rK/I1hUBRtByFrNfj68MfXLqW9VaIAdq
        sEugBH2fqkVR353stgqoFX8/xz+pVVDMY92sI39fLEwPLsAfN/FhnVQi9tTzg+hz
        nBg7/NUxNYMN2Da6JOcw/y61jMS3W21ZcaTCzmhIeYSbHONvv1Iy5pQKcX9zVYdm
        QsrzfzxgKuY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F41B91352A1;
        Wed, 24 Mar 2021 16:28:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 457841352A0;
        Wed, 24 Mar 2021 16:28:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] remote-curl.c: handle v1 when check_smart_http
References: <20210324053648.25584-1-lilinchao@oschina.cn>
        <006547b28c6311eb93820024e87935e7@oschina.cn>
Date:   Wed, 24 Mar 2021 13:28:32 -0700
In-Reply-To: <006547b28c6311eb93820024e87935e7@oschina.cn>
        (lilinchao@oschina.cn's message of "Wed, 24 Mar 2021 13:36:48 +0800")
Message-ID: <xmqq7dlwxpn3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 817CB818-8CDF-11EB-9F82-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lilinchao@oschina.cn writes:

>  		 * be handled elsewhere.
>  		 */
>  		d->proto_git = 1;
> -

Unrelated removal.

> +	} else if (!strcmp(reader.line, "version 1")) {
> +		die(_("v1 is just the original protocol with a version string, use v0 or v2 instead."));

The user may no longer get "invalid response; got 'version 1'", but
the above does not still explain why v1 is bad and v0 or v2 is
welcome, either.  IOW, I do not think the patch improves the message
to achieve what it attempted to do, i.e.

    ... but the other side just treat it as "invalid response", this
    can't explain why is not ok.

I wonder if it is a sensible and better alternative to treat v1
response as if we got v0 (if v1 is truly the same as v0 except for
the initial version advertisement).

Input from those who are familiar with the protocol versions is very
much appreciated.

Thanks.

>  	} else {
>  		die(_("invalid server response; got '%s'"), reader.line);
>  	}
