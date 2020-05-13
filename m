Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37764C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C674F2078C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MSm74Tw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbgEMAK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:10:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57279 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgEMAK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 20:10:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90AEC4C528;
        Tue, 12 May 2020 20:10:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JQp4IIWqVYvbkL34eszW/kqdcIQ=; b=MSm74T
        w+oKQxXrrFtzUyf6PmZJK8vFjVQBTZjWEyC5XeYdsyPdOKpChdjUKWVXFeaEG2Av
        N3yVaXDz1DdP50F5ZFx76XmI1d9O2a666nzyeb0yi2l8ZUhIjaSpMIng2TUWHkBf
        vY9Yrc7+xZjzlQ3AsHCvBhtWDi22se8O8OJMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MsnAjdcEnavotjQ4PNaU1UBwZCgH/OPZ
        FyxT0GzgLpam749D0IFvmiXVcUJQn2bf0h+TvmnQ6U/e0ELXl2xoUOJHlM9PuouZ
        lg+mc1EIkcz8frK4p8iUWRfJ2JgalAXmAMa/8BcxrjOzZBmggvQu3zMAAYiNui4Y
        IvOY6AmlHPM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 880AB4C527;
        Tue, 12 May 2020 20:10:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C84194C526;
        Tue, 12 May 2020 20:10:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] http, imap-send: stop using CURLOPT_VERBOSE
References: <cover.1589218693.git.jonathantanmy@google.com>
        <1df9e9deb7831b32694ea453759bf5d21952e165.1589218693.git.jonathantanmy@google.com>
        <20200512231331.GA6605@camp.crustytoothpaste.net>
Date:   Tue, 12 May 2020 17:10:24 -0700
In-Reply-To: <20200512231331.GA6605@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 12 May 2020 23:13:31 +0000")
Message-ID: <xmqqwo5gwv7z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 253FE19E-94AE-11EA-BA9C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-05-11 at 17:43:10, Jonathan Tan wrote:
>> Whenever GIT_CURL_VERBOSE is set, teach Git to behave as if
>> GIT_TRACE_CURL=1 and GIT_TRACE_CURL_NO_DATA=1 is set, instead of setting
>> CURLOPT_VERBOSE.
>> 
>> This is to prevent inadvertent revelation of sensitive data. In
>> particular, GIT_CURL_VERBOSE redacts neither the "Authorization" header
>> nor any cookies specified by GIT_REDACT_COOKIES.
>
> I actually use GIT_CURL_VERBOSE to debug authentication problems from
> time to time, so I'd like to keep an option to produce full, unredacted
> output.  Since everyone uses HTTPS, it's not possible to perform this
> debugging using a tool like Wireshark unless you use a MITM CA cert,
> which seems excessive.

Hmm, that is a valid concern.  Introducing yet another environment
feels a bit yucky, but something like GIT_NO_REDACT that disables
any redacting, not limited to curl but in all codepaths, might turn
out to be a useful escape hatch.

Opinions?
