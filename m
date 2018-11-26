Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155BD1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 02:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbeKZNCw (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 08:02:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52033 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeKZNCw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 08:02:52 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B32DF10CEA2;
        Sun, 25 Nov 2018 21:10:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qrlpqfKtwTLominUEAYTUcHkhGg=; b=Oc4lA/
        DS1+UzIgy+zb8FTbtddRKjdE7MLxd9P3VbyFbr1zxBTy9zBc79zUFq7mc5FUVtZP
        cWkgHppZ1aPan/zOhB7tzgFn3j8+tNNJfd/E9LhxoB36rDzRnPBbVyRzmQX4ZzCs
        ppu2vTkAfivHKSSG6tE0PmswZVAPn39HsClyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yF2GxOaodGZ4v1bXMEx7EyeRm74sQQqn
        RT4cbwMIvsfzkY/cGREadMBRK5p2gZe4jqpWXli8+wFbeK9lg8DEFPPoSTqt1EU2
        An4PPo3sN0Lj9L8G42eFdcoIG3BHZi5ZRVWCphDetabo2cyVVaOHA7THn7HNjCBR
        pgTbeZ5N2hM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACB4D10CEA1;
        Sun, 25 Nov 2018 21:10:16 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30D0710CEA0;
        Sun, 25 Nov 2018 21:10:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        peff@peff.net
Subject: Re: [PATCH] http-backend: enable cleaning up forked upload/receive-pack on exit
References: <20181124134827.13932-1-max@max630.net>
Date:   Mon, 26 Nov 2018 11:10:15 +0900
In-Reply-To: <20181124134827.13932-1-max@max630.net> (Max Kirillov's message
        of "Sat, 24 Nov 2018 15:48:27 +0200")
Message-ID: <xmqqh8g41tdk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A7516CC-F120-11E8-A691-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> If http-backend dies because of errors, started upload-pack or
> receive-pack are not killed and waited, but rather stay running for somtime

"sometime" (will fix locally, no reason for a resend).

> until they exits because of closed stdin. It may be undesirable in working

"they exit" (ditto)

> environment, and it also causes occasional failure of t5562, because the
> processes keep opened act.err, and sometimes write there errors after next test
> started using the file.
>
> Fix by enabling cleaning of the command at http-backed exit.

Thanks for a clear explanation.

Will queue.

> Reported-by: Carlo Arenas <carenas@gmail.com>
> Helped-by: Carlo Arenas <carenas@gmail.com>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> This seems to fix the issue at NetBSD. I verified it manually with strace but could
> not catch the visible timing effect in tests at Linux. So no tests for it.
>
> the "t5562: do not reuse output files" patches are not needed then
>  http-backend.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/http-backend.c b/http-backend.c
> index 9e894f197f..29e68e38b5 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -486,6 +486,8 @@ static void run_service(const char **argv, int buffer_input)
>  	if (buffer_input || gzipped_request || req_len >= 0)
>  		cld.in = -1;
>  	cld.git_cmd = 1;
> +	cld.clean_on_exit = 1;
> +	cld.wait_after_clean = 1;
>  	if (start_command(&cld))
>  		exit(1);
