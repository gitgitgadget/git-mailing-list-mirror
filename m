Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED98D207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 22:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757772AbcIPWRe (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 18:17:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55882 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755052AbcIPWRc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 18:17:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E1603EFF7;
        Fri, 16 Sep 2016 18:17:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qdth8qHd0d20XSvLRc/5G4qbf44=; b=J+Ib2B
        PbLLhbbHCemgFilkNmB+UYuKbva+bqrMayy24WGHrpy+XMTc+ZM5yh7Wgj2s9mb/
        Hlh3Zg2IosaErg3FHZQQdWfq8wEiOUSgoal5WEZHLSCzQvFBgpFUGrC6MBoQ6gPj
        BAc44oOBnv86GuJ1R1z70F/GxWpOxUSjeuLK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xQ1E4GdJJG1fF9qhDd9yrIzgsa3Tk1rW
        3GptvaE4UFaAPWWPvKe9OjCDVe+gXoz9nQ4VLulKUGm9SzUB6uUHTPzcZ1p4MWc3
        VOW14+vTWuO4nSng7h1e16aIXOGPkEYsjXpkt80XANqCCN5J1vpGNQM4Ap6ipjhg
        EqfhER6cY00=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F4623EFF6;
        Fri, 16 Sep 2016 18:17:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 73DDF3EFF5;
        Fri, 16 Sep 2016 18:17:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Wern <kevin.m.wern@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/11] pkt-line: create gentle packet_read_line functions
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
        <1473984742-12516-4-git-send-email-kevin.m.wern@gmail.com>
Date:   Fri, 16 Sep 2016 15:17:28 -0700
In-Reply-To: <1473984742-12516-4-git-send-email-kevin.m.wern@gmail.com> (Kevin
        Wern's message of "Thu, 15 Sep 2016 20:12:14 -0400")
Message-ID: <xmqqoa3nij5z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BC54C3C-7C5B-11E6-B0CE-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Wern <kevin.m.wern@gmail.com> writes:

>  	/* And complain if we didn't get enough bytes to satisfy the read. */
>  	if (ret < size) {
> -		if (options & PACKET_READ_GENTLE_ON_EOF)
> +		if (options & (PACKET_READ_GENTLE_ON_EOF | PACKET_READ_GENTLE_ALL))
>  			return -1;

The name _ALL suggested to me that there may be multiple "under this
condition, be gentle", "under that condition, be gentle", and _ALL
is used as a catch-all "under any condition, be gentle".  If you
defined _ALL symbol to have all GENTLE bits on, this line could have
become

	if (options & PACKET_READ_GENTLE_ALL)

> @@ -205,15 +209,23 @@ int packet_read(int fd, char **src_buf, size_t *src_len,
>  	if (ret < 0)
>  		return ret;
>  	len = packet_length(linelen);
> -	if (len < 0)
> +	if (len < 0) {
> +		if (options & PACKET_READ_GENTLE_ALL)
> +			return -1;

On the other hand, however, you do want to die here when only
GENTLE_ON_EOF is set.

Taking the above two observations together, I'd have to say that
_ALL is probably a misnomer.  I agree with a need for a flag with
the behaviour you defined in this patch, though.

>  		die("protocol error: bad line length character: %.4s", linelen);

>  static char *packet_read_line_generic(int fd,
>  				      char **src, size_t *src_len,
> -				      int *dst_len)
> +				      int *dst_len, int flags)

The original one is called options, not flags, and it would be
easier to follow if it is consistently called options, instead of
requiring the reader to keep track of "ah, it is called flags here
but the callee renames it to options".

> +/*
> + * Same as packet_read_line, but does not die on any errors (uses
> + * PACKET_READ_GENTLE_ALL).
> + */
> +char *packet_read_line_gentle(int fd, int *len_p);
> +
> +/*
> + * Same as packet_read_line_buf, but does not die on any errors (uses
> + * PACKET_READ_GENTLE_ALL).
> + */
> +char *packet_read_line_buf_gentle(char **src_buf, size_t *src_len, int *size);

I think most if not all "do the same thing as do_something() but
report errors instead of dying" variant of functions are named
do_something_gently(), not do_something_gentle().

