Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5188820196
	for <e@80x24.org>; Thu, 14 Jul 2016 18:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbcGNSiI (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 14:38:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751690AbcGNSiG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 14:38:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E5962B9EF;
	Thu, 14 Jul 2016 14:38:05 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1N9ZpUPIMz5XL1kpjgz2kUAtpVI=; b=rET+cy
	YvIfwp7Z7AY7OSGU+CUgxDKBbKrpZmg9ZPMLStYE3jBnz1AC6TrUxhgfyeEbd7xC
	fPFb8kIcJwU77mUpgI7pUyYlXdfrkJk7EG/lXOBSeaAHguF0vxNM71BicZWrZ8aY
	uNEyJtDM/861VOU4Ym4mpk1gmSPT54afTCLm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DmUmV9kt80w60c78obBiClx/ViO2OlGj
	cMj0mQFQYFNJMug9/NpCNEFyJkAogfghKcvjSEjFeZ3exFHB0MH7laHEqoRHzcXa
	2A4nYTPVIWT6PNs1h43whD7kp4geh5JFeoywE7NZxshE1UOd0f0Cfb+F57HFFIFJ
	UQELdfTlr6Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 267022B9EE;
	Thu, 14 Jul 2016 14:38:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9CD3B2B9ED;
	Thu, 14 Jul 2016 14:38:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, dwwang@google.com, e@80x24.org, peff@peff.net,
	dennis@kaarsemaker.net, jrnieder@gmail.com
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving push options
References: <20160714173920.22001-1-sbeller@google.com>
	<20160714173920.22001-3-sbeller@google.com>
Date:	Thu, 14 Jul 2016 11:38:02 -0700
In-Reply-To: <20160714173920.22001-3-sbeller@google.com> (Stefan Beller's
	message of "Thu, 14 Jul 2016 10:39:18 -0700")
Message-ID: <xmqqk2goqd4l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19EC427A-49F2-11E6-8C5E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +static struct string_list *read_push_options(void)
> +{
> +	struct string_list *ret = xmalloc(sizeof(*ret));
> +	string_list_init(ret, 1);
> +
> +	while (1) {
> +		char *line, *lf;
> +		int len;
> +
> +		line = packet_read_line(0, &len);
> +
> +		if (!line)
> +			break;
> +
> +		/*
> +		* NEEDSWORK: expose the limitations to be configurable;
> +		* Once the limit can be lifted, include a way for payloads
> +		* larger than one pkt, e.g use last byte to indicate if
> +		* the push option continues in the next packet or implement
> +		* larger packets.
> +		*/
> +		if (len > LARGE_PACKET_MAX - 1) {

packet_read_line() calls packet_read_line_generic() that calls
packet_read() with the fixed packet_buffer[] that is sized to be
LARGE_PACKET_MAX.

Can this check even trigger?

> +			/*
> +			 * NEEDSWORK: The error message in die(..) is not
> +			 * transmitted in call cases, so ideally all die(..)
> +			 * calls are prefixed with rp_error and then we can
> +			 * combine rp_error && die into one helper function.
> +			 */
> +			rp_error("protocol error: server configuration allows push "
> +				 "options of size up to %d bytes",
> +				 LARGE_PACKET_MAX - 1);
> +			die("protocol error: push options too large");
> +		}

> +		lf = strchr(line, '\n');
> +		if (lf)
> +			*lf = '\0';

packet_read_line() -> packet_read_line_generic() calls packet_read()
with PACKET_READ_CHOMP_NEWLINE flag bit; do we need this check?

> +
> +		string_list_append(ret, line);
> +	}
> +
> +	return ret;
> +}

Other than that, looks good to me.

Thanks.
