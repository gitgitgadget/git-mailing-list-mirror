Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9369E207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 02:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759114AbdDSCvM (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 22:51:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52847 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759081AbdDSCvK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 22:51:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD147821CF;
        Tue, 18 Apr 2017 22:51:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3wm0/Plr7bIIHgI6X5BvAoPH8po=; b=jdZyrB
        n0Z/3PvnXYYjcDtIf0PapRpJkzkdD9VfQFjyvWcWQKNb00YjVvNR06cGy78v1MrU
        UvWrB+U2uo7SEwMENDYMQEfrwJWtrgA4BsJJje2t+T2ggmDKHzk01av08QxEai4Q
        MY5UNMaaa1fB8H3+cugZu0FZvImndaDWoMXmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=feXmzUFVcWC+hIwXSafd8EIZETbFcEtJ
        JdltgFrVoi8Z9ClsQV4t8GhdO2jeo6PwLdtKUOGDN/FPvPI45ZFxkt11molZCI1X
        XOGvzvQvB6iUdvPNWZgK1Yizk0ZLHlt4khwbhECmvn3X5WoClimY638fBYlZmoLq
        +hLLnORwCvQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6266821CE;
        Tue, 18 Apr 2017 22:51:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 413EA821CD;
        Tue, 18 Apr 2017 22:51:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        l.s.r@web.de
Subject: Re: [PATCH v3 2/2] xgethostname: handle long hostnames
References: <20170418215743.18406-1-dturner@twosigma.com>
        <20170418215743.18406-3-dturner@twosigma.com>
        <20170419013552.GB28740@aiede.svl.corp.google.com>
Date:   Tue, 18 Apr 2017 19:51:08 -0700
In-Reply-To: <20170419013552.GB28740@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Tue, 18 Apr 2017 18:35:52 -0700")
Message-ID: <xmqq4lxlcdpf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A88DEEE-24AB-11E7-B873-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> David Turner wrote:
>
>> If the full hostname doesn't fit in the buffer supplied to
>> gethostname, POSIX does not specify whether the buffer will be
>> null-terminated, so to be safe, we should do it ourselves.  Introduce
>> new function, xgethostname, which ensures that there is always a \0
>> at the end of the buffer.
>
> I think we should detect the error instead of truncating the hostname.
> That (on top of your patch) would look like the following.
>
> Thoughts?
> Jonathan
>
> diff --git i/wrapper.c w/wrapper.c
> index d837417709..e218bd3bef 100644
> --- i/wrapper.c
> +++ w/wrapper.c
> @@ -660,11 +660,13 @@ int xgethostname(char *buf, size_t len)
>  {
>  	/*
>  	 * If the full hostname doesn't fit in buf, POSIX does not
> -	 * specify whether the buffer will be null-terminated, so to
> -	 * be safe, do it ourselves.
> +	 * guarantee that an error will be returned. Check for ourselves
> +	 * to be safe.
>  	 */
>  	int ret = gethostname(buf, len);
> -	if (!ret)
> -		buf[len - 1] = 0;
> +	if (!ret && !memchr(buf, 0, len)) {
> +		errno = ENAMETOOLONG;
> +		return -1;
> +	}

Hmmmm.  "Does not specify if the buffer will be NUL-terminated"
would mean that it is OK for the platform gethostname() to stuff
sizeof(buf)-1 first bytes of the hostname in the buffer and then
truncate by placing '\0' at the end of the buf, and we would not
notice truncation with the above change on such a platform, no?
