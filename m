Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20C04207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 23:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbcILXab (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 19:30:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60874 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751317AbcILXaa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 19:30:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0297B3EF45;
        Mon, 12 Sep 2016 19:30:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t3JlrGUbZfUZl6oU9B5LJRE4w+Q=; b=p7YSFu
        D023NfTOeQhZEx6RKJw4F5SWHK2gifJqC/TOVdReECiVxqhcdFvMjiPQOCByBxby
        vf1cjF8MVaH+Usj4LkGrLn8OG2qoxjy7g8YrQB5qaeYv9wFuWhA90QdlOYUperUU
        qGBtNjAVpqx4swviJ3FC+GFcRJDY/en/zcr7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j5+bvKmtxBK3zmSU9SFEF86MKDDvJjzT
        5NnXX5qsfMmRfX+XaESI+YvOBZY5Raw6EWhcZrCHsIprXtl9W3vHzhb4VUWjMoiA
        s+3XSyqPMb3mm3YfEWrLzExjyyXw+Amq4DEfWuiGQu9AZD0M7IFnmcM6gm9l5fRG
        yJdYhlcntek=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE0EE3EF44;
        Mon, 12 Sep 2016 19:30:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 681213EF41;
        Mon, 12 Sep 2016 19:30:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        tboegi@web.de, jacob.keller@gmail.com
Subject: Re: [PATCH v7 04/10] pkt-line: add packet_flush_gently()
References: <20160908182132.50788-1-larsxschneider@gmail.com>
        <20160908182132.50788-5-larsxschneider@gmail.com>
Date:   Mon, 12 Sep 2016 16:30:26 -0700
In-Reply-To: <20160908182132.50788-5-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Thu, 8 Sep 2016 20:21:26
        +0200")
Message-ID: <xmqqinu0y9v1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E39DE556-7940-11E6-B630-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> packet_flush() would die in case of a write error even though for some
> callers an error would be acceptable. Add packet_flush_gently() which
> writes a pkt-line flush packet and returns `0` for success and `-1` for
> failure.
> ...
> +int packet_flush_gently(int fd)
> +{
> +	packet_trace("0000", 4, 1);
> +	if (write_in_full(fd, "0000", 4) == 4)
> +		return 0;
> +	error("flush packet write failed");
> +	return -1;

It is more idiomatic to do

	return error(...);

but more importantly, does the caller even want an error message
unconditionally printed here?

I suspect that it is a strong sign that the caller wants to be in
control of when and what error message is produced; otherwise it
wouldn't be calling the _gently() variant, no?

Of course, if you have written callers to this function in later
patches in this series, they would be responsible for reporting (or
choosing not to report) this failure, but I think making this
function silent is a better course in the longer term.
