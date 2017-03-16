Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EABFC20323
	for <e@80x24.org>; Thu, 16 Mar 2017 16:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755069AbdCPQaH (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 12:30:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60052 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754032AbdCPQaF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 12:30:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E25B83D45;
        Thu, 16 Mar 2017 12:30:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s/hGce2FDnEyb1T27LCg6YQbvFY=; b=Pffj4o
        BTXUfKbBMUkZoH9EabDelyqfs3lQ2Jtb2uyEUvWiClxicg7SomxsUv6PBq1mY4LW
        gPpkd8H03QYk6XIPOKiOI5PVTpsvps7Te+APDk7LYvP/Gy96uh3jC8KEaXEfKIJR
        U1q03VO6zZ4x5BBaBAV7ZSLH+3ONQpnp2AJMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TP4wrSUafPL9qw2WQIHjnle341Ui4Y5c
        hAWRm/PY1K36Uwo4QnGwErOsEZA4svXV74l4zlDRW4eQcCjcg6xEi7ii8EhFzrtI
        mMwhOQHQWyGwpJI+XOZSGsT9eP6+J30l0MRk4Ss8E1qbDjm12y59Z/zfp9PLa6RN
        YC7mAyOFQxE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63AD283D43;
        Thu, 16 Mar 2017 12:30:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F208383D40;
        Thu, 16 Mar 2017 12:29:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v4 4/4] credential-cache: add tests for XDG functionality
References: <20170314003246.71586-4-lehmacdj@gmail.com>
        <20170316051827.97198-1-lehmacdj@gmail.com>
        <20170316051827.97198-5-lehmacdj@gmail.com>
Date:   Thu, 16 Mar 2017 09:29:58 -0700
In-Reply-To: <20170316051827.97198-5-lehmacdj@gmail.com> (Devin Lehmacher's
        message of "Thu, 16 Mar 2017 01:18:27 -0400")
Message-ID: <xmqq8to5chh5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCAE7818-0A65-11E7-885A-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Devin Lehmacher <lehmacdj@gmail.com> writes:

> @@ -20,4 +21,67 @@ helper_test_timeout cache --timeout=1
>  # our socket, leaving us with no way to access the daemon.
>  git credential-cache exit
>  
> +# we need to use rm -rf here since sometimes the daemon hasn't finished
> +# cleaning up after itself and rmdir fails

Hmmmm.  Peff, do you have ideas on better ways to do this (or
explanation why this is the best we could do)?

> +test_expect_success 'credential-cache --socket option overrides default location' '
> +	test_when_finished "rm -rf \"$HOME\"/dir/" &&
> +	check approve "cache --socket \"$HOME/dir/socket\"" <<-\EOF &&
> +	protocol=https
> +	host=example.com
> +	username=store-user
> +	password=store-pass
> +	EOF
> +	test -S "$HOME/dir/socket" &&
> +	git credential-cache exit
> +'
> +
> +XDG_CACHE_HOME="$HOME/xdg"
> +export XDG_CACHE_HOME
> +# test behavior when XDG_CACHE_HOME is set
> +helper_test cache
> +
> +test_expect_success "use custom XDG_CACHE_HOME if set and default sockets are not created" '
> +	test -S "$XDG_CACHE_HOME/git/credential/socket" &&
> +	test_path_is_missing "$HOME/.git-credential-cache/socket" &&
> +	test_path_is_missing "$HOME/.cache/git/credential/socket" &&
> +	git credential-cache exit
> +'
> +unset XDG_CACHE_HOME
> +
> +test_expect_success "use custom XDG_CACHE_HOME even if xdg socket exists" '
> +	check approve cache <<-\EOF &&
> +	protocol=https
> +	host=example.com
> +	username=store-user
> +	password=store-pass
> +	EOF
> +	test -S "$HOME/.cache/git/credential/socket" &&
> +	XDG_CACHE_HOME="$HOME/xdg" &&
> +	export XDG_CACHE_HOME &&
> +	check approve cache <<-\EOF &&
> +	protocol=https
> +	host=example.com
> +	username=store-user
> +	password=store-pass
> +	EOF
> +	test -S "$HOME/xdg/git/credential/socket" &&
> +	git credential-cache exit &&
> +	unset XDG_CACHE_HOME

This unset will not run if any of the above steps since it was set
and exported fails.  It probably should be in test_when_finished and
should use safe_unset shell function instead.

> +'
> +
> +# we need to use rm -rf here since sometimes the daemon hasn't finished
> +# cleaning up after itself and rmdir fails
> +test_expect_success 'use user socket if user directory exists' '
> +	test_when_finished "rm -rf \"$HOME/.git-credential-cache/\"" &&
> +	mkdir -p -m 700 "$HOME/.git-credential-cache/" &&
> +	check approve cache <<-\EOF &&
> +	protocol=https
> +	host=example.com
> +	username=store-user
> +	password=store-pass
> +	EOF
> +	test -S "$HOME/.git-credential-cache/socket" &&

We should also test that the XDG location is not touched at the same
time that the traditional directory was used for the socket.

> +	git credential-cache exit
> +'

This last test should be replicated to also check the case where we
have a symbolic link at ~/.git-credential-cache that points at a
directory.

>  test_done

Thanks.
