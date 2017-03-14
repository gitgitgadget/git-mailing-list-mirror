Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB7D20373
	for <e@80x24.org>; Tue, 14 Mar 2017 01:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbdCNBwX (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 21:52:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54288 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751655AbdCNBwW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 21:52:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1E0B860E5;
        Mon, 13 Mar 2017 21:52:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CGOFJ/gXhV8uv2jiPVinQYAcek0=; b=VpGckB
        8zBr2Awjeu4A6g880kgSUj+uV90n0PzqGHW1A9G5rit5nQTjbJwXLa7u0wxiLqZh
        ZvTLN4DOc7RuZrirsRqr+b1dGKHNiZENSOOfPhoYUH+AsFqYK3snnUIwzW7ZTmPy
        8nfSNu9oFn0K/VK9joRAQ87LmvNV0wjQTrFjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v5YF5VpcuumPnduXBv+viWt7ZJUVR1LQ
        TgOqwSQgQeRF1ChLiOG6jnufwkYtRP5uaP//4m41hs6Byg2g8tnf57mxNf1W6sUG
        ANHfRITdijXe8F4XLITCNTyPjjBaBD33beA0H616JpaxsQvta34ZfssfBRCKdeHf
        lbLfbDttT/I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A89BB860E4;
        Mon, 13 Mar 2017 21:52:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 19DC9860E3;
        Mon, 13 Mar 2017 21:52:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH/RFC v3 3/3] credential-cache: only use user_socket if a socket
References: <xmqqa88orgjd.fsf@gitster.mtv.corp.google.com>
        <20170314003246.71586-1-lehmacdj@gmail.com>
        <20170314003246.71586-4-lehmacdj@gmail.com>
Date:   Mon, 13 Mar 2017 18:52:18 -0700
In-Reply-To: <20170314003246.71586-4-lehmacdj@gmail.com> (Devin Lehmacher's
        message of "Mon, 13 Mar 2017 20:32:46 -0400")
Message-ID: <xmqq8to8lj59.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC1E49D6-0858-11E7-9FFD-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Devin Lehmacher <lehmacdj@gmail.com> writes:

> diff --git a/credential-cache.c b/credential-cache.c
> index db1343b46..63236adc2 100644
> --- a/credential-cache.c
> +++ b/credential-cache.c
> @@ -83,12 +83,18 @@ static void do_cache(const char *socket, const char *action, int timeout,
>  	strbuf_release(&buf);
>  }
>  
> +static int is_socket(char *path) {
> +	struct stat sb;
> +	int ret = lstat(path, &sb);
> +	return ret && S_IFSOCK(sb.st_mode);
> +}
> +
>  static char *get_socket_path(void) {
>  	char *home_socket;
>  
>  	home_socket = expand_user_path("~/.git-credential-cache/socket");
>  	if (home_socket) {
> -		if (file_exists(home_socket))
> +		if (is_socket(home_socket))

This should be done as part of 2/3, no?  It does not make sense to
add 2/3 and then immediately say "oops, the check in 2/3 is wrong,
and let's update it like so".
