Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D04E207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 04:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164626AbdDXEVg (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 00:21:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59768 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1164473AbdDXEVe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 00:21:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 607767E1C9;
        Mon, 24 Apr 2017 00:21:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=btofBkfXN8i5j/kN2MA60R0J3RY=; b=B8Xvb7
        0/MuqDtkr5YMC7/SUd8ybGlEB9WcaJJdUL1HKDyAX8tETTtv1dO78n7NS4J7Wdb6
        tAP/ALptjq7jFP2B6uuMOExBogMvoeTfekx5RIKXWeMis507kdqpRzGX4qWaKtQF
        BY8Q9xXa1ScD5flZrb8+GF1O4dy8ayc5hke08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HTlErfMgv9CI52UGKd7ie2I2RvSc675u
        YshE110OtPJKu5ibhQ5f719q/BQWkVlssdCA19YjSfZ/0Iw3pylgHTjbF90w6Hi3
        Syr/H9NLB8l2Z0QnlRt9C5PMcNPCFbFB1lx497UloRIJFgOxHKJLnVO7wt3oEQVO
        DyJD3vPjpUo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5864E7E1C8;
        Mon, 24 Apr 2017 00:21:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ABE387E1C7;
        Mon, 24 Apr 2017 00:21:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v6 1/8] pkt-line: add packet_read_line_gently()
References: <20170421172611.12152-1-benpeart@microsoft.com>
        <20170421172611.12152-2-benpeart@microsoft.com>
Date:   Sun, 23 Apr 2017 21:21:31 -0700
In-Reply-To: <20170421172611.12152-2-benpeart@microsoft.com> (Ben Peart's
        message of "Fri, 21 Apr 2017 13:26:04 -0400")
Message-ID: <xmqqy3uqzb90.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F386B3A-28A5-11E7-82A2-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Add packet_read_line_gently() to enable reading a line without dying on
> EOF.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  pkt-line.c | 14 +++++++++++++-
>  pkt-line.h | 10 ++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index d4b6bfe076..bfdb177b34 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -315,7 +315,7 @@ static char *packet_read_line_generic(int fd,
>  			      PACKET_READ_CHOMP_NEWLINE);
>  	if (dst_len)
>  		*dst_len = len;
> -	return len ? packet_buffer : NULL;
> +	return (len > 0) ? packet_buffer : NULL;
>  }

The log does not seem to explain what this change is about.  

Is this supposed to be a preliminary bugfix where this helper used
to return a non-NULL buffer when underlying packet_read() signaled
an error by returning a negative len?  If so, this should probably
be a separate patch early in the series.

Should len==0 be considered an error?  Especially given that
PACKET_READ_CHOMP_NEWLINE is in use, I would expect that len==0
should be treated similarly to positive length, i.e. the otherside
gave us an empty line.

>  char *packet_read_line(int fd, int *len_p)
> @@ -323,6 +323,18 @@ char *packet_read_line(int fd, int *len_p)
>  	return packet_read_line_generic(fd, NULL, NULL, len_p);
>  }
>  
> +int packet_read_line_gently(int fd, int *dst_len, char** dst_line)

ERROR: "foo** bar" should be "foo **bar"
#29: FILE: pkt-line.c:326:
+int packet_read_line_gently(int fd, int *dst_len, char** dst_line)

> +{
> +	int len = packet_read(fd, NULL, NULL,
> +			      packet_buffer, sizeof(packet_buffer),
> +			      PACKET_READ_CHOMP_NEWLINE|PACKET_READ_GENTLE_ON_EOF);
> +	if (dst_len)
> +		*dst_len = len;
> +	if (dst_line)
> +		*dst_line = (len > 0) ? packet_buffer : NULL;

I have the same doubt as above for len == 0 case.

> +	return len;
> +}
> +
>  char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
>  {
>  	return packet_read_line_generic(-1, src, src_len, dst_len);
> diff --git a/pkt-line.h b/pkt-line.h
> index 18eac64830..ad30db101a 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -74,6 +74,16 @@ int packet_read(int fd, char **src_buffer, size_t *src_len, char
>  char *packet_read_line(int fd, int *size);
>  
>  /*
> + * Convenience wrapper for packet_read that sets the PACKET_READ_GENTLE_ON_EOF
> + * and CHOMP_NEWLINE options. The return value specifies the number of bytes
> + * read into the buffer or -1 on truncated input. If the *dst_line parameter
> + * is not NULL it will return NULL for a flush packet and otherwise points to
> + * a static buffer (that may be overwritten by subsequent calls). If the size
> + * parameter is not NULL, the length of the packet is written to it.
> + */
> +int packet_read_line_gently(int fd, int *size, char** dst_line);
> +
> +/*
>   * Same as packet_read_line, but read from a buf rather than a descriptor;
>   * see packet_read for details on how src_* is used.
>   */
