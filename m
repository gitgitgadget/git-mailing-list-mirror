Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08061FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 21:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757193AbeAHV2O (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 16:28:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56990 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756018AbeAHV2L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 16:28:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFF65B773D;
        Mon,  8 Jan 2018 16:28:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v9qI0ouO22k+9m0Aw32LioviFfw=; b=CjMTAA
        zjQcESOQiaLS0305leb+0wK9v7VFnYRmIjeJy5p64TFdOAo2GBAwx6OwWKwMHZ7W
        kUx3UHVkgQ35mN+n2t6t4Ajq1phh7GuckRXpYZh6cNM+t0J/BFs44w/CtC29wjAa
        wG3ev3e15MoFBBDxsctYommyXaWEkA2klj1FE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AqwuqZu0WeQODYI3KvEb/2YibNsQmLFb
        zF/Hu3aYNrx0d4mFlEpFLQ4Nv1XYRlaB5AwPzrPNy4BDkq7TCu+KelIU0dApBh8r
        JxBvVweRXtwbGyrvx0FoCgC40aErosZesc1mt372tcRp2Zo+JKkacntmc0l2UbYX
        /98Hb/6gw/c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E74FCB773C;
        Mon,  8 Jan 2018 16:28:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DA4CB773B;
        Mon,  8 Jan 2018 16:28:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 5/7] convert_to_git(): safe_crlf/checksafe becomes int conv_flags
References: <20180106004808.77513-1-lars.schneider@autodesk.com>
        <20180106004808.77513-6-lars.schneider@autodesk.com>
Date:   Mon, 08 Jan 2018 13:28:09 -0800
In-Reply-To: <20180106004808.77513-6-lars.schneider@autodesk.com> (lars
        schneider's message of "Sat, 6 Jan 2018 01:48:06 +0100")
Message-ID: <xmqq4lnw82hi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D349B288-F4BA-11E7-B259-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> diff --git a/sha1_file.c b/sha1_file.c
> index afe4b90f6e..dcb02e9ffd 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -75,14 +75,14 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
>  }
>  
>  
> -static enum safe_crlf get_safe_crlf(unsigned flags)
> +static int get_conv_flags(unsigned flags)
>  {
>  	if (flags & HASH_RENORMALIZE)
> -		return SAFE_CRLF_RENORMALIZE;
> +		return CONV_EOL_RENORMALIZE;
>  	else if (flags & HASH_WRITE_OBJECT)
> -		return safe_crlf;
> +		return global_conv_flags_eol | CONV_WRITE_OBJECT;

This macro has not yet introduced at this point (it appears in 6/7
if I am not mistaken).
