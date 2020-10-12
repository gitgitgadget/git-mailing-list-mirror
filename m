Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC21C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 21:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4398208D5
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 21:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bwyuKEbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbgJLVAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 17:00:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54785 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbgJLVAk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 17:00:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0AD3F257D;
        Mon, 12 Oct 2020 17:00:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dhaeNI7F07XyZMM4D9nnB+aFJYE=; b=bwyuKE
        bPvHjXoWoO3dVJY5XMggvgRn3AcOnnfeNe9ZNeR1IvCrIiWVK1fSDDO0fmq/11ki
        fFH/c7J32j+fbR6F1TOnjuuc9O8FKS+19NJGeK3zxrwgPoDTXaAbXnM5dLQVXhoh
        iUGRnoGkmhYNa+HCkRz6nCDrA3qOcQ7oqtlog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TUpZcBK2HRM2S4/dG2BYu39ZiSAhUfZW
        sEOBCAqChBsfgHiMT+a6b2FxHtri07GnJvsMlppTWmcwgqaESiupZoLAQsIXKH1T
        YNjygdaHlbSZrv3fYFYdGqlzTrx0oOM/XGgoUi059Q/uTtC22DAbzE6ikmCE5WEJ
        ucE7SwfGAEo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8DA8F257C;
        Mon, 12 Oct 2020 17:00:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 35F43F2574;
        Mon, 12 Oct 2020 17:00:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sean McAllister <smcallis@google.com>, git@vger.kernel.org,
        peff@peff.net, masayasuzuki@google.com
Subject: Re: [PATCH 3/3] http: automatically retry some requests
References: <20201012184806.166251-1-smcallis@google.com>
        <20201012184806.166251-3-smcallis@google.com>
        <nycvar.QRO.7.76.6.2010122126280.50@tvgsbejvaqbjf.bet>
Date:   Mon, 12 Oct 2020 14:00:34 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010122126280.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 12 Oct 2020 22:15:38 +0200 (CEST)")
Message-ID: <xmqqtuuzma6l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9B8AE64-0CCD-11EB-AA7D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Sean,
>
> On Mon, 12 Oct 2020, Sean McAllister wrote:
>
>> Some HTTP response codes indicate a server state that can support
>> retrying the request rather than immediately erroring out.  The server
>> can also provide information about how long to wait before retries to
>> via the Retry-After header.  So check the server response and retry
>> some reasonable number of times before erroring out to better accomodate
>> transient errors.
>>
>> Exiting immediately becomes irksome when pulling large multi-repo code
>> bases such as Android or Chromium, as often the entire fetch operation
>> has to be restarted from the beginning due to an error in one repo. If
>> we can reduce how often that occurs, then it's a big win.
>
> Makes a lot of sense to me.
> ...
>> +http.retryLimit::
>> +	Some HTTP error codes (eg: 429,503) can reasonably be retried if
>
> Please have a space after the comma so that it is not being mistaken for a
> 6-digit number. Also, aren't they called "status codes"? Not all of them
> indicate errors, after all.
> ...

I've read your comments and agree to them all.  Thanks for a
detailed and excellent review.

