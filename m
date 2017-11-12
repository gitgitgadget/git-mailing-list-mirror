Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B471F43C
	for <e@80x24.org>; Sun, 12 Nov 2017 01:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbdKLBvh (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 20:51:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52451 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752443AbdKLBvg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 20:51:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D092A5894;
        Sat, 11 Nov 2017 20:51:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LHkgisNgHKqboylC/tWL5MMym4Y=; b=BY15mP
        9koiMwUshtZt+ZnPEMsr1AQwlP3YWiBGnIKTdHWy/2/8ygM9y+Qfg5Juea6okJqv
        IVsGo6YNsfdWOcwbSZqSdIekKZQ9hBV26H/pg7yshCVtco1P5rqeyM016RjiQH9w
        feO3pkdZTZsvBs5TLRQo9tPk98Wd3bFEdi8bo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bHcvD+snjWQPRoAl6zTMxSJFkv6eYV27
        fnKNOoDDW8O+tsz4enXRYbXZ0IBOJTTA/aHKyTLXa+eAOetWfw9pM3c1x2n1encR
        fMY4z9zwGok/UJHpxLvfKgc3vdvMLO+H53er3l4M2XGw4tBLdVee5aWkoFdqWVHI
        CxdkGzqczHA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75ADEA5892;
        Sat, 11 Nov 2017 20:51:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E99C4A5890;
        Sat, 11 Nov 2017 20:51:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerzy Kozera <jerzy.kozera@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: Strip CR chars for Windows gpg2
References: <20171111160657.11016-1-jerzy.kozera@gmail.com>
Date:   Sun, 12 Nov 2017 10:51:33 +0900
In-Reply-To: <20171111160657.11016-1-jerzy.kozera@gmail.com> (Jerzy Kozera's
        message of "Sat, 11 Nov 2017 16:06:57 +0000")
Message-ID: <xmqqr2t4cli2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 039658AC-C74C-11E7-A594-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerzy Kozera <jerzy.kozera@gmail.com> writes:

> +/* Strip CR from the line endings, in case we are on Windows. */
> +static void strip_cr(struct strbuf *buffer, size_t bottom) {
> +	size_t i, j;
> +	for (i = j = bottom; i < buffer->len; i++)
> +		if (buffer->buf[i] != '\r') {
> +			if (i != j)
> +				buffer->buf[j] = buffer->buf[i];
> +			j++;
> +		}
> +	strbuf_setlen(buffer, j);
> +}
> +

While the approach of turning CRLF into LF as a workaround is a good
one, I do not see this loop doing that; instead it is removing CR
anywhere on the line unconditionally.  

It might not make a difference in practice to rely on the assumption
that nobody sane would place a lone CR in the middle of a line, but
it feels dirty.

Because I know this was lifted from an existing code, I think it may
be better to take this patch as-is, but the code screams loudly that
it wants a clean-up patch to fix that immediately on top of it.

Thanks.


