Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA16C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 16:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C14060FD7
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 16:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhINQof (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 12:44:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50045 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhINQoc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 12:44:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66E8E15C21A;
        Tue, 14 Sep 2021 12:43:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gRuPxMZdfRp8
        O1dx0Smd4BQOm25W3oRjsHttbVBg0Rc=; b=FHzk6xjrLvHissFQp5bdCOD5G9Br
        +4qum01Cnz3rMygO05zPwXctFGCuunUUWSxKwD1qLKfyvddUUUs9y6ngiQL1BxDj
        qfTK95z2xKliKAhDQxH9ydaEFL/fN9YKp9TxPfiCxq/YKXP+LkNio5LBfw9WcYBM
        QnfAQBwcRcKQ9EM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F0BD15C219;
        Tue, 14 Sep 2021 12:43:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A2DC315C218;
        Tue, 14 Sep 2021 12:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 2/3] credential-cache: check for windows specific errors
References: <20210913085600.35506-1-carenas@gmail.com>
        <20210914072600.11552-1-carenas@gmail.com>
        <20210914072600.11552-3-carenas@gmail.com>
Date:   Tue, 14 Sep 2021 09:43:11 -0700
In-Reply-To: <20210914072600.11552-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 14 Sep 2021 00:25:59 -0700")
Message-ID: <xmqqzgsf2jmo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D9DA8B6A-157A-11EC-81D6-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> @@ -75,7 +101,7 @@ static void do_cache(const char *socket, const char =
*action, int timeout,
>  	}
> =20
>  	if (send_request(socket, &buf) < 0) {
> -		if (errno !=3D ENOENT && errno !=3D ECONNREFUSED)
> +		if (connection_fatally_broken(errno))
>  			die_errno("unable to connect to cache daemon");
>  		if (flags & FLAG_SPAWN) {
>  			spawn_daemon(socket);

In my earlier review I suggested a helper that checks
recoverability, hence leading to a code structure like this:

		if (!connection_not_yet_open(errno))
			die_errno(...);
		/* otherwise, (re)establish connection and retry */
		...

but the phrasing and semantics you chose to check for unrecoverable
state reads much better.

Thanks.
