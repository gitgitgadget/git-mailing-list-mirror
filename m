Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9380F1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 05:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbeK0QZO (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 11:25:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61705 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbeK0QZO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 11:25:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF35827A0B;
        Tue, 27 Nov 2018 00:28:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8bbsQ+hy61Yx8Vr0T7sqyhYbQXs=; b=LH9brL
        5guE8NxRsLlxow2x7OHbQ7KgkzgJrmhlszivFhjpr/b8wzP+mNtQ4eHVozoJo/Bt
        T2QP18otTnhXz87fn7l/PjOTgYGiKnTdQ0t/oMsYZFCHEZR40iuUdUMcRBcxdBLW
        LJJZ57zzrjwjjxaVmYYduluQ+tlsfEqF+5Hv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=isoPIUQhsPChK7OXtwGoj+Eo/vWh5vKB
        nW2NmzE246otbbjzZlGkBrYN0wu1sHMr2tD6H8vOAhv2U96kC31A7P51+UZAlLq9
        lFOzbdh65JnvGarX9jvgqlt6BwA+xS3IrVbRxfveWkwD7IX33x5ltRtnD9kmflpR
        qisxc+l3ST8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A6F6727A0A;
        Tue, 27 Nov 2018 00:28:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8C2B427A09;
        Tue, 27 Nov 2018 00:28:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-protocol.txt: accept error packets in any context
References: <20181127045301.103807-1-masayasuzuki@google.com>
Date:   Tue, 27 Nov 2018 14:28:25 +0900
In-Reply-To: <20181127045301.103807-1-masayasuzuki@google.com> (Masaya
        Suzuki's message of "Mon, 26 Nov 2018 20:53:01 -0800")
Message-ID: <xmqqh8g3t7gm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44AED3A2-F205-11E8-ADA7-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masaya Suzuki <masayasuzuki@google.com> writes:

> In the Git pack protocol definition, an error packet may appear only in
> a certain context. However, servers can face a runtime error (e.g. I/O
> error) at an arbitrary timing. This patch changes the protocol to allow
> an error packet to be sent instead of any packet.

Makes perfect sense.

> Following this protocol spec change, the error packet handling code is
> moved to pkt-line.c.
>
> Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
> ---
>  Documentation/technical/pack-protocol.txt | 20 +++++++++++---------
>  builtin/archive.c                         |  2 --
>  connect.c                                 |  2 --
>  fetch-pack.c                              |  2 --
>  pkt-line.c                                |  4 ++++
>  5 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index 6ac774d5f..7a2375a55 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -22,6 +22,16 @@ protocol-common.txt. When the grammar indicate `PKT-LINE(...)`, unless
>  otherwise noted the usual pkt-line LF rules apply: the sender SHOULD
>  include a LF, but the receiver MUST NOT complain if it is not present.
>  
> +An error packet is a special pkt-line that contains an error string.
> +
> +----
> +  error-line     =  PKT-LINE("ERR" SP explanation-text)
> +----
> +
> +Throughout the protocol, where `PKT-LINE(...)` is expected, an error packet MAY
> +be sent. Once this packet is sent by a client or a server, the data transfer
> +process defined in this protocol is terminated.
> +
>  Transports
>  ----------
>  There are three transports over which the packfile protocol is
> @@ -89,13 +99,6 @@ process on the server side over the Git protocol is this:
>       "0039git-upload-pack /schacon/gitbook.git\0host=example.com\0" |
>       nc -v example.com 9418
>  
> -If the server refuses the request for some reasons, it could abort
> -gracefully with an error message.
> -
> -----
> -  error-line     =  PKT-LINE("ERR" SP explanation-text)
> -----
> -
>  
>  SSH Transport
>  -------------
> @@ -398,12 +401,11 @@ from the client).
>  Then the server will start sending its packfile data.
>  
>  ----
> -  server-response = *ack_multi ack / nak / error-line
> +  server-response = *ack_multi ack / nak
>    ack_multi       = PKT-LINE("ACK" SP obj-id ack_status)
>    ack_status      = "continue" / "common" / "ready"
>    ack             = PKT-LINE("ACK" SP obj-id)
>    nak             = PKT-LINE("NAK")
> -  error-line     =  PKT-LINE("ERR" SP explanation-text)
>  ----
>  
>  A simple clone may look like this (with no 'have' lines):
> diff --git a/builtin/archive.c b/builtin/archive.c
> index d2455237c..5d179bbd1 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -59,8 +59,6 @@ static int run_remote_archiver(int argc, const char **argv,
>  	if (strcmp(buf, "ACK")) {
>  		if (starts_with(buf, "NACK "))
>  			die(_("git archive: NACK %s"), buf + 5);
> -		if (starts_with(buf, "ERR "))
> -			die(_("remote error: %s"), buf + 4);
>  		die(_("git archive: protocol error"));
>  	}
>  
> diff --git a/connect.c b/connect.c
> index 24281b608..458906e60 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -306,8 +306,6 @@ struct ref **get_remote_heads(struct packet_reader *reader,
>  			die_initial_contact(1);
>  		case PACKET_READ_NORMAL:
>  			len = reader->pktlen;
> -			if (len > 4 && skip_prefix(reader->line, "ERR ", &arg))
> -				die(_("remote error: %s"), arg);
>  			break;
>  		case PACKET_READ_FLUSH:
>  			state = EXPECTING_DONE;
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 9691046e6..e66cd7b71 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -178,8 +178,6 @@ static enum ack_type get_ack(int fd, struct object_id *result_oid)
>  			return ACK;
>  		}
>  	}
> -	if (skip_prefix(line, "ERR ", &arg))
> -		die(_("remote error: %s"), arg);
>  	die(_("git fetch-pack: expected ACK/NAK, got '%s'"), line);
>  }
>  
> diff --git a/pkt-line.c b/pkt-line.c
> index 04d10bbd0..ce9e42d10 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -346,6 +346,10 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
>  		return PACKET_READ_EOF;
>  	}
>  
> +	if (starts_with(buffer, "ERR ")) {
> +		die(_("remote error: %s"), buffer + 4);
> +	}
> +
>  	if ((options & PACKET_READ_CHOMP_NEWLINE) &&
>  	    len && buffer[len-1] == '\n')
>  		len--;
