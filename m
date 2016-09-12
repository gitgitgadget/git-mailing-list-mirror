Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D503720985
	for <e@80x24.org>; Mon, 12 Sep 2016 23:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbcILXbL (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 19:31:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62242 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751790AbcILXbL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 19:31:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 043223CA5E;
        Mon, 12 Sep 2016 19:31:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9RbR+309NPP73x+BS20gbfWnbp8=; b=gVpudC
        i+46RISvqT6X9oaz6GarvTkOWNbEAGKsHfnyHPjHV68JJQVUT9o9TooZa8gWh6Ks
        waAQQeafpnJ5SP/Xl1qRqJNl9McsEC/i+YVNoqRp5rdE5pcy4WCw4eXK/0fGxDgw
        xCTM3vKB4ojS3bCjVGHpaAUYQ0wYIaAFtJUQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DQQ9bNCWSEYn73VAqVnxJEF01DGbzscm
        wc7TjY8xE6loCeS9O/5Jv+3JpEwlOrBqgjgBCnrZuU3CikALSkjdGOmXXA7PVQMy
        ETON93ZjFPNkTLYzbxnUAm/H77Ux6CUm++89ASLsdYIJ8Un8viT8jXzq9FPqF7Yo
        ZKqakptgmHQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F064C3CA5D;
        Mon, 12 Sep 2016 19:31:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 711AE3CA5C;
        Mon, 12 Sep 2016 19:31:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        tboegi@web.de, jacob.keller@gmail.com
Subject: Re: [PATCH v7 05/10] pkt-line: add packet_write_gently()
References: <20160908182132.50788-1-larsxschneider@gmail.com>
        <20160908182132.50788-6-larsxschneider@gmail.com>
Date:   Mon, 12 Sep 2016 16:31:07 -0700
In-Reply-To: <20160908182132.50788-6-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Thu, 8 Sep 2016 20:21:27
        +0200")
Message-ID: <xmqqeg4oy9tw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC146BAA-7940-11E6-96D6-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> +int packet_write_gently(const int fd_out, const char *buf, size_t size)
> +{
> +	static char packet_write_buffer[LARGE_PACKET_MAX];
> +
> +	if (size > sizeof(packet_write_buffer) - 4) {
> +		error("packet write failed");
> +		return -1;
> +	}
> +	packet_trace(buf, size, 1);
> +	size += 4;
> +	set_packet_header(packet_write_buffer, size);
> +	memcpy(packet_write_buffer + 4, buf, size - 4);
> +	if (write_in_full(fd_out, packet_write_buffer, size) == size)
> +		return 0;
> +
> +	error("packet write failed");
> +	return -1;
> +}

The same comment as 4/10 applies here.
