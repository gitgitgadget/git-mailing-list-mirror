Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 511112036B
	for <e@80x24.org>; Wed,  4 Oct 2017 06:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbdJDGO4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 02:14:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50549 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751250AbdJDGOz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 02:14:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D9B1A1935;
        Wed,  4 Oct 2017 02:14:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CEx41jxTIZWDyfRko3PeCdz4/3w=; b=tpLk+O
        cs69f8FH72ASS6jDTzFGRj/77nZDUSmIXuHx/q6vYnzG11yz7NoVbjeyO33xHDNk
        B8zejaf+lzvJplXC2ftGPkyRZtw6QCsSp++08lUnxsMP1cGiyaIzmBwRnnD6wBNT
        ZxxLZYXSBJ7jU1tZrXJ5aZPc3qivH8lTAxCtY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JPbH/S1mLXzDq8RX4HAdNIkvJ8Yyyj3K
        f3TjmKrtvCs7JnJhW17+Uk9T+JBnxldjSUKyDok+Ssstp9jUK67BMfBUeFNLEEXL
        6KjxcTq2g+MVAm1YzZajBf4pT/SksqCFgnoVMKTaQS8/0GyKOu70EDDtFGVQ8rDG
        sAOLZIboPDc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34C75A1934;
        Wed,  4 Oct 2017 02:14:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9BF0FA1933;
        Wed,  4 Oct 2017 02:14:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com,
        sbeller@google.com
Subject: Re: [PATCH v3 4/5] sha1_name: Parse less while finding common prefix
References: <20170925095452.66833-1-dstolee@microsoft.com>
        <20171002145651.204984-5-dstolee@microsoft.com>
Date:   Wed, 04 Oct 2017 15:14:52 +0900
In-Reply-To: <20171002145651.204984-5-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 2 Oct 2017 10:56:50 -0400")
Message-ID: <xmqqlgkrcucj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5639B6A2-A8CB-11E7-8FEF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> diff --git a/sha1_name.c b/sha1_name.c
> index f2a1ebe49..5081aeb71 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -480,13 +480,23 @@ struct min_abbrev_data {
>  	char *hex;
>  };
>  
> +static inline char get_hex_char_from_oid(const struct object_id *oid,
> +					 int pos)
> +{
> +	static const char hex[] = "0123456789abcdef";
> +
> +	if ((pos & 1) == 0)
> +		return hex[oid->hash[pos >> 1] >> 4];
> +	else
> +		return hex[oid->hash[pos >> 1] & 0xf];
> +}
> +


>  static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
>  {
>  	struct min_abbrev_data *mad = cb_data;
>  
> -	char *hex = oid_to_hex(oid);
>  	unsigned int i = mad->init_len;
> -	while (mad->hex[i] && mad->hex[i] == hex[i])
> +	while (mad->hex[i] && mad->hex[i] == get_hex_char_from_oid(oid, i))
>  		i++;

Assuming that [PATCH 3/5] makes sense, it is an obvious optimization
to avoid writing the whole 20-byte out before comparing, and instead
to grab hex digits as they become needed.

I assume that the "Base Time" in the log message was with whatever
version of Git before [PATCH 3/5] and this one were applied
(i.e. not comparing to "vanilla Git plus 3/5")?

Thanks.
