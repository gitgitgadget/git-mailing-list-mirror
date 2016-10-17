Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01821F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 17:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936253AbcJQRRk (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 13:17:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62179 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932489AbcJQRRg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 13:17:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 723AD46635;
        Mon, 17 Oct 2016 13:17:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DcRlo6IPwL2RTkwU7aXn2Y8PJmQ=; b=N+tYBH
        dww4nCD1QGauWfoctTAlU1E+VpTBKAOyLd/A3DvvU10t9gbDC5qrTenuOY7/CWLL
        wz+4tKEDkBwZFdxloamFIMluVYLs7/aSax5KivJXHLwsg/dcp8ktx70ke6GGe6n7
        OHcSqdJlvQ1y0BFIzFqzgw4Zv2LNGwBkaZhi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q9if0ByMUoYxjYJ6sdE9rgsli06hK55h
        nYT86HKcCs+Jfv9rP3NqClh3zYq7/CENeuu7EtRmfr9YCJiCIQOjprFdDYCqqqK2
        cO+Rdn27bnv6u5OckFBdlqvzggN+n+Ue79oe1Udfsg8fTEIzZ74eWTt0PtBzVAf5
        Zb1QT+CmUIo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A35F46634;
        Mon, 17 Oct 2016 13:17:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE61746632;
        Mon, 17 Oct 2016 13:17:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 14/25] sequencer: introduce a helper to read files written by scripts
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <b554346c600fafa71d2a3461fda8402e377b596e.1476120229.git.johannes.schindelin@gmx.de>
Date:   Mon, 17 Oct 2016 10:17:31 -0700
In-Reply-To: <b554346c600fafa71d2a3461fda8402e377b596e.1476120229.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 10 Oct 2016 19:25:47 +0200
        (CEST)")
Message-ID: <xmqqr37ex5ck.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97C99B3A-948D-11E6-9EA4-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +/*
> + * Reads a file that was presumably written by a shell script, i.e.
> + * with an end-of-line marker that needs to be stripped.
> + *
> + * Returns 1 if the file was read, 0 if it could not be read or does not exist.
> + */
> +static int read_oneliner(struct strbuf *buf,
> +	const char *path, int skip_if_empty)
> +...
> +	if (strbuf_read_file(buf, path, 0) < 0) {
> +		warning_errno(_("could not read '%s'"), path);
> +		return 0;
> +	}
> +	if (buf->len > orig_len && buf->buf[buf->len - 1] == '\n') {
> +		if (--buf->len > orig_len && buf->buf[buf->len - 1] == '\r')
> +			--buf->len;
> +		buf->buf[buf->len] = '\0';
> +	}

The name says "oneliner" but this reads the whole thing and trims
only the last line of the input.  Which is correct?

Do we want to error out if we got more than one line?  That makes it
more strict.  Going in the other direction, do we want to just read
the first line and ignore the remainder?  That allows users to leave
cruft after what matters.  I _think_ the existing code is closer to
the latter, i.e. something along the lines of ...

	struct strbuf oneline = STRBUF_INIT;
	FILE *fp = fopen(path, "r");
	if (!fp) {
		warning_errno(_("could not open '%s'"), path);
		return 0;
	}
	if (strbuf_getline(&oneline, fp) < 0)
		; /* EOF - empty */
	else {
		strbuf_addbuf(buf, &oneline);
	}
