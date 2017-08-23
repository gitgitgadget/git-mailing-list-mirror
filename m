Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84AE520899
	for <e@80x24.org>; Wed, 23 Aug 2017 20:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932631AbdHWUNu (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 16:13:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61353 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932576AbdHWUNt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 16:13:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EAE6A8D8E;
        Wed, 23 Aug 2017 16:13:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZI6ZB4muVGKU75rhVxJ0LciA8ow=; b=UREwgl
        vDvWPen7Qde1Iy/ZmDkfiUnx+5ai+woC0lOEhNA8FJv+GR8MHv2WDW7TxcSwg8r2
        jY3FCBCdvzDUwwFw5RFJQv8/Qn3FWOdpc9ObSiVP0RqU62OG9ZxqJ/BoJ9c9ZJ5+
        tcz90ekCA8ZoBt6CrN4ywHJvt28cqjCdUpiTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NVNTgQ8v1rA1Bevbv0teuGCK45Fv1qte
        QN/Ubw9hIjNmXwrHybmoybiCowEYPbVGfmrCnc9CxV5mI3EN/hfOlXBYlsqfA2CT
        L677p0vApoGxXzfEr28NmNim3wGVNj/UVr1BWwZ9+UgUgxXou7V5Lq9frCy0g/hU
        xTtm6lSYC9o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47682A8D8D;
        Wed, 23 Aug 2017 16:13:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A438FA8D8B;
        Wed, 23 Aug 2017 16:13:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     <git@vger.kernel.org>, <peff@peff.net>
Subject: Re: [PATCH v3 2/4] imap-send: add wrapper to get server credentials if needed
References: <087f5907-6558-ce32-2f5c-2e418522c030@morey-chaisemartin.com>
        <9df045f4-71bd-92a1-20bb-4931e25b22c3@morey-chaisemartin.com>
Date:   Wed, 23 Aug 2017 13:13:47 -0700
In-Reply-To: <9df045f4-71bd-92a1-20bb-4931e25b22c3@morey-chaisemartin.com>
        (Nicolas Morey-Chaisemartin's message of "Tue, 22 Aug 2017 17:56:24
        +0200")
Message-ID: <xmqqtw0yxcsk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92E48D4A-883F-11E7-8D67-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:

> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
> ---
>  imap-send.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 09f29ea95..448a4a0b3 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -926,6 +926,25 @@ static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const cha
>  	return 0;
>  }
>  
> +static void server_fill_credential(struct imap_server_conf *srvc, struct credential *cred)
> +{
> +	if (srvc->user && srvc->pass)
> +		return;
> +
> +	cred->protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
> +	cred->host = xstrdup(srvc->host);
> +
> +	cred->username = xstrdup_or_null(srvc->user);
> +	cred->password = xstrdup_or_null(srvc->pass);
> +
> +	credential_fill(cred);
> +
> +	if (!srvc->user)
> +		srvc->user = xstrdup(cred->username);
> +	if (!srvc->pass)
> +		srvc->pass = xstrdup(cred->password);
> +}
> +

This looks straight-forward code movement.  The only thing that
makes me wonder is if this is "server".  The existing naming of the
variables screams at me that this is not "server" but is "service".

>  static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *folder)
>  {
>  	struct credential cred = CREDENTIAL_INIT;
> @@ -1078,20 +1097,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
>  		}
>  #endif
>  		imap_info("Logging in...\n");
> -		if (!srvc->user || !srvc->pass) {
> -			cred.protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
> -			cred.host = xstrdup(srvc->host);
> -
> -			cred.username = xstrdup_or_null(srvc->user);
> -			cred.password = xstrdup_or_null(srvc->pass);
> -
> -			credential_fill(&cred);
> -
> -			if (!srvc->user)
> -				srvc->user = xstrdup(cred.username);
> -			if (!srvc->pass)
> -				srvc->pass = xstrdup(cred.password);
> -		}
> +		server_fill_credential(srvc, &cred);
>  
>  		if (srvc->auth_method) {
>  			struct imap_cmd_cb cb;
