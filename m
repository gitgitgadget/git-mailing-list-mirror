Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48711C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 00:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B0B364DC4
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 00:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhCLA6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 19:58:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53509 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhCLA6b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 19:58:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE947B71C2;
        Thu, 11 Mar 2021 19:58:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WVsb1TMJIsyk73jAFCQ22C83Dug=; b=D5IwUo
        IqpS/CrQmAs3zQ5p4C791N+zGwhajTphV1dpC9sRSBbaiZmLeHJZVSkpPHF4CPOl
        sap+fbzS+9e7NVTVo76gdoRQH1gkU57pV8X8FxJ0AwC0zszJYIDT3SJ4Ee1WbWhf
        wdmFGY48ht+Ujl11olvddY891nsUrYV17GWjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aFs20aR1EJ3wgOUXd5qQbEASh4tnEyPL
        zmiGT09kHVcAoKnPVA65y+KJC+HoRH7t0LcSGhm0Hb6vdidoBSIZc9vcHvl3JpiA
        /khGimSq4ruTnNKxBgGNdnTZo085/BIy+IiyX/npDazgLFTAnJqhaPBgrFc6owWZ
        KgrdeccOfxc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D69FDB71C1;
        Thu, 11 Mar 2021 19:58:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65F66B71C0;
        Thu, 11 Mar 2021 19:58:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Szakmeister <john@szakmeister.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] http: store credential when PKI auth is used
References: <20210312004842.30697-1-john@szakmeister.net>
        <20210312004842.30697-2-john@szakmeister.net>
Date:   Thu, 11 Mar 2021 16:58:29 -0800
In-Reply-To: <20210312004842.30697-2-john@szakmeister.net> (John Szakmeister's
        message of "Thu, 11 Mar 2021 19:48:41 -0500")
Message-ID: <xmqqeeglb32i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FC450AC-82CE-11EB-B65F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Szakmeister <john@szakmeister.net> writes:

> Likewise, we also need to reject the credential when there is a failure.
> Curl appears to report client-related certificate issues are reported
> with the CURLE_SSL_CERTPROBLEM error.  This includes not only a bad
> password, but potentially other client certificate related problems.
>
> Since we cannot get more information from curl, we'll go ahead and
> reject the credential upon receiving that error, just to be safe and
> avoid caching or saving a bad password.

I think this is sensible enough.  As long as a tentative network
failure to talk to the server, or an overloaded server that fails to
accept new connection, won't trigger rejection of a password, it is
OK, I would think.

> Signed-off-by: John Szakmeister <john@szakmeister.net>
> ---
>  http.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/http.c b/http.c
> index f8ea28bb2e..12a8aaba48 100644
> --- a/http.c
> +++ b/http.c
> @@ -1637,7 +1637,17 @@ static int handle_curl_result(struct slot_results *results)
>  		credential_approve(&http_auth);
>  		if (proxy_auth.password)
>  			credential_approve(&proxy_auth);
> +		credential_approve(&cert_auth);
>  		return HTTP_OK;
> +	} else if (results->curl_result == CURLE_SSL_CERTPROBLEM) {
> +		/*
> +		 * We can't tell from here whether it's a bad path, bad
> +		 * certificate, bad password, or something else wrong
> +		 * with the certificate.  So we reject the credential to
> +		 * avoid caching or saving a bad password.
> +		 */
> +		credential_reject(&http_auth);
> +		return HTTP_NOAUTH;
>  	} else if (missing_target(results))
>  		return HTTP_MISSING_TARGET;
>  	else if (results->http_code == 401) {
