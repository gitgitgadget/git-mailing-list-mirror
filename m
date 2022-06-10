Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAF1C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 21:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347536AbiFJVxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 17:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345352AbiFJVxs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 17:53:48 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDCC21F9B8
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 14:53:47 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93E5F13FB1E;
        Fri, 10 Jun 2022 17:53:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WODmnP/+ZTNkNLY6vv0+yaUqDqEbvyqvAIwnHo
        c2FBg=; b=FVzodUOrs/pv+XjngborzAZId/hoZrSYnIwwGoHlralpaxiDEOhcXR
        M0XOdHPTNy5DEcKiNjXFqh8xcSZGZUzliUu9RR4RB+n+h8KAa+Y+y2EAzwL+kvwG
        bQ6gCtcpAcqDH2QzHXMIrvf8HduFyHyZvKHNpsgU9FXkY/uSJjOMA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BBD113FB1D;
        Fri, 10 Jun 2022 17:53:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E9C0D13FB1C;
        Fri, 10 Jun 2022 17:53:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Rodrigo Silva Mendoza <rodrigosilvamendoza3@gmail.com>,
        git@vger.kernel.org
Subject: Re: Best way to update `HEAD` in mirrored repos
References: <CANWRddN4R6AceeaOyZm1vs8AXBNv3J+cE5MOyrhKVhcqddjUOA@mail.gmail.com>
        <nycvar.QRO.7.76.6.2206091000590.349@tvgsbejvaqbjf.bet>
        <CANWRddNa1nB9shoppfXuA2yqmd2353HVBopoufkh0SevnVrngA@mail.gmail.com>
        <nycvar.QRO.7.76.6.2206102327540.353@tvgsbejvaqbjf.bet>
Date:   Fri, 10 Jun 2022 14:53:44 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2206102327540.353@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 10 Jun 2022 23:46:37 +0200 (CEST)")
Message-ID: <xmqq5yl8chhz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD47EE54-E907-11EC-BDD6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/builtin/remote.c b/builtin/remote.c
> index eddd40c8f87..fead15adb97 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1344,7 +1344,7 @@ static int show(int argc, const char **argv)
>
>  static int set_head(int argc, const char **argv)
>  {
> -	int i, opt_a = 0, opt_d = 0, result = 0;
> +	int i, opt_a = 0, opt_d = 0, result = 0, is_mirror = 0;
>  	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
>  	char *head_name = NULL;
>
> @@ -1357,8 +1357,16 @@ static int set_head(int argc, const char **argv)
>  	};
>  	argc = parse_options(argc, argv, NULL, options, builtin_remote_sethead_usage,
>  			     0);
> -	if (argc)
> -		strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
> +	if (argc) {
> +		struct remote *remote = remote_get(argv[0]);
> +
> +		if (!remote || !remote->mirror)
> +			strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
> +		else {
> +			is_mirror = 1;
> +			strbuf_addstr(&buf, "HEAD");
> +		}
> +	}

Good.

Regardless of the "mirror" issue, it makes tons of sense to ask the
remote API how the remote-tracking refs for the given remote is set
up, instead of assuming that it must be "refs/remotes/<remote>"
blindly like in the original code.

That way, we could even handle a case like so:

	[remote "frotz"]
		fetch = +refs/heads/*:refs/remotes/nitfol/*

Their HEAD should be mapped to refs/remotes/nitfol/HEAD on our end,
so set-head should be able to notice that, too, if we go further
with your "do not assume, instead ask remote API" approach.

Thanks.
