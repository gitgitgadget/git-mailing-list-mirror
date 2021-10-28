Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3232C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 01:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC1A60F6F
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 01:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhJ1BER (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 21:04:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54265 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhJ1BEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 21:04:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19E9BECDFF;
        Wed, 27 Oct 2021 21:01:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gdC4oHr3RATKH2NWKAyDBfX6vg4abiuWziKSxd
        rpE+Y=; b=XG9qwW7JnSi04KJfoXeYtyLI9LkIgpdgtf0n9EzwPxd2iGwTKk2MPU
        usMYWOSqBK3SdQBwmZ1A+hVBg11o1CseJ+QoyakEX3wgjdqyyYX+mA7niMx0mN+f
        MhvFE0ToY0/qcTk6uRXque8+CVViklcnWax2E4TW9t1J6I3FJSTz0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11D1EECDFE;
        Wed, 27 Oct 2021 21:01:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70599ECDFC;
        Wed, 27 Oct 2021 21:01:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ivan Frade <ifrade@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 1/2] fetch-pack: redact packfile urls in traces
References: <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
        <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
        <973a250752c39c3fe835d69f3fbe8f009fc4fa74.1635288599.git.gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 18:01:48 -0700
In-Reply-To: <973a250752c39c3fe835d69f3fbe8f009fc4fa74.1635288599.git.gitgitgadget@gmail.com>
        (Ivan Frade via GitGitGadget's message of "Tue, 26 Oct 2021 22:49:58
        +0000")
Message-ID: <xmqq35omt11f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A16AF008-378A-11EC-BBC0-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ivan Frade <ifrade@google.com>
>
> In some setups, packfile uris act as bearer token. It is not
> recommended to expose them plainly in logs, although in special
> circunstances (e.g. debug) it makes sense to write them.
>
> Redact the packfile URL paths by default, unless the GIT_TRACE_REDACT
> variable is set to false. This mimics the redacting of the Authorization
> header in HTTP.
>
> Signed-off-by: Ivan Frade <ifrade@google.com>
> ---
>  Documentation/git.txt  |  5 +++--
>  fetch-pack.c           |  3 +++
>  pkt-line.c             | 40 ++++++++++++++++++++++++++++++++-
>  pkt-line.h             |  1 +
>  t/t5702-protocol-v2.sh | 51 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 97 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index d63c65e67d8..f64c8ce5183 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -832,8 +832,9 @@ for full details.
>  
>  `GIT_TRACE_REDACT`::
>  	By default, when tracing is activated, Git redacts the values of
> -	cookies, the "Authorization:" header, and the "Proxy-Authorization:"
> -	header. Set this variable to `0` to prevent this redaction.
> +	cookies, the "Authorization:" header, the "Proxy-Authorization:"
> +	header and packfile URLs. Set this variable to `0` to prevent this
> +	redaction.

Just a curiosity.  Do we call these packfile URI, or packfile URL?

> diff --git a/pkt-line.c b/pkt-line.c
> index 2dc8ac274bd..ba0a2d65f0c 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -370,6 +370,31 @@ int packet_length(const char lenbuf_hex[4])
>  	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
>  }
>  
> +static char *find_url_path(const char* buffer, int *path_len)
> +{
> +	const char *URL_MARK = "://";
> +	char *path = strstr(buffer, URL_MARK);
> +	if (!path)
> +		return NULL;

Hmph, the format we expect is "<hash> <uri>"; don't we need to
validate the leading <hash> followed by SP?

    len = strspn(buffer, "0123456789abcdefABCDEF");
    if (len != 40 || len != 64 || buffer[len] != ' ')
	return NULL; /* required "<hash> SP" not seen */
    path = strstr(buffer + len + 1, URL_MARK);

or somesuch?

> +	path += strlen(URL_MARK);

OK.

> +	while (*path && *path != '/')
> +		path++;

strchr()?

> +	if (!*path || !*(path + 1))
> +		return NULL;

OK.

> +	// position after '/'

No // comments in our codebase, please.  Unless it is a borrowed
code, that is.

> +	path++;
> +
> +	if (path_len) {
> +		char *url_end = strchrnul(path, ' ');

Is this because SP is not a valid character in packfile URI, or at
this point in the callchain it would be encoded or something?  The
format we expect is "<hash> <uri>", so we shouldn't even have to
look for SP but just redact everything to the end, no?

Apparently we are assuming that there won't be more than one such
URL-path that needs redacting in the packet, but that is perfectly
fine, as the sole goal of this helper is to identify the packfile
URI packet and redact it in the log.

> +		*path_len = url_end - path;
> +	}
> +
> +	return path;
> +}

> -	packet_trace(buffer, len, 0);
> +	if (options & PACKET_READ_REDACT_URL_PATH &&
> +	    (url_path_start = find_url_path(buffer, &url_path_len))) {
> +		const char *redacted = "<redacted>";
> +		struct strbuf tracebuf = STRBUF_INIT;
> +		strbuf_insert(&tracebuf, 0, buffer, len);
> +		strbuf_splice(&tracebuf, url_path_start - buffer,
> +			      url_path_len, redacted, strlen(redacted));
> +		packet_trace(tracebuf.buf, tracebuf.len, 0);
> +		strbuf_release(&tracebuf);

I briefly wondered if the repeated allocation (and more
fundamentally, preparing the redacted copy of packet whether we are
actually tracing the packet in the first place) is blindly wasting
the resources too much, but this only happens in the protocol header
part, so it might be OK.

Even if that is not the case, we should be able to update
fetch_pack.c::do_fetch_pack_v2() so that the REDACT_URL_PATH bit is
turned on in a much narrower region of code, right?  Enable when we
enter the GET_PACK state and drop the bit when we are done with the
packfile URI packets, or something?

Thanks for working on this.


> +	} else {
> +		packet_trace(buffer, len, 0);
> +	}
