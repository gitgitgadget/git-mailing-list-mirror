Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCBDC43463
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 04:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601952086A
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 04:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SusuiKC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgIUE1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 00:27:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52330 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIUE1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 00:27:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF45488D51;
        Mon, 21 Sep 2020 00:27:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LhaLiyRXPmOmVWFBs4+zQyGXh5M=; b=SusuiK
        C1SSFWMA7MZOIpQaUZYYxnbxQkg6MDsJwSXIXkBCiL6LDe+PNpfrOI+cqByMz2hu
        NzSGpPgAp2UvbzH6PZYTDAkEGN7RYohi/nRADdHKAnvlh8/WZ3xQusOjvJqwCHkW
        x31g5wp/TwbDplzWsA3J/41x30EuAVvyD7IZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ik69FTazczfkGokDlxqgQvN+omxoOLtF
        YDu/FMv4Kw0sgRU8eoUfoZAvtBggddO8+dTbusHE6qFD2A83IuUUu3n3lg/4Qxpc
        hTQsaKyFEWjM/7L86ACnMaDxf5/vdye0J2Ea3SEdNRZW+18fKr3FURTP8bU5Kcoy
        BYyAbqv91YY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7B5C88D50;
        Mon, 21 Sep 2020 00:27:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B5B388D4F;
        Mon, 21 Sep 2020 00:27:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH v3] builtin/clone: avoid failure with GIT_DEFAULT_HASH
References: <20200911233815.2808426-1-sandals@crustytoothpaste.net>
        <20200920223541.1299038-1-sandals@crustytoothpaste.net>
Date:   Sun, 20 Sep 2020 21:27:14 -0700
In-Reply-To: <20200920223541.1299038-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 20 Sep 2020 22:35:41 +0000")
Message-ID: <xmqq4knrhhzx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9FAE0F6-FBC2-11EA-A1F5-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +test_expect_success 'clone with GIT_DEFAULT_HASH' '
> +	(
> +		sane_unset GIT_DEFAULT_HASH &&
> +		git init --object-format=sha1 test-sha1 &&
> +		git init --object-format=sha256 test-sha256
> +	) &&
> +	test_commit -C test-sha1 foo &&
> +	test_commit -C test-sha256 foo &&

Unfortunately, the 'foo' commit is created in test-sha1, but the
next step to create 'foo' in test-sha256 fails with

        fatal: unknown repository extensions found:
                objectformat

> +	GIT_DEFAULT_HASH=sha1 git clone test-sha256 test-clone-sha256 &&
> +	GIT_DEFAULT_HASH=sha256 git clone test-sha1 test-clone-sha1 &&
> +	git -C test-clone-sha1 status &&
> +	git -C test-clone-sha256 status
> +'
> +
>  partial_clone_server () {
>  	       SERVER="$1" &&
>  
