Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307D6C83013
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 23:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF18B221FD
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 23:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ambZhOFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388874AbgK3Xd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 18:33:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60789 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388814AbgK3Xd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 18:33:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79358989ED;
        Mon, 30 Nov 2020 18:33:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=baAWYhTQwPU7vmT7iYD0wVBr/oc=; b=ambZhOFFr8+I+52u81rj
        MPj4DAbJWqNbStoFeLfdbDPLyqNk9AvEi89uEPtebSF5FPX1etcezLMbsIVp3DRE
        vgoECkHmu5p7ys2yQMES+atsI0VKwkZQOnbYvTDhOULW4Y5Ifza690XITCJBnN26
        CWeaaMIhxus03xYhQHtELtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=w2KCJG+y3ahU2TKyeWiu4LBzDPpDuT0p2ims2yedDbHJgm
        p3J8BkOUVOwVB4OFUr+P5JDF+QU/HrD/t+RSVEI5vEvn7hGuARwz3BdqFWmgf1bO
        T4sjbRz1GAHbJC2ID/N+DNCfVBq+D+UYJEkcUw578W4Xo5WMLeKMrRR2TrFgE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 700B9989EC;
        Mon, 30 Nov 2020 18:33:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D836D989EB;
        Mon, 30 Nov 2020 18:33:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Cc:     git@vger.kernel.org, levraiphilippeblain@gmail.com
Subject: Re: [PATCHv2] imap-send: parse default git config
References: <1c3954a4-a8c7-d134-1a4a-aee8c3b4ef24@suse.com>
Date:   Mon, 30 Nov 2020 15:33:14 -0800
Message-ID: <xmqqk0u2to79.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6AF34564-3364-11EB-B031-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com> writes:

> git imap-send does not parse the default git config settings and thus ignore
> core.askpass value.
> Rewrite config parsing to support core settings.
>
> Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
> ---
>  imap-send.c | 52 ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 22 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 5764dd812ca7..fa1921734671 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -84,17 +84,17 @@ static int nfvasprintf(char **strp, const char *fmt, va_list ap)
>  }
>    struct imap_server_conf {
> -	char *name;
> -	char *tunnel;
> -	char *host;
> +	const char *name;
> +	const char *tunnel;
> +	const char *host;
>  	int port;
> -	char *folder;
> -	char *user;
> -	char *pass;
> +	const char *folder;
> +	const char *user;
> +	const char *pass;
>  	int use_ssl;
>  	int ssl_verify;
>  	int use_html;
> -	char *auth_method;
> +	const char *auth_method;

Nice to see these tightened up, I guess.

> @@ -955,7 +955,7 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
>  		srvc->pass = xstrdup(cred->password);
>  }
>  -static struct imap_store *imap_open_store(struct imap_server_conf
>  *srvc, char *folder)
> +static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const char *folder)

Sorry but it appears that

    Content-Type: text/plain; charset=windows-1252; format=flowed

munged the message into an unusable shape (the "flowed" part is what
makes it unusable), so it cannot be applied X-<.

>  {
>  	struct credential cred = CREDENTIAL_INIT;
>  	struct imap_store *ctx;
> @@ -1338,15 +1338,26 @@ static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
>  	return 1;
>  }
>  -static void git_imap_config(void)
> +static int git_imap_config(const char *var, const char *val, void *cb)
>  {
> -	const char *val = NULL;
>  -	git_config_get_bool("imap.sslverify", &server.ssl_verify);
> -	git_config_get_bool("imap.preformattedhtml", &server.use_html);
> -	git_config_get_string("imap.folder", &server.folder);
> -
> -	if (!git_config_get_value("imap.host", &val)) {
> +	if(!strcmp("imap.sslverify", var))
> +		server.ssl_verify = git_config_bool(var, val);
> +	else if(!strcmp("imap.preformattedhtml", var))
> +		server.use_html = git_config_bool(var, val);

Style: a SP between "if" and "(".

> +	else if(!strcmp("imap.folder", var))
> +		return git_config_string(&server.folder, var, val);

Other than that, the patch looks quite straight-forward.

Thanks.
