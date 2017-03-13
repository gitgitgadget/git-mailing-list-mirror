Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA77F1FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 18:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbdCMSJW (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 14:09:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51166 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751119AbdCMSJU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 14:09:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A503B80A6B;
        Mon, 13 Mar 2017 14:09:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1ojSLRs1dN4f9DQRjq7kHnRQ/Qc=; b=rwHAKn
        a8RSO8eelcpE6tZkC9/5mnW/bK4+YD1MnhIiZ+WxrERr/fR1cNodXag7B8rR9bw6
        Q13aha8HHMh26DW88H3plWNttkhgk4+kAIwwvGn3wGQ/IUYKiTEmnTIAbi+1Z8Hn
        TVFa22kNOzy8A9+WxznvxFI3SbPPeULQXhd2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y2UqkOXXvCbMvvjbnNAZHuifOV2UnVFh
        sWQAYU9v7e5WJ4/Ck5i2D9Oeul7iClV4aGyOSu/tcswbGznG06UYoD8wyQcDDk/1
        fBKtkUi9JxdwwsZQre5xzk9vouuMWqsF6A2E/px2aIjVm2JdeDeEvd+xm2zPONSQ
        WDX/6aUelhs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AD8880A6A;
        Mon, 13 Mar 2017 14:09:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EAB5380A69;
        Mon, 13 Mar 2017 14:09:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH 2/3] credential-cache.c: Make git use XDG_CACHE_HOME for credentials
References: <20170313172232.96678-1-lehmacdj@gmail.com>
        <20170313172232.96678-3-lehmacdj@gmail.com>
Date:   Mon, 13 Mar 2017 11:09:11 -0700
In-Reply-To: <20170313172232.96678-3-lehmacdj@gmail.com> (Devin Lehmacher's
        message of "Mon, 13 Mar 2017 13:22:31 -0400")
Message-ID: <xmqqtw6xrquw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29B07534-0818-11E7-AE6F-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Devin Lehmacher <lehmacdj@gmail.com> writes:

> +static char* get_socket_path(void) {
> +	char *home_socket;
> +
> +	home_socket = expand_user_path("~/.git_credential_cache/socket");

The typo on this line guarantees that nobody will retain the current
location and will be migrated forcibly to the new xdg place ;-)

> +	if (home_socket)
> +		if (file_exists(home_socket))
> +			return home_socket;
> +		else
> +			free(home_socket);
> +
> +	return xdg_cache_home("credential/socket");
> +}

I somehow feel that the order of precedence should be the other way
around, though.  

If somebody really wants to use the xdg location and has a socket
already there, using that existing socket would be the right thing
to do.  However, when neither ~/.git-credential-cache/socket nor
~/.cache/git/socket exists, why should we prefer the latter over the
former?

>  int cmd_main(int argc, const char **argv)
>  {
>  	char *socket_path = NULL;
> @@ -106,7 +119,7 @@ int cmd_main(int argc, const char **argv)
>  	op = argv[0];
>  
>  	if (!socket_path)
> -		socket_path = expand_user_path("~/.git-credential-cache/socket");
> +		socket_path = get_socket_path();
>  	if (!socket_path)
>  		die("unable to find a suitable socket path; use --socket");
