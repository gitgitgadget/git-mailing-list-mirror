Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2D9C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B3260F22
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhJKUlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:41:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63646 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhJKUlj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:41:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8257215D163;
        Mon, 11 Oct 2021 16:39:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=36NhFaKO6cOf
        lYE7aQjpWomtPNiOjnnEeEYqtYaw/vw=; b=Bk4hjJgwSlWYCQ6fE1TPQyq9n41F
        9jRVWR91LebmDbVMbJ8jQ9qlGeaWqHVIE8Md2UByS3tUGwX+cYg33fHPoxXcBX4b
        ti1N3GDbakadZZoOBhrFUOgOsi2+TfwXCupZa0erYuhqVdNVxgRW2HAZYKL+iThs
        URccmlXYI0biH2A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7BA0315D161;
        Mon, 11 Oct 2021 16:39:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C56D515D15C;
        Mon, 11 Oct 2021 16:39:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ivan Frade <ifrade@google.com>
Subject: Re: [PATCH v2] fetch-pack: redact packfile urls in traces
References: <pull.1052.git.1633708986.gitgitgadget@gmail.com>
        <pull.1052.v2.git.1633746024175.gitgitgadget@gmail.com>
Date:   Mon, 11 Oct 2021 13:39:34 -0700
In-Reply-To: <pull.1052.v2.git.1633746024175.gitgitgadget@gmail.com> (Ivan
        Frade via GitGitGadget's message of "Sat, 09 Oct 2021 02:20:24 +0000")
Message-ID: <xmqqczobb8jd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 58D18EB0-2AD3-11EC-9FA7-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
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
> Redact the packfile-uri lines by default, unless the GIT_TRACE_REDACT
> variable is set to false. This mimics the redacting of the
> Authorization header in HTTP.

Well explained.

It of course is a different matter if the explained idea is
agreeable, though ;-).  Hiding the entire packet, based on the "it
might be in some setups" seems a bit too much.

Is it often the case that the whole URI is sensitive, or perhaps
leading "<scheme>://<host>/pack-<abc>.pack" part is not sensitive at
all, and what follows after that "public" part has some "nonce"
material that makes it sensitive?

> Changes since v1:
> - Removed non-POSIX flags in tests
> - More accurate regex for the non-encrypted packfile line
> - Dropped documentation change
> - Dropped redacting the die message in http-fetch

These are not for those who read "git log" in 3 months, as they may
not even have seen the "v1".  But these are very helpful for those
who read the "v1" to see how good this round is.  Please write such
material below the three-dash line.

> Signed-off-by: Ivan Frade <ifrade@google.com>
> ---

i.e. here.

>     fetch-pack: redact packfile urls in traces
>    =20
>     In some setups, packfile uris act as bearer token. It is not recomm=
ended
>     to expose them plainly in logs, although in special circunstances (=
e.g.
>     debug) it makes sense to write them.
>    =20
>     Redact the packfile-uri lines by default, unless the GIT_TRACE_REDA=
CT
>     variable is set to false. This mimics the redacting of the Authoriz=
ation
>     header in HTTP.
>    =20
>     Signed-off-by: Ivan Frade ifrade@google.com
>    =20
>     cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason avarab@gmail.com

And there is no need to duplicate the log message here ;-)

> diff --git a/fetch-pack.c b/fetch-pack.c
> index a9604f35a3e..05c85eeafa1 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1518,7 +1518,16 @@ static void receive_wanted_refs(struct packet_re=
ader *reader,
>  static void receive_packfile_uris(struct packet_reader *reader,
>  				  struct string_list *uris)
>  {
> +	int original_options;
>  	process_section_header(reader, "packfile-uris", 0);
> +	/*
> +	 * In some setups, packfile-uris act as bearer tokens,
> +	 * redact them by default.
> +	 */
> +	original_options =3D reader->options;
> +	if (git_env_bool("GIT_TRACE_REDACT", 1))
> +		reader->options |=3D PACKET_READ_REDACT_ON_TRACE;
> +
>  	while (packet_reader_read(reader) =3D=3D PACKET_READ_NORMAL) {
>  		if (reader->pktlen < the_hash_algo->hexsz ||
>  		    reader->line[the_hash_algo->hexsz] !=3D ' ')
> @@ -1526,6 +1535,8 @@ static void receive_packfile_uris(struct packet_r=
eader *reader,
> =20
>  		string_list_append(uris, reader->line);
>  	}
> +	reader->options =3D original_options;

So "original_options" is used to save away the reader->options so
that it can be restored before returning to our caller? =20

OK (it may be more common in this codebase to call such a variable
"saved_X", though).

> diff --git a/pkt-line.c b/pkt-line.c
> index de4a94b437e..8da8ed88ccf 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -443,7 +443,12 @@ enum packet_read_status packet_read_with_status(in=
t fd, char **src_buffer,
>  		len--;
> =20
>  	buffer[len] =3D 0;
> -	packet_trace(buffer, len, 0);
> +	if (options & PACKET_READ_REDACT_ON_TRACE) {
> +		const char *redacted =3D "<redacted>";
> +		packet_trace(redacted, strlen(redacted), 0);
> +	} else {
> +		packet_trace(buffer, len, 0);
> +	}
> ...
> +	GIT_TRACE=3D1 GIT_TRACE_PACKET=3D"$(pwd)/log" GIT_TEST_SIDEBAND_ALL=3D=
1 \
> +	git -c protocol.version=3D2 \
> +		-c fetch.uriprotocols=3Dhttp,https \
> +		clone "$HTTPD_URL/smart/http_parent" http_child &&
> +
> +	grep "clone< <redacted>" log

This checks only that "redacted" string appears, but what the theme
of the change really cares about is different, no?  You want to
ensure that no sensitive substring of the URI appears in the log.

Imagine somebody breaking the redact logic by making it prepend that
string to the payload, instead of replacing the payload with that
string---this test will not catch such a regression.

Thanks.
